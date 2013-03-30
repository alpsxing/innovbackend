<?php

class Sysmgr_LogController extends Zend_Controller_Action {

    public function init() {
        /* Initialize action controller here */
        $this->_helper->layout->disableLayout();
    }

    public function indexAction() {
        // action body
        $query = $this->_request->getParam("query");
        $this->view->queryStr = $query;
    }

    public function listAction() {
        
        $this->_helper->viewRenderer->setNoRender();
        header('Content-type: application/json');
        
        $stime = $this->_request->getParam("stime");
        $etime = $this->_request->getParam("etime");
        
        $userid = $this->_request->getParam("userid");
        $content = $this->_request->getParam("content");
       
        
        $logObj = new Sysmgr_Model_Log();
        $result = $logObj->getLogs($userid, $stime, $etime, $content);
        
        $array = array();
        $count = count($result);
        
        $array['total'] = $count;
        $array['rows'] = $result;
        
        $json = Zend_Json::encode($array);
        echo $json;
        
    }

}

