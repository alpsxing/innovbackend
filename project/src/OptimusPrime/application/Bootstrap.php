<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap {

    protected function _initAppAutoload() {
        $autoloader = new Zend_Application_Module_Autoloader(array(
            'namespace' => 'App',
            'basePath' => dirname(__FILE__),
        ));
        return $autoloader;
    }

    protected function _initDatabase() {

        //get database configuration

        try {
            $dbconfig = new Zend_Config_Ini(APPLICATION_PATH . '/configs/database.ini', 'mysqldb');
        } catch (Zend_Config_Exception $e) {
            exit($e->getMessage());
        }

        Zend_Registry::set('dbconfig', $dbconfig);


        try {
            $dbAdapter = Zend_Db::factory($dbconfig->db->adapter, $dbconfig->db->config->toArray());
        } catch (Zend_Db_Exception $e) {
            exit($e->getMessage());
        }
        try {
            $dbAdapter->query("SET NAMES '" . $dbconfig->db->config->charset . "'");
        } catch (Zend_Db_Exception $e) {
            exit('Database Connect Fail!');
        }

        Zend_Db_Table::setDefaultAdapter($dbAdapter);
        Zend_Registry::set('dbAdapter', $dbAdapter);
    }

    protected function _initView()
    {
        $view = new Zend_View();
        $view->doctype('HTML5');
        $view->headTitle('OptimusPrime');
        $view->headLink()->setStylesheet("/easyui132/themes/default/easyui.css");
        $view->headLink()->appendStylesheet("/easyui132/themes/icon.css");
        $view->headLink()->appendStylesheet("/css/common.css");
        $view->headScript()->setFile("/easyui132/jquery-1.8.0.min.js");
        $view->headScript()->appendFile("/easyui132/jquery.easyui.min.js");
        $view->headScript()->appendFile("/easyui132/locale/easyui-lang-zh_CN.js");
        $view->headScript()->appendFile("/js/json2.js");
        $view->headScript()->appendFile("/js/common.js");
        
        $view->addScriptPath(APPLICATION_PATH . '/modules/default/views/scripts');
        $dbmenu = Zend_Registry::get('menu');
        $view->dbmenu = $dbmenu;
        $role = Zend_Registry::get('role');
        $view->role = $role;
        $viewRenderer = Zend_Controller_Action_HelperBroker::getStaticHelper('ViewRenderer');
        $viewRenderer->setView($view);    
        return $view;
    }

}

