CREATE DATABASE  IF NOT EXISTS `protegemed_clayton` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `protegemed_clayton`;
-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: protegemed_clayton
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.16.04.1

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
-- Table structure for table `alerta`
--

DROP TABLE IF EXISTS `alerta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerta` (
  `codAlerta` int(10) NOT NULL AUTO_INCREMENT,
  `codCaptura` int(11) NOT NULL,
  `codUsoSala` int(11) NOT NULL,
  `usuario` varchar(60) NOT NULL,
  `comentario` varchar(400) NOT NULL,
  PRIMARY KEY (`codAlerta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerta`
--

LOCK TABLES `alerta` WRITE;
/*!40000 ALTER TABLE `alerta` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capturaatual`
--

DROP TABLE IF EXISTS `capturaatual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `capturaatual` (
  `codCaptura` int(11) NOT NULL AUTO_INCREMENT,
  `codTomada` int(11) NOT NULL,
  `codTipoOnda` int(11) NOT NULL,
  `codEquip` int(11) NOT NULL,
  `codEvento` int(11) NOT NULL,
  `valorMedio` float DEFAULT NULL,
  `offset` float DEFAULT NULL,
  `gain` float DEFAULT NULL,
  `eficaz` float DEFAULT NULL,
  `dataatual` datetime(6) DEFAULT NULL,
  `VM2` float DEFAULT NULL,
  `under` int(11) DEFAULT NULL,
  `over` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `periculosidade_corrente` int(11) DEFAULT '1',
  `periculosidade_frequencia` int(11) DEFAULT '1',
  `periculosidade_similaridade` int(11) DEFAULT '1',
  `similaridade` varchar(50) DEFAULT NULL,
  `spearman` decimal(10,6) DEFAULT NULL,
  PRIMARY KEY (`codCaptura`),
  KEY `codTomada2` (`codTomada`),
  KEY `codEquipamento2` (`codEquip`),
  KEY `codTipoOnda2` (`codTipoOnda`),
  KEY `codEvento` (`codEvento`),
  KEY `fk_capturaatual_1_idx` (`codEvento`),
  KEY `fk_capturaatual_2_idx` (`codTipoOnda`),
  KEY `fk_capturaatual_3_idx` (`codEquip`),
  KEY `fk_capturaatual_4_idx` (`codTomada`),
  KEY `fk_periculosidade_corrente` (`periculosidade_corrente`),
  KEY `fk_periculosidade_frequencia` (`periculosidade_frequencia`),
  KEY `fk_periculosidade_similaridade` (`periculosidade_similaridade`),
  CONSTRAINT `fk_capturaatual_1` FOREIGN KEY (`codEvento`) REFERENCES `eventos` (`codEvento`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_capturaatual_2` FOREIGN KEY (`codTipoOnda`) REFERENCES `tipoonda` (`codTipoOnda`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_capturaatual_3` FOREIGN KEY (`codEquip`) REFERENCES `equipamento` (`codEquip`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_capturaatual_4` FOREIGN KEY (`codTomada`) REFERENCES `tomada` (`codTomada`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_periculosidade_corrente` FOREIGN KEY (`periculosidade_corrente`) REFERENCES `periculosidade_fuga` (`id`),
  CONSTRAINT `fk_periculosidade_frequencia` FOREIGN KEY (`periculosidade_frequencia`) REFERENCES `periculosidade_fuga` (`id`),
  CONSTRAINT `fk_periculosidade_similaridade` FOREIGN KEY (`periculosidade_similaridade`) REFERENCES `periculosidade_fuga` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capturaatual`
--

LOCK TABLES `capturaatual` WRITE;
/*!40000 ALTER TABLE `capturaatual` DISABLE KEYS */;
INSERT INTO `capturaatual` VALUES (1,1,2,1,1,0,2096,1043,0.985126,'2015-05-24 11:14:17.000000',0,0,0,0,1,1,1,NULL,NULL),(2,1,2,1,1,0,2096,1043,0.50516,'2015-05-24 11:14:34.000000',0,0,0,0,1,1,1,NULL,NULL),(3,1,2,1,1,0,2096,1043,0.556648,'2015-05-24 11:17:02.000000',0,0,0,0,1,1,1,NULL,NULL),(4,1,1,1,4,0,2091,115.55,0.186089,'2015-05-24 11:18:41.000000',0,0,0,0,1,1,1,NULL,NULL),(5,1,1,1,4,0,2091,115.55,0.28232,'2015-05-24 11:20:40.000000',0,0,0,0,1,1,1,NULL,NULL),(6,1,1,1,4,0,2091,115.55,0.200798,'2015-05-24 11:21:33.000000',0,0,0,0,1,1,1,NULL,NULL),(7,1,1,1,4,0,2091,115.55,0.0856553,'2015-05-24 11:25:50.000000',0,0,0,0,1,1,1,NULL,NULL),(8,1,2,1,1,0,2096,757,2.19691,'2015-05-24 11:43:21.000000',0.00219727,54,0,0,1,1,1,NULL,NULL);
/*!40000 ALTER TABLE `capturaatual` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `atualiza` AFTER INSERT ON `capturaatual`
 FOR EACH ROW begin
	declare ultUsoSala    int default 0; /* = seleciona a sala q esta em uso referente a sala recebida na ultima onda recebida.*/
	declare salaAtual     int default 0; /* armazena a sala da inclusao atual */
	declare usoSalaAtiva  int default 0; /* armazena o estado do campo ativa em uso sala na última usosala */
	declare insEquip      int default 0; /* conta se o equipamento ja foi inserido em usosalequip */
	declare existeUsoSala int default 0; /* se já foi inserido o usosala */
	declare capturaLiga   int default 0; /* codigo da captura que ligou um equipamento */
	declare dataLiga	   datetime;          /* hora em que o equipamento foi ligado */
	declare onEquip       int default 0; /* numero de aparelhos ligados num usosala */
	declare offEquip	  int default 0; /* numero de aparelhos desligados num usosla */

	/* pega a sala da inserção sendo realizada e guarda em salaAtual */
	select tom.codSala into @salaAtual
	from tomada tom
	where new.codTomada = tom.codTomada;

	/* pega a última codigo do último UsoSala da sala onde esta sendo inserida a onda */
	set @ultUsoSala = f_ultUsoSala( @salaAtual );

	/* verifica se a usosala esta ativa */
	select ativa into @usoSalaAtiva
	from usosala
	where codUsoSala = @ultUsoSala;

	/* verifica se existe usosala */
	select count(*) into @existeUsoSala
	from usosala
	where codUsoSala = @ultUsoSala;

	/* caso não exista um uso sala ou o usoSala não ativo, cria um novo */
	if (@usoSalaAtiva = 0 or @existeUsoSala = 0) then
		insert into usosala (codsala, codProced, codResp, horainicio,   ativa)
		values (          @salaAtual,         1,       1, new.dataAtual, 1);

		set @ultUsoSala = f_ultUsoSala( @salaAtual );
	end if;

	/* Insere o evento de captura em usosalacaptura */
	insert into usosalacaptura (codUsoSala, codCaptura) values (@ultUsoSala, new.codCaptura);

	/* Verifica se o equipamento já foi inserido */
	select count(*) into @insEquip
	from usosalaequip ue
	where ue.codEquip = new.codEquip
	and   ue.codUsoSala = @ultUsoSala;

	if (@insEquip = 0) then
		/* Insere o equipamento no usosalaequip */
		insert into usosalaequip (codUsoSala, codEquip) values (@ultUsoSala, new.codEquip);
	end if;

	if (new.codEvento = 5) then /* Equipamento sendo desligado */

      /* último evento que ligou o equipamento */
		select max(codCaptura) into @capturaLiga
		from capturaatual
		where codEvento = 4               /* Equipamento sendo ligado */
		and codEquip = new.codEquip;

      /* Pega a hora em que ele foi ligado */
		select dataAtual into @dataLiga
		from capturaatual
		where codcaptura = @capturaLiga;

      /* para tempo de uso numa variavel time
		update equipamento
		set tempoUso = addtime( tempoUso, subtime(time(new.dataAtual), @horaLiga) )
		where codEquip = new.codEquip;
      */

  		update equipamento
		set tempoUso = tempoUso + UNIX_TIMESTAMP( new.dataAtual ) - UNIX_TIMESTAMP(@dataliga)
		where codEquip = new.codEquip;

      /* Conta os equipamentos ligados no usosala */
      select count(*) into @onEquip
		from capturaatual cap, usosalacaptura uso
		where cap.codCaptura = uso.codCaptura
		and   cap.codEvento = 4
		and   uso.codUsoSala = @ultUsoSala;

      /* Conta os equipamentos desligados no usosala */
		select count(*) into @offEquip
		from capturaatual cap, usosalacaptura uso
		where cap.codCaptura = uso.codCaptura
		and   cap.codEvento = 5
		and   uso.codUsoSala = @ultUsoSala;

		if (@onEquip = @offEquip) then
			update usosala
			set horaFinal = new.dataAtual, ativa = 0
			where codusosala = @ultUsoSala;
		end if; /* @onEquip = @offEquip */
	end if;     /* Equipamento sendo desligado */
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
  `codTomada` int(11) NOT NULL,
  `rfid` varchar(45) NOT NULL,
  `codPatrimonio` int(11) NOT NULL,
  `desc` varchar(45) DEFAULT NULL,
  `dataUltimaFalha` date DEFAULT NULL,
  `dataUltimaManutencao` date DEFAULT NULL,
  `tempoUso` int(11) DEFAULT NULL,
  `limiteFase` float DEFAULT '0',
  `limiteFuga` float DEFAULT '0',
  `limiteStandByFase` float DEFAULT '0',
  `limiteStandByFuga` float DEFAULT '0',
  PRIMARY KEY (`codEquip`),
  KEY `codMarca` (`codMarca`),
  KEY `codTipo` (`codTipo`),
  KEY `codModelo` (`codModelo`),
  KEY `codTomada` (`codTomada`),
  KEY `fk_equipamento_1_idx` (`codTipo`),
  KEY `fk_equipamento_2_idx` (`codMarca`),
  KEY `fk_equipamento_3_idx` (`codModelo`),
  CONSTRAINT `fk_equipamento_1` FOREIGN KEY (`codTipo`) REFERENCES `tipo` (`codTipo`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipamento_2` FOREIGN KEY (`codMarca`) REFERENCES `marca` (`codMarca`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipamento_3` FOREIGN KEY (`codModelo`) REFERENCES `modelo` (`codModelo`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipamento_4` FOREIGN KEY (`codTomada`) REFERENCES `tomada` (`codTomada`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipamento`
--

LOCK TABLES `equipamento` WRITE;
/*!40000 ALTER TABLE `equipamento` DISABLE KEYS */;
INSERT INTO `equipamento` VALUES (1,1,1,1,0,'FFFF0001',0,'Equipamento 1','2012-03-01','2012-03-01',198,0.5,0.5,0.2,0.2),(2,1,1,1,0,'FFFF0002',1,'Equipamento 2','2012-03-01','2012-03-01',19,0.5,0.5,0.2,0.2),(3,1,1,1,0,'FFFF0003',2,'Equipamento 3','2012-03-01','2012-03-01',52,0.5,0.5,0.2,0.2),(4,1,1,1,0,'FFFF0004',3,'Equipamento 4','2012-03-01','2012-03-01',100,0.5,0.5,0.2,0.2),(5,1,1,1,0,'FFFF0005',4,'Equipamento 5','2012-03-01','2012-03-01',200,0.5,0.5,0.2,0.2),(6,1,1,1,0,'FFFF0006',5,'Equipamento 6','2012-03-01','2012-03-01',0,0.5,0.5,0.2,0.2),(7,1,1,1,0,'FFFF0007',6,'Equipamento 7','2012-03-01','2012-03-01',0,0.5,0.5,0.2,0.2),(8,1,1,1,0,'FFFF0008',7,'Equipamento 8','2012-03-01','2012-03-01',0,0.5,0.5,0.2,0.2);
/*!40000 ALTER TABLE `equipamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escala_corrente`
--

DROP TABLE IF EXISTS `escala_corrente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escala_corrente` (
  `valor` decimal(6,5) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `id_versao` int(11) NOT NULL,
  PRIMARY KEY (`valor`,`id_versao`),
  KEY `fk_versao` (`id_versao`),
  KEY `fk_tipo_corrente` (`id_tipo`),
  CONSTRAINT `fk_tipo_corrente` FOREIGN KEY (`id_tipo`) REFERENCES `periculosidade_fuga` (`id`),
  CONSTRAINT `fk_versao` FOREIGN KEY (`id_versao`) REFERENCES `versao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escala_corrente`
--

LOCK TABLES `escala_corrente` WRITE;
/*!40000 ALTER TABLE `escala_corrente` DISABLE KEYS */;
INSERT INTO `escala_corrente` VALUES (0.06000,1,1),(0.10000,2,1),(0.50000,3,1);
/*!40000 ALTER TABLE `escala_corrente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escala_frequencia`
--

DROP TABLE IF EXISTS `escala_frequencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escala_frequencia` (
  `id_tipo` int(11) NOT NULL,
  `id_versao` int(11) NOT NULL,
  `valor` decimal(6,5) NOT NULL,
  `frequencia` int(11) NOT NULL,
  PRIMARY KEY (`valor`,`frequencia`,`id_versao`),
  KEY `fk_versao_frequencia` (`id_versao`),
  KEY `fk_tipo_frequencia` (`id_tipo`),
  CONSTRAINT `fk_tipo_frequencia` FOREIGN KEY (`id_tipo`) REFERENCES `periculosidade_fuga` (`id`),
  CONSTRAINT `fk_versao_frequencia` FOREIGN KEY (`id_versao`) REFERENCES `versao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escala_frequencia`
--

LOCK TABLES `escala_frequencia` WRITE;
/*!40000 ALTER TABLE `escala_frequencia` DISABLE KEYS */;
INSERT INTO `escala_frequencia` VALUES (1,1,0.06000,60),(1,1,0.06100,120),(1,1,0.06400,180),(1,1,0.06800,240),(1,1,0.07300,300),(1,1,0.07800,360),(1,1,0.08300,420),(1,1,0.08800,480),(1,1,0.09300,540),(1,1,0.09900,600),(1,1,0.10300,660),(1,1,0.10700,720),(2,1,0.10000,60),(2,1,0.10280,120),(2,1,0.10570,180),(2,1,0.11040,240),(2,1,0.11580,300),(2,1,0.12480,360),(2,1,0.12600,420),(2,1,0.13110,480),(2,1,0.13590,540),(2,1,0.14000,600),(2,1,0.14460,660),(2,1,0.14860,720),(3,1,0.50000,60),(3,1,0.79190,120),(3,1,1.07810,180),(3,1,1.56910,240),(3,1,2.33680,300),(3,1,2.63700,360),(3,1,2.97460,420),(3,1,3.33440,480),(3,1,3.71100,540),(3,1,4.08760,600),(3,1,4.48930,660),(3,1,4.90490,720);
/*!40000 ALTER TABLE `escala_frequencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escala_similaridade`
--

DROP TABLE IF EXISTS `escala_similaridade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escala_similaridade` (
  `id_tipo` int(11) NOT NULL,
  `id_versao` int(11) NOT NULL,
  `valor_min` decimal(6,5) NOT NULL,
  `valor_max` decimal(6,5) NOT NULL,
  PRIMARY KEY (`valor_min`,`valor_max`,`id_versao`),
  KEY `fk_versao_periculosidade` (`id_versao`),
  KEY `fk_tipo_periculosidade` (`id_tipo`),
  CONSTRAINT `fk_tipo_periculosidade` FOREIGN KEY (`id_tipo`) REFERENCES `periculosidade_fuga` (`id`),
  CONSTRAINT `fk_versao_periculosidade` FOREIGN KEY (`id_versao`) REFERENCES `versao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escala_similaridade`
--

LOCK TABLES `escala_similaridade` WRITE;
/*!40000 ALTER TABLE `escala_similaridade` DISABLE KEYS */;
INSERT INTO `escala_similaridade` VALUES (1,1,0.00100,0.84900),(2,1,0.85000,0.94900),(3,1,0.95000,1.00000);
/*!40000 ALTER TABLE `escala_similaridade` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` VALUES (1,'Evento de Fuga',1),(2,'Acompanhamento - Fase',1),(3,'Acompanhamento - Diferencial',1),(4,'Equipamento Ligado',1),(5,'Equipamento Desligado',0),(6,'Término de Fuga',0),(7,'Oi',0),(8,'Protegemed Inicializando',0),(9,'Captura Externa Fase',1),(10,'Captura Externa Fuga',1),(11,'Inicio StandBy Fase',1),(12,'Inicio StandBy Fuga',1),(13,'Término StandBy Fase',0),(14,'Término StandBy Fuga',0);
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `harmatual`
--

DROP TABLE IF EXISTS `harmatual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `harmatual` (
  `codCaptura` int(11) NOT NULL,
  `codHarmonica` int(11) NOT NULL,
  `sen` float DEFAULT NULL,
  `cos` float DEFAULT NULL,
  PRIMARY KEY (`codCaptura`,`codHarmonica`),
  KEY `codOndaAtual` (`codCaptura`),
  KEY `fk_ondaatual_1_idx` (`codCaptura`),
  KEY `fk_ondaatual_1_idx1` (`codCaptura`),
  KEY `fk_harmatual_1_idx` (`codCaptura`),
  CONSTRAINT `fk_harmatual_1` FOREIGN KEY (`codCaptura`) REFERENCES `capturaatual` (`codCaptura`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `harmatual`
--

LOCK TABLES `harmatual` WRITE;
/*!40000 ALTER TABLE `harmatual` DISABLE KEYS */;
INSERT INTO `harmatual` VALUES (1,1,-1428.46,-232.767),(1,2,90.1312,7.51492),(1,3,48.0291,0.171923),(1,4,37.8526,2.31123),(1,5,37.0748,0.771017),(1,6,19.3785,4.17857),(1,7,15.1203,18.5427),(1,8,17.7631,-10.7352),(1,9,16.275,-6.67653),(1,10,11.6532,-2.16256),(1,11,11.1139,-3.32237),(1,12,10.6478,-0.43098),(2,1,285.999,687.068),(2,2,-17.7241,-21.58),(2,3,-11.0692,-8.35081),(2,4,-6.53174,-3.69786),(2,5,-5.2324,1.89548),(2,6,-2.20017,-4.3712),(2,7,4.70934,-7.0896),(2,8,-6.87618,0.970771),(2,9,-3.9104,-1.15881),(2,10,-4.09066,0.774818),(2,11,-2.55919,0.311121),(2,12,-3.47504,0.200202),(3,1,-476.024,-543.969),(3,2,217.571,312.009),(3,3,-8.11216,-26.048),(3,4,-39.1952,-52.9208),(3,5,8.37364,7.5659),(3,6,25.1747,13.7207),(3,7,3.75623,-1.26186),(3,8,-21.0635,-6.87093),(3,9,12.5784,0.236628),(3,10,10.704,1.13988),(3,11,-3.91881,-0.279367),(3,12,-4.32963,1.69589),(4,1,12.5556,27.6217),(4,2,-0.907658,-0.790046),(4,3,-0.398673,-0.392534),(4,4,-0.432962,-0.0972585),(4,5,-0.121282,-0.156301),(4,6,-0.361008,0.0804916),(4,7,-0.227823,0.296428),(4,8,-0.183537,-0.229706),(4,9,-0.0716343,-0.0284829),(4,10,-0.210425,0.000920182),(4,11,-0.147829,0.0111107),(4,12,-0.242523,-0.0230518),(5,1,-42.0549,-18.5068),(5,2,2.67686,0.364371),(5,3,1.86645,-0.0177553),(5,4,1.01068,-0.0611348),(5,5,0.80154,-0.381494),(5,6,0.762166,0.0767424),(5,7,1.10502,-0.245908),(5,8,0.08277,0.0986508),(5,9,0.208727,0.0765877),(5,10,0.356205,-0.188673),(5,11,0.225709,0.0841409),(5,12,0.290215,-0.0779049),(6,1,-22.5612,-12.4091),(6,2,1.15253,2.20712),(6,3,-0.694227,16.0172),(6,4,1.38119,-2.77471),(6,5,5.20733,-6.2106),(6,6,-1.91751,1.81091),(6,7,-4.80559,2.75847),(6,8,2.76264,-0.497085),(6,9,3.23159,0.457415),(6,10,-1.10272,-0.610915),(6,11,-0.967335,0.00736896),(6,12,1.34647,-0.374188),(7,1,5.55454,7.75249),(7,2,0.267815,0.337786),(7,3,4.57103,4.35371),(7,4,-0.253324,-0.790065),(7,5,4.77399,0.252274),(7,6,-1.48406,-0.806203),(7,7,1.93056,-2.11734),(7,8,-1.99741,0.134352),(7,9,-0.644069,-2.03067),(7,10,-1.56853,1.3738),(7,11,-1.82115,-0.644259),(7,12,-0.30297,1.49161),(8,1,2196.16,-764.291),(8,2,-97.8153,24.4413),(8,3,107.309,-253.978),(8,4,-80.1706,62.924),(8,5,-55.5683,78.6058),(8,6,-47.4704,19.0743),(8,7,1.61394,51.9225),(8,8,-53.3866,-9.39166),(8,9,-32.4453,-1.8506),(8,10,-39.4528,-2.60131),(8,11,-37.2217,8.62096),(8,12,-19.4419,-5.7716);
/*!40000 ALTER TABLE `harmatual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `harmpadrao`
--

DROP TABLE IF EXISTS `harmpadrao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `harmpadrao` (
  `codHarmonica` int(11) NOT NULL,
  `codOndaPadrao` int(11) NOT NULL,
  `sen` float DEFAULT NULL,
  `cos` float DEFAULT NULL,
  PRIMARY KEY (`codHarmonica`,`codOndaPadrao`),
  KEY `codOndaP` (`codOndaPadrao`),
  KEY `fk_harmpadrao_1_idx` (`codOndaPadrao`),
  CONSTRAINT `fk_harmpadrao_1` FOREIGN KEY (`codOndaPadrao`) REFERENCES `ondapadrao` (`codOndaPadrao`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `harmpadrao`
--

LOCK TABLES `harmpadrao` WRITE;
/*!40000 ALTER TABLE `harmpadrao` DISABLE KEYS */;
/*!40000 ALTER TABLE `harmpadrao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `email` varchar(80) NOT NULL,
  `senha` varchar(80) NOT NULL,
  `nivel` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (1,'Administrador','admin@admin.com.br','admin',1);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
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
INSERT INTO `marca` VALUES (1,'Marca Padrão'),(2,'Teste');
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
-- Table structure for table `modulo`
--

DROP TABLE IF EXISTS `modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulo` (
  `idModulo` int(10) NOT NULL AUTO_INCREMENT,
  `ip` varchar(16) DEFAULT NULL,
  `idWebSocket` int(10) DEFAULT NULL,
  `ultimoLiga` datetime DEFAULT NULL,
  `desc` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`idModulo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulo`
--

LOCK TABLES `modulo` WRITE;
/*!40000 ALTER TABLE `modulo` DISABLE KEYS */;
INSERT INTO `modulo` VALUES (0,'0.0.0.0',NULL,NULL,'Módulo 0'),(1,'192.168.17.101',112,'2018-12-12 00:00:00','Módulo 1'),(2,'192.168.1.102',NULL,NULL,'Módulo 2'),(3,'192.168.1.103',NULL,NULL,'Módulo 3'),(4,'192.168.1.104',NULL,NULL,'Módulo 4'),(5,'192.168.1.105',NULL,NULL,'Módulo 5'),(6,'192.168.1.106',NULL,NULL,'Módulo 6'),(7,'192.168.1.107',NULL,NULL,'Módulo 7');
/*!40000 ALTER TABLE `modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ondapadrao`
--

DROP TABLE IF EXISTS `ondapadrao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ondapadrao` (
  `codOndaPadrao` int(11) NOT NULL AUTO_INCREMENT,
  `codTipoOnda` int(11) NOT NULL,
  `codTomada` int(11) NOT NULL,
  `codEquip` int(11) NOT NULL,
  `valorMedio` float DEFAULT NULL,
  `offset` float DEFAULT NULL,
  `gain` float DEFAULT NULL,
  `eficaz` float DEFAULT NULL,
  `dataPadrao` datetime DEFAULT NULL,
  `codTipoPadrao` int(11) NOT NULL,
  PRIMARY KEY (`codOndaPadrao`),
  KEY `codEquip` (`codEquip`),
  KEY `codTomada` (`codTomada`),
  KEY `codTipoOnda` (`codTipoOnda`),
  KEY `fk_ondapadrao_1_idx` (`codTipoOnda`),
  KEY `fk_ondapadrao_2_idx` (`codTipoPadrao`),
  CONSTRAINT `codEquip` FOREIGN KEY (`codEquip`) REFERENCES `equipamento` (`codEquip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `codTomada` FOREIGN KEY (`codTomada`) REFERENCES `tomada` (`codTomada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ondapadrao_1` FOREIGN KEY (`codTipoOnda`) REFERENCES `tipoonda` (`codTipoOnda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ondapadrao_2` FOREIGN KEY (`codTipoPadrao`) REFERENCES `tipopadrao` (`codTipoPadrao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ondapadrao`
--

LOCK TABLES `ondapadrao` WRITE;
/*!40000 ALTER TABLE `ondapadrao` DISABLE KEYS */;
/*!40000 ALTER TABLE `ondapadrao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periculosidade_fuga`
--

DROP TABLE IF EXISTS `periculosidade_fuga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periculosidade_fuga` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` char(1) NOT NULL,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periculosidade_fuga`
--

LOCK TABLES `periculosidade_fuga` WRITE;
/*!40000 ALTER TABLE `periculosidade_fuga` DISABLE KEYS */;
INSERT INTO `periculosidade_fuga` VALUES (1,'N','NORMAL'),(2,'A','ATENCAO'),(3,'P','PERIGO');
/*!40000 ALTER TABLE `periculosidade_fuga` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salacirurgia`
--

LOCK TABLES `salacirurgia` WRITE;
/*!40000 ALTER TABLE `salacirurgia` DISABLE KEYS */;
INSERT INTO `salacirurgia` VALUES (1,'Sala de Testes'),(2,'Sala dois'),(3,'Sala tres'),(4,'Sala quatro'),(5,'Sala cinco'),(6,'sala123');
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
INSERT INTO `tipo` VALUES (1,'Fase'),(2,'Fuga'),(7,'Teste');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
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
-- Table structure for table `tomada`
--

DROP TABLE IF EXISTS `tomada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tomada` (
  `codTomada` int(11) NOT NULL AUTO_INCREMENT,
  `codSala` int(11) NOT NULL,
  `indice` int(11) DEFAULT NULL,
  `limiteFase` float DEFAULT '0',
  `limiteFuga` float DEFAULT '0',
  `limiteStandByFase` float DEFAULT '0',
  `limiteStandByFuga` float DEFAULT '0',
  `codModulo` int(11) DEFAULT NULL,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codTomada`),
  KEY `codUsoSala3` (`codSala`),
  KEY `codModulo2` (`codModulo`),
  CONSTRAINT `codSala2` FOREIGN KEY (`codSala`) REFERENCES `salacirurgia` (`codSala`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fkTomadaModulo` FOREIGN KEY (`codModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tomada`
--

LOCK TABLES `tomada` WRITE;
/*!40000 ALTER TABLE `tomada` DISABLE KEYS */;
INSERT INTO `tomada` VALUES (0,1,1,0,0,0,0,0,'Equipamento sem Tomada'),(1,1,1,0.5,0.5,0.2,0.2,1,'Tomada 1'),(2,1,2,0.5,0.5,0.2,0.2,1,'Tomada 2'),(3,1,3,0.5,0.5,0.2,0.2,1,'Tomada 3'),(4,1,4,0.5,0.5,0.2,0.2,2,'Tomada 4'),(5,1,5,0.5,0.5,0.2,0.2,2,'Tomada 5'),(6,1,6,0.5,0.5,0.2,0.2,2,'Tomada 6'),(7,1,7,0.5,0.5,0.2,0.2,3,'Tomada 7'),(8,1,8,0.5,0.5,0.2,0.2,3,'Tomada 8'),(9,1,9,0.5,0.5,0.2,0.2,3,'Tomada 9');
/*!40000 ALTER TABLE `tomada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usosala`
--

DROP TABLE IF EXISTS `usosala`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usosala` (
  `codUsoSala` int(11) NOT NULL AUTO_INCREMENT,
  `codSala` int(11) NOT NULL,
  `codProced` int(11) NOT NULL,
  `codResp` int(11) NOT NULL,
  `horaInicio` datetime DEFAULT NULL,
  `horaFinal` datetime DEFAULT NULL,
  `ativa` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`codUsoSala`),
  KEY `codResp` (`codResp`),
  KEY `codProced` (`codProced`),
  KEY `codSala` (`codSala`),
  CONSTRAINT `codProced` FOREIGN KEY (`codProced`) REFERENCES `procedimento` (`codProced`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `codResp` FOREIGN KEY (`codResp`) REFERENCES `responsavel` (`codResp`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `codSala` FOREIGN KEY (`codSala`) REFERENCES `salacirurgia` (`codSala`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usosala`
--

LOCK TABLES `usosala` WRITE;
/*!40000 ALTER TABLE `usosala` DISABLE KEYS */;
INSERT INTO `usosala` VALUES (1,1,1,1,'2014-04-28 07:38:00','0000-00-00 00:00:00',1),(2,2,1,1,'2014-04-28 07:38:00','0000-00-00 00:00:00',1);
/*!40000 ALTER TABLE `usosala` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usosalacaptura`
--

DROP TABLE IF EXISTS `usosalacaptura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usosalacaptura` (
  `codCaptura` int(11) NOT NULL,
  `codUsoSala` int(11) NOT NULL,
  PRIMARY KEY (`codCaptura`,`codUsoSala`),
  KEY `fk_codUsoSala` (`codUsoSala`),
  CONSTRAINT `fk_codCaptura` FOREIGN KEY (`codCaptura`) REFERENCES `capturaatual` (`codCaptura`),
  CONSTRAINT `fk_codUsoSala` FOREIGN KEY (`codUsoSala`) REFERENCES `usosala` (`codUsoSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usosalacaptura`
--

LOCK TABLES `usosalacaptura` WRITE;
/*!40000 ALTER TABLE `usosalacaptura` DISABLE KEYS */;
INSERT INTO `usosalacaptura` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,2),(8,2);
/*!40000 ALTER TABLE `usosalacaptura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usosalaequip`
--

DROP TABLE IF EXISTS `usosalaequip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usosalaequip` (
  `codEquip` int(11) NOT NULL,
  `codUsoSala` int(11) NOT NULL,
  PRIMARY KEY (`codEquip`,`codUsoSala`),
  KEY `codEquip3` (`codEquip`),
  KEY `codUsoSala` (`codUsoSala`),
  CONSTRAINT `fk_codEquip` FOREIGN KEY (`codEquip`) REFERENCES `equipamento` (`codEquip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usosalaequip`
--

LOCK TABLES `usosalaequip` WRITE;
/*!40000 ALTER TABLE `usosalaequip` DISABLE KEYS */;
/*!40000 ALTER TABLE `usosalaequip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `versao`
--

DROP TABLE IF EXISTS `versao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `versao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `id_versao` varchar(20) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `versao`
--

LOCK TABLES `versao` WRITE;
/*!40000 ALTER TABLE `versao` DISABLE KEYS */;
INSERT INTO `versao` VALUES (1,'2018-12-18 15:19:44','1.0','Versão Rebonatto');
/*!40000 ALTER TABLE `versao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'protegemed_clayton'
--

--
-- Dumping routines for database 'protegemed_clayton'
--
/*!50003 DROP FUNCTION IF EXISTS `f_ultCodCaptura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `f_ultCodCaptura`(sala INT, equip INT) RETURNS int(11)
BEGIN
	declare ultimo int;

	-- encontra o ultimo codigo de captura de um equipamento numa sala ativa
	select max(cap.codcaptura) into @ultimo
	from capturaatual cap, usosalacaptura usc
	where cap.codequip = equip
	and usc.codcaptura = cap.codcaptura
	and usc.codusosala = f_ultUsoSalaAtiva(sala);

	if (@ultimo is null) then
        set @ultimo = 0;
	end if;

	return @ultimo;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_ultUsoSala` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `f_ultUsoSala`(sala INT) RETURNS int(11)
BEGIN
	declare ultimo int;

	select max(u.codUsoSala) into @ultimo
	from usosala u
	where u.codSala = sala;

	if (@ultimo is null) then
		select AUTO_INCREMENT into @ultimo
		from information_schema.TABLES
		where TABLE_SCHEMA = 'protegemed'
		and   TABLE_NAME = 'usosala';
	end if;

	return @ultimo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_ultUsoSalaAtiva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `f_ultUsoSalaAtiva`(sala INT) RETURNS int(11)
BEGIN
	declare ultimo int;

	select max(codusosala) into @ultimo
	from usosala uso
	where ativa = 1
	and codsala = sala;

	if (@ultimo is null) then
        set @ultimo = 0;
	end if;

	return @ultimo;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `nextCaptura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `nextCaptura`() RETURNS int(11)
BEGIN
	declare ultimo INT;

	select max(codcaptura) into @ultimo
    from capturaatual ;

	return @ultimo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-18 15:22:37
