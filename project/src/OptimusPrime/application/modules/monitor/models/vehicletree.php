<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of vehicletree
 *
 * @author jq
 */
class Monitor_Model_Vehicletree {
    private $_dba;
    
    public function __construct($dba) {
        $this->_dba = $dba;
    }
    
    public function getTreeByClient($clientId)
    {
        $select = $this->_dba->select();
        $select->from('client', array('id', 'text'=>'name'))
                ->where('id = ?', $clientId);
        $result = $this->_dba->fetchrow($select);
        $result["attributes"] = 'c';
        $result["children"] = $this->getGroup($clientId);
        $tree = array();
        //easyui的tree需要这个格式，多加一层array包裹
        array_push($tree, $result);
        return $tree;
    }
    
    public function getNodesByGroup($groupId)
    {
        return $this->getVehicles($groupId);
    }
    
    private function getGroup($clientId)
    {
        $select = $this->_dba->select();
        $select->from('client_group', array('id'=>'client_group.group_id', 'text'=>'vehgroup.name'))
                ->join('vehgroup', 'client_group.group_id = vehgroup.id', array())
                ->where('client_id = ?', $clientId);
        $result = $this->_dba->fetchAll($select);
        foreach($result as &$group){
            $group["state"] = 'closed';
            $group["attributes"] = 'g';
            //$group["children"] = $this->getVehicles($group['id']);
        }
        return $result;
    }
    
    private function getVehicles($groupId)
    {
        $select = $this->_dba->select();
        $select->from('vehicle', array('id', 'text'=>'code'))
                ->where('group_id = ?', $groupId);
        $result = $this->_dba->fetchAll($select);
        foreach($result as &$v){
            $v["attributes"] = 'v';
        }
        return $result;
    }
}

?>
