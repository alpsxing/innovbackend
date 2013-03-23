<?php

require_once 'Users.php';

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Auth
 *
 * @author quxy
 */

class Authen_Model_Auth implements Zend_Auth_Adapter_Interface{
    private $_useraccount;
    private $_password;
    private $_db;
    /**
     * 构造函数 设置用户名和密码 数据连接对象   
     * 
     * @return void      
     */
    public function __construct($useraccount,$password,$db){   
        $this->_useraccount = $useraccount;
        $this->_password      = $password;
        $this->_db             = $db; 
    }
    
    /**     
     * 进行认证  
     * @throws Zend_Auth_Adapter_Exception    
     * @return Zend_Auth_Result
     * 
     */
    public function authenticate()
    {   
        //获得登录用户信息
        $userObj = new Authen_Model_Users($this->_db);
        $message = "";
        $result = $userObj->login($this->_useraccount,$this->_password, $message);
         //默认情况下是认证失败
        $authResult = array(
            'code'     => Zend_Auth_Result::FAILURE,//详参：Zend_Auth_Result
            'identity' => '',
            'info' => array('message'=>$message)
        );
         
        //判断是否有数据,是则赋值
        if ($result) {//认证成功,则将用户信息存储到session中
             $authResult = array(
                'code'     => Zend_Auth_Result::SUCCESS,
                'identity' => $userObj->getUserName(),
                'info'     => array('message'=>$message)
            );
             //角色存储  个人缓存空间
            $namespace = Zend_Auth::getInstance()//单例模式
                                 -> getStorage() 
                                 -> getNamespace();
            
            
            
            $_SESSION[$namespace]['role'] = $userObj->getUserName();
            $_SESSION[$namespace]['userInfo'] = $result;  
            $_SESSION[$namespace]['acklist'] = $userObj->getAclList();
            $_SESSION[$namespace]['menulist'] = $userObj->getMenuList();
        }
  
        return new Zend_Auth_Result($authResult['code'], $authResult['identity'], $authResult['info']);
    }
}