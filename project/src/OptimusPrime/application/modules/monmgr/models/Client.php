<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Client
 *
 * @author apple
 */
class Monmgr_Model_Client {

    //put your code here
    /**
     * _db
     */
    protected $_db;

    function __construct() {
        $this->_db = Zend_Registry::get('dbAdapter');
    }
    
    
}

?>
