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
-- Table structure for table `BaseFiles`
--

DROP TABLE IF EXISTS `BaseFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BaseFiles` (
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
-- Dumping data for table `BaseFiles`
--

LOCK TABLES `BaseFiles` WRITE;
/*!40000 ALTER TABLE `BaseFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `BaseFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CDImages`
--

DROP TABLE IF EXISTS `CDImages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CDImages` (
  `MediaId` int(10) unsigned NOT NULL,
  `LastBurn` datetime NOT NULL,
  PRIMARY KEY (`MediaId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CDImages`
--

LOCK TABLES `CDImages` WRITE;
/*!40000 ALTER TABLE `CDImages` DISABLE KEYS */;
/*!40000 ALTER TABLE `CDImages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Client`
--

DROP TABLE IF EXISTS `Client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Client` (
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
-- Dumping data for table `Client`
--

LOCK TABLES `Client` WRITE;
/*!40000 ALTER TABLE `Client` DISABLE KEYS */;
INSERT INTO `Client` VALUES (1,'cherry-fd','5.0.2 (28Apr10) i486-pc-linux-gnu,debian,squeeze/sid',1,2592000,15552000);
/*!40000 ALTER TABLE `Client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Counters`
--

DROP TABLE IF EXISTS `Counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Counters` (
  `Counter` tinyblob NOT NULL,
  `MinValue` int(11) DEFAULT '0',
  `MaxValue` int(11) DEFAULT '0',
  `CurrentValue` int(11) DEFAULT '0',
  `WrapCounter` tinyblob NOT NULL,
  PRIMARY KEY (`Counter`(128))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Counters`
--

LOCK TABLES `Counters` WRITE;
/*!40000 ALTER TABLE `Counters` DISABLE KEYS */;
/*!40000 ALTER TABLE `Counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Device`
--

DROP TABLE IF EXISTS `Device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Device` (
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
-- Dumping data for table `Device`
--

LOCK TABLES `Device` WRITE;
/*!40000 ALTER TABLE `Device` DISABLE KEYS */;
/*!40000 ALTER TABLE `Device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `File`
--

DROP TABLE IF EXISTS `File`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `File` (
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
) ENGINE=MyISAM AUTO_INCREMENT=158 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File`
--

LOCK TABLES `File` WRITE;
/*!40000 ALTER TABLE `File` DISABLE KEYS */;
INSERT INTO `File` VALUES (1,1,2,1,1,0,'B5 KfgAK IHt B A A A Lt BAA I BPb3UG BMP8ZL BPJZqr A A C','0zETlZzCbki45OhReGxaXg'),(2,2,2,1,2,0,'B5 KfgPS IHt B A A A WDU BAA DA BPb98U BNF9j4 BPb9uH A A C','5vFNpmU/Pn7gZCbaUP5IwQ'),(3,3,2,1,3,0,'B5 KfgAy IHt B A A A CxA BAA Y BPb3UG BNPyIt BPJZqr A A C','r9NdgDWpP/FUsMIUUd1CdA'),(4,4,2,1,4,0,'B5 KfgA5 KH/ B A A A E BAA A BPb13x BPJZqr BPJZqr A A C','0'),(5,5,2,1,5,0,'B5 Hd4AB KH/ B A A A Y BAA A BPb13x BPSDKv BPSDKv A A C','0'),(6,6,2,1,6,0,'B5 Kfgoo IHt B A A A BFho BAA I4 BPb9t/ BNF9j4 BPb9uH A A C','6iaD074FoTugwNbIAmMDtA'),(7,7,2,1,7,0,'B5 KfgBO IHt B A A A Kl0 BAA BY BPb3UG BJvdzZ BPJZqr A A C','NXUVQBkSWQ/FA9glUM4bUA'),(8,8,2,1,8,0,'B5 Hd4AF IHt B A A A bsw BAA Do BPb3UG BNZSQJ BPJta0 A A C','uskkgS4u2+lJ03SVScePtw'),(9,9,2,1,9,0,'B5 KfgBd IHt B A A A B54 BAA Q BPb3UG BM5YDk BPJZqr A A C','Mg+/uGnhoCQTV7CJMIShjw'),(10,10,2,1,10,0,'B5 Kfgrb IHt B A A A BFf BAA Q BPb3UG BMmJGr BPJqC7 A A C','Bsirtt9C0j/dCZ+B4sFS5A'),(11,11,2,1,11,0,'B5 KfgSn KH/ B A A A Y BAA A BPb9wk BPJZr+ BPJZr+ A A C','0'),(12,12,2,1,12,0,'B5 KfgAI IHt B A A A 2M BAA I BPb3UG BNRbGk BPJZqr A A C','njnqfDs3Jaqk8atv4lWOoA'),(13,13,2,1,13,0,'B5 KfgAo IHt B A A A SxU BAA Cg BPb1vN BNWucC BPJZqr A A C','WwR4FijyN7hwcctGcTp4sQ'),(14,14,2,1,14,0,'B5 KfgAH IHt B A A A 1u BAA I BPb1aa BNRbGk BPJZqr A A C','JI44HhelfwuPFP92sdfeWg'),(15,15,2,1,15,0,'B5 Kfgr8 KH/ B A A A a BAA A BPb0Wx BPJqEn BPJqEn A A C','0'),(16,16,2,1,16,0,'B5 KfgBB KH/ B A A A H BAA A BPb13x BPJZqr BPJZqr A A C','0'),(17,17,2,1,17,0,'B5 KfgAJ IHt B A A A K1 BAA I BPb3UG BMP8ZL BPJZqr A A C','JEtTTiBRpHoNpwncu05iKw'),(18,18,2,1,18,0,'B5 Kfgrl KH/ B A A A X BAA A BPb13x BPJqDA BPJqDC A A C','0'),(19,19,2,1,19,0,'B5 KfgA4 KH/ B A A A E BAA A BPb13x BPJZqr BPJZqr A A C','0'),(20,20,2,1,20,0,'B5 KfgBR IHt B A A A XE BAA I BPb3UG BMQ0sK BPJZqr A A C','bg1DHOqXSBDmW4MrP+tavw'),(21,21,2,1,21,0,'B5 KfgA0 IHt B A A A B0k BAA Q BPb3UG BNPyIt BPJZqr A A C','eydndqfDjB/8gqibEwElYw'),(22,22,2,1,22,0,'B5 KfgAV IHt B A A A ELR BAA o BPb3UG BL48eu BPJZqr A A C','0tmCQhl0gZI713cqaz7e3A'),(23,23,2,1,23,0,'B5 KfgBA KH/ B A A A H BAA A BPb1vL BPJZqr BPJZqr A A C','0'),(24,24,2,1,24,0,'B5 KfgA7 KH/ B A A A V BAA A BPb13x BPJZqs BPJZqs A A C','0'),(25,25,2,1,25,0,'B5 KfgOi IHt B A A A CPL0 BAA SI BPb3UG BPZJoW BPad30 A A C','BfQeejBImSDWC7Z6YrggNA'),(26,26,2,1,26,0,'B5 KfgAz IHt B A A A Bhs BAA Q BPb3UH BNPyIt BPJZqr A A C','ThsI1zHN6rqa4eT9q2sqgQ'),(27,27,2,1,27,0,'B5 KfgBY IHt B A A A BKk BAA Q BPb3UH BL+T96 BPJZqr A A C','3tIXE/ztU1RVq+comGHZNA'),(28,28,2,1,28,0,'B5 KfgAe IHt B A A A KsA BAA BY BPb3UH BNWucC BPJZqr A A C','WK5uwklZI71mhsqBLZO6rA'),(29,29,2,1,29,0,'B5 KfgDM IHt B A A A Xx BAA I BPb3UH BO6+yC BPJZsp A A C','AmqsSI+ikijvagbh2D0hNw'),(30,30,2,1,30,0,'B5 KfgAa IHt B A A A JJ0 BAA BQ BPb3UH BNWucC BPJZqr A A C','nrJCejG24BEqyWXAgfc3JQ'),(31,31,2,1,31,0,'B5 KfgQg IHt B A A A HqQ BAA BA BPb9t/ BLpHyJ BPb9uH A A C','1GV24/SPyAFoOU0XxKpU0g'),(32,32,2,1,32,0,'B5 KfgDI IHt B A A A bt BAA I BPb3UH BO6+yC BPJZsp A A C','cBASDr8fFTJGcfGr7RCZzg'),(33,33,2,1,33,0,'B5 KfgBP IHt B A A A BIz8 BAA JQ BPb3UH BM9QQQ BPJZqr A A C','snbSpspeWI5FMI+JN7ohsg'),(34,34,2,1,34,0,'B5 KfgA6 KH/ B A A A E BAA A BPb13x BPJZqr BPJZqr A A C','0'),(35,35,2,1,35,0,'B5 KfgAY IHt B A A A y4 BAA I BPb3UH BNWucD BPJZqr A A C','6J7DBIy4SFIfZAykmZpF/A'),(36,36,2,1,36,0,'B5 KfgDR IHt B A A A Bsys BAA Nw BPbsV4 BOMZK3 BPJZsr A A C','f/DK/UhTA8AsNtR23UuyNw'),(37,37,2,1,37,0,'B5 Kfgrp KH/ B A A A V BAA A BPb13x BPJqDA BPJqDC A A C','0'),(38,38,2,1,38,0,'B5 KfgSl KH/ B A A A S BAA A BPb13x BPJZr+ BPJZr+ A A C','0'),(39,39,2,1,39,0,'B5 Hd4AR IHt B A A A luA BAA E4 BPb3UH BNF9j4 BPakDh A A C','JswGt+3nU78CA1u9mMwNtg'),(40,40,2,1,40,0,'B5 KfgqP IHt B A A A jG BAA I BPb3UH BNakYF BPJZyW A A C','x+mvy/ha/ZwMm5pfemI1cg'),(41,41,2,1,41,0,'B5 KfgR+ IHt B A A A Ijw BAA BI BPb9t/ BLpHyJ BPb9uH A A C','ukJKw0lrp/YX149VxuCLfg'),(42,42,2,1,42,0,'B5 KfgqU IHt B A A A Baj BAA Q BPb3UH BMQvY+ BPJZye A A C','m+sEbLM78TsjiYmtW+DGTw'),(43,43,2,1,43,0,'B5 Kfgrq KH/ B A A A M BAA A BPb13x BPJqDA BPJqDC A A C','0'),(44,44,2,1,44,0,'B5 Kfgra IHt B A A A FwU BAA w BPb3UH BMmJGr BPJqC7 A A C','7OW0/ILzyt66i4vTtcuvGw'),(45,45,2,1,45,0,'B5 KfgBe IHt B A A A Rsc BAA CY BPb3UH BM5YDk BPJZqr A A C','lwminMCN6E9q4Tap3iO+0A'),(46,46,2,1,46,0,'B5 KfgBZ IHt B A A A Bd8 BAA Q BPb3UH BL+T96 BPJZqr A A C','epj+r8mc3cntjtDXrYv1Nw'),(47,47,2,1,47,0,'B5 KfgqM IHt B A A A ut BAA I BPb3UH BMcta0 BPJZyE A A C','DMImxgOQ8ZIc9SDRvwsU9w'),(48,48,2,1,48,0,'B5 KfgSe IHt B A A A GYk BAA 4 BPb3UH BO7SkX BPJZsA A A C','M6+QbzRUL1G7VyzkH6YcBg'),(49,49,2,1,49,0,'B5 KfgAp IHt B A A A JsA BAA BQ BPb3UH BNWucC BPJZqr A A C','3UMpGMLyyHwT/X87DUaRlw'),(50,50,2,1,50,0,'B5 Kfgoi IHt B A A A JAQ BAA BQ BPb9t/ BLpHyJ BPb9uH A A C','YQrEBQKjOtLxSX5Nrv+2pg'),(51,51,2,1,51,0,'B5 KfgAr KH/ B A A A E BAA A BPb13x BPJZqr BPJZqr A A C','0'),(52,52,2,1,52,0,'B5 KfgCs IHt B A A A tI BAA I BPb3UH BOnFdm BPJZsT A A C','yy3iGHBwaztAJjemuLHxeg'),(53,53,2,1,53,0,'B5 KfgSv IHt B A A A BxY BAA Q BPb3UH BN/ORb BPJZsI A A C','WGw6cwUJas6dgpFqyo4Mig'),(54,54,2,1,54,0,'B5 KfgAu IHt B A A A BIG BAA Q BPb3UH BNHr0D BPJZqr A A C','5quKINUv4JNebl3jlB8VBA'),(55,55,2,1,55,0,'B5 KfgA1 IHt B A A A CQs BAA Y BPb3UH BNPyIt BPJZqr A A C','z7zQ8BuUG00s0Tnw5dX5Mg'),(56,56,2,1,56,0,'B5 KfgBG IHt B A A A Lrc BAA Bg BPb3UH BLOA/t BPJZqr A A C','MvHh8GEcsu93FBbKp3j7lA'),(57,57,2,1,57,0,'B5 Kfgrk KH/ B A A A V BAA A BPb13x BPJqDA BPJqDC A A C','0'),(58,58,2,1,58,0,'B5 KfgSB IHt B A A A ImU BAA BI BPb3UH BLstsZ BPJbpg A A C','yGiVZzZvaTGOSLh/r0Hhgg'),(59,59,2,1,59,0,'B5 KfgAG IHt B A A A GjM BAA 4 BPb3UH BL15E3 BPJZqr A A C','3GpQ4uyRf2RwLnTyFm2ttQ'),(60,60,2,1,60,0,'B5 KfgBM IHt B A A A Les BAA Bg BPbmR3 BLyiK6 BPJZqr A A C','a0xxntVe1xZFTgIkTMevbw'),(61,61,2,1,61,0,'B5 Kfgrm KH/ B A A A b BAA A BPb13x BPJqDA BPJqDC A A C','0'),(62,62,2,1,62,0,'B5 Kfgqy IHt B A A A BRIQ BAA KY BPb9uL BNF9j4 BPb9uO A A C','s+97AMv0Yi/wVC4dgyrn3w'),(63,63,2,1,63,0,'B5 KfgAZ IHt B A A A IKU BAA BI BPb3UH BNWucC BPJZqr A A C','gvaoLO9c2dN6UBcb9kcrqw'),(64,64,2,1,64,0,'B5 KfgPQ IHt B A A A BZJ BAA Q BPb9t/ BNdAk4 BPb9uB A A C','U7RiVX/hDY5TTRjrNWFAFw'),(65,65,2,1,65,0,'B5 KfgPF IHt B A A A BhU BAA Q BPb9t/ BNF9j3 BPb9uA A A C','vk2xcr361y07Q3549LNqMQ'),(66,66,2,1,66,0,'B5 Kfgor IHt B A A A gj1I BAA EFA BPb9vv BPVp39 BPb9uJ A A C','Jvm5GUzYYPEJQeMfrwTdiQ'),(67,67,2,1,67,0,'B5 KfgSf IHt B A A A JZA BAA BQ BPb3UH BO7SkX BPJZsA A A C','giPIPdsTr8Auhc0gVDjdcA'),(68,68,2,1,68,0,'B5 KfgqS KH/ B A A A r BAA A BPb13x BPJZyd BPJZyd A A C','0'),(69,69,2,1,69,0,'B5 Hd4AG IHt B A A A CYE BAA Y BPb3UI BPLu5g BPR5gl A A C','m/mRW7OvAPKd5BcTtNdUgw'),(70,70,2,1,70,0,'B5 KfgSC IHt B A A A Ilk BAA BI BPb3UI BLstsZ BPJbpg A A C','sQ7UC1YvpAyFVk2NDHqISA'),(71,71,2,1,71,0,'B5 KfgPN IHt B A A A C1+ BAA Y BPb9t/ BNdAk4 BPb9uB A A C','+c5P+c9Wh/mnleS0yyAUlQ'),(72,72,2,1,72,0,'B5 KfgAx IHt B A A A BqQ BAA Q BPb3UI BNPyIt BPJZqr A A C','rOPd0qwnwnHAYKifkcr7vg'),(73,73,2,1,73,0,'B5 Kfgro KH/ B A A A M BAA A BPb13x BPJqDA BPJqDC A A C','0'),(74,74,2,1,74,0,'B5 Kfgrr Int B A A A CUw BAA Y BPb98U BMmhzR BPJqDE A A C','KuxvuDVneohmpaLx+OFnDQ'),(75,75,2,1,75,0,'B5 KfgBi IHt B A A A PG8 BAA CI BPb3UI BM5YDk BPJZqr A A C','bsE07LiuWniM6QrJSxrqtg'),(76,76,2,1,76,0,'B5 KfgAj IHt B A A A Hf0 BAA BA BPb3UI BNWucC BPJZqr A A C','gjtb82s8X/Pu2YVJ4ETHjA'),(77,77,2,1,77,0,'B5 Hd4AD IHt B A A A H6k BAA BA BPb1yE BNF9j4 BPSDKw A A C','vwo47FZzeokiSypetm7OsQ'),(78,78,2,1,78,0,'B5 KfgqR KH/ B A A A n BAA A BPb13x BPJZyd BPJZyd A A C','0'),(79,79,2,1,79,0,'B5 KfgBS KH/ B A A A h BAA A BPb13x BPJZqs BPJZqs A A C','0'),(80,80,2,1,80,0,'B5 KfgAf IHt B A A A JHA BAA BQ BPb3UI BNWucC BPJZqr A A C','JsKAQYTBRz/gpvYHJp+YKQ'),(81,81,2,1,81,0,'B5 KfgSA IHt B A A A IsY BAA BI BPb3UI BLstsZ BPJbpg A A C','h8226BAAK717wOAlDvX7pw'),(82,82,2,1,82,0,'B5 KfgqX IHt B A A A Bhj BAA Q BPb3UI BK2L29 BPJZyf A A C','mmlbg3hMsmopUPxwvGkp3A'),(83,83,2,1,83,0,'B5 KfgBC IHt B A A A IuY BAA BI BPb3UI BNDUfK BPJZqr A A C','27nm+nby982g2rrEUwIoww'),(84,84,2,1,84,0,'B5 KfgBf IHt B A A A SAc BAA Cg BPb3UI BM5YDk BPJZqr A A C','sjGVo+f8o9H3lQJlgisxMA'),(85,85,2,1,85,0,'B5 KfgQS IHt B A A A HKw BAA BA BPb9t/ BLpHyJ BPb9uH A A C','mdYp9U8H19dnEa38qIziVA'),(86,86,2,1,86,0,'B5 Kfgon IHt B A A A BYyo BAA LQ BPb9vv BNF9j4 BPb9uH A A C','PfvyxdSNADVj4Z6iszrtDA'),(87,87,2,1,87,0,'B5 KfgOp IHt B A A A BbY BAA Q BPb9t/ BNF9j3 BPb9uA A A C','l76WvUZ7DOWadZQyEN5Fkw'),(88,88,2,1,88,0,'B5 KfgrZ IHt B A A A EzI BAA o BPb1vK BMJ1S8 BPJc4L A A C','JnoB9ZuV8beSOIdP83k1RA'),(89,89,2,1,89,0,'B5 KfgCq IHt B A A A EvD BAA o BPb3UI BOnFdm BPJZsT A A C','Vl09KrhIDNbOAOEsUcFyWQ'),(90,90,2,1,90,0,'B5 KfgAb IHt B A A A IqA BAA BI BPb3UI BNWucC BPJZqr A A C','eLzReVLcwUbRYYt6YuM/jg'),(91,91,2,1,91,0,'B5 KfgqZ IHt B A A A EEi BAA o BPb3UI BK5NZ9 BPJZyf A A C','svFdD1KA0Gzo3mQLva3e7g'),(92,92,2,1,92,0,'B5 KfgAt IHt B A A A CwX BAA Y BPb9th BNHr0I BPJZqr A A C','w6wR6d5Vje9W5EoMxuenjA'),(93,93,2,1,93,0,'B5 KfgAv IHt B A A A KSc BAA BY BPb3UI BMma16 BPJZqr A A C','kyLwvDcGntn3Jw2tVlQH8Q'),(94,94,2,1,94,0,'B5 KfgqV IHt B A A A BHH BAA Q BPb3UI BMQvY+ BPJZye A A C','snD8Aap+sFUakVZyZDDHPg'),(95,95,2,1,95,0,'B5 KfgBH IHt B A A A CJs BAA Y BPb3UI BLOA/t BPJZqr A A C','X++HpYNZ7TOZPkBit3TuZg'),(96,96,2,1,96,0,'B5 KfgBX IHt B A A A DcE BAA g BPb3UI BL+T96 BPJZqr A A C','jAYw0ZfpZcx0MoO5/IcpEA'),(97,97,2,1,97,0,'B5 Kfgrx KH/ B A A A W BAA A BPb13x BPJqEn BPJqEn A A C','0'),(98,98,2,1,98,0,'B5 KfgBJ IHt B A A A HfY BAA BA BPb3UI BMMwti BPJZqr A A C','IBLFvjEL07KccXIHiMTeFg'),(99,99,2,1,99,0,'B5 KfgA/ IHt B A A A D2m BAA g BPb3UI BM6YwT BPJZqr A A C','5oWb2n8Eq9FIUnFj/1bLbw'),(100,100,2,1,100,0,'B5 KfgBQ IHt B A A A Vb BAA I BPb3UI BMtsvr BPJZqr A A C','9gF73PLqlOueWbkFZs+WHg'),(101,101,2,1,101,0,'B5 KfgBg IHt B A A A Rsc BAA CY BPb3UI BM5YDk BPJZqr A A C','QCJ1NzMAYykac5RqtJP/kQ'),(102,102,2,1,102,0,'B5 KfgqQ IHt B A A A JU BAA I BPb3UI BJyjLW BPJZyd A A C','UigmDPywLXa9yMjzGkKzEg'),(103,103,2,1,103,0,'B5 KfgAF IHt B A A A ESs BAA o BPb3UI BKpECv BPJZqr A A C','nPUj0ZWpJ2wKPlem7ab2Vw'),(104,104,2,1,104,0,'B5 Kfgol IHt B A A A H1w BAA BA BPb9t/ BLpHyJ BPb9uH A A C','qQcQQuuvhkaXTNAYieFZdA'),(105,105,2,1,105,0,'B5 KfgSh IHt B A A A BDs BAA Q BPb3UI BOu+ek BPJZr+ A A C','nKQCks4lqp6Dnnv87k38RQ'),(106,106,2,1,106,0,'B5 Kfgop IHt B A A A BFgo BAA I4 BPb9t/ BNF9j4 BPb9uH A A C','Hn6pQRR50ZDzpBHN3sU7gA'),(107,107,2,1,107,0,'B5 KfgBU IHt B A A A CJY BAA Y BPb3UI BM5YDk BPJZqr A A C','g17xcYofvTURWDO0gmcwsQ'),(108,108,2,1,108,0,'B5 KfgpI IHt B A A A +2 BAA I BPb3UI BOeZTz BPJZyC A A C','jzEhQ1AoRA5Gwks8Sv++Tw'),(109,109,2,1,109,0,'B5 KfgA3 IHt B A A A CnU BAA Y BPb3UI BNPyIt BPJZqr A A C','2Im0ubH/uVArWNd6J4mrDg'),(110,110,2,1,110,0,'B5 KfgBD IHt B A A A Psc BAA CI BPb3UI BM5YDk BPJZqr A A C','1AKFOL8gT8MR1tcVzB0y4g'),(111,111,2,1,111,0,'B5 KfgQG IHt B A A A B2II BAA PA BPb9vu BNF9j4 BPb9uH A A C','lTU7mw+RsPRXfAeDBdULMA'),(112,112,2,1,112,0,'B5 KfgBa IHt B A A A EOU BAA o BPb3UI BL+T96 BPJZqr A A C','LnRjEBVxx/gwzGUEpTM5eg'),(113,113,2,1,113,0,'B5 KfgBV IHt B A A A O58 BAA CA BPb3UI BM5YDk BPJZqr A A C','braJ7oFRKTkkhSj+3J5F9Q'),(114,114,2,1,114,0,'B5 KfgBK IHt B A A A 2W BAA I BPb3UI BMQNUz BPJZqr A A C','i39/9KTEWQODwaNNIUj8nA'),(115,115,2,1,115,0,'B5 KfgBh IHt B A A A Qr8 BAA CQ BPb3UI BM5YDk BPJZqr A A C','XVXbyCj3xQs18uTRStWowA'),(116,116,2,1,116,0,'B5 KfgBT KH/ B A A A f BAA A BPb13x BPJZqs BPJZqs A A C','0'),(117,117,2,1,117,0,'B5 Hd4AI IHt B A A A O2 BAA I BPb3UI BB8+Cg BPR5gl A A C','l+jTmhB4qbWzx8uFfiHiLw'),(118,118,2,1,118,0,'B5 Kfgr0 KH/ B A A A c BAA A BPb13x BPJqEn BPJqEn A A C','0'),(119,119,2,1,119,0,'B5 KfgAs IHt B A A A EH+ BAA o BPb1re BNHr0I BPJZqr A A C','nI4sBkIuAkWZpegWq4IpXg'),(120,120,2,1,120,0,'B5 KfgBL KH/ B A A A O BAA A BPb13x BPJZqr BPJZqr A A C','0'),(121,121,2,1,121,0,'B5 Kfgr5 KH/ B A A A e BAA A BPb0Wx BPJqEn BPJqEn A A C','0'),(122,122,2,1,122,0,'B5 KfgqY IHt B A A A /r BAA I BPb3UI BK2L29 BPJZyf A A C','ZU9rcmp6NUqfrg5PQVTM6g'),(123,123,2,1,123,0,'B5 KfgqW IHt B A A A Bbb BAA Q BPb3UI BLHCug BPJZyf A A C','VcV4f2bJ/5vxIEJJc2AtqQ'),(124,124,2,1,124,0,'B5 KfgAk IHt B A A A Ge0 BAA 4 BPb3UI BNWucC BPJZqr A A C','dTlHFLHjgC4rbuFI4SkHxA'),(125,125,2,1,125,0,'B5 KfgSj KH/ B A A A a BAA A BPb1o6 BPJZr+ BPJZr+ A A C','0'),(126,126,2,1,126,0,'B5 KfgDK IHt B A A A v3 BAA I BPb3UI BO6+yC BPJZsp A A C','ZHuz7JLOdCPIlJLow/IcBw'),(127,127,2,1,127,0,'B5 KfgAi IHt B A A A LsU BAA Bg BPb3UI BNWucC BPJZqr A A C','RD83+ULljygPjFB53SRIIg'),(128,128,2,1,128,0,'B5 KfgAd IHt B A A A IHA BAA BI BPb3UI BNWucC BPJZqr A A C','KYdEcUAPdF69ogDVJp4Y1Q'),(129,129,2,1,129,0,'B5 Hd4AJ IHt B A A A BV8 BAA Q BPb3UI BPLu5g BPR5gl A A C','NSMavwf19/eEAnsDAqDDTg'),(130,130,2,1,130,0,'B5 Hd4AK IHt B A A A lW BAA I BPb3UI BPLu5D BPR5gl A A C','iWJPFaNCfb+kMPWHircrhw'),(131,131,2,1,131,0,'B5 KfgA2 IHt B A A A B7A BAA Q BPb3UI BNPyIt BPJZqr A A C','Cagk4239wZvMUPM2qQSC1g'),(132,132,2,1,132,0,'B5 KfgSx IHt B A A A CbQ BAA Y BPb3UI BN/ORb BPJZsI A A C','2z+6U2fBq93PYC6KmyDBDA'),(133,133,2,1,133,0,'B5 KfgBE IHt B A A A M/0 BAA Bw BPb3UI BLstsZ BPJbpg A A C','7ZkckWOs/PsORDGcbgJn4w'),(134,134,2,1,134,0,'B5 KfgPR IHt B A A A H67I BAA /g BPb9t/ BPVp39 BPb9uG A A C','y69TeTLUgKb9ihkCINokuA'),(135,135,2,1,135,0,'B5 Kfgrt KH/ B A A A e BAA A BPb13x BPJqEn BPJqEn A A C','0'),(136,136,2,1,136,0,'B5 KfgqO IHt B A A A VH BAA I BPb3UI BElCWu BPJZyW A A C','1jVRgAJOaPxAZINOWOSuSQ'),(137,137,2,1,137,0,'B5 KfgCw IHt B A A A Bq BAA I BPb3UI BInff8 BPJZsi A A C','g3QwKrk2+5XgsNFA0IkYUQ'),(138,138,2,1,138,0,'B5 KfgBN IHt B A A A SYM BAA Cg BPb3UI BNISMO BPJZqr A A C','gzSUciUBb/Pqwwdf3k3y/w'),(139,139,2,1,139,0,'B5 KfgAl IHt B A A A F/0 BAA w BPb3UI BNWucC BPJZqr A A C','o2fwmZC0N5ICIG5LmT2Ypw'),(140,140,2,1,140,0,'B5 KfgAm IHt B A A A S00 BAA Cg BPb1vN BNWucC BPJZqr A A C','fS8Udzciba31vDeJ1/wrYA'),(141,141,2,1,141,0,'B5 KfgAq KH/ B A A A E BAA A BPb13x BPJZqr BPJZqr A A C','0'),(142,142,2,1,142,0,'B5 Hd4AH IHt B A A A FZk BAA w BPb3UI BPLu5g BPR5gl A A C','9DVPlamXpdBwmnsv9Ug1tA'),(143,143,2,1,143,0,'B5 KfgAc IHt B A A A JJU BAA BQ BPb1vM BNWucC BPJZqr A A C','7k1xukOD8EAUN0c9ZT9K0A'),(144,144,2,1,144,0,'B5 KfgSw IHt B A A A BIA BAA Q BPb3UI BN/ORb BPJZsI A A C','UqcP2xUY4u/lJ53h2ko4Gg'),(145,145,2,1,145,0,'B5 KfgAh IHt B A A A IHA BAA BI BPb3UI BNWucC BPJZqr A A C','Si1RQ7nkSN8dWJiX/yBCFA'),(146,146,2,1,146,0,'B5 KfgrA IHt B A A A FSr BAA w BPb3UI BMmJGr BPJqC7 A A C','sQKB1VR4Jm+f5sUXHcpGsA'),(147,147,2,1,147,0,'B5 KfgBb IHt B A A A BJQ BAA Q BPb3UI BL+T96 BPJZqr A A C','ZXd6pJi7VS8ncDYX6XBauA'),(148,148,2,1,148,0,'B5 KfgA+ IHt B A A A Iaa BAA BI BPb1vL BM6YwT BPJZqr A A C','/r2FB/xgVlhbLJmO/W1G5Q'),(149,149,2,1,149,0,'B5 KfgAU IHt B A A A FK BAA I BPb3UI BL48eu BPJZqr A A C','CcCXgbhG4D0DwHWUkjbkqA'),(150,150,2,1,150,0,'B5 KfgBF IHt B A A A Bps BAA Q BPb3UI BLOA/t BPJZqr A A C','7/6fPtZIMEVP1E1ltpNmnA'),(151,151,2,1,151,0,'B5 KfgA8 IHt B A A A Ot8 BAA CA BPb3UI BM5YDk BPJZqr A A C','ff2Kgl9WeVgAquM9YfCW4A'),(152,152,2,1,152,0,'B5 KfgrR IHt B A A A Bh+ BAA Q BPb3UI BLHpiv BPJcAv A A C','g9Q6fAnebUF62VPtsIbsQA'),(153,153,2,1,153,0,'B5 Hd4AC KH/ B A A A T BAA A BPb13x BPSDKv BPSDKv A A C','0'),(154,154,2,1,154,0,'B5 KfgBI IHt B A A A BO4 BAA Q BPb3UI BLOA/t BPJZqr A A C','XcoAfIO2edRpJxMP+vNmRA'),(155,155,2,1,155,0,'B5 KfgAg IHt B A A A IHA BAA BI BPb3UI BNWucC BPJZqr A A C','YA7c8fgRCFRzkqk0bAdXLA'),(156,156,2,1,156,0,'B5 KfgAn IHt B A A A Lr0 BAA Bg BPb3UI BNWucC BPJZqr A A C','2b0K670Ma3CXE+aDDeG3ug'),(157,157,2,1,157,0,'B5 KfgAE EHt C A A A BAA BAA I BPb9wk BPb9uO BPb9uO A A C','0');
/*!40000 ALTER TABLE `File` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FileSet`
--

DROP TABLE IF EXISTS `FileSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FileSet` (
  `FileSetId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `FileSet` tinyblob NOT NULL,
  `MD5` tinyblob,
  `CreateTime` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`FileSetId`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FileSet`
--

LOCK TABLES `FileSet` WRITE;
/*!40000 ALTER TABLE `FileSet` DISABLE KEYS */;
INSERT INTO `FileSet` VALUES (1,'Catalog','b84+V6+tB/+hy4+qT8tJDD','2012-03-26 03:14:26'),(2,'Full Set','O3/69k/N6W0g1/pTBA/5DD','2012-03-26 03:14:30');
/*!40000 ALTER TABLE `FileSet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Filename`
--

DROP TABLE IF EXISTS `Filename`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Filename` (
  `FilenameId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` blob NOT NULL,
  PRIMARY KEY (`FilenameId`),
  KEY `Name` (`Name`(255))
) ENGINE=MyISAM AUTO_INCREMENT=158 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Filename`
--

LOCK TABLES `Filename` WRITE;
/*!40000 ALTER TABLE `Filename` DISABLE KEYS */;
INSERT INTO `Filename` VALUES (1,'remove-shell'),(2,'dbcheck'),(3,'rtcwake'),(4,'ramsize'),(5,'btraceback'),(6,'bextract'),(7,'arp'),(8,'avahi-daemon'),(9,'xqmstats'),(10,'etrn'),(11,'dpkg-statoverride'),(12,'dpkg-reconfigure'),(13,'usermod'),(14,'dpkg-preconfigure'),(15,'sendmail'),(16,'delgroup'),(17,'add-shell'),(18,'praliases'),(19,'rootflags'),(20,'tcptraceroute.db'),(21,'ldattach'),(22,'update-rc.d-insserv'),(23,'addgroup'),(24,'rmt'),(25,'nginx'),(26,'fdformat'),(27,'try-from'),(28,'groupmod'),(29,'locale-gen'),(30,'chgpasswd'),(31,'loaderinfo'),(32,'validlocale'),(33,'rsyslogd'),(34,'vidmode'),(35,'nologin'),(36,'sshd'),(37,'editmap'),(38,'dpkg-divert'),(39,'bacula-fd'),(40,'update-pangox-aliases'),(41,'tapeinfo'),(42,'update-catalog'),(43,'purgestat'),(44,'checksendmail'),(45,'edquota'),(46,'safe_finger'),(47,'update-java-alternatives'),(48,'iconvconfig'),(49,'vipw'),(50,'mtx'),(51,'vigr'),(52,'pam_getenv'),(53,'e2freefrag'),(54,'service'),(55,'cytune'),(56,'dmidecode'),(57,'makemap'),(58,'vzdqdump'),(59,'chroot'),(60,'logrotate'),(61,'mailstats'),(62,'btape'),(63,'chpasswd'),(64,'dbconfig-load-include'),(65,'bregex'),(66,'mysqld'),(67,'zic'),(68,'update-gdkpixbuf-loaders'),(69,'rotatelogs'),(70,'vzdqload'),(71,'dbconfig-generate-include'),(72,'tunelp'),(73,'hoststat'),(74,'sensible-mda'),(75,'repquota'),(76,'pwck'),(77,'bacula-console'),(78,'update-gtk-immodules'),(79,'traceroute'),(80,'grpck'),(81,'vzdqcheck'),(82,'update-fonts-scale'),(83,'cron'),(84,'warnquota'),(85,'scsieject'),(86,'bacula-sd'),(87,'bwild'),(88,'update-python-modules'),(89,'pam-auth-update'),(90,'cppw'),(91,'update-xmlcatalog'),(92,'invoke-rc.d'),(93,'rmt-tar'),(94,'install-sgmlcatalog'),(95,'biosdecode'),(96,'tcpdmatch'),(97,'runq'),(98,'arpd'),(99,'deluser'),(100,'update-info-dir'),(101,'setquota'),(102,'update-icon-caches'),(103,'update-passwd'),(104,'scsitape'),(105,'install-info'),(106,'bls'),(107,'quotastats'),(108,'update-ca-certificates'),(109,'readprofile'),(110,'quota_nld'),(111,'bacula-dir'),(112,'tcpdchk'),(113,'convertquota'),(114,'iptables-apply'),(115,'rpc.rquotad'),(116,'tcptraceroute'),(117,'check_forensic'),(118,'newaliases'),(119,'update-rc.d'),(120,'ip6tables-apply'),(121,'sendmail-msp'),(122,'update-fonts-dir'),(123,'update-fonts-alias'),(124,'pwconv'),(125,'update-alternatives'),(126,'update-locale'),(127,'newusers'),(128,'groupdel'),(129,'checkgid'),(130,'split-logfile'),(131,'rdev'),(132,'filefrag'),(133,'vzquota'),(134,'mysqlmanager'),(135,'sendmail-mta'),(136,'defoma-reconfigure'),(137,'tzconfig'),(138,'accessdb'),(139,'pwunconv'),(140,'useradd'),(141,'cpgr'),(142,'htcacheclean'),(143,'groupadd'),(144,'mklost+found'),(145,'grpunconv'),(146,'sendmailconfig'),(147,'tcpd'),(148,'adduser'),(149,'update-bootsystem-insserv'),(150,'vpddecode'),(151,'quot'),(152,'update-mime'),(153,'bsmtp'),(154,'ownership'),(155,'grpconv'),(156,'userdel'),(157,'');
/*!40000 ALTER TABLE `Filename` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Job`
--

DROP TABLE IF EXISTS `Job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Job` (
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Job`
--

LOCK TABLES `Job` WRITE;
/*!40000 ALTER TABLE `Job` DISABLE KEYS */;
INSERT INTO `Job` VALUES (1,'BackupCatalog.2012-03-26_03.14.26_03','BackupCatalog','B','F',1,'f','2012-03-26 03:14:24','2012-03-26 03:14:28','2012-03-26 03:17:16','2012-03-26 03:17:16',1332731836,1,1332731659,0,0,0,0,0,2,1,0,0,0,0,0,NULL),(2,'BackupClient1.2012-03-26_03.14.30_04','BackupClient1','B','F',1,'T','2012-03-26 03:14:29','2012-03-26 03:17:18','2012-03-26 03:17:45','2012-03-26 03:17:45',1332731865,1,1332731832,157,16594245,16594245,0,0,2,2,0,0,0,0,0,NULL);
/*!40000 ALTER TABLE `Job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JobHisto`
--

DROP TABLE IF EXISTS `JobHisto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `JobHisto` (
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
-- Dumping data for table `JobHisto`
--

LOCK TABLES `JobHisto` WRITE;
/*!40000 ALTER TABLE `JobHisto` DISABLE KEYS */;
/*!40000 ALTER TABLE `JobHisto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JobMedia`
--

DROP TABLE IF EXISTS `JobMedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `JobMedia` (
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JobMedia`
--

LOCK TABLES `JobMedia` WRITE;
/*!40000 ALTER TABLE `JobMedia` DISABLE KEYS */;
INSERT INTO `JobMedia` VALUES (1,2,1,1,157,0,0,182,16627731,1);
/*!40000 ALTER TABLE `JobMedia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Location` (
  `LocationId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Location` tinyblob NOT NULL,
  `Cost` int(11) DEFAULT '0',
  `Enabled` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`LocationId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LocationLog`
--

DROP TABLE IF EXISTS `LocationLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LocationLog` (
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
-- Dumping data for table `LocationLog`
--

LOCK TABLES `LocationLog` WRITE;
/*!40000 ALTER TABLE `LocationLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `LocationLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Log`
--

DROP TABLE IF EXISTS `Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Log` (
  `LogId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `JobId` int(10) unsigned DEFAULT '0',
  `Time` datetime DEFAULT '0000-00-00 00:00:00',
  `LogText` blob NOT NULL,
  PRIMARY KEY (`LogId`),
  KEY `JobId` (`JobId`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Log`
--

LOCK TABLES `Log` WRITE;
/*!40000 ALTER TABLE `Log` DISABLE KEYS */;
INSERT INTO `Log` VALUES (1,1,'2012-03-26 03:14:28','cherry-dir JobId 1: shell command: run BeforeJob \"/etc/bacula/scripts/make_catalog_backup.pl MyCatalog\"\n\0'),(2,1,'2012-03-26 03:14:28','cherry-dir JobId 1: Start Backup JobId 1, Job=BackupCatalog.2012-03-26_03.14.26_03\n\0'),(3,1,'2012-03-26 03:14:28','cherry-dir JobId 1: Using Device \"FileStorage\"\n\0'),(4,1,'2012-03-26 03:14:28','cherry-sd JobId 1: Job BackupCatalog.2012-03-26_03.14.26_03 is waiting. Cannot find any appendable volumes.\nPlease use the \"label\" command to create a new Volume for:\n    Storage:      \"FileStorage\" (/tmp/)\n    Pool:         File\n    Media type:   File\n\0'),(5,2,'2012-03-26 03:14:30','cherry-dir JobId 2: No prior Full backup Job record found.\n\0'),(6,2,'2012-03-26 03:14:30','cherry-dir JobId 2: No prior or suitable Full backup found in catalog. Doing FULL backup.\n\0'),(7,1,'2012-03-26 03:15:40','cherry-sd JobId 1: Job BackupCatalog.2012-03-26_03.14.26_03 is waiting. Cannot find any appendable volumes.\nPlease use the \"label\" command to create a new Volume for:\n    Storage:      \"FileStorage\" (/tmp/)\n    Pool:         File\n    Media type:   File\n\0'),(8,1,'2012-03-26 03:17:11','cherry-sd JobId 1: Job BackupCatalog.2012-03-26_03.14.26_03 canceled while waiting for mount on Storage Device \"\"FileStorage\" (/tmp/)\".\n\0'),(9,1,'2012-03-26 03:17:11','cherry-fd JobId 1: Fatal error: job.c:2004 Bad response to Append Data command. Wanted 3000 OK data\n, got 3903 Error append data\n\n\0'),(10,1,'2012-03-26 03:17:16','cherry-dir JobId 1: Error: Bacula cherry-dir 5.0.2 (28Apr10): 26-Mar-2012 03:17:16\n  Build OS:               i486-pc-linux-gnu debian squeeze/sid\n  JobId:                  1\n  Job:                    BackupCatalog.2012-03-26_03.14.26_03\n  Backup Level:           Full\n  Client:                 \"cherry-fd\" 5.0.2 (28Apr10) i486-pc-linux-gnu,debian,squeeze/sid\n  FileSet:                \"Catalog\" 2012-03-26 03:14:26\n  Pool:                   \"File\" (From Job resource)\n  Catalog:                \"MyCatalog\" (From Client resource)\n  Storage:                \"File\" (From Job resource)\n  Scheduled time:         26-Mar-2012 03:14:24\n  Start time:             26-Mar-2012 03:14:28\n  End time:               26-Mar-2012 03:17:16\n  Elapsed time:           2 mins 48 secs\n  Priority:               11\n  FD Files Written:       0\n  SD Files Written:       0\n  FD Bytes Written:       0 (0 B)\n  SD Bytes Written:       0 (0 B)\n  Rate:                   0.0 KB/s\n  Software Compression:   None\n  VSS:                    no\n  Encryption:             no\n  Accurate:               no\n  Volume name(s):         \n  Volume Session Id:      1\n  Volume Session Time:    1332731659\n  Last Volume Bytes:      0 (0 B)\n  Non-fatal FD errors:    0\n  SD Errors:              0\n  FD termination status:  Error\n  SD termination status:  Canceled\n  Termination:            *** Backup Error ***\n\n\0'),(11,2,'2012-03-26 03:17:18','cherry-dir JobId 2: Start Backup JobId 2, Job=BackupClient1.2012-03-26_03.14.30_04\n\0'),(12,2,'2012-03-26 03:17:18','cherry-dir JobId 2: Using Device \"FileStorage\"\n\0'),(13,2,'2012-03-26 03:17:18','cherry-sd JobId 2: Job BackupClient1.2012-03-26_03.14.30_04 is waiting. Cannot find any appendable volumes.\nPlease use the \"label\" command to create a new Volume for:\n    Storage:      \"FileStorage\" (/tmp/)\n    Pool:         File\n    Media type:   File\n\0'),(14,2,'2012-03-26 03:17:25','cherry-sd JobId 2: Job BackupClient1.2012-03-26_03.14.30_04 is waiting. Cannot find any appendable volumes.\nPlease use the \"label\" command to create a new Volume for:\n    Storage:      \"FileStorage\" (/tmp/)\n    Pool:         File\n    Media type:   File\n\0'),(15,2,'2012-03-26 03:17:45','cherry-sd JobId 2: Wrote label to prelabeled Volume \"2\" on device \"FileStorage\" (/tmp/)\n\0'),(16,2,'2012-03-26 03:17:45','cherry-sd JobId 2: Job write elapsed time = 00:00:01, Transfer rate = 16.61 M Bytes/second\n\0'),(17,2,'2012-03-26 03:17:45','cherry-dir JobId 2: Bacula cherry-dir 5.0.2 (28Apr10): 26-Mar-2012 03:17:45\n  Build OS:               i486-pc-linux-gnu debian squeeze/sid\n  JobId:                  2\n  Job:                    BackupClient1.2012-03-26_03.14.30_04\n  Backup Level:           Full (upgraded from Incremental)\n  Client:                 \"cherry-fd\" 5.0.2 (28Apr10) i486-pc-linux-gnu,debian,squeeze/sid\n  FileSet:                \"Full Set\" 2012-03-26 03:14:30\n  Pool:                   \"File\" (From Job resource)\n  Catalog:                \"MyCatalog\" (From Client resource)\n  Storage:                \"File\" (From Job resource)\n  Scheduled time:         26-Mar-2012 03:14:29\n  Start time:             26-Mar-2012 03:17:18\n  End time:               26-Mar-2012 03:17:45\n  Elapsed time:           27 secs\n  Priority:               10\n  FD Files Written:       157\n  SD Files Written:       157\n  FD Bytes Written:       16,594,245 (16.59 MB)\n  SD Bytes Written:       16,610,386 (16.61 MB)\n  Rate:                   614.6 KB/s\n  Software Compression:   None\n  VSS:                    no\n  Encryption:             no\n  Accurate:               no\n  Volume name(s):         2\n  Volume Session Id:      1\n  Volume Session Time:    1332731832\n  Last Volume Bytes:      16,627,732 (16.62 MB)\n  Non-fatal FD errors:    0\n  SD Errors:              0\n  FD termination status:  OK\n  SD termination status:  OK\n  Termination:            Backup OK\n\n\0'),(18,2,'2012-03-26 03:17:45','cherry-dir JobId 2: Begin pruning Jobs older than 6 months .\n\0'),(19,2,'2012-03-26 03:17:45','cherry-dir JobId 2: No Jobs found to prune.\n\0'),(20,2,'2012-03-26 03:17:45','cherry-dir JobId 2: Begin pruning Jobs.\n\0'),(21,2,'2012-03-26 03:17:45','cherry-dir JobId 2: No Files found to prune.\n\0'),(22,2,'2012-03-26 03:17:45','cherry-dir JobId 2: End auto prune.\n\n\0');
/*!40000 ALTER TABLE `Log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Media`
--

DROP TABLE IF EXISTS `Media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Media` (
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
-- Dumping data for table `Media`
--

LOCK TABLES `Media` WRITE;
/*!40000 ALTER TABLE `Media` DISABLE KEYS */;
INSERT INTO `Media` VALUES (1,'2',0,2,'File',0,0,'2012-03-26 03:17:18','2012-03-26 03:17:45','2012-03-26 03:17:18',1,0,258,1,16627732,0,0,259,0,'Append',1,1,0,31536000,0,0,0,53687091200,0,1,0,0,0,19972,0,16627731,0,0,'0000-00-00 00:00:00',0,0,NULL);
/*!40000 ALTER TABLE `Media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MediaType`
--

DROP TABLE IF EXISTS `MediaType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MediaType` (
  `MediaTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MediaType` tinyblob NOT NULL,
  `ReadOnly` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`MediaTypeId`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MediaType`
--

LOCK TABLES `MediaType` WRITE;
/*!40000 ALTER TABLE `MediaType` DISABLE KEYS */;
INSERT INTO `MediaType` VALUES (1,'File',0);
/*!40000 ALTER TABLE `MediaType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Path`
--

DROP TABLE IF EXISTS `Path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Path` (
  `PathId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Path` blob NOT NULL,
  PRIMARY KEY (`PathId`),
  KEY `Path` (`Path`(255))
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Path`
--

LOCK TABLES `Path` WRITE;
/*!40000 ALTER TABLE `Path` DISABLE KEYS */;
INSERT INTO `Path` VALUES (1,'/usr/sbin/');
/*!40000 ALTER TABLE `Path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PathHierarchy`
--

DROP TABLE IF EXISTS `PathHierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PathHierarchy` (
  `PathId` int(11) NOT NULL,
  `PPathId` int(11) NOT NULL,
  PRIMARY KEY (`PathId`),
  KEY `pathhierarchy_ppathid` (`PPathId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PathHierarchy`
--

LOCK TABLES `PathHierarchy` WRITE;
/*!40000 ALTER TABLE `PathHierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `PathHierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PathVisibility`
--

DROP TABLE IF EXISTS `PathVisibility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PathVisibility` (
  `PathId` int(11) NOT NULL,
  `JobId` int(11) NOT NULL,
  `Size` bigint(20) DEFAULT '0',
  `Files` int(11) DEFAULT '0',
  PRIMARY KEY (`JobId`,`PathId`),
  KEY `pathvisibility_jobid` (`JobId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PathVisibility`
--

LOCK TABLES `PathVisibility` WRITE;
/*!40000 ALTER TABLE `PathVisibility` DISABLE KEYS */;
/*!40000 ALTER TABLE `PathVisibility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pool`
--

DROP TABLE IF EXISTS `Pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pool` (
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
-- Dumping data for table `Pool`
--

LOCK TABLES `Pool` WRITE;
/*!40000 ALTER TABLE `Pool` DISABLE KEYS */;
INSERT INTO `Pool` VALUES (1,'Default',0,0,0,1,0,31536000,0,0,0,0,1,1,0,'Backup',0,'*',1,0,0,0,0,0,0),(2,'File',1,100,0,1,0,31536000,0,0,0,53687091200,1,1,0,'Backup',0,'*',1,0,0,0,0,0,0),(3,'Scratch',0,0,0,1,0,31536000,0,0,0,0,1,1,0,'Backup',0,'*',1,0,0,0,0,0,0);
/*!40000 ALTER TABLE `Pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Status`
--

DROP TABLE IF EXISTS `Status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Status` (
  `JobStatus` char(1) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `JobStatusLong` blob,
  `Severity` int(11) DEFAULT NULL,
  PRIMARY KEY (`JobStatus`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Status`
--

LOCK TABLES `Status` WRITE;
/*!40000 ALTER TABLE `Status` DISABLE KEYS */;
INSERT INTO `Status` VALUES ('C','Created, not yet running',15),('R','Running',15),('B','Blocked',15),('T','Completed successfully',10),('E','Terminated with errors',25),('e','Non-fatal error',20),('f','Fatal error',100),('D','Verify found differences',15),('A','Canceled by user',90),('F','Waiting for Client',15),('S','Waiting for Storage daemon',15),('m','Waiting for new media',15),('M','Waiting for media mount',15),('s','Waiting for storage resource',15),('j','Waiting for job resource',15),('c','Waiting for client resource',15),('d','Waiting on maximum jobs',15),('t','Waiting on start time',15),('p','Waiting on higher priority jobs',15),('i','Doing batch insert file records',15),('a','SD despooling attributes',15);
/*!40000 ALTER TABLE `Status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Storage`
--

DROP TABLE IF EXISTS `Storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Storage` (
  `StorageId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` tinyblob NOT NULL,
  `AutoChanger` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`StorageId`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Storage`
--

LOCK TABLES `Storage` WRITE;
/*!40000 ALTER TABLE `Storage` DISABLE KEYS */;
INSERT INTO `Storage` VALUES (1,'File',0);
/*!40000 ALTER TABLE `Storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UnsavedFiles`
--

DROP TABLE IF EXISTS `UnsavedFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UnsavedFiles` (
  `UnsavedId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `JobId` int(10) unsigned NOT NULL,
  `PathId` int(10) unsigned NOT NULL,
  `FilenameId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`UnsavedId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UnsavedFiles`
--

LOCK TABLES `UnsavedFiles` WRITE;
/*!40000 ALTER TABLE `UnsavedFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `UnsavedFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Version`
--

DROP TABLE IF EXISTS `Version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Version` (
  `VersionId` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Version`
--

LOCK TABLES `Version` WRITE;
/*!40000 ALTER TABLE `Version` DISABLE KEYS */;
INSERT INTO `Version` VALUES (12);
/*!40000 ALTER TABLE `Version` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-26  3:18:06
