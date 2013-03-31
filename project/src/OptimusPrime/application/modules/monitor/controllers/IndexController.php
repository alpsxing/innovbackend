<?php

class Monitor_IndexController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
       
    }

    public function westmenuAction()
    {
        $this->_helper->layout->disableLayout();
    }
    
    public function southmenuAction()
    {
        $this->_helper->layout->disableLayout();
    }

    public function indexAction()
    {
        // action body
    }
    
    public function vehicletreeAction()
    {
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender();
//        $json = '[{"text":"客户1"},{"id":2,"text":"客户2","children":[{
//                        "id":3,
//                        "text":"分组1",
//                        "children":[{"id":5,
//                        "text":"京Gvy622"},{"id":6, "text":"京V2012"}]
//		},{
//			"text":"ford"
//		}]}]';
//        header('Content-type: application/json');
        $dba = Zend_Registry::get("dbAdapter");
        $treeObj = new Monitor_Model_Vehicletree($dba);
        $ret = $treeObj->getTreeByClient(1);
        $json = Zend_Json::encode($ret);
        echo $json;
    }
    
    public function groupvehicleAction()
    {
        header('Content-type: application/json');
        $gid = $this->getRequest()->getParam('gid');
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender();
        $dba = Zend_Registry::get("dbAdapter");
        $treeObj = new Monitor_Model_Vehicletree($dba);
        $ret = $treeObj->getNodesByGroup($gid);
        $json = Zend_Json::encode($ret);
        echo $json;
    }
    
    public function regiontreeAction()
    {
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender();
        $json = '[{"id":1,"text":"regioncustomer1"},{"id":2,"text":"regioncustomer2","children":[{
			"text":"benz",
			"checked":true
		},{
			"text":"ford"
		}]}]';
        header('Content-type: application/json');
        echo $json;
    }

}

