<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Bootstrap
 *
 * @author apple
 */
//class Admin_Bootstrap extends Zend_Application_Bootstrap_Bootstrap { 
class Admin_Bootstrap extends Zend_Application_Module_Bootstrap {
    protected function _initAutoload() {
        $autoloader = new Zend_Application_Module_Autoloader(array(
            'namespace' => 'Admin_',
            'basePath' => APPLICATION_PATH . '/modules/admin'));
        return $autoloader;
    }
    //后台系统如果需要使用Smarty模板可以在这里进行初始化。
    protected function _initSmarty(){
        
    }

}  
?>
