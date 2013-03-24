<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of LoginController
 *
 * @author apple
 */
class Authen_LoginController extends Zend_Controller_Action {

    public function init() {
        /* Initialize action controller here */
        $this->_helper->layout->disableLayout();
    }

    public function indexAction() {
        // action body
        $msg = $this->_request->getParam("message");
        $this->view->message = $msg;
    }

    public function loginAction() {

        $post_arr = $this->getRequest()->getParams();
        $username = trim(htmlspecialchars($post_arr['username']));
        $password = trim(htmlspecialchars($post_arr['password']));

        $db = Zend_Registry::get("dbAdapter");
        $authenAdapter = new Authen_Model_Auth($username, $password, $db);
        $result = Zend_Auth::getInstance()->authenticate($authenAdapter);

        switch ($result->getCode()) {
            case Zend_Auth_Result::SUCCESS:
                if (Zend_Registry::isRegistered('mainUrl')) {
                    $url = Zend_Registry::get('mainUrl');
                } else {
                    $url = 'authen/login/index';
                }
                $this->_redirect($url);
                break;
            case Zend_Auth_Result::FAILURE:
            default:
                $this->_redirect("authen/login/index", $result->getMessages());
                break;
        }
    }

    public function logoutAction() {
        Zend_Auth::getInstance()->clearIdentity();
        $namespace = Zend_Auth::getInstance()
                ->getStorage()
                ->getNamespace();
        unset($namespace);
        $this->_redirect("authen/login/index");
    }

    public function chgpwdAction() {
        
    }

    public function dochgpwdAction() {

        $this->_helper->viewRenderer->setNoRender();
        header('Content-type: application/json');

        $post_arr = $this->getRequest()->getParams();
        $oldpwd = trim(htmlspecialchars($post_arr['changePwd_OldPwd']));
        $newpwd = trim(htmlspecialchars($post_arr['changePwd_NewPwd']));
        //$renewpwd = trim(htmlspecialchars($post_arr['changePwd_NewRePwd']));
        $result = array('status' => false, 'msg' => '密码修改失败，请重试');
        try {

            $userinfo = Authen_Model_Acl::getUserInfo();
            if (!$userinfo) {
                $result = array('status' => false, 'msg' => '登陆过期，请重新登陆');
            } else {
                if (md5($oldpwd) != $userinfo['passwd']) {
                    $result = array('status' => false, 'msg' => '旧密码错误');
                } else {
                    $user = new Authen_Model_Users(Zend_Registry::get('dbAdapter'));
                    if ($user->changePwd($userinfo['id'], $newpwd)) {
                        $result = array('status' => true, 'msg' => '密码修改成功');
                    } else {
                        $result = array('status' => false, 'msg' => '密码修改失败，请重试');
                    }
                }
            }
        } catch (Zend_Exception $e) {
            
        }

        $json = Zend_Json::encode($result);
        echo $json;
    }

}

