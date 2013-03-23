<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of IndexController
 *
 * @author robert
 */
//require_once APPLICATION_PATH . '/modules/authen/models/Menu.php';
class IndexController extends Zend_Controller_Action {

    public function init() {
        if(Zend_Registry::isRegistered('mainUrl')){
            $url = Zend_Registry::get('mainUrl');
        }else{
            $url = 'authen/login/index';
        }
        $this->_redirect($url);
    }

    public function indexAction() {
        
    }
   
}

