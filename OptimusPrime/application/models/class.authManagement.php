<?PHP
class authManagement{
	public function __construct(){
		$this->db = Zend_Registry::get("db");
		$this->userinfo = Zend_Registry::get("userinfo");
		$this->zend_acl = Zend_Registry::get('zend_acl');
	}
	
	public function getsubgroup(){
		$select = $this->db->select();
		$select -> from ('groups');
		if ($this->userinfo['groupid'] == 1){	//admin
			
		}else{
			
		}
	}
	
	public function getgroupinfo($group_id){
		$select = $this->db->select();
		$select -> from ('groups')
				-> where ('id in(?)',$group_id);
		return $this->db->fetchall($select);
	}
	
	
	
	
}

?>