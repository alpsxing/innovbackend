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
class Monitor_Model_Parameter {
    private $_dba;
    
    public function __construct($dba) {
        $this->_dba = $dba;
    }
    
    public function getNetworkParameter($vid)
    {
        $select = $this->_dba->select();
        $select->from('device_network_param')
                ->where('device_id = ?', $vid);
        $result = $this->_dba->fetchrow($select);
        return $result;
    }
    
    public function getPositionReportParameter($vid)
    {
        $select = $this->_dba->select();
        $select->from('device_position_report_param')
                ->where('device_id = ?', $vid);
        $result = $this->_dba->fetchrow($select);
        return $result;
    }
    
    public function getPhoneParameter($vid)
    {
        $select = $this->_dba->select();
        $select->from('device_phone_param')
                ->where('device_id = ?', $vid);
        $result = $this->_dba->fetchrow($select);
        return $result;
    }
    
    public function getAlarmParameter($vid)
    {
        $select = $this->_dba->select();
        $select->from('device_alarm_param')
                ->where('device_id = ?', $vid);
        $result = $this->_dba->fetchrow($select);
        return $result;
    }
    
}

?>
