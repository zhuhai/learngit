/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50705
Source Host           : localhost:3306
Source Database       : weixin

Target Server Type    : MYSQL
Target Server Version : 50705
File Encoding         : 65001

Date: 2016-06-19 21:37:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_organization
-- ----------------------------
DROP TABLE IF EXISTS `sys_organization`;
CREATE TABLE `sys_organization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '组织机构名称',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父组织编号',
  `parent_ids` varchar(100) DEFAULT NULL COMMENT '父组织编号列表',
  `avaliable` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_sys_orginzation_parent_id` (`parent_id`),
  KEY `idx_sys_orginzation_parent_ids` (`parent_ids`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_organization
-- ----------------------------
INSERT INTO `sys_organization` VALUES ('1', '总公司', '0', '0/', '1');
INSERT INTO `sys_organization` VALUES ('2', '分公司1', '1', '0/1/', '1');
INSERT INTO `sys_organization` VALUES ('3', '分公司2', '1', '0/1/', '1');
INSERT INTO `sys_organization` VALUES ('4', '分公司11', '2', '0/1/2/', '1');
INSERT INTO `sys_organization` VALUES ('5', '分公司3', '1', '0/', '1');
INSERT INTO `sys_organization` VALUES ('6', '分公司4', '1', '0/1/', '1');
INSERT INTO `sys_organization` VALUES ('7', '分公司5', '1', '0/1/', '1');
INSERT INTO `sys_organization` VALUES ('8', '分公司12', '2', '0/1/2/', '1');

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
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
  PRIMARY KEY (`id`),
  KEY `idx_sys_resource_parent_id` (`parent_id`),
  KEY `idx_sys_resource_parent_ids` (`parent_ids`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_resource
-- ----------------------------
INSERT INTO `sys_resource` VALUES ('1', '资源', 'menu', '', '0', '0/', null, '1');
INSERT INTO `sys_resource` VALUES ('2', '组织机构管理', 'menu', '/organization', '1', '0/1/', 'organization:*', '1');
INSERT INTO `sys_resource` VALUES ('3', '组织机构添加', 'button', '', '2', '0/1/2/', 'organization:create', '1');
INSERT INTO `sys_resource` VALUES ('4', '组织机构修改', 'button', '', '2', '0/1/2/', 'organization:update', '1');
INSERT INTO `sys_resource` VALUES ('5', '组织机构删除', 'button', '', '2', '0/1/2/', 'organization:delete', '1');
INSERT INTO `sys_resource` VALUES ('6', '组织机构查看', 'button', '', '2', '0/1/2/', 'organization:view', '1');
INSERT INTO `sys_resource` VALUES ('7', '用户管理', 'menu', '/user', '1', '0/1/', 'user:*', '1');
INSERT INTO `sys_resource` VALUES ('8', '用户新增', 'button', '', '7', '0/1/7/', 'user:create', '1');
INSERT INTO `sys_resource` VALUES ('9', '用户修改', 'button', '', '7', '0/1/7/', 'user:update', '1');
INSERT INTO `sys_resource` VALUES ('10', '用户删除', 'button', '', '7', '0/1/7/', 'user:delete', '1');
INSERT INTO `sys_resource` VALUES ('11', '用户查看', 'button', '', '7', '0/1/7/', 'user:view', '1');
INSERT INTO `sys_resource` VALUES ('12', '资源管理', 'menu', '/resource', '1', '0/1/', 'resource:*', '1');
INSERT INTO `sys_resource` VALUES ('13', '资源新增', 'button', '', '12', '0/1/12/', 'resource:create', '1');
INSERT INTO `sys_resource` VALUES ('14', '资源修改', 'button', '', '12', '0/1/12/', 'resource:update', '1');
INSERT INTO `sys_resource` VALUES ('15', '资源删除', 'button', '', '12', '0/1/12/', 'resource:delete', '1');
INSERT INTO `sys_resource` VALUES ('16', '资源查看', 'button', '', '12', '0/1/12/', 'resource:view', '1');
INSERT INTO `sys_resource` VALUES ('17', '角色管理', 'menu', '/role', '1', '0/1/', 'role:*', '1');
INSERT INTO `sys_resource` VALUES ('18', '角色新增', 'button', '', '17', '0/1/17/', 'role:create', '1');
INSERT INTO `sys_resource` VALUES ('19', '角色修改', 'button', '', '17', '0/1/17/', 'role:update', '1');
INSERT INTO `sys_resource` VALUES ('20', '角色删除', 'button', '', '17', '0/1/17/', 'role:delete', '1');
INSERT INTO `sys_resource` VALUES ('21', '角色查看', 'button', '', '17', '0/1/17/', 'role:view', '1');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` varchar(100) DEFAULT NULL COMMENT '角色标识',
  `description` varchar(100) DEFAULT NULL COMMENT '角色描述',
  `resource_ids` varchar(100) DEFAULT NULL COMMENT '资源编号列表',
  `avaliable` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_sys_role_resource_ids` (`resource_ids`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', 'admin', '超级管理员', '2,7,12,17', '1');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `organization_id` bigint(20) DEFAULT NULL COMMENT '组织机构id',
  `role_ids` varchar(100) DEFAULT NULL COMMENT '角色id',
  `locked` tinyint(1) DEFAULT '0' COMMENT '是否锁定',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sys_user_username` (`username`),
  KEY `idx_sys_user_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '1234', '1', '1', '0');
