<?PHP
class Login_IndexController extends Zend_Controller_Action
{
	public function init(){
		$this->smarty=Zend_Registry::get("smarty");
		$this->user = new users();
		$isLogin=$this->user->checkLoginStatus(strtoupper(Zend_Session::getId()),$user_id);
		if ($isLogin){
			header('Location: /');	
		}
		
	}
	
	public function indexAction(){
		$post_arr = $this->getRequest()->getParams();
		if ( $post_arr['act'] != 'login' ){
			$this->smarty->display("login/login.html");
			return ;
		}
		$username = trim(htmlspecialchars($post_arr['username']));
		$password = trim(htmlspecialchars($post_arr['password']));
		$login=$this->user->login($username,$password);
		if ($login){
			header('Location: /');
		}else{
			header('Location:/login/');
		}
	}
	
	public function logoutAction(){
		$this->user->logout();
		header("Location: /login/");	
	}
	
}
?>