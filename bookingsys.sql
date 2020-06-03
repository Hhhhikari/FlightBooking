/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80016
Source Host           : localhost:3306
Source Database       : bookingsys

Target Server Type    : MYSQL
Target Server Version : 80016
File Encoding         : 65001

Date: 2020-02-17 17:48:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for airline
-- ----------------------------
DROP TABLE IF EXISTS `airline`;
CREATE TABLE `airline` (
  `airlineID` varchar(12) NOT NULL COMMENT '航空公司ID',
  `aielineName` varchar(20) DEFAULT NULL COMMENT '航空公司名称',
  `ownDiscount` double(10,1) DEFAULT NULL COMMENT '航空公司折扣',
  PRIMARY KEY (`airlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of airline
-- ----------------------------
INSERT INTO `airline` VALUES ('0001', '华中航空公司', '0.9');

-- ----------------------------
-- Table structure for airplane
-- ----------------------------
DROP TABLE IF EXISTS `airplane`;
CREATE TABLE `airplane` (
  `airplaneID` varchar(12) NOT NULL COMMENT '飞机ID',
  `airplaneType` varchar(20) DEFAULT NULL COMMENT '飞机类型',
  `airplaneName` varchar(20) DEFAULT NULL COMMENT '飞机名称',
  PRIMARY KEY (`airplaneID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of airplane
-- ----------------------------
INSERT INTO `airplane` VALUES ('B2128', 'B737-300', '华中三号客机');
INSERT INTO `airplane` VALUES ('B2153', 'B737-300', '华中一号客机');
INSERT INTO `airplane` VALUES ('B2276', 'B737-300', '华中四号客机');
INSERT INTO `airplane` VALUES ('B2284', 'B737-300', '华中二号客机');

-- ----------------------------
-- Table structure for airport
-- ----------------------------
DROP TABLE IF EXISTS `airport`;
CREATE TABLE `airport` (
  `airportID` varchar(12) NOT NULL COMMENT '机场ID',
  `airportName` varchar(20) DEFAULT NULL COMMENT '机场名称',
  `city` varchar(20) DEFAULT NULL COMMENT '机场所在城市',
  `country` varchar(20) DEFAULT NULL COMMENT '机场所在国家',
  `connectionUp` double(10,0) DEFAULT NULL COMMENT '机场连接时间上限',
  `connectionDown` double(10,0) DEFAULT NULL COMMENT '机场连接时间下限',
  PRIMARY KEY (`airportID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of airport
-- ----------------------------
INSERT INTO `airport` VALUES ('CAN', '广州白云国际机场', 'guangzhou', 'china', '40', '20');
INSERT INTO `airport` VALUES ('CKG', '重庆江北国际机场', 'chongqing', 'china', '40', '20');
INSERT INTO `airport` VALUES ('CSX', '长沙黄花国际机场', 'changsha', 'china', '40', '20');
INSERT INTO `airport` VALUES ('CTU', '成都双流国际机场', 'chengdu', 'china', '40', '20');
INSERT INTO `airport` VALUES ('DLC', '大连周水子国际机场', 'dalian', 'china', '40', '20');
INSERT INTO `airport` VALUES ('HGH', '杭州萧山国际机场', 'hangzhou', 'china', '40', '20');
INSERT INTO `airport` VALUES ('KMG', '昆明长水国际机场', 'kunming', 'china', '40', '20');
INSERT INTO `airport` VALUES ('NGB', '宁波栎社国际机场', 'ningbo', 'china', '40', '20');
INSERT INTO `airport` VALUES ('NKG', '南京禄口国际机场', 'nanjing', 'china', '40', '20');
INSERT INTO `airport` VALUES ('PKX', '北京大兴国际机场', 'beijing', 'china', '30', '20');
INSERT INTO `airport` VALUES ('PVG', '上海浦东国际机场', 'shanghai', 'china', '40', '15');
INSERT INTO `airport` VALUES ('SHE', '沈阳桃仙国际机场', 'shenyang', 'china', '40', '20');
INSERT INTO `airport` VALUES ('TSN', '天津滨海国际机场', 'tianjin', 'china', '40', '20');
INSERT INTO `airport` VALUES ('WUH', '武汉天河国际机场', 'wuhan', 'china', '40', '20');
INSERT INTO `airport` VALUES ('XIY', '西安咸阳国际机场', 'xian', 'china', '40', '20');

-- ----------------------------
-- Table structure for flight
-- ----------------------------
DROP TABLE IF EXISTS `flight`;
CREATE TABLE `flight` (
  `flightID` varchar(12) NOT NULL COMMENT '航班ID',
  `airlineID` varchar(12) DEFAULT NULL COMMENT '航空公司ID',
  `airplaneID` varchar(12) DEFAULT NULL COMMENT '飞机ID',
  `startAirportID` varchar(12) DEFAULT NULL COMMENT '起飞机场ID',
  `arrivalAirportID` varchar(12) DEFAULT NULL COMMENT '到达机场ID',
  `depatureTime` varchar(20) DEFAULT NULL COMMENT '起飞时间',
  `arrivalTime` varchar(20) DEFAULT NULL COMMENT '到达时间',
  `firstclassFare` double(10,2) DEFAULT NULL COMMENT '头等舱费用',
  `economyclassFare` double(10,2) DEFAULT NULL COMMENT '经济舱费用',
  PRIMARY KEY (`flightID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of flight
-- ----------------------------
INSERT INTO `flight` VALUES ('HZ1101', '0001', 'B2153', 'PKX', 'PVG', '7：00', '9：15', '1000.00', '670.00');
INSERT INTO `flight` VALUES ('HZ1351', '0001', 'B2128', 'PKX', 'CAN', '7：30', '10：55', '1000.00', '900.00');
INSERT INTO `flight` VALUES ('HZ1402', '0001', 'B2276', 'PVG', 'CAN', '9：00', '11：55', '1500.00', '1225.00');
INSERT INTO `flight` VALUES ('HZ3102', '0001', 'B2284', 'PKX', 'PVG', '19：00', '20：05', '1200.00', '700.00');
INSERT INTO `flight` VALUES ('HZ3287', '0001', 'B2153', 'PVG', 'CAN', '13：30', '16：05', '1200.00', '870.00');

-- ----------------------------
-- Table structure for ordered
-- ----------------------------
DROP TABLE IF EXISTS `ordered`;
CREATE TABLE `ordered` (
  `flightID` varchar(12) DEFAULT NULL COMMENT '航班ID',
  `seatID` int(12) DEFAULT NULL COMMENT '座位ID',
  `date` date DEFAULT NULL COMMENT '日期',
  `level` varchar(10) DEFAULT NULL COMMENT '舱型'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ordered
-- ----------------------------
INSERT INTO `ordered` VALUES ('HZ1101', '1', '2020-02-19', '商务舱');

-- ----------------------------
-- Table structure for passenger
-- ----------------------------
DROP TABLE IF EXISTS `passenger`;
CREATE TABLE `passenger` (
  `userID` int(12) NOT NULL AUTO_INCREMENT COMMENT '乘客ID',
  `passengerName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '姓名',
  `passport` varchar(20) DEFAULT NULL COMMENT '证件号',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of passenger
-- ----------------------------
INSERT INTO `passenger` VALUES ('1', '张三', '11111');
INSERT INTO `passenger` VALUES ('2', '李四', '22222');

-- ----------------------------
-- Table structure for seat
-- ----------------------------
DROP TABLE IF EXISTS `seat`;
CREATE TABLE `seat` (
  `seatID` int(12) NOT NULL AUTO_INCREMENT COMMENT '座位ID',
  `airplaneType` varchar(20) DEFAULT NULL COMMENT '飞机类型',
  `row` varchar(5) DEFAULT NULL COMMENT '行',
  `line` varchar(5) DEFAULT NULL COMMENT '列',
  `level` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '舱型',
  PRIMARY KEY (`seatID`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of seat
-- ----------------------------
INSERT INTO `seat` VALUES ('1', 'B737-300', '1', 'A', '商务舱');
INSERT INTO `seat` VALUES ('2', 'B737-300', '2', 'A', '商务舱');
INSERT INTO `seat` VALUES ('3', 'B737-300', '3', 'A', '经济舱');
INSERT INTO `seat` VALUES ('4', 'B737-300', '4', 'A', '经济舱');
INSERT INTO `seat` VALUES ('5', 'B737-300', '5', 'A', '经济舱');
INSERT INTO `seat` VALUES ('6', 'B737-300', '6', 'A', '经济舱');
INSERT INTO `seat` VALUES ('7', 'B737-300', '7', 'A', '经济舱');
INSERT INTO `seat` VALUES ('8', 'B737-300', '8', 'A', '经济舱');
INSERT INTO `seat` VALUES ('9', 'B737-300', '9', 'A', '经济舱');
INSERT INTO `seat` VALUES ('10', 'B737-300', '10', 'A', '经济舱');
INSERT INTO `seat` VALUES ('11', 'B737-300', '11', 'A', '经济舱');
INSERT INTO `seat` VALUES ('12', 'B737-300', '12', 'A', '经济舱');
INSERT INTO `seat` VALUES ('13', 'B737-300', '13', 'A', '经济舱');
INSERT INTO `seat` VALUES ('14', 'B737-300', '14', 'A', '经济舱');
INSERT INTO `seat` VALUES ('15', 'B737-300', '15', 'A', '经济舱');
INSERT INTO `seat` VALUES ('16', 'B737-300', '16', 'A', '经济舱');
INSERT INTO `seat` VALUES ('17', 'B737-300', '17', 'A', '经济舱');
INSERT INTO `seat` VALUES ('18', 'B737-300', '18', 'A', '经济舱');
INSERT INTO `seat` VALUES ('19', 'B737-300', '19', 'A', '经济舱');
INSERT INTO `seat` VALUES ('20', 'B737-300', '20', 'A', '经济舱');
INSERT INTO `seat` VALUES ('21', 'B737-300', '1', 'B', '商务舱');
INSERT INTO `seat` VALUES ('22', 'B737-300', '2', 'B', '商务舱');
INSERT INTO `seat` VALUES ('23', 'B737-300', '3', 'B', '经济舱');
INSERT INTO `seat` VALUES ('24', 'B737-300', '4', 'B', '经济舱');
INSERT INTO `seat` VALUES ('25', 'B737-300', '5', 'B', '经济舱');
INSERT INTO `seat` VALUES ('26', 'B737-300', '6', 'B', '经济舱');
INSERT INTO `seat` VALUES ('27', 'B737-300', '7', 'B', '经济舱');
INSERT INTO `seat` VALUES ('28', 'B737-300', '8', 'B', '经济舱');
INSERT INTO `seat` VALUES ('29', 'B737-300', '9', 'B', '经济舱');
INSERT INTO `seat` VALUES ('30', 'B737-300', '10', 'B', '经济舱');
INSERT INTO `seat` VALUES ('31', 'B737-300', '11', 'B', '经济舱');
INSERT INTO `seat` VALUES ('32', 'B737-300', '12', 'B', '经济舱');
INSERT INTO `seat` VALUES ('33', 'B737-300', '13', 'B', '经济舱');
INSERT INTO `seat` VALUES ('34', 'B737-300', '14', 'B', '经济舱');
INSERT INTO `seat` VALUES ('35', 'B737-300', '15', 'B', '经济舱');
INSERT INTO `seat` VALUES ('36', 'B737-300', '16', 'B', '经济舱');
INSERT INTO `seat` VALUES ('37', 'B737-300', '17', 'B', '经济舱');
INSERT INTO `seat` VALUES ('38', 'B737-300', '18', 'B', '经济舱');
INSERT INTO `seat` VALUES ('39', 'B737-300', '19', 'B', '经济舱');
INSERT INTO `seat` VALUES ('40', 'B737-300', '20', 'B', '经济舱');
INSERT INTO `seat` VALUES ('41', 'B737-300', '1', 'C', '商务舱');
INSERT INTO `seat` VALUES ('42', 'B737-300', '2', 'C', '商务舱');
INSERT INTO `seat` VALUES ('43', 'B737-300', '3', 'C', '经济舱');
INSERT INTO `seat` VALUES ('44', 'B737-300', '4', 'C', '经济舱');
INSERT INTO `seat` VALUES ('45', 'B737-300', '5', 'C', '经济舱');
INSERT INTO `seat` VALUES ('46', 'B737-300', '6', 'C', '经济舱');
INSERT INTO `seat` VALUES ('47', 'B737-300', '7', 'C', '经济舱');
INSERT INTO `seat` VALUES ('48', 'B737-300', '8', 'C', '经济舱');
INSERT INTO `seat` VALUES ('49', 'B737-300', '9', 'C', '经济舱');
INSERT INTO `seat` VALUES ('50', 'B737-300', '10', 'C', '经济舱');
INSERT INTO `seat` VALUES ('51', 'B737-300', '11', 'C', '经济舱');
INSERT INTO `seat` VALUES ('52', 'B737-300', '12', 'C', '经济舱');
INSERT INTO `seat` VALUES ('53', 'B737-300', '13', 'C', '经济舱');
INSERT INTO `seat` VALUES ('54', 'B737-300', '14', 'C', '经济舱');
INSERT INTO `seat` VALUES ('55', 'B737-300', '15', 'C', '经济舱');
INSERT INTO `seat` VALUES ('56', 'B737-300', '16', 'C', '经济舱');
INSERT INTO `seat` VALUES ('57', 'B737-300', '17', 'C', '经济舱');
INSERT INTO `seat` VALUES ('58', 'B737-300', '18', 'C', '经济舱');
INSERT INTO `seat` VALUES ('59', 'B737-300', '19', 'C', '经济舱');
INSERT INTO `seat` VALUES ('60', 'B737-300', '20', 'C', '经济舱');
INSERT INTO `seat` VALUES ('61', 'B737-300', '1', 'D', '商务舱');
INSERT INTO `seat` VALUES ('62', 'B737-300', '2', 'D', '商务舱');
INSERT INTO `seat` VALUES ('63', 'B737-300', '3', 'D', '经济舱');
INSERT INTO `seat` VALUES ('64', 'B737-300', '4', 'D', '经济舱');
INSERT INTO `seat` VALUES ('65', 'B737-300', '5', 'D', '经济舱');
INSERT INTO `seat` VALUES ('66', 'B737-300', '6', 'D', '经济舱');
INSERT INTO `seat` VALUES ('67', 'B737-300', '7', 'D', '经济舱');
INSERT INTO `seat` VALUES ('68', 'B737-300', '8', 'D', '经济舱');
INSERT INTO `seat` VALUES ('69', 'B737-300', '9', 'D', '经济舱');
INSERT INTO `seat` VALUES ('70', 'B737-300', '10', 'D', '经济舱');
INSERT INTO `seat` VALUES ('71', 'B737-300', '11', 'D', '经济舱');
INSERT INTO `seat` VALUES ('72', 'B737-300', '12', 'D', '经济舱');
INSERT INTO `seat` VALUES ('73', 'B737-300', '13', 'D', '经济舱');
INSERT INTO `seat` VALUES ('74', 'B737-300', '14', 'D', '经济舱');
INSERT INTO `seat` VALUES ('75', 'B737-300', '15', 'D', '经济舱');
INSERT INTO `seat` VALUES ('76', 'B737-300', '16', 'D', '经济舱');
INSERT INTO `seat` VALUES ('77', 'B737-300', '17', 'D', '经济舱');
INSERT INTO `seat` VALUES ('78', 'B737-300', '18', 'D', '经济舱');
INSERT INTO `seat` VALUES ('79', 'B737-300', '19', 'D', '经济舱');
INSERT INTO `seat` VALUES ('80', 'B737-300', '20', 'D', '经济舱');
INSERT INTO `seat` VALUES ('81', 'B737-300', '1', 'E', '商务舱');
INSERT INTO `seat` VALUES ('82', 'B737-300', '2', 'E', '商务舱');
INSERT INTO `seat` VALUES ('83', 'B737-300', '3', 'E', '经济舱');
INSERT INTO `seat` VALUES ('84', 'B737-300', '4', 'E', '经济舱');
INSERT INTO `seat` VALUES ('85', 'B737-300', '5', 'E', '经济舱');
INSERT INTO `seat` VALUES ('86', 'B737-300', '6', 'E', '经济舱');
INSERT INTO `seat` VALUES ('87', 'B737-300', '7', 'E', '经济舱');
INSERT INTO `seat` VALUES ('88', 'B737-300', '8', 'E', '经济舱');
INSERT INTO `seat` VALUES ('89', 'B737-300', '9', 'E', '经济舱');
INSERT INTO `seat` VALUES ('90', 'B737-300', '10', 'E', '经济舱');
INSERT INTO `seat` VALUES ('91', 'B737-300', '11', 'E', '经济舱');
INSERT INTO `seat` VALUES ('92', 'B737-300', '12', 'E', '经济舱');
INSERT INTO `seat` VALUES ('93', 'B737-300', '13', 'E', '经济舱');
INSERT INTO `seat` VALUES ('94', 'B737-300', '14', 'E', '经济舱');
INSERT INTO `seat` VALUES ('95', 'B737-300', '15', 'E', '经济舱');
INSERT INTO `seat` VALUES ('96', 'B737-300', '16', 'E', '经济舱');
INSERT INTO `seat` VALUES ('97', 'B737-300', '17', 'E', '经济舱');
INSERT INTO `seat` VALUES ('98', 'B737-300', '18', 'E', '经济舱');
INSERT INTO `seat` VALUES ('99', 'B737-300', '19', 'E', '经济舱');
INSERT INTO `seat` VALUES ('100', 'B737-300', '20', 'E', '经济舱');
INSERT INTO `seat` VALUES ('101', 'B737-300', '1', 'F', '商务舱');
INSERT INTO `seat` VALUES ('102', 'B737-300', '2', 'F', '商务舱');
INSERT INTO `seat` VALUES ('103', 'B737-300', '3', 'F', '经济舱');
INSERT INTO `seat` VALUES ('104', 'B737-300', '4', 'F', '经济舱');
INSERT INTO `seat` VALUES ('105', 'B737-300', '5', 'F', '经济舱');
INSERT INTO `seat` VALUES ('106', 'B737-300', '6', 'F', '经济舱');
INSERT INTO `seat` VALUES ('107', 'B737-300', '7', 'F', '经济舱');
INSERT INTO `seat` VALUES ('108', 'B737-300', '8', 'F', '经济舱');
INSERT INTO `seat` VALUES ('109', 'B737-300', '9', 'F', '经济舱');
INSERT INTO `seat` VALUES ('110', 'B737-300', '10', 'F', '经济舱');
INSERT INTO `seat` VALUES ('111', 'B737-300', '11', 'F', '经济舱');
INSERT INTO `seat` VALUES ('112', 'B737-300', '12', 'F', '经济舱');
INSERT INTO `seat` VALUES ('113', 'B737-300', '13', 'F', '经济舱');
INSERT INTO `seat` VALUES ('114', 'B737-300', '14', 'F', '经济舱');
INSERT INTO `seat` VALUES ('115', 'B737-300', '15', 'F', '经济舱');
INSERT INTO `seat` VALUES ('116', 'B737-300', '16', 'F', '经济舱');
INSERT INTO `seat` VALUES ('117', 'B737-300', '17', 'F', '经济舱');
INSERT INTO `seat` VALUES ('118', 'B737-300', '18', 'F', '经济舱');
INSERT INTO `seat` VALUES ('119', 'B737-300', '19', 'F', '经济舱');
INSERT INTO `seat` VALUES ('120', 'B737-300', '20', 'F', '经济舱');

-- ----------------------------
-- Table structure for ticket
-- ----------------------------
DROP TABLE IF EXISTS `ticket`;
CREATE TABLE `ticket` (
  `passport` varchar(20) DEFAULT NULL COMMENT '证件号',
  `passengerName` varchar(20) DEFAULT NULL COMMENT '姓名',
  `flightID` varchar(12) DEFAULT NULL COMMENT '航班ID',
  `date` date DEFAULT NULL COMMENT '日期',
  `tripID` int(12) DEFAULT NULL COMMENT '订单ID',
  `row` varchar(5) DEFAULT NULL COMMENT '行',
  `line` varchar(5) DEFAULT NULL COMMENT '列',
  `fare` double(20,2) DEFAULT NULL COMMENT '费用',
  `state` varchar(20) DEFAULT NULL COMMENT '车票状态',
  `seatID` int(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ticket
-- ----------------------------

-- ----------------------------
-- Table structure for trip
-- ----------------------------
DROP TABLE IF EXISTS `trip`;
CREATE TABLE `trip` (
  `tripID` int(12) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `flightID` varchar(12) DEFAULT NULL COMMENT '航班ID',
  `startAirportID` varchar(12) DEFAULT NULL COMMENT '起飞机场ID',
  `arrivalAirportID` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '到达机场ID',
  `depatureTime` varchar(20) DEFAULT NULL,
  `arrivalTime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`tripID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of trip
-- ----------------------------

-- ----------------------------
-- View structure for fromairport
-- ----------------------------
DROP VIEW IF EXISTS `fromairport`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `fromairport` AS select distinct `flight`.`startAirportID` AS `startAirportID`,`airport`.`airportName` AS `fromAirport` from (`airport` join `flight`) where (`airport`.`airportID` = `flight`.`startAirportID`) ;

-- ----------------------------
-- View structure for toairport
-- ----------------------------
DROP VIEW IF EXISTS `toairport`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `toairport` AS select distinct `flight`.`arrivalAirportID` AS `arrivalAirportID`,`airport`.`airportName` AS `toAirport` from (`airport` join `flight`) where (`airport`.`airportID` = `flight`.`arrivalAirportID`) ;
