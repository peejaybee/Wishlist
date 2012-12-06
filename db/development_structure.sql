SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS;
SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION;
SET NAMES utf8;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE=NO_AUTO_VALUE_ON_ZERO */;


CREATE DATABASE /*!32312 IF NOT EXISTS*/ `wishlist`;
USE `wishlist`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(80) default NULL,
  `password` varchar(40) default NULL,
  `firstName` varchar(45) NOT NULL default '',
  `lastName` varchar(45) NOT NULL default '',
  `city` varchar(45) NOT NULL default '',
  `state` varchar(45) NOT NULL default '',
  `email` varchar(60) NOT NULL default '',
  `admin` int(1) unsigned NOT NULL default '0',
  `active` int(1) unsigned NOT NULL default '1',
  `notes` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;
INSERT INTO `users` (`id`,`login`,`password`,`firstName`,`lastName`,`city`,`state`,`email`,`admin`,`active`,`notes`) VALUES (1,'hskank','2059d1ae736a96495ad533e0fc36bcdd27d957d2','Hankie','Skank','Anytown','IL','hank@bigscary.com',0,1,''),(2,'phillip','2059d1ae736a96495ad533e0fc36bcdd27d957d2','Phillip','Birmingham','McHenry','IL','phillip@bigscary.com',1,1,'');

DROP TABLE IF EXISTS `wishes`;
CREATE TABLE `wishes` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `wishDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `itemName` varchar(45) NOT NULL default '',
  `numberWanted` int(10) unsigned NOT NULL default '0',
  `itemPrice` int(10) unsigned NOT NULL default '0',
  `whereFound` varchar(100) NOT NULL default '',
  `visible` int(1) unsigned NOT NULL default '1',
  `notes` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;
INSERT INTO `wishes` (`id`,`user_id`,`wishDate`,`itemName`,`numberWanted`,`itemPrice`,`whereFound`,`visible`,`notes`) VALUES (3,2,'2005-03-06 23:00:00','Goomber',1,300,'Wal MArt',0,''),(4,2,'2005-03-06 23:17:00','gozzmoe',3,2500,'Tar-zhay',0,'');

DROP TABLE IF EXISTS `purchases`;
CREATE TABLE `purchases` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `wish_id` int(10) unsigned NOT NULL default '0',
  `numberBought` int(10) unsigned NOT NULL default '0',
  `confirmed` tinyint(1) unsigned NOT NULL default '0',
  `purchaseDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `user_id` int(10) unsigned NOT NULL default '0',
  `visible` int(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT;
SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS;
SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
