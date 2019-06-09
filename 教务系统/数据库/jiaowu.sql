/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.40 : Database - jiaowu
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`jiaowu` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `jiaowu`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `adminuser` varchar(20) NOT NULL COMMENT '管理员用户名',
  `adminpw` varchar(20) DEFAULT NULL COMMENT '管理员密码',
  PRIMARY KEY (`adminuser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`adminuser`,`adminpw`) values ('admin','admin');

/*Table structure for table `curriculum` */

DROP TABLE IF EXISTS `curriculum`;

CREATE TABLE `curriculum` (
  `curriculum` varchar(20) NOT NULL COMMENT '课程号',
  `curriculumname` varchar(20) DEFAULT NULL COMMENT '课程名',
  `tno` varchar(20) DEFAULT NULL COMMENT '教师号',
  `classnum` varchar(20) DEFAULT NULL COMMENT '班级号',
  PRIMARY KEY (`curriculum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `curriculum` */

insert  into `curriculum`(`curriculum`,`curriculumname`,`tno`,`classnum`) values ('10001','JavaEE设计','001','2'),('10002','嵌入式系统开发','004','1'),('10003','计算机网络','001','1'),('10004','职业指导与职业发展','003','2'),('10008','高等数学A1','002','2'),('10009','高等数学A2','002','1'),('10010','毕业设计指导','006','2'),('10011','华清','006','1'),('10012','创业实习','002','1'),('10013','英雄联盟课程2','007','1');

/*Table structure for table `grade` */

DROP TABLE IF EXISTS `grade`;

CREATE TABLE `grade` (
  `sno` varchar(20) DEFAULT NULL COMMENT '学号',
  `curriculum` varchar(20) DEFAULT NULL COMMENT '课程号',
  `grade` varchar(20) DEFAULT NULL COMMENT '成绩',
  `status` varchar(20) DEFAULT NULL COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `grade` */

insert  into `grade`(`sno`,`curriculum`,`grade`,`status`) values ('01502025','10008','87','及格'),('01502025','10009','30','已申请重修'),('01502007','10010','60','及格'),('01502007','10011','45','已申请重修'),('01502007','10001','45','不及格'),('01502007','10002','京东方','不及格'),('01502025','10010','60','及格'),('11','10013','50','已申请重修'),('01502040','10013','50','不及格'),('01502025','10013','60','及格'),('01502007','10013','50','不及格');

/*Table structure for table `message` */

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message` (
  `id` varchar(30) NOT NULL COMMENT 'id',
  `informObj` varchar(30) DEFAULT NULL COMMENT '通知对象',
  `content` varchar(80) DEFAULT NULL COMMENT '内容',
  `time` varchar(50) DEFAULT NULL COMMENT '时间 ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `message` */

insert  into `message`(`id`,`informObj`,`content`,`time`) values ('1551522226330','全体成员','星期八集合,兄弟们@','2019/3/2 下午6:23:46'),('1551532279916','老师','操场集合','2019/3/2 下午9:11:19'),('1551620816082','学生','下午不上课啊','2019/3/3 下午9:46:56'),('1551706998656','学生','毕业再聚@','2019/3/4 下午9:43:18'),('1551707682273','学生','同学们毕业加油@','2019/3/4 下午9:54:42'),('1551708090728','全体成员','900网吧集合,带你吃鸡@','2019/3/4 下午10:01:30'),('1552314869488','老师','通知老师去网吧！','2019/3/11 下午10:34:29'),('1552315717296','全体成员','好好学习','2019/3/11 下午10:48:37'),('1552461552749','全体成员','下午好好学习','2019/3/13 下午3:19:12');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `sno` varchar(20) NOT NULL COMMENT '学号',
  `pasword` varchar(20) DEFAULT NULL COMMENT '密码',
  `name` varchar(15) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `birth` varchar(20) DEFAULT NULL COMMENT '出生年月',
  `class` varchar(20) DEFAULT NULL COMMENT '班级号',
  PRIMARY KEY (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`sno`,`pasword`,`name`,`sex`,`birth`,`class`) values ('01502007','110','李雪东','男','1994-2-09','1'),('01502025','123456','程智慧','女','1993-5-06','2'),('01502026','123456','郭敏','女','1996-6-05','2'),('01502040','123456','王佳烽','男','1995-6-06','2'),('01502044','123456','郝园园','男','1996-2-04','2');

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `tno` varchar(20) NOT NULL COMMENT '教师号',
  `password` varchar(20) DEFAULT NULL COMMENT '密码',
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(20) DEFAULT NULL COMMENT '性别',
  `education` varchar(20) DEFAULT NULL COMMENT '学历',
  `college` varchar(20) DEFAULT NULL COMMENT '所属学院',
  PRIMARY KEY (`tno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `teacher` */

insert  into `teacher`(`tno`,`password`,`name`,`sex`,`education`,`college`) values ('002','123456','张燕','女','研究生','信息工程学院'),('003','123456','张海峰','男','本科','信息工程学院'),('004','123456','希润高娃','女','研究生','信息工程学院'),('006','123','赵佳宁','女','研究生','信息工程学院'),('007','123','李雪冬','女','博士','信息工程学院');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
