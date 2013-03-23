<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Verify
 *
 * @author apple
 */
class Authen_Model_Verify extends Zend_Controller_Plugin_Abstract {

    /**
     * 访问控制列表对象
     * @var object
     */
    protected $_acl;

    /**
     * 登录的用户名
     * @var string 
     */
    protected $_loginname;

    /**
     * 构造函数
     * 初始化访问控制列表
     * @param Acl $acl
     * @todo 未登录的时候,$this -> _loginname是为空的
     */
    public function __construct($acl) {
        $this->_acl = $acl;
        require_once('Zend/Auth.php');
        $this->_loginname = Zend_Auth::getInstance()->getIdentity(); //eg:张三
    }

    /**
     * 重写父类的preDispatch方法
     * 
     * @param Zend_Controller_Request_Abstract $request
     */
    public function preDispatch(Zend_Controller_Request_Abstract $request) {
        //请求信息
        $module = $request->module;                //模块
        $controller = $request->controller;            //请求的控制器
        $action = $request->action;                //请求的action

        $resource = ucfirst(strtolower($module . '_' . $controller));    //资源：一个限制访问的对象
        $action = strtolower($action);
        $role = $this->_acl->getRoleInfo();                //角色：一个可以发出请求去访问Resource的对象

        $this->_acl->initRoleMenu($role);

        //判断是否拥有资源
        if (!($this->_acl->has($resource))) {
            $resource = null;
        }

//        $this->_acl->removeAllow($role,$resource);        //可以针对某个role移除权限
        //判断当前用户是有权限执行某个请求
        if (!($this->_acl->isAllowed($role, $resource, $action))) {
            if (!$this->_loginname) {//未登陆的情况
                $module = 'authen';
                $controller = 'login';
                $action = 'index';
            } else {

                //没有权限的情况,测试阶段要打开这个注解。
                /* echo "<script>
                  $.messager.alert('提醒','您没有操作权限', 'warning');
                  </script>";
                  exit(); */
            }
        }
        $request->setModuleName($module);
        $request->setControllerName($controller);
        $request->setActionName($action);
        $this->setModuleId2View($module);
    }
    
    private function setModuleId2View($module) {
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
