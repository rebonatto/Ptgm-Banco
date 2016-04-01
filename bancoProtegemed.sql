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
  `dataAtual` datetime DEFAULT NULL,
  PRIMARY KEY (`codCaptura`),
  KEY `codTomada2` (`codTomada`),
  KEY `codEquipamento2` (`codEquip`),
  KEY `codTipoOnda2` (`codTipoOnda`),
  KEY `codEvento` (`codEvento`),
  KEY `fk_capturaatual_1_idx` (`codEvento`),
  KEY `fk_capturaatual_2_idx` (`codTipoOnda`),
  KEY `fk_capturaatual_3_idx` (`codEquip`),
  KEY `fk_capturaatual_4_idx` (`codTomada`),
  CONSTRAINT `fk_capturaatual_1` FOREIGN KEY (`codEvento`) REFERENCES `eventos` (`codEvento`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_capturaatual_2` FOREIGN KEY (`codTipoOnda`) REFERENCES `tipoonda` (`codTipoOnda`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_capturaatual_3` FOREIGN KEY (`codEquip`) REFERENCES `equipamento` (`codEquip`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_capturaatual_4` FOREIGN KEY (`codTomada`) REFERENCES `tomada` (`codTomada`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6221971 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `protegemed`.`atualiza`
AFTER INSERT ON `protegemed`.`capturaatual`
FOR EACH ROW
begin
	declare ultUsoSala    int default 0; /* = seleciona a sala q esta em uso referente a sala recebida na ultima onda recebida.*/
	declare salaAtual     int default 0; /* armazena a sala da inclusao atual */
	declare usoSalaAtiva  int default 0; /* armazena o estado do campo ativa em uso sala na última usosala */
	declare insEquip      int default 0; /* conta se o equipamento ja foi inserido em usosalequip */
	declare existeUsoSala int default 0; /* se já foi inserido o usosala */
	declare capturaLiga   int default 0; /* codigo da captura que ligou um equipamento */
	declare horaLiga	  time;          /* hora em que o equipamento foi ligado */
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

	/* caso exista e esteja ativa, verifica se faz mais de 10 minutos desde ultima captura */
	if (@usoSalaAtiva = 1 and @existeUsoSala > 0) then
		select MAX(dataAtual) into @ultimo
		from capturaatual
		join usosalacaptura using (codCaptura)
		where codUsoSala = @ultUsoSala;
		SET @limite = DATE_SUB(NOW(), INTERVAL '10' MINUTE);
		if (@ultimo > @limite) then
			update usosala set ativa = 0 where codUsoSala = @ultUsoSala;
			select 0 into @usoSalaAtiva;
		end if;
	end if;
	
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
		
		select time(dataAtual) into @horaLiga
		from capturaatual
		where codcaptura = @capturaLiga;		

		update equipamento
		set tempoUso = addtime( tempoUso, subtime(time(new.dataAtual), @horaLiga) )
		where codEquip = new.codEquip;

		select count(*) into @onEquip
		from capturaatual cap, usosalacaptura uso
		where cap.codCaptura = uso.codCaptura
		and   cap.codEvento = 4
		and   uso.codUsoSala = @ultUsoSala;

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
  KEY `codUsoSala` (`codUsoSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `usosalacaptura`
--

DROP TABLE IF EXISTS `usosalacaptura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usosalacaptura` (
  `codCaptura` int(11) NOT NULL,
  `codUsoSala` int(11) NOT NULL,
  PRIMARY KEY (`codCaptura`,`codUsoSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Dumping routines for database 'protegemed'
--
/*!50003 DROP FUNCTION IF EXISTS `f_ultCodCaptura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
/*!50003 SET sql_mode              = '' */ ;
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
/*!50003 SET sql_mode              = '' */ ;
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
/*!50003 SET sql_mode              = '' */ ;
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

-- Dump completed on 2014-03-17 19:36:36
