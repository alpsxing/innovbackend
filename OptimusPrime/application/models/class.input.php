<?PHP
class input{
	public function __construct(){
		$this->db = Zend_Registry::get("db");
	}
	
	public function getSchoolInfo($school_id){
		$select = $this->db->select();
		$select -> from ('schools')
				-> where ('id in (?)',$school_id);
		return $this->db->fetchall($select);
	}
	
	public function recordlist($school_id){
		$select = $this->db->select();
		$select -> from ('students')
				-> where ('school_id =?',$school_id)
				-> order('grade')
				-> order ('class');
		return $this->db->fetchall($select);	
	}
	
	public function modifyOneRecord($data){
		if ($this->checkExist($data['sid'])){
			return $this->updateOneRecord($data);	
		}else{
			return $this->insertOneRecord($data);
		}
	}
	
	private function insertOneRecord($data){
		return $this->db->insert('students',$data);	
	}
	
	private function updateOneRecord($data){
		return $this->db->update('students',$data,'sid = '.$data['sid']);	
	}
	
	private function checkExist($sid){
		$select = $this->db->select();
		$select -> from ('students',array('id'))
				-> where ('sid =? ' ,$sid)
				-> limit (1);
		$result = $this->db->fetchrow($select);
		if (!empty($result)){
			return true;	
		}else{
			return false;
		}
	}
}
?>