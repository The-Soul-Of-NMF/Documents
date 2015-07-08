CREATE DATABASE `db_mrms` /*!40100 DEFAULT CHARACTER SET utf8 */;
use `db_mrms`;
CREATE TABLE `tb_department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `total_number` int(10) unsigned NOT NULL,
  `state` tinyint(1) unsigned NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
CREATE TABLE `tb_user_application` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` varchar(32) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `department_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` bigint(11) unsigned NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `DEPARTMENT_idx` (`department_id`),
  CONSTRAINT `DEPARTMENT` FOREIGN KEY (`department_id`) REFERENCES `tb_department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `tb_user` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(32) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `department_id` int(10) unsigned NOT NULL,
  `icon_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` bigint(11) unsigned NOT NULL,
  `working_state` tinyint(1) unsigned NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `USER_DEPARTMENT_idx` (`department_id`),
  CONSTRAINT `USER_DEPARTMENT` FOREIGN KEY (`department_id`) REFERENCES `tb_department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `tb_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `super_admin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  CONSTRAINT `USER` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
CREATE TABLE `tb_notice_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `tb_notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `information` text NOT NULL,
  `send_time` datetime NOT NULL,
  `type` int(11) unsigned NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `NOTICE_TYPE_idx` (`type`),
  CONSTRAINT `NOTICE_TYPE` FOREIGN KEY (`type`) REFERENCES `tb_notice_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `tb_notice_interaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notice_id` int(10) unsigned NOT NULL,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(10) unsigned NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `TO_USER` (`to_user_id`),
  KEY `FROM_USER_idx` (`from_user_id`),
  KEY `NOTICE_idx` (`notice_id`),
  CONSTRAINT `FROM_USER` FOREIGN KEY (`from_user_id`) REFERENCES `tb_user` (`id`),
  CONSTRAINT `NOTICE` FOREIGN KEY (`notice_id`) REFERENCES `tb_notice` (`id`),
  CONSTRAINT `TO_USER` FOREIGN KEY (`to_user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `tb_thing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
CREATE TABLE `tb_meeting_room_state` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
CREATE TABLE `tb_meeting_room` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `door_number` int(10) unsigned NOT NULL,
  `person_limit` int(10) unsigned NOT NULL,
  `state` int(10) unsigned NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `door_number_UNIQUE` (`door_number`),
  KEY `STATE_idx` (`state`),
  CONSTRAINT `STATE` FOREIGN KEY (`state`) REFERENCES `tb_meeting_room_state` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
CREATE TABLE `tb_meeting_room_thing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_room_id` int(10) unsigned NOT NULL,
  `thing_id` int(10) unsigned NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `THING_idx` (`thing_id`),
  KEY `MEETINGROOM_idx` (`meeting_room_id`),
  CONSTRAINT `MEETINGROOM` FOREIGN KEY (`meeting_room_id`) REFERENCES `tb_meeting_room` (`id`),
  CONSTRAINT `THING` FOREIGN KEY (`thing_id`) REFERENCES `tb_thing` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
CREATE TABLE `tb_meeting_state` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
CREATE TABLE `tb_meeting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `sponsor_id` int(10) unsigned NOT NULL,
  `room_id` int(10) unsigned DEFAULT NULL,
  `date` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `during_time` int(10) unsigned NOT NULL,
  `total_number` int(10) unsigned NOT NULL,
  `description` text NOT NULL,
  `state` int(10) unsigned NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `SPONSOR_idx` (`sponsor_id`),
  KEY `ROOM_idx` (`room_id`),
  KEY `meeting_state_idx` (`state`),
  CONSTRAINT `meeting_state` FOREIGN KEY (`state`) REFERENCES `tb_meeting_state` (`id`),
  CONSTRAINT `room` FOREIGN KEY (`room_id`) REFERENCES `tb_meeting_room` (`id`),
  CONSTRAINT `SPONSOR` FOREIGN KEY (`sponsor_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
CREATE TABLE `tb_meeting_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meeting_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `reserved_word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `meeting_idx` (`meeting_id`),
  KEY `user_idx` (`user_id`),
  CONSTRAINT `meeting_id` FOREIGN KEY (`meeting_id`) REFERENCES `tb_meeting` (`id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
