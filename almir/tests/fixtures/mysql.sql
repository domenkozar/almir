-- MySQL dump 10.13  Distrib 5.1.61, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: bacula
-- ------------------------------------------------------
-- Server version	5.1.61-0+squeeze1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `basefiles`
--

DROP TABLE IF EXISTS `basefiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basefiles` (
  `BaseId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `BaseJobId` int(10) unsigned NOT NULL,
  `JobId` int(10) unsigned NOT NULL,
  `FileId` bigint(20) unsigned NOT NULL,
  `FileIndex` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`BaseId`),
  KEY `basefiles_jobid_idx` (`JobId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basefiles`
--

LOCK TABLES `basefiles` WRITE;
/*!40000 ALTER TABLE `basefiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `basefiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdimages`
--

DROP TABLE IF EXISTS `cdimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdimages` (
  `MediaId` int(10) unsigned NOT NULL,
  `LastBurn` datetime NOT NULL,
  PRIMARY KEY (`MediaId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdimages`
--

LOCK TABLES `cdimages` WRITE;
/*!40000 ALTER TABLE `cdimages` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdimages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `ClientId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` tinyblob NOT NULL,
  `Uname` tinyblob NOT NULL,
  `AutoPrune` tinyint(4) DEFAULT '0',
  `FileRetention` bigint(20) unsigned DEFAULT '0',
  `JobRetention` bigint(20) unsigned DEFAULT '0',
  PRIMARY KEY (`ClientId`),
  UNIQUE KEY `Name` (`Name`(128))
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'cherry-fd','5.0.2 (28Apr10) i486-pc-linux-gnu,debian,squeeze/sid',1,2592000,15552000);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counters`
--

DROP TABLE IF EXISTS `counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counters` (
  `Counter` tinyblob NOT NULL,
  `MinValue` int(11) DEFAULT '0',
  `MaxValue` int(11) DEFAULT '0',
  `CurrentValue` int(11) DEFAULT '0',
  `WrapCounter` tinyblob NOT NULL,
  PRIMARY KEY (`Counter`(128))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counters`
--

LOCK TABLES `counters` WRITE;
/*!40000 ALTER TABLE `counters` DISABLE KEYS */;
/*!40000 ALTER TABLE `counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `DeviceId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` tinyblob NOT NULL,
  `MediaTypeId` int(10) unsigned DEFAULT '0',
  `StorageId` int(10) unsigned DEFAULT '0',
  `DevMounts` int(10) unsigned DEFAULT '0',
  `DevReadBytes` bigint(20) unsigned DEFAULT '0',
  `DevWriteBytes` bigint(20) unsigned DEFAULT '0',
  `DevReadBytesSinceCleaning` bigint(20) unsigned DEFAULT '0',
  `DevWriteBytesSinceCleaning` bigint(20) unsigned DEFAULT '0',
  `DevReadTime` bigint(20) unsigned DEFAULT '0',
  `DevWriteTime` bigint(20) unsigned DEFAULT '0',
  `DevReadTimeSinceCleaning` bigint(20) unsigned DEFAULT '0',
  `DevWriteTimeSinceCleaning` bigint(20) unsigned DEFAULT '0',
  `CleaningDate` datetime DEFAULT '0000-00-00 00:00:00',
  `CleaningPeriod` bigint(20) unsigned DEFAULT '0',
  PRIMARY KEY (`DeviceId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `FileId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `FileIndex` int(10) unsigned DEFAULT '0',
  `JobId` int(10) unsigned NOT NULL,
  `PathId` int(10) unsigned NOT NULL,
  `FilenameId` int(10) unsigned NOT NULL,
  `MarkId` int(10) unsigned DEFAULT '0',
  `LStat` tinyblob NOT NULL,
  `MD5` tinyblob,
  PRIMARY KEY (`FileId`),
  KEY `JobId` (`JobId`),
  KEY `JobId_2` (`JobId`,`PathId`,`FilenameId`)
) ENGINE=MyISAM AUTO_INCREMENT=159 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
INSERT INTO `file` VALUES (1,1,3,1,1,0,'B5 ewlj IGg B Bs Bu A HeA BAA BA BPTA1L BPakHD BPakHD A A C','xSDM84FduguRzbIeVK4Jiw'),(2,1,4,2,2,0,'B5 KfgAK IHt B A A A Lt BAA I BPJZqo BMP8ZL BPJZqr A A C','0zETlZzCbki45OhReGxaXg'),(3,2,4,2,3,0,'B5 Hd4AP IHt B A A A WDU BAA DA BPaeGS BNF9j4 BPadDA A A C','5vFNpmU/Pn7gZCbaUP5IwQ'),(4,3,4,2,4,0,'B5 KfgAy IHt B A A A CxA BAA Y BPJZqo BNPyIt BPJZqr A A C','r9NdgDWpP/FUsMIUUd1CdA'),(5,4,4,2,5,0,'B5 KfgA5 KH/ B A A A E BAA A BPJZqr BPJZqr BPJZqr A A C','0'),(6,5,4,2,6,0,'B5 Hd4AB KH/ B A A A Y BAA A BPSDKv BPSDKv BPSDKv A A C','0'),(7,6,4,2,7,0,'B5 KfgQg IHt B A A A BFho BAA I4 BPadv+ BNF9j4 BPadv/ A A C','6iaD074FoTugwNbIAmMDtA'),(8,7,4,2,8,0,'B5 KfgBO IHt B A A A Kl0 BAA BY BPJZqo BJvdzZ BPJZqr A A C','NXUVQBkSWQ/FA9glUM4bUA'),(9,8,4,2,9,0,'B5 Hd4AF IHt B A A A bsw BAA Do BPVjPY BNZSQJ BPJta0 A A C','uskkgS4u2+lJ03SVScePtw'),(10,9,4,2,10,0,'B5 KfgBd IHt B A A A B54 BAA Q BPJZqo BM5YDk BPJZqr A A C','Mg+/uGnhoCQTV7CJMIShjw'),(11,10,4,2,11,0,'B5 Kfgrb IHt B A A A BFf BAA Q BPJqAp BMmJGr BPJqC7 A A C','Bsirtt9C0j/dCZ+B4sFS5A'),(12,11,4,2,12,0,'B5 KfgSn KH/ B A A A Y BAA A BPadpf BPJZr+ BPJZr+ A A C','0'),(13,12,4,2,13,0,'B5 KfgAI IHt B A A A 2M BAA I BPad5m BNRbGk BPJZqr A A C','njnqfDs3Jaqk8atv4lWOoA'),(14,13,4,2,14,0,'B5 KfgAo IHt B A A A SxU BAA Cg BPSDKv BNWucC BPJZqr A A C','WwR4FijyN7hwcctGcTp4sQ'),(15,14,4,2,15,0,'B5 KfgAH IHt B A A A 1u BAA I BPakDg BNRbGk BPJZqr A A C','JI44HhelfwuPFP92sdfeWg'),(16,15,4,2,16,0,'B5 Kfgr8 KH/ B A A A a BAA A BPaf+x BPJqEn BPJqEn A A C','0'),(17,16,4,2,17,0,'B5 KfgBB KH/ B A A A H BAA A BPaJ3p BPJZqr BPJZqr A A C','0'),(18,17,4,2,18,0,'B5 KfgAJ IHt B A A A K1 BAA I BPJZqo BMP8ZL BPJZqr A A C','JEtTTiBRpHoNpwncu05iKw'),(19,18,4,2,19,0,'B5 Kfgrl KH/ B A A A X BAA A BPJqDA BPJqDA BPJqDC A A C','0'),(20,19,4,2,20,0,'B5 KfgA4 KH/ B A A A E BAA A BPJZqr BPJZqr BPJZqr A A C','0'),(21,20,4,2,21,0,'B5 KfgBR IHt B A A A XE BAA I BPKd28 BMQ0sK BPJZqr A A C','bg1DHOqXSBDmW4MrP+tavw'),(22,21,4,2,22,0,'B5 KfgA0 IHt B A A A B0k BAA Q BPJZqo BNPyIt BPJZqr A A C','eydndqfDjB/8gqibEwElYw'),(23,22,4,2,23,0,'B5 KfgAV IHt B A A A ELR BAA o BPJZqo BL48eu BPJZqr A A C','0tmCQhl0gZI713cqaz7e3A'),(24,23,4,2,24,0,'B5 KfgBA KH/ B A A A H BAA A BPadDF BPJZqr BPJZqr A A C','0'),(25,24,4,2,25,0,'B5 KfgA7 KH/ B A A A V BAA A BPJZqs BPJZqs BPJZqs A A C','0'),(26,25,4,2,26,0,'B5 KfgOi IHt B A A A CPL0 BAA SI BPad4R BPZJoW BPad30 A A C','BfQeejBImSDWC7Z6YrggNA'),(27,26,4,2,27,0,'B5 KfgAz IHt B A A A Bhs BAA Q BPJZqo BNPyIt BPJZqr A A C','ThsI1zHN6rqa4eT9q2sqgQ'),(28,27,4,2,28,0,'B5 KfgBY IHt B A A A BKk BAA Q BPJZqo BL+T96 BPJZqr A A C','3tIXE/ztU1RVq+comGHZNA'),(29,28,4,2,29,0,'B5 KfgAe IHt B A A A KsA BAA BY BPJZqo BNWucC BPJZqr A A C','WK5uwklZI71mhsqBLZO6rA'),(30,29,4,2,30,0,'B5 KfgDM IHt B A A A Xx BAA I BPJZt1 BO6+yC BPJZsp A A C','AmqsSI+ikijvagbh2D0hNw'),(31,30,4,2,31,0,'B5 KfgAa IHt B A A A JJ0 BAA BQ BPJZqo BNWucC BPJZqr A A C','nrJCejG24BEqyWXAgfc3JQ'),(32,31,4,2,32,0,'B5 KfgPS IHt B A A A HqQ BAA BA BPadv+ BLpHyJ BPadv/ A A C','1GV24/SPyAFoOU0XxKpU0g'),(33,32,4,2,33,0,'B5 KfgDI IHt B A A A bt BAA I BPJZsk BO6+yC BPJZsp A A C','cBASDr8fFTJGcfGr7RCZzg'),(34,33,4,2,34,0,'B5 KfgBP IHt B A A A BIz8 BAA JQ BPVjPR BM9QQQ BPJZqr A A C','snbSpspeWI5FMI+JN7ohsg'),(35,34,4,2,35,0,'B5 KfgA6 KH/ B A A A E BAA A BPJZqr BPJZqr BPJZqr A A C','0'),(36,35,4,2,36,0,'B5 KfgAY IHt B A A A y4 BAA I BPJZqo BNWucD BPJZqr A A C','6J7DBIy4SFIfZAykmZpF/A'),(37,36,4,2,37,0,'B5 KfgDR IHt B A A A Bsys BAA Nw BPaPTS BOMZK3 BPJZsr A A C','f/DK/UhTA8AsNtR23UuyNw'),(38,37,4,2,38,0,'B5 Kfgrp KH/ B A A A V BAA A BPJqDA BPJqDA BPJqDC A A C','0'),(39,38,4,2,39,0,'B5 KfgSl KH/ B A A A S BAA A BPaJ3p BPJZr+ BPJZr+ A A C','0'),(40,39,4,2,40,0,'B5 Hd4AR IHt B A A A luA BAA E4 BPakDi BNF9j4 BPakDh A A C','JswGt+3nU78CA1u9mMwNtg'),(41,40,4,2,41,0,'B5 KfgqP IHt B A A A jG BAA I BPJZyz BNakYF BPJZyW A A C','x+mvy/ha/ZwMm5pfemI1cg'),(42,41,4,2,42,0,'B5 KfgPT IHt B A A A Ijw BAA BI BPadv+ BLpHyJ BPadv/ A A C','ukJKw0lrp/YX149VxuCLfg'),(43,42,4,2,43,0,'B5 KfgqU IHt B A A A Baj BAA Q BPJZy6 BMQvY+ BPJZye A A C','m+sEbLM78TsjiYmtW+DGTw'),(44,43,4,2,44,0,'B5 Kfgrq KH/ B A A A M BAA A BPJqDA BPJqDA BPJqDC A A C','0'),(45,44,4,2,45,0,'B5 Kfgra IHt B A A A FwU BAA w BPJqAp BMmJGr BPJqC7 A A C','7OW0/ILzyt66i4vTtcuvGw'),(46,45,4,2,46,0,'B5 KfgBe IHt B A A A Rsc BAA CY BPJZqo BM5YDk BPJZqr A A C','lwminMCN6E9q4Tap3iO+0A'),(47,46,4,2,47,0,'B5 KfgBZ IHt B A A A Bd8 BAA Q BPJZqo BL+T96 BPJZqr A A C','epj+r8mc3cntjtDXrYv1Nw'),(48,47,4,2,48,0,'B5 KfgqM IHt B A A A ut BAA I BPJZx6 BMcta0 BPJZyE A A C','DMImxgOQ8ZIc9SDRvwsU9w'),(49,48,4,2,49,0,'B5 KfgSe IHt B A A A GYk BAA 4 BPJZsA BO7SkX BPJZsA A A C','M6+QbzRUL1G7VyzkH6YcBg'),(50,49,4,2,50,0,'B5 KfgAp IHt B A A A JsA BAA BQ BPJZqo BNWucC BPJZqr A A C','3UMpGMLyyHwT/X87DUaRlw'),(51,50,4,2,51,0,'B5 KfgPW IHt B A A A JAQ BAA BQ BPadv+ BLpHyJ BPadv/ A A C','YQrEBQKjOtLxSX5Nrv+2pg'),(52,51,4,2,52,0,'B5 KfgAr KH/ B A A A E BAA A BPJZqr BPJZqr BPJZqr A A C','0'),(53,52,4,2,53,0,'B5 KfgCs IHt B A A A tI BAA I BPJZsT BOnFdm BPJZsT A A C','yy3iGHBwaztAJjemuLHxeg'),(54,53,4,2,54,0,'B5 KfgSv IHt B A A A BxY BAA Q BPJZsH BN/ORb BPJZsI A A C','WGw6cwUJas6dgpFqyo4Mig'),(55,54,4,2,55,0,'B5 KfgAu IHt B A A A BIG BAA Q BPJZqo BNHr0D BPJZqr A A C','5quKINUv4JNebl3jlB8VBA'),(56,55,4,2,56,0,'B5 KfgA1 IHt B A A A CQs BAA Y BPJZqo BNPyIt BPJZqr A A C','z7zQ8BuUG00s0Tnw5dX5Mg'),(57,56,4,2,57,0,'B5 KfgBG IHt B A A A Lrc BAA Bg BPJZqo BLOA/t BPJZqr A A C','MvHh8GEcsu93FBbKp3j7lA'),(58,57,4,2,58,0,'B5 Kfgrk KH/ B A A A V BAA A BPadr7 BPJqDA BPJqDC A A C','0'),(59,58,4,2,59,0,'B5 KfgSB IHt B A A A ImU BAA BI BPJbpg BLstsZ BPJbpg A A C','yGiVZzZvaTGOSLh/r0Hhgg'),(60,59,4,2,60,0,'B5 KfgAG IHt B A A A GjM BAA 4 BPJZqo BL15E3 BPJZqr A A C','3GpQ4uyRf2RwLnTyFm2ttQ'),(61,60,4,2,61,0,'B5 KfgBM IHt B A A A Les BAA Bg BPZ8z7 BLyiK6 BPJZqr A A C','a0xxntVe1xZFTgIkTMevbw'),(62,61,4,2,62,0,'B5 Kfgrm KH/ B A A A b BAA A BPJqDA BPJqDA BPJqDC A A C','0'),(63,62,4,2,63,0,'B5 Hd4AS IHt B A A A BRIQ BAA KY BPadv+ BNF9j4 BPadv/ A A C','s+97AMv0Yi/wVC4dgyrn3w'),(64,63,4,2,64,0,'B5 KfgAZ IHt B A A A IKU BAA BI BPJZrK BNWucC BPJZqr A A C','gvaoLO9c2dN6UBcb9kcrqw'),(65,64,4,2,65,0,'B5 Hd4AN IHt B A A A BZJ BAA Q BPadC0 BNdAk4 BPadC6 A A C','U7RiVX/hDY5TTRjrNWFAFw'),(66,65,4,2,66,0,'B5 Hd4AL IHt B A A A BhU BAA Q BPadC0 BNF9j3 BPadC2 A A C','vk2xcr361y07Q3549LNqMQ'),(67,66,4,2,67,0,'B5 Hd4AO IHt B A A A gj1I BAA EFA BPad34 BPVp39 BPad3w A A C','Jvm5GUzYYPEJQeMfrwTdiQ'),(68,67,4,2,68,0,'B5 KfgSf IHt B A A A JZA BAA BQ BPJZsA BO7SkX BPJZsA A A C','giPIPdsTr8Auhc0gVDjdcA'),(69,68,4,2,69,0,'B5 KfgqS KH/ B A A A r BAA A BPJb6Q BPJZyd BPJZyd A A C','0'),(70,69,4,2,70,0,'B5 Hd4AG IHt B A A A CYE BAA Y BPR5gj BPLu5g BPR5gl A A C','m/mRW7OvAPKd5BcTtNdUgw'),(71,70,4,2,71,0,'B5 KfgSC IHt B A A A Ilk BAA BI BPJbpg BLstsZ BPJbpg A A C','sQ7UC1YvpAyFVk2NDHqISA'),(72,71,4,2,72,0,'B5 Hd4AM IHt B A A A C1+ BAA Y BPad86 BNdAk4 BPadC6 A A C','+c5P+c9Wh/mnleS0yyAUlQ'),(73,72,4,2,73,0,'B5 KfgAx IHt B A A A BqQ BAA Q BPJZqo BNPyIt BPJZqr A A C','rOPd0qwnwnHAYKifkcr7vg'),(74,73,4,2,74,0,'B5 Kfgro KH/ B A A A M BAA A BPJqDA BPJqDA BPJqDC A A C','0'),(75,74,4,2,75,0,'B5 Kfgrr Int B A A A CUw BAA Y BPaQ5M BMmhzR BPJqDE A A C','KuxvuDVneohmpaLx+OFnDQ'),(76,75,4,2,76,0,'B5 KfgBi IHt B A A A PG8 BAA CI BPJZqo BM5YDk BPJZqr A A C','bsE07LiuWniM6QrJSxrqtg'),(77,76,4,2,77,0,'B5 KfgAj IHt B A A A Hf0 BAA BA BPJZqo BNWucC BPJZqr A A C','gjtb82s8X/Pu2YVJ4ETHjA'),(78,77,4,2,78,0,'B5 Hd4AD IHt B A A A H6k BAA BA BPajuU BNF9j4 BPSDKw A A C','vwo47FZzeokiSypetm7OsQ'),(79,78,4,2,79,0,'B5 KfgqR KH/ B A A A n BAA A BPJb6Q BPJZyd BPJZyd A A C','0'),(80,79,4,2,80,0,'B5 KfgBS KH/ B A A A h BAA A BPJZqs BPJZqs BPJZqs A A C','0'),(81,80,4,2,81,0,'B5 KfgAf IHt B A A A JHA BAA BQ BPJZqo BNWucC BPJZqr A A C','JsKAQYTBRz/gpvYHJp+YKQ'),(82,81,4,2,82,0,'B5 KfgSA IHt B A A A IsY BAA BI BPJbpg BLstsZ BPJbpg A A C','h8226BAAK717wOAlDvX7pw'),(83,82,4,2,83,0,'B5 KfgqX IHt B A A A Bhj BAA Q BPJtc7 BK2L29 BPJZyf A A C','mmlbg3hMsmopUPxwvGkp3A'),(84,83,4,2,84,0,'B5 KfgBC IHt B A A A IuY BAA BI BPVjPX BNDUfK BPJZqr A A C','27nm+nby982g2rrEUwIoww'),(85,84,4,2,85,0,'B5 KfgBf IHt B A A A SAc BAA Cg BPJZqo BM5YDk BPJZqr A A C','sjGVo+f8o9H3lQJlgisxMA'),(86,85,4,2,86,0,'B5 KfgPR IHt B A A A HKw BAA BA BPadv+ BLpHyJ BPadv/ A A C','mdYp9U8H19dnEa38qIziVA'),(87,86,4,2,87,0,'B5 KfgQS IHt B A A A BYyo BAA LQ BPadwF BNF9j4 BPadv/ A A C','PfvyxdSNADVj4Z6iszrtDA'),(88,87,4,2,88,0,'B5 Hd4AE IHt B A A A BbY BAA Q BPadC0 BNF9j3 BPadC2 A A C','l76WvUZ7DOWadZQyEN5Fkw'),(89,88,4,2,89,0,'B5 KfgrZ IHt B A A A EzI BAA o BPJc4M BMJ1S8 BPJc4L A A C','JnoB9ZuV8beSOIdP83k1RA'),(90,89,4,2,90,0,'B5 KfgCq IHt B A A A EvD BAA o BPJZsV BOnFdm BPJZsT A A C','Vl09KrhIDNbOAOEsUcFyWQ'),(91,90,4,2,91,0,'B5 KfgAb IHt B A A A IqA BAA BI BPJZqo BNWucC BPJZqr A A C','eLzReVLcwUbRYYt6YuM/jg'),(92,91,4,2,92,0,'B5 KfgqZ IHt B A A A EEi BAA o BPJZy6 BK5NZ9 BPJZyf A A C','svFdD1KA0Gzo3mQLva3e7g'),(93,92,4,2,93,0,'B5 KfgAt IHt B A A A CwX BAA Y BPac/4 BNHr0I BPJZqr A A C','w6wR6d5Vje9W5EoMxuenjA'),(94,93,4,2,94,0,'B5 KfgAv IHt B A A A KSc BAA BY BPKd26 BMma16 BPJZqr A A C','kyLwvDcGntn3Jw2tVlQH8Q'),(95,94,4,2,95,0,'B5 KfgqV IHt B A A A BHH BAA Q BPJZx6 BMQvY+ BPJZye A A C','snD8Aap+sFUakVZyZDDHPg'),(96,95,4,2,96,0,'B5 KfgBH IHt B A A A CJs BAA Y BPJZqo BLOA/t BPJZqr A A C','X++HpYNZ7TOZPkBit3TuZg'),(97,96,4,2,97,0,'B5 KfgBX IHt B A A A DcE BAA g BPJZqo BL+T96 BPJZqr A A C','jAYw0ZfpZcx0MoO5/IcpEA'),(98,97,4,2,98,0,'B5 Kfgrx KH/ B A A A W BAA A BPJqEn BPJqEn BPJqEn A A C','0'),(99,98,4,2,99,0,'B5 KfgBJ IHt B A A A HfY BAA BA BPJZqo BMMwti BPJZqr A A C','IBLFvjEL07KccXIHiMTeFg'),(100,99,4,2,100,0,'B5 KfgA/ IHt B A A A D2m BAA g BPJZqo BM6YwT BPJZqr A A C','5oWb2n8Eq9FIUnFj/1bLbw'),(101,100,4,2,101,0,'B5 KfgBQ IHt B A A A Vb BAA I BPJZr8 BMtsvr BPJZqr A A C','9gF73PLqlOueWbkFZs+WHg'),(102,101,4,2,102,0,'B5 KfgBg IHt B A A A Rsc BAA CY BPJZqo BM5YDk BPJZqr A A C','QCJ1NzMAYykac5RqtJP/kQ'),(103,102,4,2,103,0,'B5 KfgqQ IHt B A A A JU BAA I BPJZx6 BJyjLW BPJZyd A A C','UigmDPywLXa9yMjzGkKzEg'),(104,103,4,2,104,0,'B5 KfgAF IHt B A A A ESs BAA o BPJZqo BKpECv BPJZqr A A C','nPUj0ZWpJ2wKPlem7ab2Vw'),(105,104,4,2,105,0,'B5 KfgQG IHt B A A A H1w BAA BA BPadv+ BLpHyJ BPadv/ A A C','qQcQQuuvhkaXTNAYieFZdA'),(106,105,4,2,106,0,'B5 KfgSh IHt B A A A BDs BAA Q BPJZr9 BOu+ek BPJZr+ A A C','nKQCks4lqp6Dnnv87k38RQ'),(107,106,4,2,107,0,'B5 KfgR+ IHt B A A A BFgo BAA I4 BPadv+ BNF9j4 BPadv/ A A C','Hn6pQRR50ZDzpBHN3sU7gA'),(108,107,4,2,108,0,'B5 KfgBU IHt B A A A CJY BAA Y BPJZqo BM5YDk BPJZqr A A C','g17xcYofvTURWDO0gmcwsQ'),(109,108,4,2,109,0,'B5 KfgpI IHt B A A A +2 BAA I BPJZyj BOeZTz BPJZyC A A C','jzEhQ1AoRA5Gwks8Sv++Tw'),(110,109,4,2,110,0,'B5 KfgA3 IHt B A A A CnU BAA Y BPJZqo BNPyIt BPJZqr A A C','2Im0ubH/uVArWNd6J4mrDg'),(111,110,4,2,111,0,'B5 KfgBD IHt B A A A Psc BAA CI BPJZqo BM5YDk BPJZqr A A C','1AKFOL8gT8MR1tcVzB0y4g'),(112,111,4,2,112,0,'B5 Hd4AQ IHt B A A A B2II BAA PA BPadGq BNF9j4 BPadDA A A C','lTU7mw+RsPRXfAeDBdULMA'),(113,112,4,2,113,0,'B5 KfgBa IHt B A A A EOU BAA o BPJZqo BL+T96 BPJZqr A A C','LnRjEBVxx/gwzGUEpTM5eg'),(114,113,4,2,114,0,'B5 KfgBV IHt B A A A O58 BAA CA BPJZqo BM5YDk BPJZqr A A C','braJ7oFRKTkkhSj+3J5F9Q'),(115,114,4,2,115,0,'B5 KfgBK IHt B A A A 2W BAA I BPJZqo BMQNUz BPJZqr A A C','i39/9KTEWQODwaNNIUj8nA'),(116,115,4,2,116,0,'B5 KfgBh IHt B A A A Qr8 BAA CQ BPJZqo BM5YDk BPJZqr A A C','XVXbyCj3xQs18uTRStWowA'),(117,116,4,2,117,0,'B5 KfgBT KH/ B A A A f BAA A BPJZqs BPJZqs BPJZqs A A C','0'),(118,117,4,2,118,0,'B5 Hd4AI IHt B A A A O2 BAA I BPR5gj BB8+Cg BPR5gl A A C','l+jTmhB4qbWzx8uFfiHiLw'),(119,118,4,2,119,0,'B5 Kfgr0 KH/ B A A A c BAA A BPJqEn BPJqEn BPJqEn A A C','0'),(120,119,4,2,120,0,'B5 KfgAs IHt B A A A EH+ BAA o BPadDK BNHr0I BPJZqr A A C','nI4sBkIuAkWZpegWq4IpXg'),(121,120,4,2,121,0,'B5 KfgBL KH/ B A A A O BAA A BPJZqr BPJZqr BPJZqr A A C','0'),(122,121,4,2,122,0,'B5 Kfgr5 KH/ B A A A e BAA A BPaf+x BPJqEn BPJqEn A A C','0'),(123,122,4,2,123,0,'B5 KfgqY IHt B A A A /r BAA I BPJtc8 BK2L29 BPJZyf A A C','ZU9rcmp6NUqfrg5PQVTM6g'),(124,123,4,2,124,0,'B5 KfgqW IHt B A A A Bbb BAA Q BPJtc8 BLHCug BPJZyf A A C','VcV4f2bJ/5vxIEJJc2AtqQ'),(125,124,4,2,125,0,'B5 KfgAk IHt B A A A Ge0 BAA 4 BPJZqo BNWucC BPJZqr A A C','dTlHFLHjgC4rbuFI4SkHxA'),(126,125,4,2,126,0,'B5 KfgSj KH/ B A A A a BAA A BPadAA BPJZr+ BPJZr+ A A C','0'),(127,126,4,2,127,0,'B5 KfgDK IHt B A A A v3 BAA I BPJZsk BO6+yC BPJZsp A A C','ZHuz7JLOdCPIlJLow/IcBw'),(128,127,4,2,128,0,'B5 KfgAi IHt B A A A LsU BAA Bg BPJZqo BNWucC BPJZqr A A C','RD83+ULljygPjFB53SRIIg'),(129,128,4,2,129,0,'B5 KfgAd IHt B A A A IHA BAA BI BPJZqo BNWucC BPJZqr A A C','KYdEcUAPdF69ogDVJp4Y1Q'),(130,129,4,2,130,0,'B5 Hd4AJ IHt B A A A BV8 BAA Q BPR5gj BPLu5g BPR5gl A A C','NSMavwf19/eEAnsDAqDDTg'),(131,130,4,2,131,0,'B5 Hd4AK IHt B A A A lW BAA I BPR5gj BPLu5D BPR5gl A A C','iWJPFaNCfb+kMPWHircrhw'),(132,131,4,2,132,0,'B5 KfgA2 IHt B A A A B7A BAA Q BPJZqo BNPyIt BPJZqr A A C','Cagk4239wZvMUPM2qQSC1g'),(133,132,4,2,133,0,'B5 KfgSx IHt B A A A CbQ BAA Y BPJZsH BN/ORb BPJZsI A A C','2z+6U2fBq93PYC6KmyDBDA'),(134,133,4,2,134,0,'B5 KfgBE IHt B A A A M/0 BAA Bw BPJbpg BLstsZ BPJbpg A A C','7ZkckWOs/PsORDGcbgJn4w'),(135,134,4,2,135,0,'B5 Hd4AT IHt B A A A H67I BAA /g BPad3l BPVp39 BPad3p A A C','y69TeTLUgKb9ihkCINokuA'),(136,135,4,2,136,0,'B5 Kfgrt KH/ B A A A e BAA A BPVjPe BPJqEn BPJqEn A A C','0'),(137,136,4,2,137,0,'B5 KfgqO IHt B A A A VH BAA I BPJZx6 BElCWu BPJZyW A A C','1jVRgAJOaPxAZINOWOSuSQ'),(138,137,4,2,138,0,'B5 KfgCw IHt B A A A Bq BAA I BPJZsY BInff8 BPJZsi A A C','g3QwKrk2+5XgsNFA0IkYUQ'),(139,138,4,2,139,0,'B5 KfgBN IHt B A A A SYM BAA Cg BPJZqo BNISMO BPJZqr A A C','gzSUciUBb/Pqwwdf3k3y/w'),(140,139,4,2,140,0,'B5 KfgAl IHt B A A A F/0 BAA w BPJZqo BNWucC BPJZqr A A C','o2fwmZC0N5ICIG5LmT2Ypw'),(141,140,4,2,141,0,'B5 KfgAm IHt B A A A S00 BAA Cg BPadDF BNWucC BPJZqr A A C','fS8Udzciba31vDeJ1/wrYA'),(142,141,4,2,142,0,'B5 KfgAq KH/ B A A A E BAA A BPJZqr BPJZqr BPJZqr A A C','0'),(143,142,4,2,143,0,'B5 Hd4AH IHt B A A A FZk BAA w BPR5gj BPLu5g BPR5gl A A C','9DVPlamXpdBwmnsv9Ug1tA'),(144,143,4,2,144,0,'B5 KfgAc IHt B A A A JJU BAA BQ BPadDF BNWucC BPJZqr A A C','7k1xukOD8EAUN0c9ZT9K0A'),(145,144,4,2,145,0,'B5 KfgSw IHt B A A A BIA BAA Q BPJZsH BN/ORb BPJZsI A A C','UqcP2xUY4u/lJ53h2ko4Gg'),(146,145,4,2,146,0,'B5 KfgAh IHt B A A A IHA BAA BI BPJZqo BNWucC BPJZqr A A C','Si1RQ7nkSN8dWJiX/yBCFA'),(147,146,4,2,147,0,'B5 KfgrA IHt B A A A FSr BAA w BPJqAp BMmJGr BPJqC7 A A C','sQKB1VR4Jm+f5sUXHcpGsA'),(148,147,4,2,148,0,'B5 KfgBb IHt B A A A BJQ BAA Q BPJZqo BL+T96 BPJZqr A A C','ZXd6pJi7VS8ncDYX6XBauA'),(149,148,4,2,149,0,'B5 KfgA+ IHt B A A A Iaa BAA BI BPadDF BM6YwT BPJZqr A A C','/r2FB/xgVlhbLJmO/W1G5Q'),(150,149,4,2,150,0,'B5 KfgAU IHt B A A A FK BAA I BPJZqo BL48eu BPJZqr A A C','CcCXgbhG4D0DwHWUkjbkqA'),(151,150,4,2,151,0,'B5 KfgBF IHt B A A A Bps BAA Q BPJZqo BLOA/t BPJZqr A A C','7/6fPtZIMEVP1E1ltpNmnA'),(152,151,4,2,152,0,'B5 KfgA8 IHt B A A A Ot8 BAA CA BPJZqo BM5YDk BPJZqr A A C','ff2Kgl9WeVgAquM9YfCW4A'),(153,152,4,2,153,0,'B5 KfgrR IHt B A A A Bh+ BAA Q BPJcBM BLHpiv BPJcAv A A C','g9Q6fAnebUF62VPtsIbsQA'),(154,153,4,2,154,0,'B5 Hd4AC KH/ B A A A T BAA A BPSDKv BPSDKv BPSDKv A A C','0'),(155,154,4,2,155,0,'B5 KfgBI IHt B A A A BO4 BAA Q BPJZqo BLOA/t BPJZqr A A C','XcoAfIO2edRpJxMP+vNmRA'),(156,155,4,2,156,0,'B5 KfgAg IHt B A A A IHA BAA BI BPJZqo BNWucC BPJZqr A A C','YA7c8fgRCFRzkqk0bAdXLA'),(157,156,4,2,157,0,'B5 KfgAn IHt B A A A Lr0 BAA Bg BPJZqo BNWucC BPJZqr A A C','2b0K670Ma3CXE+aDDeG3ug'),(158,157,4,2,158,0,'B5 KfgAE EHt C A A A BAA BAA I BPakD9 BPakDh BPakDh A A C','0');
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filename`
--

DROP TABLE IF EXISTS `filename`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filename` (
  `FilenameId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` blob NOT NULL,
  PRIMARY KEY (`FilenameId`),
  KEY `Name` (`Name`(255))
) ENGINE=MyISAM AUTO_INCREMENT=159 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filename`
--

LOCK TABLES `filename` WRITE;
/*!40000 ALTER TABLE `filename` DISABLE KEYS */;
INSERT INTO `filename` VALUES (1,'bacula.sql'),(2,'remove-shell'),(3,'dbcheck'),(4,'rtcwake'),(5,'ramsize'),(6,'btraceback'),(7,'bextract'),(8,'arp'),(9,'avahi-daemon'),(10,'xqmstats'),(11,'etrn'),(12,'dpkg-statoverride'),(13,'dpkg-reconfigure'),(14,'usermod'),(15,'dpkg-preconfigure'),(16,'sendmail'),(17,'delgroup'),(18,'add-shell'),(19,'praliases'),(20,'rootflags'),(21,'tcptraceroute.db'),(22,'ldattach'),(23,'update-rc.d-insserv'),(24,'addgroup'),(25,'rmt'),(26,'nginx'),(27,'fdformat'),(28,'try-from'),(29,'groupmod'),(30,'locale-gen'),(31,'chgpasswd'),(32,'loaderinfo'),(33,'validlocale'),(34,'rsyslogd'),(35,'vidmode'),(36,'nologin'),(37,'sshd'),(38,'editmap'),(39,'dpkg-divert'),(40,'bacula-fd'),(41,'update-pangox-aliases'),(42,'tapeinfo'),(43,'update-catalog'),(44,'purgestat'),(45,'checksendmail'),(46,'edquota'),(47,'safe_finger'),(48,'update-java-alternatives'),(49,'iconvconfig'),(50,'vipw'),(51,'mtx'),(52,'vigr'),(53,'pam_getenv'),(54,'e2freefrag'),(55,'service'),(56,'cytune'),(57,'dmidecode'),(58,'makemap'),(59,'vzdqdump'),(60,'chroot'),(61,'logrotate'),(62,'mailstats'),(63,'btape'),(64,'chpasswd'),(65,'dbconfig-load-include'),(66,'bregex'),(67,'mysqld'),(68,'zic'),(69,'update-gdkpixbuf-loaders'),(70,'rotatelogs'),(71,'vzdqload'),(72,'dbconfig-generate-include'),(73,'tunelp'),(74,'hoststat'),(75,'sensible-mda'),(76,'repquota'),(77,'pwck'),(78,'bacula-console'),(79,'update-gtk-immodules'),(80,'traceroute'),(81,'grpck'),(82,'vzdqcheck'),(83,'update-fonts-scale'),(84,'cron'),(85,'warnquota'),(86,'scsieject'),(87,'bacula-sd'),(88,'bwild'),(89,'update-python-modules'),(90,'pam-auth-update'),(91,'cppw'),(92,'update-xmlcatalog'),(93,'invoke-rc.d'),(94,'rmt-tar'),(95,'install-sgmlcatalog'),(96,'biosdecode'),(97,'tcpdmatch'),(98,'runq'),(99,'arpd'),(100,'deluser'),(101,'update-info-dir'),(102,'setquota'),(103,'update-icon-caches'),(104,'update-passwd'),(105,'scsitape'),(106,'install-info'),(107,'bls'),(108,'quotastats'),(109,'update-ca-certificates'),(110,'readprofile'),(111,'quota_nld'),(112,'bacula-dir'),(113,'tcpdchk'),(114,'convertquota'),(115,'iptables-apply'),(116,'rpc.rquotad'),(117,'tcptraceroute'),(118,'check_forensic'),(119,'newaliases'),(120,'update-rc.d'),(121,'ip6tables-apply'),(122,'sendmail-msp'),(123,'update-fonts-dir'),(124,'update-fonts-alias'),(125,'pwconv'),(126,'update-alternatives'),(127,'update-locale'),(128,'newusers'),(129,'groupdel'),(130,'checkgid'),(131,'split-logfile'),(132,'rdev'),(133,'filefrag'),(134,'vzquota'),(135,'mysqlmanager'),(136,'sendmail-mta'),(137,'defoma-reconfigure'),(138,'tzconfig'),(139,'accessdb'),(140,'pwunconv'),(141,'useradd'),(142,'cpgr'),(143,'htcacheclean'),(144,'groupadd'),(145,'mklost+found'),(146,'grpunconv'),(147,'sendmailconfig'),(148,'tcpd'),(149,'adduser'),(150,'update-bootsystem-insserv'),(151,'vpddecode'),(152,'quot'),(153,'update-mime'),(154,'bsmtp'),(155,'ownership'),(156,'grpconv'),(157,'userdel'),(158,'');
/*!40000 ALTER TABLE `filename` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileset`
--

DROP TABLE IF EXISTS `fileset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileset` (
  `FileSetId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `FileSet` tinyblob NOT NULL,
  `MD5` tinyblob,
  `CreateTime` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`FileSetId`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileset`
--

LOCK TABLES `fileset` WRITE;
/*!40000 ALTER TABLE `fileset` DISABLE KEYS */;
INSERT INTO `fileset` VALUES (1,'Catalog','b84+V6+tB/+hy4+qT8tJDD','2012-03-21 20:35:40'),(2,'Full Set','O3/69k/N6W0g1/pTBA/5DD','2012-03-21 21:02:20');
/*!40000 ALTER TABLE `fileset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job` (
  `JobId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Job` tinyblob NOT NULL,
  `Name` tinyblob NOT NULL,
  `Type` binary(1) NOT NULL,
  `Level` binary(1) NOT NULL,
  `ClientId` int(11) DEFAULT '0',
  `JobStatus` binary(1) NOT NULL,
  `SchedTime` datetime DEFAULT '0000-00-00 00:00:00',
  `StartTime` datetime DEFAULT '0000-00-00 00:00:00',
  `EndTime` datetime DEFAULT '0000-00-00 00:00:00',
  `RealEndTime` datetime DEFAULT '0000-00-00 00:00:00',
  `JobTDate` bigint(20) unsigned DEFAULT '0',
  `VolSessionId` int(10) unsigned DEFAULT '0',
  `VolSessionTime` int(10) unsigned DEFAULT '0',
  `JobFiles` int(10) unsigned DEFAULT '0',
  `JobBytes` bigint(20) unsigned DEFAULT '0',
  `ReadBytes` bigint(20) unsigned DEFAULT '0',
  `JobErrors` int(10) unsigned DEFAULT '0',
  `JobMissingFiles` int(10) unsigned DEFAULT '0',
  `PoolId` int(10) unsigned DEFAULT '0',
  `FileSetId` int(10) unsigned DEFAULT '0',
  `PriorJobId` int(10) unsigned DEFAULT '0',
  `PurgedFiles` tinyint(4) DEFAULT '0',
  `HasBase` tinyint(4) DEFAULT '0',
  `HasCache` tinyint(4) DEFAULT '0',
  `Reviewed` tinyint(4) DEFAULT '0',
  `Comment` blob,
  PRIMARY KEY (`JobId`),
  KEY `Name` (`Name`(128))
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (1,'BackupCatalog.2012-03-21_20.35.40_03','BackupCatalog','B','F',1,'E','2012-03-21 20:35:37','2012-03-21 20:35:42','2012-03-21 20:38:42','2012-03-21 20:38:42',1332362322,3,1332339992,0,0,0,0,0,2,1,0,0,0,0,0,NULL),(2,'BackupCatalog.2012-03-21_20.59.34_08','BackupCatalog','B','F',1,'f','2012-03-21 20:59:33','2012-03-21 20:59:36','2012-03-21 21:01:48','2012-03-21 21:01:48',1332363708,4,1332339992,0,0,0,0,0,2,1,0,0,0,0,0,NULL),(3,'BackupCatalog.2012-03-21_21.01.53_11','BackupCatalog','B','F',1,'T','2012-03-21 21:01:51','2012-03-21 21:01:55','2012-03-21 21:02:04','2012-03-21 21:02:04',1332363724,1,1332363704,1,30592,30592,0,0,2,1,0,0,0,0,0,NULL),(4,'BackupClient1.2012-03-21_21.02.20_12','BackupClient1','B','F',1,'T','2012-03-21 21:02:18','2012-03-21 21:02:22','2012-03-21 21:02:23','2012-03-21 21:02:23',1332363743,2,1332363704,157,16594245,16594245,0,0,2,2,0,0,0,0,0,NULL);
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobhisto`
--

DROP TABLE IF EXISTS `jobhisto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobhisto` (
  `JobId` int(10) unsigned NOT NULL,
  `Job` tinyblob NOT NULL,
  `Name` tinyblob NOT NULL,
  `Type` binary(1) NOT NULL,
  `Level` binary(1) NOT NULL,
  `ClientId` int(11) DEFAULT '0',
  `JobStatus` binary(1) NOT NULL,
  `SchedTime` datetime DEFAULT '0000-00-00 00:00:00',
  `StartTime` datetime DEFAULT '0000-00-00 00:00:00',
  `EndTime` datetime DEFAULT '0000-00-00 00:00:00',
  `RealEndTime` datetime DEFAULT '0000-00-00 00:00:00',
  `JobTDate` bigint(20) unsigned DEFAULT '0',
  `VolSessionId` int(10) unsigned DEFAULT '0',
  `VolSessionTime` int(10) unsigned DEFAULT '0',
  `JobFiles` int(10) unsigned DEFAULT '0',
  `JobBytes` bigint(20) unsigned DEFAULT '0',
  `ReadBytes` bigint(20) unsigned DEFAULT '0',
  `JobErrors` int(10) unsigned DEFAULT '0',
  `JobMissingFiles` int(10) unsigned DEFAULT '0',
  `PoolId` int(10) unsigned DEFAULT '0',
  `FileSetId` int(10) unsigned DEFAULT '0',
  `PriorJobId` int(10) unsigned DEFAULT '0',
  `PurgedFiles` tinyint(4) DEFAULT '0',
  `HasBase` tinyint(4) DEFAULT '0',
  `HasCache` tinyint(4) DEFAULT '0',
  `Reviewed` tinyint(4) DEFAULT '0',
  `Comment` blob,
  KEY `StartTime` (`StartTime`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobhisto`
--

LOCK TABLES `jobhisto` WRITE;
/*!40000 ALTER TABLE `jobhisto` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobhisto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobmedia`
--

DROP TABLE IF EXISTS `jobmedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobmedia` (
  `JobMediaId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `JobId` int(10) unsigned NOT NULL,
  `MediaId` int(10) unsigned NOT NULL,
  `FirstIndex` int(10) unsigned DEFAULT '0',
  `LastIndex` int(10) unsigned DEFAULT '0',
  `StartFile` int(10) unsigned DEFAULT '0',
  `EndFile` int(10) unsigned DEFAULT '0',
  `StartBlock` int(10) unsigned DEFAULT '0',
  `EndBlock` int(10) unsigned DEFAULT '0',
  `VolIndex` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`JobMediaId`),
  KEY `JobId` (`JobId`,`MediaId`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobmedia`
--

LOCK TABLES `jobmedia` WRITE;
/*!40000 ALTER TABLE `jobmedia` DISABLE KEYS */;
INSERT INTO `jobmedia` VALUES (1,3,1,1,1,0,0,184,31318,1),(2,4,1,1,157,0,0,31319,16658868,1);
/*!40000 ALTER TABLE `jobmedia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `LocationId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Location` tinyblob NOT NULL,
  `Cost` int(11) DEFAULT '0',
  `Enabled` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`LocationId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locationlog`
--

DROP TABLE IF EXISTS `locationlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locationlog` (
  `LocLogId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Date` datetime DEFAULT '0000-00-00 00:00:00',
  `Comment` blob NOT NULL,
  `MediaId` int(10) unsigned DEFAULT '0',
  `LocationId` int(10) unsigned DEFAULT '0',
  `NewVolStatus` enum('Full','Archive','Append','Recycle','Purged','Read-Only','Disabled','Error','Busy','Used','Cleaning') NOT NULL,
  `NewEnabled` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`LocLogId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locationlog`
--

LOCK TABLES `locationlog` WRITE;
/*!40000 ALTER TABLE `locationlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `locationlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `LogId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `JobId` int(10) unsigned DEFAULT '0',
  `Time` datetime DEFAULT '0000-00-00 00:00:00',
  `LogText` blob NOT NULL,
  PRIMARY KEY (`LogId`),
  KEY `JobId` (`JobId`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,1,'2012-03-21 20:35:42','cherry-dir JobId 1: shell command: run BeforeJob \"/etc/bacula/scripts/make_catalog_backup.pl MyCatalog\"\n\0'),(2,1,'2012-03-21 20:35:42','cherry-dir JobId 1: Start Backup JobId 1, Job=BackupCatalog.2012-03-21_20.35.40_03\n\0'),(3,1,'2012-03-21 20:35:42','cherry-dir JobId 1: Using Device \"FileStorage\"\n\0'),(4,1,'2012-03-21 20:38:42','cherry-sd JobId 1: JobId=1 Job=\"BackupCatalog.2012-03-21_20.35.40_03\" marked to be canceled.\n\0'),(5,1,'2012-03-21 20:38:42','cherry-dir JobId 1: Fatal error: No Job status returned from FD.\n\0'),(6,1,'2012-03-21 20:35:52','cherry-dir JobId 1: Warning: bsock.c:129 Could not connect to Client: cherry-fd on localhost:9102. ERR=Connection refused\nRetrying ...\n\0'),(7,1,'2012-03-21 20:38:42','cherry-dir JobId 1: Fatal error: bsock.c:135 Unable to connect to Client: cherry-fd on localhost:9102. ERR=Connection refused\n\0'),(8,1,'2012-03-21 20:38:42','cherry-dir JobId 1: Error: Bacula cherry-dir 5.0.2 (28Apr10): 21-Mar-2012 20:38:42\n  Build OS:               i486-pc-linux-gnu debian squeeze/sid\n  JobId:                  1\n  Job:                    BackupCatalog.2012-03-21_20.35.40_03\n  Backup Level:           Full\n  Client:                 \"cherry-fd\" \n  FileSet:                \"Catalog\" 2012-03-21 20:35:40\n  Pool:                   \"File\" (From Job resource)\n  Catalog:                \"MyCatalog\" (From Client resource)\n  Storage:                \"File\" (From Job resource)\n  Scheduled time:         21-Mar-2012 20:35:37\n  Start time:             21-Mar-2012 20:35:42\n  End time:               21-Mar-2012 20:38:42\n  Elapsed time:           3 mins \n  Priority:               11\n  FD Files Written:       0\n  SD Files Written:       0\n  FD Bytes Written:       0 (0 B)\n  SD Bytes Written:       0 (0 B)\n  Rate:                   0.0 KB/s\n  Software Compression:   None\n  VSS:                    no\n  Encryption:             no\n  Accurate:               no\n  Volume name(s):         \n  Volume Session Id:      3\n  Volume Session Time:    1332339992\n  Last Volume Bytes:      0 (0 B)\n  Non-fatal FD errors:    0\n  SD Errors:              0\n  FD termination status:  Error\n  SD termination status:  Waiting on FD\n  Termination:            *** Backup Error ***\n\n\0'),(9,2,'2012-03-21 20:59:36','cherry-dir JobId 2: shell command: run BeforeJob \"/etc/bacula/scripts/make_catalog_backup.pl MyCatalog\"\n\0'),(10,2,'2012-03-21 20:59:36','cherry-dir JobId 2: Start Backup JobId 2, Job=BackupCatalog.2012-03-21_20.59.34_08\n\0'),(11,2,'2012-03-21 20:59:36','cherry-dir JobId 2: Using Device \"FileStorage\"\n\0'),(12,2,'2012-03-21 20:59:37','cherry-sd JobId 2: Job BackupCatalog.2012-03-21_20.59.34_08 is waiting. Cannot find any appendable volumes.\nPlease use the \"label\" command to create a new Volume for:\n    Storage:      \"FileStorage\" (/var/)\n    Pool:         File\n    Media type:   File\n\0'),(13,2,'2012-03-21 21:01:43','cherry-sd JobId 2: Job BackupCatalog.2012-03-21_20.59.34_08 canceled while waiting for mount on Storage Device \"\"FileStorage\" (/var/)\".\n\0'),(14,2,'2012-03-21 21:01:43','cherry-fd JobId 2: Fatal error: job.c:2004 Bad response to Append Data command. Wanted 3000 OK data\n, got 3903 Error append data\n\n\0'),(15,2,'2012-03-21 21:01:48','cherry-dir JobId 2: Error: Bacula cherry-dir 5.0.2 (28Apr10): 21-Mar-2012 21:01:48\n  Build OS:               i486-pc-linux-gnu debian squeeze/sid\n  JobId:                  2\n  Job:                    BackupCatalog.2012-03-21_20.59.34_08\n  Backup Level:           Full\n  Client:                 \"cherry-fd\" 5.0.2 (28Apr10) i486-pc-linux-gnu,debian,squeeze/sid\n  FileSet:                \"Catalog\" 2012-03-21 20:35:40\n  Pool:                   \"File\" (From Job resource)\n  Catalog:                \"MyCatalog\" (From Client resource)\n  Storage:                \"File\" (From Job resource)\n  Scheduled time:         21-Mar-2012 20:59:33\n  Start time:             21-Mar-2012 20:59:36\n  End time:               21-Mar-2012 21:01:48\n  Elapsed time:           2 mins 12 secs\n  Priority:               11\n  FD Files Written:       0\n  SD Files Written:       0\n  FD Bytes Written:       0 (0 B)\n  SD Bytes Written:       0 (0 B)\n  Rate:                   0.0 KB/s\n  Software Compression:   None\n  VSS:                    no\n  Encryption:             no\n  Accurate:               no\n  Volume name(s):         \n  Volume Session Id:      4\n  Volume Session Time:    1332339992\n  Last Volume Bytes:      0 (0 B)\n  Non-fatal FD errors:    0\n  SD Errors:              0\n  FD termination status:  Error\n  SD termination status:  Canceled\n  Termination:            *** Backup Error ***\n\n\0'),(16,3,'2012-03-21 21:01:55','cherry-dir JobId 3: shell command: run BeforeJob \"/etc/bacula/scripts/make_catalog_backup.pl MyCatalog\"\n\0'),(17,3,'2012-03-21 21:01:55','cherry-dir JobId 3: Start Backup JobId 3, Job=BackupCatalog.2012-03-21_21.01.53_11\n\0'),(18,3,'2012-03-21 21:01:55','cherry-dir JobId 3: Using Device \"FileStorage\"\n\0'),(19,3,'2012-03-21 21:01:55','cherry-sd JobId 3: Job BackupCatalog.2012-03-21_21.01.53_11 is waiting. Cannot find any appendable volumes.\nPlease use the \"label\" command to create a new Volume for:\n    Storage:      \"FileStorage\" (/tmp/)\n    Pool:         File\n    Media type:   File\n\0'),(20,3,'2012-03-21 21:02:04','cherry-sd JobId 3: Wrote label to prelabeled Volume \"Vol\" on device \"FileStorage\" (/tmp/)\n\0'),(21,3,'2012-03-21 21:02:04','cherry-sd JobId 3: Job write elapsed time = 00:00:01, Transfer rate = 30.70 K Bytes/second\n\0'),(22,3,'2012-03-21 21:02:04','cherry-dir JobId 3: Bacula cherry-dir 5.0.2 (28Apr10): 21-Mar-2012 21:02:04\n  Build OS:               i486-pc-linux-gnu debian squeeze/sid\n  JobId:                  3\n  Job:                    BackupCatalog.2012-03-21_21.01.53_11\n  Backup Level:           Full\n  Client:                 \"cherry-fd\" 5.0.2 (28Apr10) i486-pc-linux-gnu,debian,squeeze/sid\n  FileSet:                \"Catalog\" 2012-03-21 20:35:40\n  Pool:                   \"File\" (From Job resource)\n  Catalog:                \"MyCatalog\" (From Client resource)\n  Storage:                \"File\" (From Job resource)\n  Scheduled time:         21-Mar-2012 21:01:51\n  Start time:             21-Mar-2012 21:01:55\n  End time:               21-Mar-2012 21:02:04\n  Elapsed time:           9 secs\n  Priority:               11\n  FD Files Written:       1\n  SD Files Written:       1\n  FD Bytes Written:       30,592 (30.59 KB)\n  SD Bytes Written:       30,701 (30.70 KB)\n  Rate:                   3.4 KB/s\n  Software Compression:   None\n  VSS:                    no\n  Encryption:             no\n  Accurate:               no\n  Volume name(s):         Vol\n  Volume Session Id:      1\n  Volume Session Time:    1332363704\n  Last Volume Bytes:      31,319 (31.31 KB)\n  Non-fatal FD errors:    0\n  SD Errors:              0\n  FD termination status:  OK\n  SD termination status:  OK\n  Termination:            Backup OK\n\n\0'),(23,3,'2012-03-21 21:02:04','cherry-dir JobId 3: Begin pruning Jobs older than 6 months .\n\0'),(24,3,'2012-03-21 21:02:04','cherry-dir JobId 3: No Jobs found to prune.\n\0'),(25,3,'2012-03-21 21:02:04','cherry-dir JobId 3: Begin pruning Jobs.\n\0'),(26,3,'2012-03-21 21:02:04','cherry-dir JobId 3: No Files found to prune.\n\0'),(27,3,'2012-03-21 21:02:04','cherry-dir JobId 3: End auto prune.\n\n\0'),(28,3,'2012-03-21 21:02:04','cherry-dir JobId 3: shell command: run AfterJob \"/etc/bacula/scripts/delete_catalog_backup\"\n\0'),(29,4,'2012-03-21 21:02:20','cherry-dir JobId 4: No prior Full backup Job record found.\n\0'),(30,4,'2012-03-21 21:02:20','cherry-dir JobId 4: No prior or suitable Full backup found in catalog. Doing FULL backup.\n\0'),(31,4,'2012-03-21 21:02:22','cherry-dir JobId 4: Start Backup JobId 4, Job=BackupClient1.2012-03-21_21.02.20_12\n\0'),(32,4,'2012-03-21 21:02:22','cherry-dir JobId 4: Using Device \"FileStorage\"\n\0'),(33,4,'2012-03-21 21:02:22','cherry-sd JobId 4: Volume \"Vol\" previously written, moving to end of data.\n\0'),(34,4,'2012-03-21 21:02:22','cherry-sd JobId 4: Ready to append to end of Volume \"Vol\" size=31319\n\0'),(35,4,'2012-03-21 21:02:23','cherry-sd JobId 4: Job write elapsed time = 00:00:01, Transfer rate = 16.61 M Bytes/second\n\0'),(36,4,'2012-03-21 21:02:23','cherry-dir JobId 4: Bacula cherry-dir 5.0.2 (28Apr10): 21-Mar-2012 21:02:23\n  Build OS:               i486-pc-linux-gnu debian squeeze/sid\n  JobId:                  4\n  Job:                    BackupClient1.2012-03-21_21.02.20_12\n  Backup Level:           Full (upgraded from Incremental)\n  Client:                 \"cherry-fd\" 5.0.2 (28Apr10) i486-pc-linux-gnu,debian,squeeze/sid\n  FileSet:                \"Full Set\" 2012-03-21 21:02:20\n  Pool:                   \"File\" (From Job resource)\n  Catalog:                \"MyCatalog\" (From Client resource)\n  Storage:                \"File\" (From Job resource)\n  Scheduled time:         21-Mar-2012 21:02:18\n  Start time:             21-Mar-2012 21:02:22\n  End time:               21-Mar-2012 21:02:23\n  Elapsed time:           1 sec\n  Priority:               10\n  FD Files Written:       157\n  SD Files Written:       157\n  FD Bytes Written:       16,594,245 (16.59 MB)\n  SD Bytes Written:       16,610,386 (16.61 MB)\n  Rate:                   16594.2 KB/s\n  Software Compression:   None\n  VSS:                    no\n  Encryption:             no\n  Accurate:               no\n  Volume name(s):         Vol\n  Volume Session Id:      2\n  Volume Session Time:    1332363704\n  Last Volume Bytes:      16,658,869 (16.65 MB)\n  Non-fatal FD errors:    0\n  SD Errors:              0\n  FD termination status:  OK\n  SD termination status:  OK\n  Termination:            Backup OK\n\n\0'),(37,4,'2012-03-21 21:02:23','cherry-dir JobId 4: Begin pruning Jobs older than 6 months .\n\0'),(38,4,'2012-03-21 21:02:23','cherry-dir JobId 4: No Jobs found to prune.\n\0'),(39,4,'2012-03-21 21:02:23','cherry-dir JobId 4: Begin pruning Jobs.\n\0'),(40,4,'2012-03-21 21:02:23','cherry-dir JobId 4: No Files found to prune.\n\0'),(41,4,'2012-03-21 21:02:23','cherry-dir JobId 4: End auto prune.\n\n\0');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `MediaId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `VolumeName` tinyblob NOT NULL,
  `Slot` int(11) DEFAULT '0',
  `PoolId` int(10) unsigned DEFAULT '0',
  `MediaType` tinyblob NOT NULL,
  `MediaTypeId` int(10) unsigned DEFAULT '0',
  `LabelType` tinyint(4) DEFAULT '0',
  `FirstWritten` datetime DEFAULT '0000-00-00 00:00:00',
  `LastWritten` datetime DEFAULT '0000-00-00 00:00:00',
  `LabelDate` datetime DEFAULT '0000-00-00 00:00:00',
  `VolJobs` int(10) unsigned DEFAULT '0',
  `VolFiles` int(10) unsigned DEFAULT '0',
  `VolBlocks` int(10) unsigned DEFAULT '0',
  `VolMounts` int(10) unsigned DEFAULT '0',
  `VolBytes` bigint(20) unsigned DEFAULT '0',
  `VolParts` int(10) unsigned DEFAULT '0',
  `VolErrors` int(10) unsigned DEFAULT '0',
  `VolWrites` int(10) unsigned DEFAULT '0',
  `VolCapacityBytes` bigint(20) unsigned DEFAULT '0',
  `VolStatus` enum('Full','Archive','Append','Recycle','Purged','Read-Only','Disabled','Error','Busy','Used','Cleaning') NOT NULL,
  `Enabled` tinyint(4) DEFAULT '1',
  `Recycle` tinyint(4) DEFAULT '0',
  `ActionOnPurge` tinyint(4) DEFAULT '0',
  `VolRetention` bigint(20) unsigned DEFAULT '0',
  `VolUseDuration` bigint(20) unsigned DEFAULT '0',
  `MaxVolJobs` int(10) unsigned DEFAULT '0',
  `MaxVolFiles` int(10) unsigned DEFAULT '0',
  `MaxVolBytes` bigint(20) unsigned DEFAULT '0',
  `InChanger` tinyint(4) DEFAULT '0',
  `StorageId` int(10) unsigned DEFAULT '0',
  `DeviceId` int(10) unsigned DEFAULT '0',
  `MediaAddressing` tinyint(4) DEFAULT '0',
  `VolReadTime` bigint(20) unsigned DEFAULT '0',
  `VolWriteTime` bigint(20) unsigned DEFAULT '0',
  `EndFile` int(10) unsigned DEFAULT '0',
  `EndBlock` int(10) unsigned DEFAULT '0',
  `LocationId` int(10) unsigned DEFAULT '0',
  `RecycleCount` int(10) unsigned DEFAULT '0',
  `InitialWrite` datetime DEFAULT '0000-00-00 00:00:00',
  `ScratchPoolId` int(10) unsigned DEFAULT '0',
  `RecyclePoolId` int(10) unsigned DEFAULT '0',
  `Comment` blob,
  PRIMARY KEY (`MediaId`),
  UNIQUE KEY `VolumeName` (`VolumeName`(128)),
  KEY `PoolId` (`PoolId`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,'Vol',0,2,'File',0,0,'2012-03-21 21:01:55','2012-03-21 21:02:23','2012-03-21 21:01:55',2,0,259,2,16658869,0,0,260,0,'Append',1,1,0,31536000,0,0,0,53687091200,0,1,0,0,0,22660,0,16658868,0,0,'0000-00-00 00:00:00',0,0,NULL);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mediatype`
--

DROP TABLE IF EXISTS `mediatype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mediatype` (
  `MediaTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MediaType` tinyblob NOT NULL,
  `ReadOnly` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`MediaTypeId`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediatype`
--

LOCK TABLES `mediatype` WRITE;
/*!40000 ALTER TABLE `mediatype` DISABLE KEYS */;
INSERT INTO `mediatype` VALUES (1,'File',0);
/*!40000 ALTER TABLE `mediatype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `path`
--

DROP TABLE IF EXISTS `path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `path` (
  `PathId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Path` blob NOT NULL,
  PRIMARY KEY (`PathId`),
  KEY `Path` (`Path`(255))
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `path`
--

LOCK TABLES `path` WRITE;
/*!40000 ALTER TABLE `path` DISABLE KEYS */;
INSERT INTO `path` VALUES (1,'/var/lib/bacula/'),(2,'/usr/sbin/');
/*!40000 ALTER TABLE `path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathhierarchy`
--

DROP TABLE IF EXISTS `pathhierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathhierarchy` (
  `PathId` int(11) NOT NULL,
  `PPathId` int(11) NOT NULL,
  PRIMARY KEY (`PathId`),
  KEY `pathhierarchy_ppathid` (`PPathId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathhierarchy`
--

LOCK TABLES `pathhierarchy` WRITE;
/*!40000 ALTER TABLE `pathhierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `pathhierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathvisibility`
--

DROP TABLE IF EXISTS `pathvisibility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathvisibility` (
  `PathId` int(11) NOT NULL,
  `JobId` int(11) NOT NULL,
  `Size` bigint(20) DEFAULT '0',
  `Files` int(11) DEFAULT '0',
  PRIMARY KEY (`JobId`,`PathId`),
  KEY `pathvisibility_jobid` (`JobId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathvisibility`
--

LOCK TABLES `pathvisibility` WRITE;
/*!40000 ALTER TABLE `pathvisibility` DISABLE KEYS */;
/*!40000 ALTER TABLE `pathvisibility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pool`
--

DROP TABLE IF EXISTS `pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pool` (
  `PoolId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` tinyblob NOT NULL,
  `NumVols` int(10) unsigned DEFAULT '0',
  `MaxVols` int(10) unsigned DEFAULT '0',
  `UseOnce` tinyint(4) DEFAULT '0',
  `UseCatalog` tinyint(4) DEFAULT '0',
  `AcceptAnyVolume` tinyint(4) DEFAULT '0',
  `VolRetention` bigint(20) unsigned DEFAULT '0',
  `VolUseDuration` bigint(20) unsigned DEFAULT '0',
  `MaxVolJobs` int(10) unsigned DEFAULT '0',
  `MaxVolFiles` int(10) unsigned DEFAULT '0',
  `MaxVolBytes` bigint(20) unsigned DEFAULT '0',
  `AutoPrune` tinyint(4) DEFAULT '0',
  `Recycle` tinyint(4) DEFAULT '0',
  `ActionOnPurge` tinyint(4) DEFAULT '0',
  `PoolType` enum('Backup','Copy','Cloned','Archive','Migration','Scratch') NOT NULL,
  `LabelType` tinyint(4) DEFAULT '0',
  `LabelFormat` tinyblob,
  `Enabled` tinyint(4) DEFAULT '1',
  `ScratchPoolId` int(10) unsigned DEFAULT '0',
  `RecyclePoolId` int(10) unsigned DEFAULT '0',
  `NextPoolId` int(10) unsigned DEFAULT '0',
  `MigrationHighBytes` bigint(20) unsigned DEFAULT '0',
  `MigrationLowBytes` bigint(20) unsigned DEFAULT '0',
  `MigrationTime` bigint(20) unsigned DEFAULT '0',
  PRIMARY KEY (`PoolId`),
  UNIQUE KEY `Name` (`Name`(128))
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pool`
--

LOCK TABLES `pool` WRITE;
/*!40000 ALTER TABLE `pool` DISABLE KEYS */;
INSERT INTO `pool` VALUES (1,'Default',0,0,0,1,0,31536000,0,0,0,0,1,1,0,'Backup',0,'*',1,0,0,0,0,0,0),(2,'File',1,100,0,1,0,31536000,0,0,0,53687091200,1,1,0,'Backup',0,'*',1,0,0,0,0,0,0),(3,'Scratch',0,0,0,1,0,31536000,0,0,0,0,1,1,0,'Backup',0,'*',1,0,0,0,0,0,0);
/*!40000 ALTER TABLE `pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `JobStatus` char(1) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `JobStatusLong` blob,
  `Severity` int(11) DEFAULT NULL,
  PRIMARY KEY (`JobStatus`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES ('C','Created, not yet running',15),('R','Running',15),('B','Blocked',15),('T','Completed successfully',10),('E','Terminated with errors',25),('e','Non-fatal error',20),('f','Fatal error',100),('D','Verify found differences',15),('A','Canceled by user',90),('F','Waiting for Client',15),('S','Waiting for Storage daemon',15),('m','Waiting for new media',15),('M','Waiting for media mount',15),('s','Waiting for storage resource',15),('j','Waiting for job resource',15),('c','Waiting for client resource',15),('d','Waiting on maximum jobs',15),('t','Waiting on start time',15),('p','Waiting on higher priority jobs',15),('i','Doing batch insert file records',15),('a','SD despooling attributes',15);
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage`
--

DROP TABLE IF EXISTS `storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage` (
  `StorageId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` tinyblob NOT NULL,
  `AutoChanger` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`StorageId`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage`
--

LOCK TABLES `storage` WRITE;
/*!40000 ALTER TABLE `storage` DISABLE KEYS */;
INSERT INTO `storage` VALUES (1,'File',0);
/*!40000 ALTER TABLE `storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unsavedfiles`
--

DROP TABLE IF EXISTS `unsavedfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unsavedfiles` (
  `UnsavedId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `JobId` int(10) unsigned NOT NULL,
  `PathId` int(10) unsigned NOT NULL,
  `FilenameId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`UnsavedId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unsavedfiles`
--

LOCK TABLES `unsavedfiles` WRITE;
/*!40000 ALTER TABLE `unsavedfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `unsavedfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `VersionId` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (12);
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-21 21:03:34
