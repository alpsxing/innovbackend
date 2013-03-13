<?PHP

class acl{
	public function __construct(){
		$this->db = Zend_Registry::get("db");
		$this->userinfo=Zend_registry::get('userinfo');
		$this->zend_acl = new Zend_Acl();
		$this->getGroupAuth();
		$this->setSelfAuth();
		Zend_Registry::set("menu",$this->getmenu());
	}
	
	public function setSelfAuth(){
		$this->zend_acl ->addRole(new Zend_Acl_Role($this->userinfo['username']));
		foreach ($this->resourceid_arr as $var){
			$this->zend_acl ->add(new Zend_Acl_Resource($var));
			//$this->zend_acl ->allow($this->userinfo['username'],$var);
			$this->zend_acl ->allow($this->userinfo['username'],$var,$this->allowedControllers);
		}
		/*
		foreach ($this->allowedControllers as $var){
			$acl ->add(new Zend_Acl_Resource($var));
			$acl ->allow($this->userinfo['username'],$var);
		}*/
		Zend_registry::set("zend_acl",$this->zend_acl);
	}
	
	public function getAuth(){
		print_r($this->userinfo);
		print_r($this->controllers);
		print_r($this->zend_acl);
		
	}
	
	private function getGroupAuth(){
		$groupinfo = $this->getGroupInfo();
		//print_r($groupinfo);
		$resourceid = array();
		$controllers = array();
		foreach ($groupinfo as $var){
			//print_r(explode(",", $var['auth_resource']));exit;
			if ( substr_count($var['auth_resource'],",")){
				$arr = 	explode(",",$var['auth_resource']);
			}else{
				$arr = array($var['auth_resource']);	
			}
			if (!empty($var['auth_resource'])){
				$resourceid = array_merge($resourceid,$arr);	
			}
			if ( substr_count($var['controller_list'],",")){
				$controllersarr = 	explode(",",$var['controller_list']);
			}else{
				$controllersarr = array($var['controller_list']);	
			}
			if (!empty($var['controller_list'])){
				$controllers=array_merge($controllers,$controllersarr);	
			}
		}
		$this->resourceid_arr = array_unique($resourceid);
		if ($this->userinfo['groupid'] == 1){
			$this->resourceid_arr = $this->getAllResource();
			$select = $this->db->select();
			$select -> from ('controllerlist','id');
			$this->controllers= $this->db->fetchcol($select);
		}else{
			$this->controllers = array_unique($controllers);
		}
		$this->fetchControllers();
	}
	
	private function fetchControllers(){
		$select = $this->db->select();
		$select -> from ('controllerlist');
		if ($this->userinfo['groupid'] != 1)
		$select	-> where ('id in (?)',$this->controllers);
		$result = $this->db->fetchall($select);
		foreach ($result as $var){
			$this->allowedControllers[]=$var['module'].$var['controller'].$var['action'];
		}
	}
	
	private function getAllResource(){
		$select = $this->db->select();
		$select -> from ('schools','id');
		return $this->db->fetchcol($select);
			
	}
	
	public function getGroupInfo(){
		$select = $this->db->select();
		$select -> from ('usergroups')
				-> where ('id =? ',$this->userinfo['groupid'])
				-> limit (1);
		$result = $this->db->fetchall($select);
		if ($result[0]['inherts_from'] == 0){
			
		}else{
			$inherts_from = $result[0]['inherts_from'];
			while( $inherts_from != 0){
				$result[] = $this->fetchInherts($inherts_from);
				$last = end($result);
				$inherts_from = $last['inherts_from'];
			}
		}
		return $result;
		
	}
	private function find_child($ar, $id='id', $pid='pid') {
	  foreach($ar as $v) $t[$v[$id]] = $v;
		  foreach ($t as $k => $item){
			if( $item[$pid] ) {
			  $t[$item[$pid]]['child'][$item[$id]] =& $t[$k];
		
			  $t[$k]['reference'] = true;
			}
		  }
	  return $t;
	}
	
	private function find_parent($ar, $id='id', $pid='pid') { 
	  foreach($ar as $v) $t[$v[$id]] = $v;
		  foreach ($t as $k => $item){
			if( $item[$pid] ){
			  if( ! isset($t[$item[$pid]]['inhert_from'][$item[$pid]]) )
				 $t[$item[$id]]['inhert_from'][$item[$pid]] =& $t[$item[$pid]];
		
				  $t[$k]['reference'] = true;
			}
		  } 
	  return $t;
	}
	
	public function getAllGroup(){
		$select = $this->db->select();
		$select -> from ('usergroups');
		return $this->db->fetchall($select);	
	}
	
	public function getChildGroup(){
		if ($this->userinfo['groupid'] == 1){
				$groups = $this->getAllGroup();
		}else{
			$groups = $this->getGroupInfo();
		}
		foreach ($groups as $key=>$var){
			if ($var['id'] == $this->userinfo['groupid']){
				unset ($groups[$key]);
			}else{
				$groups[$key]['function'] = $this->getAllowedController	(explode(",",$var['controller_list']));
			}
		}
		return $groups;
	}
	
	private function fetchInherts($inherts_from){
		$select = $this->db->select();
		$select -> from ('usergroups')
				-> where ('id =? ',$inherts_from)
				-> limit(1);
		return $this->db->fetchrow($select);	
	}
	
	private function getAllowedController($controller_list){
		$select = $this->db->select();
		$select -> from ('controllerlist')
				-> where ('id in (?)',$controller_list);
		return $this->db->fetchall($select);	
	}
	
	public function getAuthoriedResource(){
		return $this->zend_acl->getResources();	
	}
	
	public function getCurrentAllowedController(){
		if ($this->userinfo['groupid'] != 1){
			$select = $this->db->select();
			$select -> from ('usergroups');
			$select	-> where('id = ?',$this->userinfo['groupid'])
					-> limit(1);
			$currentgroup = $this->db->fetchrow($select);
			$select = $this->db->select();
			$select -> from ('controllerlist')
					-> where ('id in (?)', explode(",",$currentgroup['controller_list']));
		}else{
			$select = $this->db->select();
			$select -> from ('controllerlist')
					-> where ('tree_parent >0');	
		}
		return $this->db->fetchall($select);
	}
	
	public function getmenu(){
		$select = $this->db->select();
		$select -> from ('controllerlist');
		$rawlist = $this->db->fetchall($select);
		//取出允许的
		/* 暂时屏蔽 
		$reources=$this->zend_acl->getResources();
		*/
		foreach ($rawlist as $key => $var){
			//if (!empty($var['module']) and ($var['menu']) and $this->zend_acl -> isallowed($this->userinfo['username'],$reources[0],$var['module'].$var['controller'].$var['action'])){
				$allowed[$var['tree_parent']]['children'][] = $var;
			//}
		}
		$menu_parent = array_keys($allowed);
		foreach ($menu_parent as $var){
			$allowed[$var]['father'] = $rawlist[$var];
		}
		
		return $allowed;
	}
	
	public function createGroup($arr){
		
	}
	
}
?>