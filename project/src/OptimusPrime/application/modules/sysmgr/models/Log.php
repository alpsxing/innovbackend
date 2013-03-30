<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Log
 *
 * @author apple
 */
class Sysmgr_Model_Log {

    //put your code here
    //put your code here
    /**
     * 
     * @param type $db
     */
    protected $_db;

    public function __construct() {
        $this->_db = Zend_Registry::get('dbAdapter');
    }

    public function getLogs($userid, $stime, $etime, $content) {
        $select = $this->_db->select();
        $select->from('operate_log');
        
        if($userid){
            $select->where('user_id = ?', $userid);
        }
        if($stime){
            $select->where('time >= ?', $stime);
        }
        if($etime){
            $select->where('time <= ?', $etime);
        }
        if($content){
            $select->where('content like "%' . $content . '%"');
        }
          
        $result = $this->_db->fetchAll($select);
        
        
        return $result;
    }

}

?>
