<?php

class IndexController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
		$this->userinfo=Zend_registry::get('userinfo');
		if (!$this->userinfo){
			header('Location: /login');	
		}
		$this->smarty=Zend_Registry::get("smarty");
		$this->smarty->assign("menu",Zend_Registry::get('menu'));
		$this->smarty->assign('left_navi',$this->smarty->fetch('common/navi.html'));
    }

    public function indexAction()
    {
        // action body
		$this->smarty->caching = false;
		//$this->smarty->display("defaults/index.html");
		$this->showdisplay();
    }
	
	public function infoAction(){
		phpinfo();	
	}
	public function treeAction(){
		//$this->smarty->assign('index_list',"input record");
		
	}

	
	private function showdisplay(){
		$this->smarty->display("defaults/index.html");	
	}
}

