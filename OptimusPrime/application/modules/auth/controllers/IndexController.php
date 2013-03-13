<?PHP
class Auth_IndexController extends Zend_Controller_Action
{
	public function init(){
		include_once("class.authManagement.php");
		$this->smarty=Zend_Registry::get("smarty");
		$this->smarty->assign("menu",Zend_Registry::get('menu'));
		$this->smarty->assign('left_navi',$this->smarty->fetch('common/navi.html'));
		/*
		$this->user = new users();
		$isLogin=$this->user->checkLoginStatus(strtoupper(Zend_Session::getId()),$user_id);
		if (!$isLogin){
			header('Location: /login');	
		}
		*/
		$this->userinfo = Zend_Registry::get("userinfo");
		$this->p=$this->getRequest()->getParams();
		if (!$this->userinfo){
			header("Location: /login");	
		}
		//$this->auth = new acl();
		$this->zend_acl = Zend_Registry::get('zend_acl');
		//$this->auth->getAuth();
		
	}
	
	public function indexAction(){
		/*
		$acl = new Zend_Acl();
		$acl ->addRole(new Zend_Acl_Role('guest'))
			 ->addRole(new Zend_Acl_Role('admin'));
		$p = array('guest','admin');
		$acl ->addRole(new Zend_Acl_Role('annoymous'),$p);
		$acl ->add(new Zend_Acl_Resource('someResource'));
		
		$acl ->add(new Zend_Acl_Resource('oneResource'),'someResource');
		$acl -> allow('guest','someResource');
		echo $acl->isallowed('annoymous','oneResource')?"allowed":"denied";
		print_r($acl);
		echo "<BR>";
		print_r($acl->getRoles( ));
		echo "<BR>";
		print_r($acl->get('someResource'));
		*/
	}
	
	public function userlistAction(){
			
	}
	
}
?>