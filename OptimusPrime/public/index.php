<?php

ob_start();
session_start();
ini_set("display_errors", true);
error_reporting(E_ALL ^ E_NOTICE);
date_default_timezone_set('Asia/Shanghai');
// Define path to application directory
/*defined('APPLICATION_PATH')
    || define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application'));
*/
define('APPLICATION_PATH','/usr/local/www/gps.21com.com/application');
defined('ROOT_PATH') || define('ROOT_PATH',dirname(dirname(__FILE__)));
// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));
// Ensure library/ is on include_path
set_include_path(implode(PATH_SEPARATOR, array(
    realpath(APPLICATION_PATH . '/../library'),
	APPLICATION_PATH . '/models',
	APPLICATION_PATH . '/templates',
    get_include_path()
)));
require_once 'Zend/Loader/Autoloader.php';
Zend_Loader_Autoloader::getInstance();
/** Zend_Application */
require_once 'Zend/Application.php';
include_once 'Zend/Session.php';
include_once 'Smarty/Smarty.class.php';
include_once 'class.users.php';
include_once 'class.acl.php';
include_once("CommonFunction.php");
// Create application, bootstrap, and run
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);

//$db = new Zend_Db;


$smarty =  new Smarty();
$smarty->caching = 2;
$smarty->cache_lifetime =1; 
$smarty->debugging = false; 
$smarty->left_delimiter  = '{/'; 
$smarty->right_delimiter = '/}';
$smarty->template_dir = ROOT_PATH.'/templates'; 
$smarty->compile_dir = ROOT_PATH.'/templates/compile';
$smarty->cache_dir  = ROOT_PATH.'/templates/cache';
Zend_Registry::set('smarty',$smarty);
Zend_Loader::loadClass('Zend_Controller_Front');



//user phpapi pwd ssS8TtdPE2VusUh8

/**
 * 将路由器注入到前端控制器
 */
$frontController = Zend_Controller_Front::getInstance ();

$frontController->setControllerDirectory ( array (
	'default' => APPLICATION_PATH . '/default/controller'
	)
);

$baseUrl = '/';
//$router = $frontController->getRouter();
$router = new Zend_Controller_Router_Rewrite();
/*
$route = new Zend_Controller_Router_Route(
    'api/:cell',
    array(
		'module'=>'api',
        'controller' => 'index',
        'action'     => 'index'
    )
);
$compat = new Zend_Controller_Router_Route_Module(array(), 
                                                  $dispatcher, 
                                                  $request);
$router->addRoute('default', $compat);
$router->addRoute('api', $route);
*/
$config = new Zend_Config_Ini(APPLICATION_PATH . '/configs/config.ini', 'production');
$router->addConfig($config, 'routes');

//$router->addRoute('location', $route);
$frontController->setRouter($router);
//$frontController->addRouter($route_lo);
$frontController->setParam('noViewRenderer', true);
$frontController->setParam('throwExceptions',true);
//print_r($frontController->getRouter( ));
$frontController->throwExceptions(true);
//$frontController->dispatch();

$application->bootstrap()
            ->run();
