<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of CommonHelper
 *
 * @author apple
 */
class CommonHelper {

    //put your code here
    static public function getCurrentUserInfo() {
        $namespace = Zend_Auth::getInstance()->getStorage()->getNamespace();
        //用户认证失败则返回false
        if (isset($_SESSION[$namespace]['userInfo'])) {
            return $_SESSION[$namespace]['userInfo'];
        } else {
            return false;
        }
    }
    
    static public function setModuleId2View($module) {
        $menu = Zend_Registry::get('menu');
        foreach ($menu as $item) {
            if ($item['tree_parent'] === '0' && $module === $item['module']) {
                $bootstrap = Zend_Controller_Front::getInstance()->getParam("bootstrap");
                $view = $bootstrap->getResource('view');
                $view->module_id = $item['id'];
            }
        }
    }

}

?>
