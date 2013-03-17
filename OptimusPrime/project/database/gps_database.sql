-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2013 年 03 月 12 日 17:19
-- 服务器版本: 5.5.28-0ubuntu0.12.04.2
-- PHP 版本: 5.3.10-1ubuntu3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `gps_database`
--

-- --------------------------------------------------------

--
-- 表的结构 `administrative_region`
--

CREATE TABLE IF NOT EXISTS `administrative_region` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `alarm_type`
--

CREATE TABLE IF NOT EXISTS `alarm_type` (
  `id` int(11) NOT NULL,
  `type_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `answer`
--

CREATE TABLE IF NOT EXISTS `answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `answer` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `book_items`
--

CREATE TABLE IF NOT EXISTS `book_items` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `circle_region`
--

CREATE TABLE IF NOT EXISTS `circle_region` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `client`
--

CREATE TABLE IF NOT EXISTS `client` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `client_group`
--

CREATE TABLE IF NOT EXISTS `client_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `command`
--

CREATE TABLE IF NOT EXISTS `command` (
  `userId` int(11) NOT NULL,
  `vhcId` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `cmd_code` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`vhcId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `contact_person`
--

CREATE TABLE IF NOT EXISTS `contact_person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `phone1` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `controllerlist`
--

CREATE TABLE IF NOT EXISTS `controllerlist` (
  `id` smallint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `tree_parent` tinyint(2) NOT NULL DEFAULT '0',
  `module` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `controller` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `action` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `menu` tinyint(1) NOT NULL COMMENT '是否属于导航栏',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='所有功能表' AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `controllerlist`
--

INSERT INTO `controllerlist` (`id`, `name`, `tree_parent`, `module`, `controller`, `action`, `menu`) VALUES
(1, '登陆', 10, 'login', 'index', 'index', 0),
(2, '登出', 10, 'login', 'index', 'logout', 0),
(8, '修改密码', 10, 'user', 'index', 'chgpwd', 1),
(9, '信息管理', 0, '', '', '', 1),
(10, '用户管理', 0, '', '', '', 1),
(11, '权限管理', 10, 'auth', 'index', 'index', 1),
(12, '创建新用户', 10, 'user', 'index', 'registration', 1),
(13, '创建用户组', 10, 'user', 'index', 'newgroup', 1);

-- --------------------------------------------------------

--
-- 表的结构 `device`
--

CREATE TABLE IF NOT EXISTS `device` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `device`
--

INSERT INTO `device` (`id`, `province_id`, `city_id`, `provider_id`, `type_id`, `serial_no`, `phone_no`, `ICCID`, `hardware_version`, `firmware_version`, `GNSS`, `com_property`, `reg_time`, `cancel_time`, `create_time`, `authen_code`, `device_type`) VALUES
(1, 10, 10, 1, 1, '1234567', '13800138000', NULL, NULL, NULL, NULL, NULL, '2013-03-08 00:00:00', NULL, NULL, NULL, b'00110001');

-- --------------------------------------------------------

--
-- 表的结构 `device_alarm_param`
--

CREATE TABLE IF NOT EXISTS `device_alarm_param` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `device_gnss_param`
--

CREATE TABLE IF NOT EXISTS `device_gnss_param` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `device_media_param`
--

CREATE TABLE IF NOT EXISTS `device_media_param` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `device_network_param`
--

CREATE TABLE IF NOT EXISTS `device_network_param` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `device_param`
--

CREATE TABLE IF NOT EXISTS `device_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devId` int(11) NOT NULL,
  `paramId` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `device_phone_param`
--

CREATE TABLE IF NOT EXISTS `device_phone_param` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `device_postion_report_param`
--

CREATE TABLE IF NOT EXISTS `device_postion_report_param` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `device_provider`
--

CREATE TABLE IF NOT EXISTS `device_provider` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `device_type`
--

CREATE TABLE IF NOT EXISTS `device_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(40) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `driver_record`
--

CREATE TABLE IF NOT EXISTS `driver_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `driver_id` int(11) NOT NULL,
  `work_time` datetime DEFAULT NULL COMMENT '上班时间',
  `closing_time` datetime DEFAULT NULL COMMENT '下班时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `group_circle_region`
--

CREATE TABLE IF NOT EXISTS `group_circle_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `group_rectangle_region`
--

CREATE TABLE IF NOT EXISTS `group_rectangle_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `province`
--

CREATE TABLE IF NOT EXISTS `province` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `letter_code` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `question`
--

CREATE TABLE IF NOT EXISTS `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag` int(11) DEFAULT NULL,
  `question` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `question_answer`
--

CREATE TABLE IF NOT EXISTS `question_answer` (
  `question_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `rectangle_region`
--

CREATE TABLE IF NOT EXISTS `rectangle_region` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `schedue_information`
--

CREATE TABLE IF NOT EXISTS `schedue_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag` int(11) NOT NULL,
  `text` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `session`
--

CREATE TABLE IF NOT EXISTS `session` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` smallint(5) NOT NULL,
  `last_act_time` int(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `session`
--

INSERT INTO `session` (`id`, `session_id`, `user_id`, `last_act_time`) VALUES
(2, 'NVKNIVUCVSR8KMH682TTKPQ6I7', 1, 1362730835),
(5, 'PH2LLE67KC8BDTLVUC4E01K1V6', 1, 1363078712);

-- --------------------------------------------------------

--
-- 表的结构 `telephone_book`
--

CREATE TABLE IF NOT EXISTS `telephone_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `usergroups`
--

CREATE TABLE IF NOT EXISTS `usergroups` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `inherts_from` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '从X继承',
  `group_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `controller_list` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'controllerlist中id',
  `auth_resource` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'resource table id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `usergroups`
--

INSERT INTO `usergroups` (`id`, `inherts_from`, `group_name`, `controller_list`, `auth_resource`) VALUES
(1, '0', 'admin', '', '0');

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE IF NOT EXISTS `users` (
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `username`, `creater_Id`, `create_time`, `passwd`, `phone`, `email`, `qq`, `client_id`, `groupid`, `last_login_time`, `last_try_time`, `tried`, `last_session_id`, `status`) VALUES
(1, 'admin', 1, '2013-03-07 17:00:00', '202cb962ac59075b964b07152d234b70', NULL, NULL, NULL, NULL, '1', '2013-03-12 16:46:56', 1363078016, 0, 'PH2LLE67KC8BDTLVUC4E01K1V6', 1);

-- --------------------------------------------------------

--
-- 表的结构 `vehicle`
--

CREATE TABLE IF NOT EXISTS `vehicle` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `vehicle`
--

INSERT INTO `vehicle` (`id`, `color_id`, `type_id`, `code`, `create_time`, `creater`, `dev_install_time`, `driver_Id`, `owner_id`, `group_id`, `brand`, `productor`, `oilbox_capacity`, `total_distance`, `device_id`) VALUES
(1, NULL, NULL, '测A0001', '2013-03-08 00:00:00', 1, '2013-03-08 00:00:00', NULL, NULL, '1', 'Ford', NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- 表的结构 `vehicle_alarm`
--

CREATE TABLE IF NOT EXISTS `vehicle_alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(11) NOT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `alarm_time` datetime NOT NULL,
  `clear_time` datetime DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `vehicle_color`
--

CREATE TABLE IF NOT EXISTS `vehicle_color` (
  `id` int(11) NOT NULL,
  `color` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `vehicle_driver`
--

CREATE TABLE IF NOT EXISTS `vehicle_driver` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `vehicle_group`
--

CREATE TABLE IF NOT EXISTS `vehicle_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `creater` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `min_pos_interval` int(11) DEFAULT NULL COMMENT '位置汇报最短间隔',
  `max_pos_interval` int(11) DEFAULT NULL COMMENT '位置汇报最大间隔',
  `user_count` int(11) DEFAULT NULL,
  `vhc_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `vehicle_group`
--

INSERT INTO `vehicle_group` (`id`, `name`, `creater`, `create_time`, `min_pos_interval`, `max_pos_interval`, `user_count`, `vhc_count`) VALUES
(1, '测试组1', 1, '2013-03-08 00:00:00', NULL, NULL, NULL, NULL),
(2, '测试组2', 1, '2013-03-08 00:00:00', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `vehicle_owner`
--

CREATE TABLE IF NOT EXISTS `vehicle_owner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `sex` bit(1) DEFAULT NULL,
  `phone1` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `identity_card` varchar(20) DEFAULT NULL COMMENT '身份证',
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `vehicle_position`
--

CREATE TABLE IF NOT EXISTS `vehicle_position` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `vehicle_position_last`
--

CREATE TABLE IF NOT EXISTS `vehicle_position_last` (
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

-- --------------------------------------------------------

--
-- 表的结构 `vehicle_type`
--

CREATE TABLE IF NOT EXISTS `vehicle_type` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
