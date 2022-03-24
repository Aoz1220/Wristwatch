/*
SQLyog Ultimate v12.3.1 (64 bit)
MySQL - 8.0.17 : Database - wristwatch
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`wristwatch` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `wristwatch`;

/*Table structure for table `brand` */

DROP TABLE IF EXISTS `brand`;

CREATE TABLE `brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `brand_name` varchar(50) DEFAULT NULL COMMENT '品牌名称',
  `type_id` int(11) DEFAULT NULL COMMENT '腕表类型ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `brand` */

insert  into `brand`(`id`,`brand_name`,`type_id`) values 
(1,'欧米茄',1),
(2,'阿然表',2),
(3,'周阳表',3),
(4,'蒋一铭表',1),
(6,'林澳表',2),
(7,'电子表1号',1),
(8,'机械手表1号',2),
(9,'智能手表1号',3),
(10,'智能手表2号',3);

/*Table structure for table `fix_history` */

DROP TABLE IF EXISTS `fix_history`;

CREATE TABLE `fix_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `watch_id` int(11) DEFAULT NULL COMMENT '腕表ID',
  `start_time` datetime DEFAULT NULL COMMENT '修理开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '修理完成时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `fix_history` */

insert  into `fix_history`(`id`,`watch_id`,`start_time`,`end_time`) values 
(14,9,'2021-10-12 08:23:56','2021-10-15 06:51:51'),
(15,17,'2021-10-13 02:44:46','2021-10-13 02:44:51'),
(16,20,'2021-10-13 14:15:44','2021-10-13 14:15:52'),
(17,34,'2021-10-14 04:38:30','2021-10-14 04:38:33'),
(18,35,'2021-10-14 04:53:16','2021-10-14 05:04:09'),
(20,33,'2021-10-15 06:55:16','2021-10-15 06:55:19'),
(21,40,'2021-10-20 05:03:04','2021-10-20 05:03:07');

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(32) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(255) DEFAULT NULL COMMENT '菜单路径',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `pid` int(11) DEFAULT NULL COMMENT '父节点ID',
  `level` int(11) DEFAULT NULL COMMENT '菜单级别',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `hidden` int(11) DEFAULT NULL COMMENT '是否隐藏',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `menu` */

insert  into `menu`(`id`,`name`,`url`,`icon`,`pid`,`level`,`sort`,`hidden`) values 
(1,'账号管理','manager/user/list','fa fa-users',NULL,1,1,0),
(2,'进行中订单管理','store/watch/list','fa fa-users',NULL,1,2,0),
(4,'待维修','factory/watch/waiting','fa fa-users',NULL,1,3,0),
(5,'维修中','factory/watch/going','fa fa-users',NULL,1,4,0),
(6,'维修记录','factory/watch/history','fa fa-users',NULL,1,5,0),
(7,'维修订单管理','customer/order/list','fa fa-users',NULL,1,6,0),
(8,'已完成订单评分','customer/order/history','fa fa-users',NULL,1,7,0),
(9,'退款订单记录','customer/order/refund/history','fa fa-users',NULL,1,8,0),
(10,'被拒绝订单记录','customer/order/refuse/history','fa fa-users',NULL,1,9,0),
(11,'已完成订单记录','store/watch/history','fa fa-users',NULL,1,10,0),
(12,'已拒绝订单记录','store/watch/refuse/history','fa fa-users',NULL,1,11,0),
(13,'已退款订单记录','store/watch/refund/history','fa fa-users',NULL,1,12,0);

/*Table structure for table `order_history` */

DROP TABLE IF EXISTS `order_history`;

CREATE TABLE `order_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `watch_id` int(11) DEFAULT NULL COMMENT '订单腕表id',
  `finish_time` datetime DEFAULT NULL COMMENT '订单完成时间',
  `refund_reason` varchar(255) DEFAULT NULL COMMENT '申请退款理由',
  `refund_price` int(11) DEFAULT NULL COMMENT '退款金额',
  `refuse_reason` varchar(255) DEFAULT NULL COMMENT '拒绝维修理由',
  `score` varchar(11) DEFAULT NULL COMMENT '评分',
  `score_time` datetime DEFAULT NULL COMMENT '评分时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `order_history` */

insert  into `order_history`(`id`,`watch_id`,`finish_time`,`refund_reason`,`refund_price`,`refuse_reason`,`score`,`score_time`) values 
(2,17,'2021-10-13 02:45:46',NULL,NULL,NULL,'5','2021-10-15 07:46:10'),
(3,20,'2021-10-13 14:17:05',NULL,NULL,NULL,'5','2021-10-15 07:45:15'),
(4,34,'2021-10-14 04:40:47',NULL,NULL,NULL,'5','2021-10-15 07:58:42'),
(8,36,'2021-10-14 07:54:32','想退款',100,NULL,NULL,NULL),
(12,37,'2021-10-14 08:41:33',NULL,NULL,'修不了',NULL,NULL),
(15,33,'2021-10-15 07:02:26',NULL,NULL,NULL,'2','2021-10-15 07:58:48'),
(16,40,'2021-10-20 05:04:09',NULL,NULL,NULL,'0',NULL);

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_name` varchar(50) DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`id`,`role_name`) values 
(1,'超级管理员'),
(2,'维修总店(客服)'),
(3,'修理厂'),
(4,'客户');

/*Table structure for table `role_menu` */

DROP TABLE IF EXISTS `role_menu`;

CREATE TABLE `role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menu_id` int(11) DEFAULT NULL COMMENT '菜单ID',
  `role_id` int(11) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `role_menu` */

insert  into `role_menu`(`id`,`menu_id`,`role_id`) values 
(1,1,1),
(2,2,2),
(3,4,3),
(4,5,3),
(5,6,3),
(6,7,4),
(7,8,4),
(8,9,4),
(9,10,4),
(10,11,2),
(11,12,2),
(12,13,2);

/*Table structure for table `type` */

DROP TABLE IF EXISTS `type`;

CREATE TABLE `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type_name` varchar(50) DEFAULT NULL COMMENT '维修类型名称',
  `role_id` int(11) DEFAULT NULL COMMENT '联系角色类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `type` */

insert  into `type`(`id`,`type_name`,`role_id`) values 
(1,'电子表维修',3),
(2,'机械表维修',3),
(3,'智能手表维修',3);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `role_id` int(20) NOT NULL COMMENT '角色类型ID',
  `type_id` int(20) DEFAULT NULL COMMENT '修理厂类型ID',
  `tel` varchar(11) DEFAULT NULL COMMENT '用户联系方式',
  `realname` varchar(50) DEFAULT NULL COMMENT '客户真实姓名',
  `balance` int(50) DEFAULT NULL COMMENT '客户钱包余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`role_id`,`type_id`,`tel`,`realname`,`balance`) values 
(1,'admin','202cb962ac59075b964b07152d234b70',1,NULL,'17301541178','null',NULL),
(11,'store','e10adc3949ba59abbe56e057f20f883e',2,NULL,'11111111111',NULL,NULL),
(14,'linsir','e10adc3949ba59abbe56e057f20f883e',3,1,'12345678901',NULL,NULL),
(15,'zhousir','e10adc3949ba59abbe56e057f20f883e',3,2,'11111111111',NULL,NULL),
(16,'nisir','e10adc3949ba59abbe56e057f20f883e',3,3,'11111111111',NULL,NULL),
(17,'kehu','e10adc3949ba59abbe56e057f20f883e',4,NULL,'12345678901','林澳',37648),
(22,'xwahi1','e10adc3949ba59abbe56e057f20f883e',4,NULL,'12121212121','zy',0);

/*Table structure for table `watch` */

DROP TABLE IF EXISTS `watch`;

CREATE TABLE `watch` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `watchname` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '腕表名称',
  `brand` varchar(128) DEFAULT NULL COMMENT '腕表品牌',
  `type` int(11) DEFAULT NULL COMMENT '腕表类型',
  `fixprice` int(200) DEFAULT NULL COMMENT '腕表维修价格',
  `status` int(11) DEFAULT NULL COMMENT '修理状态',
  `user_address` varchar(255) DEFAULT NULL COMMENT '腕表寄回地址',
  `user_name` varchar(50) DEFAULT NULL COMMENT '腕表持有者姓名',
  `user_tel` varchar(50) DEFAULT NULL COMMENT '腕表持有者电话',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

/*Data for the table `watch` */

insert  into `watch`(`id`,`watchname`,`brand`,`type`,`fixprice`,`status`,`user_address`,`user_name`,`user_tel`) values 
(9,'第三块表','4',1,123,11,'好好好地方','倪梓然','17301541111'),
(12,'第六块表','3',3,1111,8,'12345','林澳','11111111111'),
(17,'第十块表','1',1,256,12,'终极测试','林澳','12345678900'),
(20,'第十一块表','1',1,123,12,'123','林澳','12345678900'),
(33,'阿斯顿','7',1,123,12,'123','林澳','12345678990'),
(34,'巴拉巴拉','3',3,123,12,'魔仙堡','林澳','12345678999'),
(36,'测试退款表','1',1,123,7,'测试','林澳','12345678909'),
(37,'第二块表','1',1,NULL,4,'好地方','林澳','12345555555'),
(38,'报告表','1',1,NULL,2,'好地方','林澳','12345678900'),
(39,'你好','1',1,NULL,0,'江苏淮安','林澳','12311212311'),
(40,'sac','1',1,111,12,'淮师','林澳','11111111111'),
(41,'绿石','1',1,1000,3,'怀安','林澳','11111111112');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
