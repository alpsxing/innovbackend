<?PHP
class users{
	public function __construct(){
		$this->db = Zend_Registry::get("db");
		
	}
	
	public function checkLoginStatus($session_id,&$user_id){
		$select = $this->db->select();
		$select -> from ('session')
				-> where ('session_id =?', $session_id)
				-> limit (1);
		$result = $this->db->fetchrow($select);
		//60分钟超时退出
		if ((time() - $result['last_act_time'])>3600 ){
			return false;	
		}else{
			$user_id = $result['user_id'];
			return true;	
		}
	}
	
	public function getInfo($user_id){
		$select = $this->db->select();
		$select -> from ('users')
				-> where ('id = ?',$user_id)
				-> where ('status =1')
				-> limit (1);
		try {
			return $this->db->fetchrow($select);
		}
		catch (Zend_Db_Exception $e) {
			exit('Database Connect Fail!');
		}	
	}
	public function login($username,$password){
		$select = $this->db->select();
		$select -> from ('users')
				-> where ('username = ?',$username)
				-> where ('status = 1')
				-> limit (1);
		$result = $this->db->fetchrow($select);
		if ($result['tried'] >5 && (time() - $result['last_try_time'] )< 300){
			return false;	
		}
		if ($result['passwd'] == md5($password) ){ //成功登陆
			$sql = "UPDATE `users` SET  `last_login_time` =  '".date("Y-m-d H:i:s",time())."', `last_try_time`=UNIX_TIMESTAMP(), `tried`=0 , `last_session_id` = '".strtoupper(Zend_Session::getId())."' WHERE  `id` =".$result['id'].";";
			//echo $sql;exit;
			$this->db->query($sql);
			$this->insertSession($result['id']);
			return true;
		}else{
			if (!empty($result['username'])){ //
				if ((time() - $result['last_try_time'] )< 300){ // 
					$sql="UPDATE `users` SET `last_try_time`=UNIX_TIMESTAMP(), `tried`=`tried`+1 where `id`=".$result['id'].";";
				}else{
					$sql ="UPDATE `users` set `last_try_time`=UNIX_TIMESTAMP(), `tried`=1 where `id`=".$result['id'].";";
				}
					$this->db->query($sql);
			}else{

			}
			
			return false;
		}
	}
	
	public function logout(){
		$sql = "delete from `session` where `session_id` = '".Zend_Session::getId()."';";
		$this->db->query($sql);
	}
	
	public function insertSession($user_id){
		$sql ="DELETE from `session` where `session_id`='".Zend_Session::getId()."';";
		$this->db->query($sql);
		$sql ="INSERT INTO `session` (`id` ,`session_id` ,`user_id` ,`last_act_time`) VALUES (NULL ,  '".strtoupper(Zend_Session::getId())."',  ". $user_id .",  UNIX_TIMESTAMP())";
		$this->db->query($sql);
	}
	
	public function updateSessionTime($user_id){
		$sql = "UPDATE `session` SET `last_act_time`=UNIX_TIMESTAMP() where `session_id` = '".strtoupper(Zend_Session::getId())."' and `user_id`=".$user_id." limit 1";
		$this->db->query($sql);	
	}
	
	public function chgpwd($userid,$newpwd){
		$sql = "UPDATE `users` SET `passwd` = md5(".$newpwd.") where `id` = ".$userid." limit 1";
		try {
			$this->db->query($sql);
			$this->logout();
			return true;
		}catch (Exception $e){
			return false;
		}
	}
}
?>