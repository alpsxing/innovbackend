<?php

class Monitor_CmdController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
        $this->_helper->layout->disableLayout();        
    }

    public function indexAction()
    {
        // action body
    }

    public function sendcmdAction()
    {
    }
    
    public function setterminalAction()
    {
    }

    public function setnetworkAction()
    {
    }
    
    public function terminalcontrolAction()
    {
    }

    public function positionreportAction()
    {
    }
    
    public function specifyserverAction()
    {
        
    }
    
    public function phoneAction()
    {
        
    }

    public function alarmAction()
    {
        
    }

    public function multimediaAction()
    {
        
    }

    public function gnssAction()
    {
        
    }

    public function traceAction()
    {
        
    }

    public function sendmessageAction()
    {
        
    }

    public function questionAction()
    {
        
    }

    public function callbackAction()
    {
        
    }

    public function phonebookAction()
    {
        
    }

    public function vehiclecontrolAction()
    {
        
    }

    public function cameraAction()
    {
        
    }

    public function recorderAction()
    {
        
    }

    public function initnetworkformAction()
    {
        header('Content-type: application/json');
        $vid = $this->getRequest()->getParam('id');
        $this->_helper->viewRenderer->setNoRender();
        $dba = Zend_Registry::get("dbAdapter");
        $paraObj = new Monitor_Model_Parameter($dba);
        $ret = $paraObj->getNetworkParameter($vid);
        $json = Zend_Json::encode($ret);
        echo $json;
     }

    public function initpositionreportAction()
    {
        header('Content-type: application/json');
        $vid = $this->getRequest()->getParam('id');
        $this->_helper->viewRenderer->setNoRender();
        $dba = Zend_Registry::get("dbAdapter");
        $paraObj = new Monitor_Model_Parameter($dba);
        $ret = $paraObj->getPositionReportParameter($vid);
        $json = Zend_Json::encode($ret);
        echo $json;
     }

    public function initphoneAction()
    {
        header('Content-type: application/json');
        $vid = $this->getRequest()->getParam('id');
        $this->_helper->viewRenderer->setNoRender();
        $dba = Zend_Registry::get("dbAdapter");
        $paraObj = new Monitor_Model_Parameter($dba);
        $ret = $paraObj->getPhoneParameter($vid);
        $json = Zend_Json::encode($ret);
        echo $json;
     }

    public function initalarmAction()
    {
        header('Content-type: application/json');
        $vid = $this->getRequest()->getParam('id');
        $this->_helper->viewRenderer->setNoRender();
        $dba = Zend_Registry::get("dbAdapter");
        $paraObj = new Monitor_Model_Parameter($dba);
        $ret = $paraObj->getAlarmParameter($vid);
        $json = Zend_Json::encode($ret);
        echo $json;
     }

}

