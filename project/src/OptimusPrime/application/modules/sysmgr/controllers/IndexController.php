<?php

class Sysmgr_IndexController extends Zend_Controller_Action {

    public function init() {
        /* Initialize action controller here */
    }

    public function indexAction() {
        // action body
      
    }

    public function westmenuAction() {
        $this->_helper->layout->disableLayout();
    }

    public function roleAction() {
        $this->_helper->layout->disableLayout();
    }

}

