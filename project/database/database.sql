-- MySQL dump 10.13  Distrib 5.5.24, for osx10.5 (i386)
--
-- Host: localhost    Database: gps_database
-- ------------------------------------------------------
-- Server version	5.5.29-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrative_region`
--

DROP TABLE IF EXISTS `administrative_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrative_region` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrative_region`
--

LOCK TABLES `administrative_region` WRITE;
/*!40000 ALTER TABLE `administrative_region` DISABLE KEYS */;
/*!40000 ALTER TABLE `administrative_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alarm_type`
--

DROP TABLE IF EXISTS `alarm_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm_type` (
  `id` int(11) NOT NULL,
  `type_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_type`
--

LOCK TABLES `alarm_type` WRITE;
/*!40000 ALTER TABLE `alarm_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `alarm_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `answer` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_items`
--

DROP TABLE IF EXISTS `book_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_items` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_items`
--

LOCK TABLES `book_items` WRITE;
/*!40000 ALTER TABLE `book_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `book_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circle_region`
--

DROP TABLE IF EXISTS `circle_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circle_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `property` int(11) DEFAULT NULL COMMENT '区域属性，见表 58 区域的区域属性定义\n',
  `center_ latitude` float DEFAULT NULL,
  `center_ longitude` float DEFAULT NULL,
  `radius` float DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `max_speed` int(11) DEFAULT NULL,
  `overspeed_time_len` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circle_region`
--

LOCK TABLES `circle_region` WRITE;
/*!40000 ALTER TABLE `circle_region` DISABLE KEYS */;
/*!40000 ALTER TABLE `circle_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `org_code` varchar(45) DEFAULT NULL COMMENT '组织结构编码',
  `reg_time` datetime DEFAULT NULL,
  `reg_address` varchar(200) DEFAULT NULL COMMENT '注册地址',
  `office_address` varchar(200) DEFAULT NULL COMMENT '办公地址\n',
  `legal_person` varchar(45) DEFAULT NULL COMMENT '法人代表',
  `company_person` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `homepage` varchar(45) DEFAULT NULL,
  `emp_count` int(11) DEFAULT NULL,
  `remark` varchar(250) DEFAULT NULL,
  `creater_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_group`
--

DROP TABLE IF EXISTS `client_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_group`
--

LOCK TABLES `client_group` WRITE;
/*!40000 ALTER TABLE `client_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `command`
--

DROP TABLE IF EXISTS `command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command` (
  `userId` int(11) NOT NULL,
  `vhcId` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `cmd_code` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`vhcId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `command`
--

LOCK TABLES `command` WRITE;
/*!40000 ALTER TABLE `command` DISABLE KEYS */;
/*!40000 ALTER TABLE `command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_person`
--

DROP TABLE IF EXISTS `contact_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `phone1` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_person`
--

LOCK TABLES `contact_person` WRITE;
/*!40000 ALTER TABLE `contact_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controllerlist`
--

DROP TABLE IF EXISTS `controllerlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `controllerlist` (
  `id` smallint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `tree_parent` tinyint(2) NOT NULL DEFAULT '0',
  `module` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `controller` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `action` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `menu` tinyint(1) NOT NULL COMMENT '是否属于导航栏',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31305 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='所有功能表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controllerlist`
--

LOCK TABLES `controllerlist` WRITE;
/*!40000 ALTER TABLE `controllerlist` DISABLE KEYS */;
INSERT INTO `controllerlist` VALUES (21201,'角色管理',21,'sysmgr','group','index',2),(32,'分组管理',3,'monmgr','group','index',2),(33,'车辆管理',3,'monmgr','vehicle','index',3),(21101,'权限管理',21,'sysmgr','perm','index',1),(31,'客户管理',3,'monmgr','client','index',1),(22,'日志管理',2,'sysmgr','log','index',2),(21,'用户管理',2,'sysmgr','user','index',1),(1,'实时监控',0,'monitor','index','index',1),(2,'系统管理',0,'sysmgr','index','index',3),(11,'车辆列表',1,'monitor','index','vehicletree',1),(12,'围栏管理',1,'monitor','index','regiontree',2),(3,'监控管理',0,'monmgr','index','index',2),(21301,'用户管理',21,'sysmgr','user','index',3),(21401,'修改密码',21,'authen','login','chgpwd',4),(31101,'客户管理',31,'monmgr','client','index',1),(31201,'车辆分组管理',32,'monmgr','group','index',2),(31301,'车辆管理',33,'monmgr','vehicle','index',3),(11101,'西部菜单',1,'monitor','index','westmenu',0),(11102,'南部菜单',1,'monitor','index','southmenu',0);
/*!40000 ALTER TABLE `controllerlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `province_id` int(11) DEFAULT NULL COMMENT '省份ID',
  `city_id` int(11) DEFAULT NULL COMMENT '市县ID',
  `provider_id` int(11) DEFAULT NULL COMMENT '供应商ID',
  `type_id` int(11) DEFAULT NULL,
  `serial_no` varchar(20) DEFAULT NULL COMMENT '终端ID，内部序列号，制造商自行定义',
  `phone_no` varchar(12) DEFAULT NULL,
  `ICCID` varchar(20) DEFAULT NULL,
  `hardware_version` varchar(45) DEFAULT NULL COMMENT '硬件版本号',
  `firmware_version` varchar(45) DEFAULT NULL COMMENT '固件版本号',
  `GNSS` int(11) DEFAULT NULL COMMENT 'bit0，0：不支持 GPS 定位， 1：支持 GPS 定位； \nbit1，0：不支持北斗定位， 1：支持北斗定位； \nbit2，0：不支持 GLONASS 定位， 1：支持 GLONASS 定位；\nbit3，0：不支持 Galileo 定位， 1：支持 Galileo 定位',
  `com_property` int(11) DEFAULT NULL COMMENT 'bit0，0：不支持GPRS通信， 1：支持GPRS通信； \nbit1，0：不支持CDMA通信， 1：支持CDMA通信； \nbit2，0：不支持TD-SCDMA通信， 1：支持TD-SCDMA通信；\nbit3，0：不支持WCDMA通信， 1：支持WCDMA通信； \nbit4，0：不支持CDMA2000通信， 1：支持CDMA2000通信。\nbit5，0：不支持TD-LTE通信， 1：支持TD-LTE通信； \nbit7，0：不支持其他通信方式， 1：支持其他通信方式',
  `reg_time` datetime DEFAULT NULL,
  `cancel_time` datetime DEFAULT NULL COMMENT '注销时间',
  `create_time` datetime DEFAULT NULL,
  `authen_code` varchar(45) DEFAULT NULL COMMENT '鉴权码',
  `device_type` bit(8) DEFAULT NULL COMMENT 'bit0，0：不适用客运车辆，1：适用客运车辆； bit1，0：不适用危险品车辆，1：适用危险品车辆； bit2，0：不适用普通货运车辆，1：适用普通货运车辆；bit3，0：不适用出租车辆，1：适用出租车辆； bit6，0：不支持硬盘录像，1：支持硬盘录像； bit7，0：一体机，1：分体机',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (1,10,10,1,1,'1234567','13800138000',NULL,NULL,NULL,NULL,NULL,'2013-03-08 00:00:00',NULL,NULL,NULL,'1');
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_alarm_param`
--

DROP TABLE IF EXISTS `device_alarm_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_alarm_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sms_switch` int(11) DEFAULT NULL COMMENT '报警发送文本 SMS 开关,与位置信息汇报消息中的报警标志相对应, 相应位为 1 则相应报警时发送文本 SMS\n',
  `alarm_mask` int(11) DEFAULT NULL,
  `shoot_store_flag` int(11) DEFAULT NULL COMMENT '报警拍摄存储标志,与位置信息汇报消息中的报警标志相对应,相应 位为 1 则对相应报警时拍的照片进行存储,否则实时上传\n',
  `shoot_switch` int(11) DEFAULT NULL COMMENT '报警拍摄开关,与位置信息汇报消息中的报警标志相对应,相应位为 1 则相应报警时摄像头拍摄\n',
  `key_alrm_flag` int(11) DEFAULT NULL,
  `max_speed` int(11) DEFAULT NULL,
  `overspeed_time_len` int(11) DEFAULT NULL,
  `drive_time_len` int(11) DEFAULT NULL,
  `drive_day_time` int(11) DEFAULT NULL,
  `min_rest_time` int(11) DEFAULT NULL,
  `max_stop_time` int(11) DEFAULT NULL,
  `overspeed_dvalue` int(11) DEFAULT NULL COMMENT '超速报警预警差值,单位为 1/10Km/h\n',
  `fatigue_dvalue` int(11) DEFAULT NULL COMMENT '疲劳驾驶预警差值,单位为秒(s)',
  `collision_flag` int(11) DEFAULT NULL COMMENT '碰撞报警参数设置: b7-b0: 碰撞时间,单位 4ms; b15-b8:碰撞加速度,单位 0.1g,设置范围在:0-79 之间,默认为 10\n',
  `turnover_flag` int(11) DEFAULT NULL COMMENT '侧翻报警参数设置: 侧翻角度,单位 1 度,默认为 30 度。\n',
  `create_time` datetime DEFAULT NULL,
  `device_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_alarm_param`
--

LOCK TABLES `device_alarm_param` WRITE;
/*!40000 ALTER TABLE `device_alarm_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_alarm_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_gnss_param`
--

DROP TABLE IF EXISTS `device_gnss_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_gnss_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL,
  `pos_mode` int(11) DEFAULT NULL,
  `baud_rate` int(11) DEFAULT NULL,
  `output_freq` int(11) DEFAULT NULL,
  `sample_freq` int(11) DEFAULT NULL,
  `upload_mode` int(11) DEFAULT NULL,
  `upload_set` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_gnss_param`
--

LOCK TABLES `device_gnss_param` WRITE;
/*!40000 ALTER TABLE `device_gnss_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_gnss_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_media_param`
--

DROP TABLE IF EXISTS `device_media_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_media_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL,
  `photo_time_ctrl` int(11) DEFAULT NULL,
  `photo_distance_ctrl` int(11) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `brightness` int(11) DEFAULT NULL,
  `contrast` int(11) DEFAULT NULL,
  `saturation` int(11) DEFAULT NULL,
  `chroma` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_media_param`
--

LOCK TABLES `device_media_param` WRITE;
/*!40000 ALTER TABLE `device_media_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_media_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_network_param`
--

DROP TABLE IF EXISTS `device_network_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_network_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `heartbeat` int(11) DEFAULT NULL,
  `tcp_timeout` int(11) DEFAULT NULL,
  `udp_timeout` int(11) DEFAULT NULL,
  `tcp_attempt` int(11) DEFAULT NULL COMMENT 'TCP 消息重传次数\n',
  `udp_attempt` int(11) DEFAULT NULL,
  `sms_timeout` int(11) DEFAULT NULL,
  `sms_attempt` int(11) DEFAULT NULL,
  `server_apn` varchar(45) DEFAULT NULL COMMENT '主服务器 APN,无线通信拨号访问点。若网络制式为 CDMA,则该处为 PPP 拨号号码\n',
  `server_username` varchar(45) DEFAULT NULL,
  `server_passwd` varchar(45) DEFAULT NULL,
  `server_ip` varchar(45) DEFAULT NULL,
  `slave_server_apn` varchar(45) DEFAULT NULL,
  `slave_server_username` varchar(45) DEFAULT NULL,
  `slave_server_passwd` varchar(45) DEFAULT NULL,
  `slave_server_ip` varchar(45) DEFAULT NULL,
  `tcp_port` int(11) DEFAULT NULL,
  `udp_port` int(11) DEFAULT NULL,
  `ic_server_ip` varchar(45) DEFAULT NULL,
  `ic_server_tcp_port` int(11) DEFAULT NULL,
  `ic_server_udp_port` int(11) DEFAULT NULL,
  `ic_slave_server_ip` varchar(45) DEFAULT NULL COMMENT '道路运输证 IC 卡认证备份服务器 IP 地址或域名,端口同主服务器\n',
  `create_time` datetime DEFAULT NULL,
  `device_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_network_param`
--

LOCK TABLES `device_network_param` WRITE;
/*!40000 ALTER TABLE `device_network_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_network_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_param`
--

DROP TABLE IF EXISTS `device_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devId` int(11) NOT NULL,
  `paramId` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_param`
--

LOCK TABLES `device_param` WRITE;
/*!40000 ALTER TABLE `device_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_phone_param`
--

DROP TABLE IF EXISTS `device_phone_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_phone_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform_phone` varchar(45) DEFAULT NULL,
  `reset_phone` varchar(45) DEFAULT NULL,
  `initial_phone` varchar(45) DEFAULT NULL,
  `sms_phone` varchar(45) DEFAULT NULL,
  `alarm_phone` varchar(45) DEFAULT NULL,
  `phone_ rstrategy` int(11) DEFAULT NULL,
  `max_time_each` int(11) DEFAULT NULL,
  `max_time_month` int(11) DEFAULT NULL,
  `monitor_phone` varchar(45) DEFAULT NULL,
  `sm_phone` varchar(45) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `device_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_phone_param`
--

LOCK TABLES `device_phone_param` WRITE;
/*!40000 ALTER TABLE `device_phone_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_phone_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_postion_report_param`
--

DROP TABLE IF EXISTS `device_postion_report_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_postion_report_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_strategy` int(11) DEFAULT NULL,
  `report_scneme` int(11) DEFAULT NULL COMMENT '位置汇报方案,0:根据 ACC 状态; 1:根据登录状态和 ACC 状态, 先判断登录状态,若登录再根据 ACC 状态\n',
  `logout_rep_interval` int(11) DEFAULT NULL COMMENT '驾驶员未登录汇报时间间隔,单位为秒(s),>0\n',
  `sleep_rep_interval` int(11) DEFAULT NULL COMMENT '休眠时汇报时间间隔,单位为秒(s),>0\n',
  `alarm_rep_interval` int(11) DEFAULT NULL COMMENT '紧急报警时汇报时间间隔,单位为秒(s),>0\n',
  `default_rep_interval` int(11) DEFAULT NULL COMMENT '缺省时间汇报间隔,单位为秒(s),>0\n',
  `default_rep_distance` int(11) DEFAULT NULL COMMENT '缺省距离汇报间隔,单位为米(m),>0\n',
  `logout_rep_distance` int(11) DEFAULT NULL,
  `sleep_rep_distance` int(11) DEFAULT NULL,
  `alarm_rep_distance` int(11) DEFAULT NULL,
  `inflexion_rep_anglel` int(11) DEFAULT NULL COMMENT '拐点补传角度,<180\n',
  `fence_radius` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `device_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_postion_report_param`
--

LOCK TABLES `device_postion_report_param` WRITE;
/*!40000 ALTER TABLE `device_postion_report_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_postion_report_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_provider`
--

DROP TABLE IF EXISTS `device_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_provider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `office_address` varchar(200) DEFAULT NULL,
  `legal_person` varchar(15) DEFAULT NULL,
  `reg_time` datetime DEFAULT NULL,
  `reg_address` varchar(200) DEFAULT NULL,
  `company_person` varchar(15) DEFAULT NULL,
  `createrId` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `remark` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_provider`
--

LOCK TABLES `device_provider` WRITE;
/*!40000 ALTER TABLE `device_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_type`
--

DROP TABLE IF EXISTS `device_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(40) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_type`
--

LOCK TABLES `device_type` WRITE;
/*!40000 ALTER TABLE `device_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `driver_record`
--

DROP TABLE IF EXISTS `driver_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `driver_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `driver_id` int(11) NOT NULL,
  `work_time` datetime DEFAULT NULL COMMENT '上班时间',
  `closing_time` datetime DEFAULT NULL COMMENT '下班时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver_record`
--

LOCK TABLES `driver_record` WRITE;
/*!40000 ALTER TABLE `driver_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `driver_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_circle_region`
--

DROP TABLE IF EXISTS `group_circle_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_circle_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_circle_region`
--

LOCK TABLES `group_circle_region` WRITE;
/*!40000 ALTER TABLE `group_circle_region` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_circle_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_rectangle_region`
--

DROP TABLE IF EXISTS `group_rectangle_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_rectangle_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_rectangle_region`
--

LOCK TABLES `group_rectangle_region` WRITE;
/*!40000 ALTER TABLE `group_rectangle_region` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_rectangle_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `province`
--

DROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `province` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `letter_code` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `province`
--

LOCK TABLES `province` WRITE;
/*!40000 ALTER TABLE `province` DISABLE KEYS */;
/*!40000 ALTER TABLE `province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag` int(11) DEFAULT NULL,
  `question` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_answer`
--

DROP TABLE IF EXISTS `question_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_answer` (
  `question_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_answer`
--

LOCK TABLES `question_answer` WRITE;
/*!40000 ALTER TABLE `question_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rectangle_region`
--

DROP TABLE IF EXISTS `rectangle_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rectangle_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `property` int(11) DEFAULT NULL COMMENT '区域属性，见表 58 区域的区域属性定义\n',
  `left_top_ lat` float DEFAULT NULL,
  `left_top_ long` float DEFAULT NULL,
  `right_bottom_ long` float DEFAULT NULL,
  `right_bottom_lat` float DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `max_speed` int(11) DEFAULT NULL,
  `overspeed_time_len` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rectangle_region`
--

LOCK TABLES `rectangle_region` WRITE;
/*!40000 ALTER TABLE `rectangle_region` DISABLE KEYS */;
/*!40000 ALTER TABLE `rectangle_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedue_information`
--

DROP TABLE IF EXISTS `schedue_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedue_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag` int(11) NOT NULL,
  `text` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedue_information`
--

LOCK TABLES `schedue_information` WRITE;
/*!40000 ALTER TABLE `schedue_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedue_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` smallint(5) NOT NULL,
  `last_act_time` int(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (2,'NVKNIVUCVSR8KMH682TTKPQ6I7',1,0),(5,'PH2LLE67KC8BDTLVUC4E01K1V6',1,0),(31,'T6VHMUQTHCF79D21BDFC7G9SN6',1,1363879591),(25,'',1,1363789106),(29,'JU47FN8A3DOM02LT0HMDBLOR76',1,1363789194);
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telephone_book`
--

DROP TABLE IF EXISTS `telephone_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telephone_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telephone_book`
--

LOCK TABLES `telephone_book` WRITE;
/*!40000 ALTER TABLE `telephone_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `telephone_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `inherts_from` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '从X继承',
  `group_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `controller_list` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'controllerlist中id',
  `auth_resource` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'resource table id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
INSERT INTO `usergroups` VALUES (1,'0','admin','','0');
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `creater_Id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `passwd` varchar(50) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `qq` varchar(45) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `groupid` varchar(255) NOT NULL,
  `last_login_time` datetime NOT NULL,
  `last_try_time` int(12) NOT NULL,
  `tried` tinyint(1) NOT NULL,
  `last_session_id` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0:用户已关闭 1:正常',
  `loginname` varchar(20) NOT NULL,
  `last_login_ip` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin',1,'2013-03-07 17:00:00','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,NULL,'1','2013-03-23 23:12:02',1364051522,0,'S05CIPV30RSGFLEGNODDBFG2R6',1,'admin','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `color_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `code` varchar(20) NOT NULL COMMENT '车牌号码',
  `create_time` datetime DEFAULT NULL,
  `creater` int(11) DEFAULT NULL,
  `dev_install_time` datetime DEFAULT NULL,
  `driver_Id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL COMMENT '车主ID',
  `group_id` varchar(255) DEFAULT NULL COMMENT '车组ID，可属于多个车组，车组ID间使用“，”隔开',
  `brand` varchar(45) DEFAULT NULL COMMENT '品牌',
  `productor` varchar(45) DEFAULT NULL,
  `oilbox_capacity` int(11) DEFAULT NULL COMMENT '邮箱容积',
  `total_distance` int(11) DEFAULT NULL COMMENT '里程表读数',
  `device_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,NULL,NULL,'测A0001','2013-03-08 00:00:00',1,'2013-03-08 00:00:00',NULL,NULL,'1','Ford',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_alarm`
--

DROP TABLE IF EXISTS `vehicle_alarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(11) NOT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `alarm_time` datetime NOT NULL,
  `clear_time` datetime DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_alarm`
--

LOCK TABLES `vehicle_alarm` WRITE;
/*!40000 ALTER TABLE `vehicle_alarm` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_alarm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_color`
--

DROP TABLE IF EXISTS `vehicle_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_color` (
  `id` int(11) NOT NULL,
  `color` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_color`
--

LOCK TABLES `vehicle_color` WRITE;
/*!40000 ALTER TABLE `vehicle_color` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_driver`
--

DROP TABLE IF EXISTS `vehicle_driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_driver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `sex` bit(1) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `company` varchar(45) DEFAULT NULL COMMENT '所属公司',
  `license_no` varchar(45) DEFAULT NULL COMMENT '驾驶证',
  `certificate_code` varchar(45) DEFAULT NULL COMMENT '从业资格证编码',
  `institution` varchar(45) DEFAULT NULL,
  `remark` varchar(150) DEFAULT NULL COMMENT '发证机构',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_driver`
--

LOCK TABLES `vehicle_driver` WRITE;
/*!40000 ALTER TABLE `vehicle_driver` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_group`
--

DROP TABLE IF EXISTS `vehicle_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `creater` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `min_pos_interval` int(11) DEFAULT NULL COMMENT '位置汇报最短间隔',
  `max_pos_interval` int(11) DEFAULT NULL COMMENT '位置汇报最大间隔',
  `user_count` int(11) DEFAULT NULL,
  `vhc_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_group`
--

LOCK TABLES `vehicle_group` WRITE;
/*!40000 ALTER TABLE `vehicle_group` DISABLE KEYS */;
INSERT INTO `vehicle_group` VALUES (1,'测试组1',1,'2013-03-08 00:00:00',NULL,NULL,NULL,NULL),(2,'测试组2',1,'2013-03-08 00:00:00',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `vehicle_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_owner`
--

DROP TABLE IF EXISTS `vehicle_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_owner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `sex` bit(1) DEFAULT NULL,
  `phone1` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `identity_card` varchar(20) DEFAULT NULL COMMENT '身份证',
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_owner`
--

LOCK TABLES `vehicle_owner` WRITE;
/*!40000 ALTER TABLE `vehicle_owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_position`
--

DROP TABLE IF EXISTS `vehicle_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(11) NOT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `gps_time` datetime NOT NULL,
  `server_time` datetime NOT NULL,
  `longitude` float NOT NULL,
  `latitude` float NOT NULL,
  `height` float DEFAULT NULL,
  `speed` float DEFAULT NULL,
  `direction` smallint(6) DEFAULT NULL,
  `status_flag` int(11) DEFAULT NULL,
  `status_desc` varchar(250) DEFAULT NULL,
  `pos_pesc` varchar(250) DEFAULT NULL,
  `alarm_flag` int(11) DEFAULT NULL,
  `alarm_desc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_position`
--

LOCK TABLES `vehicle_position` WRITE;
/*!40000 ALTER TABLE `vehicle_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_position_last`
--

DROP TABLE IF EXISTS `vehicle_position_last`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_position_last` (
  `vehicle_id` int(11) NOT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `gps_time` datetime NOT NULL,
  `server_time` datetime NOT NULL,
  `longitude` float NOT NULL,
  `latitude` float NOT NULL,
  `height` float DEFAULT NULL,
  `speed` float DEFAULT NULL,
  `direction` smallint(6) DEFAULT NULL,
  `status_flag` int(11) DEFAULT NULL,
  `status_desc` varchar(250) DEFAULT NULL,
  `pos_pesc` varchar(250) DEFAULT NULL,
  `alarm_flag` int(11) DEFAULT NULL,
  `alarm_desc` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_position_last`
--

LOCK TABLES `vehicle_position_last` WRITE;
/*!40000 ALTER TABLE `vehicle_position_last` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_position_last` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_type`
--

DROP TABLE IF EXISTS `vehicle_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_type` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_type`
--

LOCK TABLES `vehicle_type` WRITE;
/*!40000 ALTER TABLE `vehicle_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-03-23 23:29:15
