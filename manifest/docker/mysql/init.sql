-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS modulith_open DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE modulith_open;

-- 用户表
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `salt` varchar(20) NOT NULL COMMENT '盐',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态 0:禁用，1:正常',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`),
  KEY `idx_mobile` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 初始化管理员账号
INSERT INTO `user` (`username`, `password`, `salt`, `email`, `mobile`, `status`)
VALUES ('admin', 'e10adc3949ba59abbe56e057f20f883e', 'random_salt', 'admin@example.com', '13800138000', 1);

-- 其他必要的初始化SQL语句将根据实际需求添加
