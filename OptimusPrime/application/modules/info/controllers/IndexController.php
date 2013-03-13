<?PHP
class Info_IndexController extends Zend_Controller_Action{
	public function init()
    {
        /* Initialize action controller here */
		$this->userinfo = Zend_Registry::get("userinfo");
		if (!$this->userinfo){
			header("Location: /login");	
		}

		$this->smarty=Zend_Registry::get("smarty");
		$this->smarty->assign('left_navi',$this->smarty->fetch('common/navi.html'));
		
    }
	
	public function indexAction(){
		echo "test";	
	}
	
	public function inputAction(){
		$this->smarty->assign("index_list","input_record");
		$this->display();
	}
	
	private function display(){
		$this->smarty->display("defaults/index.html");	
	}
}
?>