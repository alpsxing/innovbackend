<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Users
 *
 * @author apple
 */
class Authen_Model_Users {

    //put your code here
    /**
     * 
     * @param type $db
     */
    protected $_db;

    /**
     * 
     * @param type $
     */
    protected $_menulist;

    /**
     * 
     * @param type $acklist
     */
    protected $_acklist;

    /**
     * 
     * @param type $username
     */
    protected $_username;
    protected $_groupid;
    protected $_lastLoginTime;
    protected $_lastLoginIp;

    public function __construct($db) {
        $this->_db = $db;
        $this->_acklist = array();
        $this->_menulist = array();
        $this->_username = "";
        $this->_groupid = -1;
        $this->_lastLoginTime = "";
        $this->_lastLoginIp = "";
       
        
    }

    public function login($username, $password, &$message) {
        $select = $this->_db->select();
        $select->from('users')
                ->where('username = ?', $username)
                ->where('status = 1')
                ->limit(1);
        $result = $this->_db->fetchrow($select);
        if ($result['tried'] > 5 && (time() - $result['last_try_time'] ) < 300) {
            $message = "登陆错误次数达到上限";
            return false;
        }
        if ($result['passwd'] == md5($password)) { //成功登陆
            $sql = "UPDATE `users` SET  `last_login_time` =  '" . date("Y-m-d H:i:s", time()) . "', `last_try_time`=UNIX_TIMESTAMP(), `tried`=0 , `last_session_id` = '" . strtoupper(Zend_Session::getId()) . "' WHERE  `id` =" . $result['id'] . ";";
            //echo $sql;exit;
            $this->_db->query($sql);
            $result = $this->_db->fetchrow($select);
            //$this->insertSession($result['id']);
            $this->_username = $result['username'];
            $this->_groupid = $result['groupid'];
            $this->_lastLoginTime = $result['last_login_time'];
            $this->_lastLoginIp = "";
            $this->initMenu();
            $this->initGroupAcl();
            return $result;
        } else {
            if (!empty($result['username'])) { //
                if ((time() - $result['last_try_time'] ) < 300) { // 
                    $sql = "UPDATE `users` SET `last_try_time`=UNIX_TIMESTAMP(), `tried`=`tried`+1 where `id`=" . $result['id'] . ";";
                } else {
                    $sql = "UPDATE `users` set `last_try_time`=UNIX_TIMESTAMP(), `tried`=1 where `id`=" . $result['id'] . ";";
                }
                $this->_db->query($sql);
            } else {
                
            }
            $message = "登陆失败，请检查用户名与密码是否正确";
            return false;
        }
    }

    /**
     * 
     * @return type
     */
    public function getAclList() {
        return $this->_acklist;
    }

    /**
     * 
     * @return type
     */
    public function getMenuList() {
        return $this->_menulist;
    }

    public function getUserName() {
        return $this->_username;
    }

    public function getGroupId() {
        return $this->_groupid;
    }

    public function getLastLoginTime() {
        return $this->_lastLoginTime;
    }


    public function changePwd($userid, $newpwd) {
        $sql = "UPDATE `users` SET `passwd` = md5(" . $newpwd . ") where `id` = " . $userid . " limit 1";
        try {
            $this->_db->query($sql);
            return true;
        } catch (Exception $e) {
            return false;
        }
    }
    
    public function getUserInfo($user_id) {
        $select = $this->_db->select();
        $select->from('users')
                ->where('id = ?', $user_id)
                ->where('status =1')
                ->limit(1);
        try {
            return $this->_db->fetchrow($select);
        } catch (Zend_Db_Exception $e) {
            exit('Database Connect Fail!');
        }
    }

    public function getGroupInfo($groupId) {
        $select = $this->_db->select();
        $select->from('usergroups')
                ->where('id =? ', $groupId)
                ->limit(1);
        $result = $this->_db->fetchall($select);
        if ($result[0]['inherts_from'] == 0) {
            
        } else {
            $inherts_from = $result[0]['inherts_from'];
            while ($inherts_from != 0) {
                $result[] = $this->fetchInherts($inherts_from);
                $last = end($result);
                $inherts_from = $last['inherts_from'];
            }
        }
        return $result;
    }

    private function fetchInherts($inherts_from) {
        $select = $this->_db->select();
        $select->from('usergroups')
                ->where('id =? ', $inherts_from)
                ->limit(1);
        return $this->_db->fetchrow($select);
    }

    private function initGroupAcl() {
        $groupinfo = $this->getGroupInfo($this->_groupid);
        $controllers = array();
        foreach ($groupinfo as $var) {

            if (substr_count($var['controller_list'], ",")) {
                $controllersarr = explode(",", $var['controller_list']);
            } else {
                $controllersarr = array($var['controller_list']);
            }
            if (!empty($var['controller_list'])) {
                $controllers = array_merge($controllers, $controllersarr);
            }
        }
        $select = $this->_db->select();
        $select->from('controllerlist');
        if ($this->_groupid != 1) {
            $controllers = array_unique($controllers);
            $select->where('id in (?)', $controllers);
        }

        $result = $this->_db->fetchall($select);
        $this->_acklist = $result;
    }

    private function initMenu() {
        
        $select = $this->_db->select();
        $select->from('controllerlist')
                ->where('menu>0');
        $rawlist = $this->_db->fetchassoc($select);
        $this->_menulist = $rawlist;
    }

}

