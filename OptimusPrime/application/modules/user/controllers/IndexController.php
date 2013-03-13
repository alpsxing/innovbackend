<?PHP
class User_IndexController extends Zend_Controller_Action{
	
	public function init(){
        /* Initialize action controller here */
		$this->smarty=Zend_Registry::get("smarty");
		$this->userinfo = Zend_Registry::get("userinfo");
		$this->p=$this->getRequest()->getParams();
		if (!$this->userinfo){
			header("Location: /login");	
		}
		$this->smarty->assign("menu",Zend_Registry::get('menu'));
		$this->smarty->assign('left_navi',$this->smarty->fetch('common/navi.html'));
		$this->acl = new acl();
		//$this->auth->setSelfAuth();
		$this->zend_acl = Zend_registry::get("zend_acl");
		//echo $this->acl->isallowed($this->userinfo['username'],1,$this->p['module'].$this->p['controller'].$this->p['action'])?"resource id 1":"no resource";
		/*
		if ($this->acl->has($this->p['module'].$this->p['controller'].$this->p['action'])){
			echo $this->acl->isallowed($this->userinfo['username'],$this->p['module'].$this->p['controller'].$this->p['action'])?"allowed":"dennied";
		}else{
			echo $this->p['module'].$this->p['controller'].$this->p['action']." is not exist";	
		}
		*/
    }

	public function chgpwdAction(){
		if (!$this->p['submit']){
			$body = $this->smarty->fetch("user/chgpwd.html");
			$this->smarty->assign("index_list",$body);
			$this->display();	
		}else{
			if (md5(trim($this->p['oldpwd'])) != $this->userinfo['password']){
				echo "旧密码错误";
				exit;
			}elseif(($this->p['newpwd1'] != $this->p['newpwd2']) or (empty($this->p['newpwd1']))){
				echo "新密码确认错误";
				exit;
			}else{
				$users = new users();
				if ($users->chgpwd($this->userinfo['id'],trim($this->p['newpwd1']))){
					echo "密码修改完成，请<a href='/'>重新登陆</a>";
				}else{
					echo "密码修改失败，请重试";
				}
			}
		}
	}
	
	public function registrationAction(){
		if ($_POST){
			$resources=$this->acl->getAuthoriedResource();
			print_r($resources);
			echo ($this->zend_acl->isallowed($this->userinfo['username'],$resources[0]))?"allowed":"denied";
				
		}else{
			$groups= $this->acl->getChildGroup();
			$this->smarty->assign('groups',$groups);
			$this->smarty->assign('index_list',$this->smarty->fetch('user/registration.html'));
			$this->display();
		}
	}
	
	public function newgroupAction(){
		echo ($this->zend_acl->isallowed($this->userinfo['username'],1,$this->p['module'].$this->p['controller'].$this->p['action']))?"true":"false";
		print_r($this->userinfo);
		if (!$_POST){
			$groups= $this->acl->getChildGroup();
			//$tree = $this->genTreeHtml($groups,'');
			$this->smarty->assign('controllerlist',$this->acl->getCurrentAllowedController());
			$this->smarty->assign('userinfo',$this->userinfo);
			$this->smarty->assign('index_list',$this->smarty->fetch('user/newgroup.html'));
			$this->display();
		}else{
			print_r($_POST);	
		}

	}
	
	
	
	private function genTreeHtml($group,$function){
		
	}
	
	/*
	private function genTreeHtml($arr,$html ='',$top){
		foreach ($arr as $var){
			if (!$top){
				$html .= '<ul>'	;
			}
			$html .= '<li>
                    <input type="checkbox" value="'.$var['group_name'].'">
                    <label>'.$var['group_name'].'</label>';
			if (is_array($var['inhert_from'])){
				$html .= $this->genTreeHtml($var['inhert_from'],$html,false);	
			}
			$html .= '</li>';
			if (!$top){
				$html .='</ul>';	
			}
		}
		return $html;
	}
	*/
	private function display(){
		$this->smarty->display("defaults/index.html");	
	}
	
	public function testAction(){
		/*
		$format = "%6s %s\n<br />";
		for ($number = 0; $number < 255; $number++)
		{
			if (getprotobynumber ($number))
		
			printf ($format, " $number-->", getprotobynumber ($number));
		}
		*/
		$address = "210.82.111.147";
		$port=1502;
		
		//socket_bind($sock, $address, $port) or die('Could not bind to address');
		
		$buff = '{"header":{"cmd":"1000"},"body":{"name":"test1","pass":"123456","ver":"","type":"","mode":""}}';
		$sock = socket_create(AF_INET, SOCK_STREAM,SOL_TCP);
		//print_r(socket_get_option($sock, SOL_SOCKET, SO_REUSEADDR));exit;
		if($sock = socket_create(AF_INET, SOCK_STREAM,SOL_TCP) and $sock_data = socket_connect($sock, $address, $port)){
			echo "connected";	
			$sock_data = socket_set_option($sock, SOL_SOCKET, SO_BROADCAST, 1); //Set 
			$sock_data = socket_write($sock, $buff, strlen($buff)); //Send data
		}
		//$send  = socket_sendto($sock,$buff,strlen($buff),0,$address,$port);
		$result =  socket_read($sock,2048);
		echo $result;
		socket_close($sock);
	}
}
?>