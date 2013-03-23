<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of AclManger
 *
 * @author quxy
 */
class Authen_Model_Acl extends Zend_Acl {

    public function __construct() {
        $role = $this->getRoleInfo();
        $this->initRoleMenu($role);
    }

    /**
     * 获取用户的角色名
     * @return string
     */
    public function getRoleInfo() {


        $ns = Zend_Auth::getInstance()->getStorage()->getNamespace();
        //有session信息
        if (isset($_SESSION[$ns])) {//有登录
            if (isset($_SESSION[$ns]['role'])) {//判断有没有登录用户的角色信息
                $role = $_SESSION[$ns]['role'];
            } else {
                $role = 'guest_';
            }
        } else {
            $role = 'guest_';
        }
        $this->_initRolePerm($role);

        return $role;
    }

    /**
     * 获得登录用户的数据数据
     *
     */
    public function getUserInfo() {
        $namespace = Zend_Auth::getInstance()->getStorage()->getNamespace();
        //用户认证失败则返回false
        if (isset($_SESSION[$namespace]['userInfo'])) {
            return $_SESSION[$namespace]['userInfo'];
        } else {
            return false;
        }
    }

    /**
     * 获得权限数据 
     * @return Array   成功返回
     * @return Array   失败返回
     * @todo 
     */
    public function getUserPermission() {

        $namespace = Zend_Auth::getInstance()->getStorage()->getNamespace();

        //用户认证失败则返回false
        if (isset($_SESSION[$namespace]['acklist'])) {
            return $_SESSION[$namespace]['acklist'];
        } else {
            return false;
        }
    }

    /**
     * 
     *
     * @return unknown
     */
    public function initRoleMenu($role) {

        $namespace = Zend_Auth::getInstance()->getStorage()->getNamespace();
        //用户认证失败则返回false
        $menu = array();
        $mainUrl = 'authen/login/index';
        $assign = false;
        if (isset($_SESSION[$namespace]['menulist'])) {
            $rawlist = $_SESSION[$namespace]['menulist'];
            foreach ($rawlist as $key => $var) {
                if (!empty($var['module']) and ($var['menu'])) {
                    $resource = ucfirst(strtolower($var['module'] . '_' . $var['controller']));    //资源：一个限制访问的对象
                    $action = strtolower($var['action']);
                    if ($this->isallowed($role, $resource, $action)) {
                        $menu[] = $var;
                        if ($var['tree_parent'] == 0 && !$assign) {
                            $mainUrl = $var['module'] . '/' . $var['controller'] . '/' . $var['action'];
                            $assign = true;
                        }
                    }
                }
            }
        }

        Zend_Registry::set('menu', $menu);
        Zend_Registry::set('mainUrl', $mainUrl);
        Zend_Registry::set('role', $role);
    }

    private function _initRolePerm($role) {

        if ($this->hasRole($role)) {
            return;
        }

        //都需要的资源
        if (!$this->has('Authen_login')) {
            $this->add(new Zend_Acl_Resource('Authen_login'));
        }

        if ($role == 'guest_') {                        //访客角色
            $roleGuest = new Zend_Acl_Role('guest_');    //创建角色guest
            $this->addRole($roleGuest);                //将角色添加到role注册表
        } else {                                    //登录用户的权限
            //如果该角色不存在,则添加到Role注册表中,否则后面的代码会报错
            //eg:Fatal error: Uncaught exception 'Zend_Acl_Role_Registry_Exception' with message 'Role 'admin' not found'
            if (!$this->hasRole($role)) {
                $this->addRole(new Zend_Acl_Role($role));
            }


            $acklist = $this->getUserPermission();
            if ($acklist) {
                foreach ($acklist as $var) {
                    //controller资源
                    $resource = ucfirst(strtolower($var['module'] . '_' . $var['controller']));    //资源：一个限制访问的对象
                    $action = strtolower($var['action']);

                    //判断是否拥有资源
                    if (!$this->has($resource)) {//没有资源
                        $this->add(new Zend_Acl_Resource($resource)); //增加资源
                    }
                    $this->allow($role, $resource, $action); //允许角色访问资源
                }
            }
        }

        //都需要的权限
        $this->allow($role, 'Authen_login', array('index'));
        $this->allow($role, 'Authen_login', array('login'));
    }

}

?>
