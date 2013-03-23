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
class Authen_Bootstrap extends Zend_Application_Module_Bootstrap {

    protected function _initAutoload() {
        $autoloader = new Zend_Application_Module_Autoloader(array(
            'namespace' => 'Authen_',
            'basePath' => APPLICATION_PATH . '/modules/authen'));
        return $autoloader;
    }
}

?>
