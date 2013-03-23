<?php

ini_set("display_errors", true);
error_reporting(E_ALL ^ E_NOTICE);
date_default_timezone_set('Asia/Shanghai');
// Define path to application directory
defined('APPLICATION_PATH')
    || define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application'));

// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));

// Ensure library/ is on include_path
set_include_path(implode(PATH_SEPARATOR, array(
    realpath(APPLICATION_PATH . '/../library'),
    realpath(APPLICATION_PATH . '/models'),
    realpath(APPLICATION_PATH . '/modules/admin/models'),
    realpath(APPLICATION_PATH . '/modules/authen/models'),
    realpath(APPLICATION_PATH . '/modules/default/models'),
    realpath(APPLICATION_PATH . '/modules/monitor/models'),
    
    get_include_path(),
)));

//start session
//Zend_Session::start();

/** Zend_Application */
require_once 'Zend/Application.php';



// Create application, bootstrap, and run
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);

require_once 'Acl.php';
require_once 'Verify.php';
$acl = new Authen_Model_Acl();//自定义的Acl类
$fc = Zend_Controller_Front::getInstance();//取得Zend_Controller_Front类实例
$fc -> registerPlugin(new Authen_Model_Verify($acl));


$application->bootstrap()
            ->run();