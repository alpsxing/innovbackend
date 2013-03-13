<?PHP
class Menu{

	public function __construct(){
		$this->db = Zend_Registry::get("db");
		$this->userinfo=Zend_registry::get('userinfo');
		$this->zend_acl = Zend_Registry::get('zend_acl');
	}

	public function getmenu(){
		$select = $this->db->select();
		$select -> from ('controllerlist');
		$rawlist = $this->db->fetchall($select);
		//取出允许的
		$reources=$this->zend_acl->getResources();
		foreach ($rawlist as $key => $var){
			if (!empty($var['module']) and ($var['menu']) and $this->zend_acl -> isallowed($this->userinfo['username'],$reources[0],$var['module'].$var['controller'].$var['action'])){
				$allowed[$var['tree_parent']]['children'][] = $var;
			}
		}
		$menu_parent = array_keys($allowed);
		foreach ($menu_parent as $var){
			$allowed[$var]['father'] = $rawlist[$var];
		}
		return $allowed;
	}
}
?>