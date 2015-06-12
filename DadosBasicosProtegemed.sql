CREATE DATABASE  IF NOT EXISTS `protegemed` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `protegemed`;
-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: protegemed
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.12.04.2

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
-- Table structure for table `eventos`
--

DROP TABLE IF EXISTS `eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventos` (
  `codEvento` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) NOT NULL,
  `formaOnda` tinyint(4) NOT NULL,
  PRIMARY KEY (`codEvento`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` VALUES (1,'Evento de Fuga',1),(2,'Acompanhamento - Fase',1),(3,'Acompanhamento - Diferencial',1),(4,'Equipamento Ligado',1),(5,'Equipamento Desligado',0),(6,'Término de Fuga',0),(7,'Oi',0),(8,'Protegemed Inicializando',0);
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedimento`
--

DROP TABLE IF EXISTS `procedimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procedimento` (
  `codProced` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codProced`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedimento`
--

LOCK TABLES `procedimento` WRITE;
/*!40000 ALTER TABLE `procedimento` DISABLE KEYS */;
INSERT INTO `procedimento` VALUES (1,'teste'),(6,'opaaa'),(7,'opaaa');
/*!40000 ALTER TABLE `procedimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marca`
--

DROP TABLE IF EXISTS `marca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marca` (
  `codMarca` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codMarca`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marca`
--

LOCK TABLES `marca` WRITE;
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
INSERT INTO `marca` VALUES (1,'Marca Padrão'),(2,'TESTEEEEE');
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modelo`
--

DROP TABLE IF EXISTS `modelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modelo` (
  `codModelo` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codModelo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelo`
--

LOCK TABLES `modelo` WRITE;
/*!40000 ALTER TABLE `modelo` DISABLE KEYS */;
INSERT INTO `modelo` VALUES (1,'Modelo Padrão');
/*!40000 ALTER TABLE `modelo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipamento`
--

DROP TABLE IF EXISTS `equipamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipamento` (
  `codEquip` int(11) NOT NULL AUTO_INCREMENT,
  `codMarca` int(11) NOT NULL,
  `codModelo` int(11) NOT NULL,
  `codTipo` int(11) NOT NULL,
  `rfid` varchar(45) NOT NULL,
  `codPatrimonio` int(11) NOT NULL,
  `desc` varchar(45) DEFAULT NULL,
  `dataUltimaFalha` date DEFAULT NULL,
  `dataUltimaManutencao` date DEFAULT NULL,
  `tempoUso` time DEFAULT NULL,
  PRIMARY KEY (`codEquip`),
  KEY `codMarca` (`codMarca`),
  KEY `codTipo` (`codTipo`),
  KEY `codModelo` (`codModelo`),
  KEY `fk_equipamento_1_idx` (`codTipo`),
  KEY `fk_equipamento_2_idx` (`codMarca`),
  KEY `fk_equipamento_3_idx` (`codModelo`),
  CONSTRAINT `fk_equipamento_1` FOREIGN KEY (`codTipo`) REFERENCES `tipo` (`codTipo`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipamento_2` FOREIGN KEY (`codMarca`) REFERENCES `marca` (`codMarca`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipamento_3` FOREIGN KEY (`codModelo`) REFERENCES `modelo` (`codModelo`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipamento`
--

LOCK TABLES `equipamento` WRITE;
/*!40000 ALTER TABLE `equipamento` DISABLE KEYS */;
INSERT INTO `equipamento` VALUES (1,1,1,1,'12345678',0,'Equipamento Padrão (+30)','2012-03-01','2012-03-01','14:34:04'),(2,1,1,1,'12345601',1,'Equipamento na tomada 1','2012-03-01','2012-03-01','03:45:45'),(3,1,1,1,'12345602',2,'Equipamento na tomada 2','2012-03-01','2012-03-01','00:02:57'),(4,1,1,1,'12345603',3,'Equipamento na tomada 3','2012-03-01','2012-03-01','00:06:36'),(5,1,1,1,'12345604',4,'Equipamento na tomada 4','2012-03-01','2012-03-01','00:02:21'),(6,1,1,1,'12345605',5,'Equipamento na tomada 5','2012-03-01','2012-03-01','00:00:10'),(7,1,1,1,'12345606',6,'Equipamento na tomada 6','2012-03-01','2012-03-01','00:00:10');
/*!40000 ALTER TABLE `equipamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoonda`
--

DROP TABLE IF EXISTS `tipoonda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoonda` (
  `codTipoOnda` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codTipoOnda`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoonda`
--

LOCK TABLES `tipoonda` WRITE;
/*!40000 ALTER TABLE `tipoonda` DISABLE KEYS */;
INSERT INTO `tipoonda` VALUES (1,'Fase'),(2,'Fuga');
/*!40000 ALTER TABLE `tipoonda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsavel`
--

DROP TABLE IF EXISTS `responsavel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responsavel` (
  `codResp` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codResp`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsavel`
--

LOCK TABLES `responsavel` WRITE;
/*!40000 ALTER TABLE `responsavel` DISABLE KEYS */;
INSERT INTO `responsavel` VALUES (1,'teste'),(9,'jose'),(10,'jose');
/*!40000 ALTER TABLE `responsavel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salacirurgia`
--

DROP TABLE IF EXISTS `salacirurgia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salacirurgia` (
  `codSala` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codSala`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salacirurgia`
--

LOCK TABLES `salacirurgia` WRITE;
/*!40000 ALTER TABLE `salacirurgia` DISABLE KEYS */;
INSERT INTO `salacirurgia` VALUES (1,'Sala de Testes'),(2,'Sala dois'),(3,'Sala tres'),(4,'Sala quatro'),(5,'Sala cinco');
/*!40000 ALTER TABLE `salacirurgia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo`
--

DROP TABLE IF EXISTS `tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo` (
  `codTipo` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo`
--

LOCK TABLES `tipo` WRITE;
/*!40000 ALTER TABLE `tipo` DISABLE KEYS */;
INSERT INTO `tipo` VALUES (1,'Fase'),(2,'Fuga'),(7,'TESTEEEEE');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tomada`
--

DROP TABLE IF EXISTS `tomada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tomada` (
  `codTomada` int(11) NOT NULL,
  `codSala` int(11) NOT NULL,
  `indice` int(11) DEFAULT NULL,
  `modulo` int(11) DEFAULT NULL,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codTomada`),
  KEY `codUsoSala3` (`codSala`),
  CONSTRAINT `codSala2` FOREIGN KEY (`codSala`) REFERENCES `salacirurgia` (`codSala`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tomada`
--

LOCK TABLES `tomada` WRITE;
/*!40000 ALTER TABLE `tomada` DISABLE KEYS */;
INSERT INTO `tomada` VALUES (1,1,1,1,'Tomada 1'),(2,1,2,2,'Tomada 2'),(3,1,3,3,'Tomada 3'),(4,1,4,4,'Tomada 4'),(5,1,5,5,'Tomada 5'),(6,1,6,6,'Tomada 6'),(7,3,7,7,'Tomada 7');
/*!40000 ALTER TABLE `tomada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipopadrao`
--

DROP TABLE IF EXISTS `tipopadrao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipopadrao` (
  `codTipoPadrao` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codTipoPadrao`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipopadrao`
--

LOCK TABLES `tipopadrao` WRITE;
/*!40000 ALTER TABLE `tipopadrao` DISABLE KEYS */;
INSERT INTO `tipopadrao` VALUES (1,'Funcionamento Normal'),(2,'Erro - Fuga de corrente'),(4,'oy');
/*!40000 ALTER TABLE `tipopadrao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'protegemed'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-17 19:37:52
