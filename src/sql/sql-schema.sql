create table sys_user(
	id bigint auto_increment,
	username varchar(100) comment '用户名',
	password varchar(100) comment '密码',
	organization_id bigint comment '组织机构id',
	role_ids varchar(100) comment '角色id',
	locked boolean default false comment '是否锁定',
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	create_time timestamp NOT NULL DEFAULT now(),
	constraint pk_sys_user primary key(id),
	unique index idx_sys_user_username(username),
	index idx_sys_user_organization_id(orgainzation_id)
)charset=utf8 ENGINE=InnoDB;

create table sys_organization(
	id bigint auto_increment,
	name varchar(100) comment '组织机构名称',
	parent_id bigint comment '父组织编号',
	parent_ids varchar(100) comment '父组织编号列表',
	avaliable boolean default false,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	create_time timestamp NOT NULL DEFAULT now(),
	constraint pk_sys_orginzation primary key(id),
	index idx_sys_orginzation_parent_id(parent_id),
	index idx_sys_orginzation_parent_ids(parent_ids)
)charset=utf8 ENGINE=InnoDB;

create table sys_role(
	id bigint auto_increment,
	role varchar(100) comment '角色标识',
	description varchar(100) comment '角色描述',
	resource_ids varchar(100) comment '资源编号列表',
	avaliable boolean default false,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	create_time timestamp NOT NULL DEFAULT now(),
	constraint pk_sys_role primary key(id),
	index idx_sys_role_resource_ids(resource_ids)
)charset=utf8 ENGINE=InnoDB;

create table sys_resource(
	id bigint auto_increment,
	name varchar(100) comment '资源名称',
	type varchar(50) comment '资源类型',
	url varchar(200) comment  '资源路径',
	parent_id bigint,
	parent_ids varchar(100),
	permission varchar(100),
	avaliable boolean default false,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	create_time timestamp NOT NULL DEFAULT now(),
	constraint pk_sys_resource primary key(id),
	index idx_sys_resource_parent_id(parent_id),
	index idx_sys_resource_parent_ids(parent_ids)
)charset=utf8 ENGINE=InnoDB;

