DROP TABLE IF EXISTS eap_user;
CREATE TABLE eap_user
(
    id BIGINT(20) PRIMARY KEY NOT NULL,
    mobile NVARCHAR(20),
    nickName NVARCHAR(200),
    PASSWORD NVARCHAR(100),
    birthday NVARCHAR(20),
    sex MEDIUMTEXT,
    createTime DATETIME,
    updateTime DATETIME
) DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX eap_user_id_uindex ON  eap_user (id);
ALTER TABLE eap_user COMMENT = '用户表';


DROP TABLE IF EXISTS eap_role;
CREATE TABLE eap_role (
  id BIGINT (15) PRIMARY KEY NOT NULL, 
  CODE NVARCHAR (45),
  NAME NVARCHAR (50),
  createTime DATETIME,
  updateTime DATETIME,
  memo NVARCHAR (200)
) COMMENT = '角色表' DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX eap_role_id_uindex ON  eap_role (id);


DROP TABLE IF EXISTS eap_user_role;
CREATE TABLE eap_user_role (
  id BIGINT(15) PRIMARY KEY NOT NULL,
  userid BIGINT (15) NOT NULL, 
  roleid BIGINT (15) NOT NULL
) COMMENT = '用户和角色的关联表' DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS eap_menu;
CREATE TABLE eap_menu
(
    id BIGINT(20) PRIMARY KEY NOT NULL,
    CODE NVARCHAR(20),
    NAME NVARCHAR(100),
    appName NVARCHAR(200),
    appProps NVARCHAR(200),
    showOrder BIGINT(20) DEFAULT 0,
    parentId BIGINT(20) DEFAULT 0,
    userId BIGINT(20),
    createTime DATETIME,
    updateTime DATETIME
) DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX eap_menu_id_uindex ON  eap_menu (id);
ALTER TABLE eap_menu COMMENT = '门户菜单表';


DROP TABLE IF EXISTS eap_operation;
CREATE TABLE eap_operation (
  id BIGINT(15) PRIMARY KEY NOT NULL,
  NAME NVARCHAR(50) NOT NULL COMMENT '操作名称',
  parentId BIGINT(15) DEFAULT NULL COMMENT '上级操作',
  dependentId BIGINT(15) DEFAULT NULL,
  isEndNode BIT(1) DEFAULT b'1' COMMENT '是否末级'
) COMMENT='操作类型表' DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX eap_operation_id_uindex ON eap_operation(id);


DROP TABLE IF EXISTS eap_menu_operation;
CREATE TABLE eap_menu_operation (
  id BIGINT(15) PRIMARY KEY NOT NULL,
  menuId BIGINT(15) NOT NULL COMMENT '功能对应菜单ID',
  operationId BIGINT(15) NOT NULL COMMENT '菜单下对应操作类型ID',
  roleId BIGINT(15) DEFAULT '0' COMMENT '值为0时表示菜单上启用的操作'
) COMMENT='请会计处理功能按钮权限表' DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX eap_menu_operation_id_uindex ON eap_menu_operation(id);


DROP TABLE IF EXISTS eap_enum;
CREATE TABLE eap_enum (
  id BIGINT(15) PRIMARY KEY NOT NULL,
  CODE NVARCHAR(100) DEFAULT NULL COMMENT '枚举编码',
  NAME NVARCHAR(100) DEFAULT NULL COMMENT '枚举名称'
) COMMENT='枚举字典主表' DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX eap_enum_id_uindex ON  eap_enum(id);

DROP TABLE IF EXISTS eap_enum_detail;
CREATE TABLE eap_enum_detail (
  id BIGINT(15) PRIMARY KEY NOT NULL,
  enumId BIGINT(15) NOT NULL COMMENT '枚举id',
  CODE NVARCHAR(45) DEFAULT NULL COMMENT '枚举项编码',
  NAME NVARCHAR(100) DEFAULT NULL COMMENT '枚举项名称'
) COMMENT='枚举明细表' DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX eap_enum_detail_id_uindex ON  eap_enum_detail (id);


DROP TABLE IF EXISTS eap_column;
CREATE TABLE eap_column (
  id BIGINT(15) PRIMARY KEY NOT NULL,
  CODE NVARCHAR(100) DEFAULT NULL COMMENT '栏目编码',
  NAME NVARCHAR(100) DEFAULT NULL COMMENT '栏目名称',
  isDefault BIGINT(15) DEFAULT '0' COMMENT '是否为默认方案 1：是 0：否',
  userId BIGINT(20),
  createTime DATETIME,
  updateTime DATETIME
) COMMENT='栏目主表' DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX eap_column_id_uindex ON  eap_column(id);

DROP TABLE IF EXISTS eap_column_detail;
CREATE TABLE eap_column_detail (
  id BIGINT(15) PRIMARY KEY NOT NULL,
  columnId BIGINT(15) NOT NULL COMMENT '栏目方案id',
  fieldName VARCHAR(45) NOT NULL COMMENT '字段名称',
  caption VARCHAR(45) NOT NULL COMMENT '字段标题',
  idFieldType VARCHAR(45) NOT NULL COMMENT '字段类型', 
  width BIGINT(15) COMMENT '宽度',
  defPrecision BIGINT(15) COMMENT '默认精度', 
  idAlignType VARCHAR(45) COMMENT '对齐方式', 
  colIndex BIGINT(15) NOT NULL COMMENT '显示顺序', 
  idOrderMode VARCHAR(45) COMMENT '排序方式', 
  isFixed TINYINT(1) NOT NULL COMMENT '是否固定列', 
  isVisible TINYINT(1) NOT NULL COMMENT '是否显示', 
  isMustSelect TINYINT(1) NOT NULL COMMENT '是否必选', 
  isSystem TINYINT(1) NOT NULL COMMENT '是否系统字段'
) COMMENT='栏目明细表' DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX eap_column_detail_id_uindex ON  eap_column_detail (id);

-- ----------------------------
--  Table structure for `set_enclosure`
-- ----------------------------
DROP TABLE IF EXISTS `set_enclosure`;
CREATE TABLE `set_enclosure` (
  `id` bigint(15) NOT NULL COMMENT '组织ID',
  `orgId` bigint(15) NOT NULL COMMENT '客户组织机构id\n[set_org]',
  `elType` bigint(15) NOT NULL COMMENT '附件类型: 1、图片；2、doc；3、pdf；4、excel；',
  `elSize` varchar(100) DEFAULT NULL COMMENT '默认为0，附件大小（单位: kb）',
  `oldName` varchar(200) NOT NULL COMMENT '上传前文件名',
  `newName` varchar(200) NOT NULL COMMENT '上传后文件名',
  `elSuffix` varchar(50) DEFAULT NULL COMMENT '文件后缀（如: .jpg）',
  `elMd5` varchar(500) DEFAULT NULL COMMENT '文件 MD5 签名信息（预留字段，目前暂不处理）',
  `ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间戳',
  `creator` bigint(15) DEFAULT NULL COMMENT '上传人',
  PRIMARY KEY (`id`,`orgId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件文件信息存储表';


