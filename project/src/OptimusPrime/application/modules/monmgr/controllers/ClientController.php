<?php

class Monmgr_ClientController extends Zend_Controller_Action
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
    
    public function listAction()
    {
        $this->_helper->viewRenderer->setNoRender();
        header('Content-type: application/json');
        
    }
    public function addAction()
    {
        $this->_helper->viewRenderer->setNoRender();
        header('Content-type: application/json');
        
    }
    public function updateAction()
    {
        $this->_helper->viewRenderer->setNoRender();
        header('Content-type: application/json');
        
    }
    public function deleteAction()
    {
        $this->_helper->viewRenderer->setNoRender();
        header('Content-type: application/json');
        
    }
    


}

