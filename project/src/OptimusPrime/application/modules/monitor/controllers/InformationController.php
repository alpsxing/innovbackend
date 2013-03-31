<?php

class Monitor_InformationController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
       
        
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender();

    }

    public function westmenuAction()
    {
    }
    
    public function vehiclepositionAction()
    {
        $json = '{"total":28,"rows":[
	{"code":"FI-SW-01","name":"Koi","price":10.00},
	{"code":"K9-DL-01","name":"Dalmation","price":12.00},
	{"code":"RP-SN-01","name":"Rattlesnake","price":12.00},
	{"code":"RP-SN-01","name":"Rattlesnake","price":12.00},
	{"code":"RP-LI-02","name":"Iguana","price":12.00},
	{"code":"FL-DSH-01","name":"Manx","price":12.00},
	{"code":"FL-DSH-01","name":"Manx","price":12.00},
	{"code":"FL-DLH-02","name":"Persian","price":12.00},
	{"code":"FL-DLH-02","name":"Persian","price":12.00},
	{"code":"AV-CB-01","name":"Amazon Parrot","price":92.00}
]}';
        header('Content-type: application/json');
        echo $json;
    }
}