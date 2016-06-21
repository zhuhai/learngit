/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.6.11 : Database - weixin
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`weixin` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `weixin`;

/*Table structure for table `sys_organization` */

DROP TABLE IF EXISTS `sys_organization`;

CREATE TABLE `sys_organization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '组织机构名称',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父组织编号',
  `parent_ids` varchar(100) DEFAULT NULL COMMENT '父组织编号列表',
  `avaliable` tinyint(1) DEFAULT '0',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_sys_orginzation_parent_id` (`parent_id`),
  KEY `idx_sys_orginzation_parent_ids` (`parent_ids`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `sys_organization` */

insert  into `sys_organization`(`id`,`name`,`parent_id`,`parent_ids`,`avaliable`,`update_time`,`create_time`) values (1,'总公司',0,'0/',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(2,'分公司1',1,'0/1/',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(3,'分公司2',1,'0/1/',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(4,'分公司11',2,'0/1/2/',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(5,'分公司3',1,'0/',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(6,'分公司4',1,'0/1/',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(7,'分公司5',1,'0/1/',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(8,'分公司12',2,'0/1/2/',1,'2016-06-20 10:18:26','2016-06-20 10:18:26');

/*Table structure for table `sys_resource` */

DROP TABLE IF EXISTS `sys_resource`;

CREATE TABLE `sys_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '资源名称',
  `type` varchar(50) DEFAULT NULL COMMENT '资源类型',
  `url` varchar(200) DEFAULT NULL COMMENT '资源路径',
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_ids` varchar(100) DEFAULT NULL,
  `permission` varchar(100) DEFAULT NULL,
  `avaliable` tinyint(1) DEFAULT '0',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_sys_resource_parent_id` (`parent_id`),
  KEY `idx_sys_resource_parent_ids` (`parent_ids`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `sys_resource` */

insert  into `sys_resource`(`id`,`name`,`type`,`url`,`parent_id`,`parent_ids`,`permission`,`avaliable`,`update_time`,`create_time`) values (1,'资源','menu','',0,'0/',NULL,1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(2,'组织机构管理','menu','/organization',1,'0/1/','organization:*',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(3,'组织机构添加','button','',2,'0/1/2/','organization:create',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(4,'组织机构修改','button','',2,'0/1/2/','organization:update',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(5,'组织机构删除','button','',2,'0/1/2/','organization:delete',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(6,'组织机构查看','button','',2,'0/1/2/','organization:view',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(7,'用户管理','menu','/user',1,'0/1/','user:*',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(8,'用户新增','button','',7,'0/1/7/','user:create',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(9,'用户修改','button','',7,'0/1/7/','user:update',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(10,'用户删除','button','',7,'0/1/7/','user:delete',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(11,'用户查看','button','',7,'0/1/7/','user:view',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(12,'资源管理','menu','/resource',1,'0/1/','resource:*',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(13,'资源新增','button','',12,'0/1/12/','resource:create',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(14,'资源修改','button','',12,'0/1/12/','resource:update',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(15,'资源删除','button','',12,'0/1/12/','resource:delete',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(16,'资源查看','button','',12,'0/1/12/','resource:view',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(17,'角色管理','menu','/role',1,'0/1/','role:*',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(18,'角色新增','button','',17,'0/1/17/','role:create',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(19,'角色修改','button','',17,'0/1/17/','role:update',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(20,'角色删除','button','',17,'0/1/17/','role:delete',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(21,'角色查看','button','',17,'0/1/17/','role:view',1,'2016-06-20 10:18:26','2016-06-20 10:18:26');

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` varchar(100) DEFAULT NULL COMMENT '角色标识',
  `description` varchar(100) DEFAULT NULL COMMENT '角色描述',
  `resource_ids` varchar(100) DEFAULT NULL COMMENT '资源编号列表',
  `avaliable` tinyint(1) DEFAULT '0',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_sys_role_resource_ids` (`resource_ids`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`role`,`description`,`resource_ids`,`avaliable`,`update_time`,`create_time`) values (1,'admin','超级管理员','2,7,12,17',1,'2016-06-20 10:18:26','2016-06-20 10:18:26'),(2,'root','管理员','2',1,'2016-06-20 17:57:36','2016-06-20 14:34:05');

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `organization_id` bigint(20) DEFAULT NULL COMMENT '组织机构id',
  `role_ids` varchar(100) DEFAULT NULL COMMENT '角色id',
  `locked` tinyint(1) DEFAULT '0' COMMENT '是否锁定',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sys_user_username` (`username`),
  KEY `idx_sys_user_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`password`,`organization_id`,`role_ids`,`locked`,`update_time`,`create_time`) values (1,'admin','123456',1,'1',0,'2016-06-20 15:38:48','2016-06-20 10:18:26'),(2,'root','1234',1,'2',0,'2016-06-21 13:35:48','2016-06-20 15:38:37');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
