<?PHP
class Info_InputController extends Zend_Controller_Action{
	
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
		include_once("class.input.php");
		$this->input= new input();
    }
	
	public function indexAction(){
		$schoolsid = $this->zend_acl->getResources();
		
		if (!$this->p['school'] && (count($schoolsid)>1)){
			$schools = $this->input->getSchoolInfo($schoolsid);
			$this->smarty->assign("schools",$schools);
		}else{
			$schools = $this->input->getSchoolInfo(($this->p['school'])?$this->p['school']:$schoolsid[0]);
			$this->smarty->assign('schooltitle',$schools[0]['school_name']);
			$this->smarty->assign('school_id',$schools[0]['id']);	
		}
		$body = $this->smarty->fetch("info/inputindex.html");
		$this->smarty->assign("index_list",$body);
		$this->display();	
	}
	
	public function inputAction(){
		//$this->smarty->assign("index_list","input_record");
		//$this->display();
		$data = $_POST;
		$data['modify_by'] =$this->userinfo['id'];
		$data['last_modify_date'] = date("Y-m-d H:i:s",time());
		try {
			$this->input->modifyOneRecord($data);
			echo "成功录入";
		}catch (Exception $e){
			echo "录入失败".json_encode($e);	
		}
		
	}
	
	public function importAction(){
		$schoolsid = $this->zend_acl->getResources();
		
		if (!$this->p['school'] && (count($schoolsid)>1)){
			$schools = $this->input->getSchoolInfo($schoolsid);
			$this->smarty->assign("schools",$schools);
		}else{
			$schools = $this->input->getSchoolInfo(($this->p['school'])?$this->p['school']:$schoolsid[0]);
			$this->smarty->assign('schooltitle',$schools[0]['school_name']);
			$this->smarty->assign('school_id',$schools[0]['id']);	
		}
		$body = $this->smarty->fetch("info/importindex.html");
		$this->smarty->assign("index_list",$body);
		$this->display();
	}
	
	public function uploadAction(){
		//file_put_contents('/usr/local/www/sms.21com.com/log.txt',"File Upload start\r\n",FILE_APPEND);
		$error = "";
		$msg = "";
		$fileElementName = 'fileToUpload';
		if(!empty($_FILES[$fileElementName]['error']))
		{
			switch($_FILES[$fileElementName]['error'])
			{
	
				case '1':
					$error = '文件过大';
					break;
				case '2':
					$error = '文件过大';
					break;
				case '3':
					$error = '文件上传不完整，请重试';
					break;
				case '4':
					$error = '没有文件上传';
					break;
	
				case '6':
					$error = '文件上传失败';
					break;
				case '7':
					$error = '文件上传失败';
					break;
				case '8':
					$error = '文件上传失败';
					break;
				case '999':
				default:
					$error = '文件上传失败';
			}
		}elseif(empty($_FILES['fileToUpload']['tmp_name']) || $_FILES['fileToUpload']['tmp_name'] == 'none')
		{
			$error = '没有文件上传';
		}else 
		{

				$ext=substr($_FILES['fileToUpload']['name'], strrpos($_FILES['fileToUpload']['name'], '.')+1);
				$newFileName = "/usr/local/www/sms.21com.com/tmp/".md5(time()).".".$ext;
				copy($_FILES['fileToUpload']['tmp_name'],$newFileName);
				include_once("PHPExcel/PHPExcel/IOFactory.php");
				$inputFileName = $newFileName;
				switch ($ext){
					case "xls":
						$xlsReader=PHPExcel_IOFactory::createReader("Excel5");
					break;
					case "xlsx":
					default:
						$xlsReader=PHPExcel_IOFactory::createReader("Excel2007");
					break;	
				}
				//file_put_contents('/usr/local/www/sms.21com.com/log.txt',var_dump($inputFileName)."\r\n",FILE_APPEND);
				try{
					$objPHPExcel = $xlsReader->load($inputFileName);
					$sheetData = $objPHPExcel->getActiveSheet()->toArray(null,true,true,true);
					//file_put_contents('/usr/local/www/sms.21com.com/log.txt',json_encode($sheetData),FILE_APPEND);
				}catch (Exception $e){
					$error=$e->getmessage();
				}
				//file_put_contents('/usr/local/www/sms.21com.com/log.txt',"runs here\r\n",FILE_APPEND);
				@unlink($_FILES['fileToUpload']);
				$records=0;
				
				for($i=2;$i<count($sheetData)+1;$i++){
					if ($sheetData[$i]['A'] != 'null'){
						$data = array(
							'school_id'=>$_POST['school_id'],
							'sid'=>$sheetData[$i]['A'],
							'name'=>$sheetData[$i]['B'],
							'grade'=>$sheetData[$i]['C'],
							'class'=>$sheetData[$i]['D'],
							'address'=>htmlspecialchars($sheetData[$i]['E']),
							'parent_phone'=>$sheetData[$i]['F'],
							'last_modify_date'=>date("Y-m-d H:i:s",time()),
							'modify_by'=>$this->userinfo['id']
						);
						$this->input->modifyOneRecord($data);
						$records++;
					}
				}
				
		}		
		echo "{";
		echo				"error: '" . $error . "',\n";
		echo				"msg: '".$records."条记录更新／录入'\n";
		echo "}";
		//echo "msg:".json_encode($_FILES)."}";
	}
	
	public function recordlistAction(){
		$schoolsid = $this->zend_acl->getResources();
		if (!$this->p['school'] && (count($schoolsid)>1)){
			$schools = $this->input->getSchoolInfo($schoolsid);
			$this->smarty->assign("schools",$schools);
		}else{
			$schools = $this->input->getSchoolInfo(($this->p['school'])?$this->p['school']:$schoolsid[0]);
			$this->smarty->assign('schooltitle',$schools[0]['school_name']);
			$this->smarty->assign('school_id',$schools[0]['id']);
			$records=$this->input->recordlist($schools[0]['id']);
			$this->smarty->assign('records',$records);
		}
		$body = $this->smarty->fetch("info/recordlist.html");
		$this->smarty->assign("index_list",$body);
		$this->display();	
	}
	
	private function display(){
		$this->smarty->display("defaults/index.html");	
	}
}
?>