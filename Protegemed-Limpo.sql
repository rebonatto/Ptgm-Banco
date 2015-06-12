-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: 20/07/2014 às 22h24min
-- Versão do Servidor: 5.5.37
-- Versão do PHP: 5.3.10-1ubuntu3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `protegemed`
--

CREATE DATABASE  IF NOT EXISTS `protegemed`;
USE `protegemed`;

DELIMITER $$
--
-- Funções
--
DROP FUNCTION IF EXISTS `f_ultCodCaptura`$$
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
END$$

DROP FUNCTION IF EXISTS `f_ultUsoSala`$$
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
END$$

DROP FUNCTION IF EXISTS `f_ultUsoSalaAtiva`$$
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
END$$

DROP FUNCTION IF EXISTS `nextCaptura`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `nextCaptura`() RETURNS int(11)
BEGIN
	declare ultimo INT;

	select max(codcaptura) into @ultimo
    from capturaatual ;
	
	return @ultimo;
END$$

DELIMITER ;

-- --------------------------------------------------------
--
-- Estrutura da tabela `equipamento`
--

CREATE TABLE IF NOT EXISTS `equipamento` (
  `codEquip` int(11) NOT NULL AUTO_INCREMENT,
  `codMarca` int(11) NOT NULL,
  `codModelo` int(11) NOT NULL,
  `codTipo` int(11) NOT NULL,
  `rfid` varchar(45) NOT NULL,
  `codPatrimonio` int(11) NOT NULL,
  `desc` varchar(45) DEFAULT NULL,
  `dataUltimaFalha` date DEFAULT NULL,
  `dataUltimaManutencao` date DEFAULT NULL,
  `tempoUso` int(11) DEFAULT NULL,
  PRIMARY KEY (`codEquip`),
  KEY `codMarca` (`codMarca`),
  KEY `codTipo` (`codTipo`),
  KEY `codModelo` (`codModelo`),
  KEY `fk_equipamento_1_idx` (`codTipo`),
  KEY `fk_equipamento_2_idx` (`codMarca`),
  KEY `fk_equipamento_3_idx` (`codModelo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `equipamento`
--


INSERT INTO `equipamento` (`codEquip`,`codMarca`,`codModelo`,`codTipo`,`rfid`,`codPatrimonio`,`desc`,`dataUltimaFalha`,`dataUltimaManutencao`,`tempoUso`) VALUES (1,1,1,1,'12345601',0,'Equipamento na Tomada 1','2012-03-01','2012-03-01',198);
INSERT INTO `equipamento` (`codEquip`,`codMarca`,`codModelo`,`codTipo`,`rfid`,`codPatrimonio`,`desc`,`dataUltimaFalha`,`dataUltimaManutencao`,`tempoUso`) VALUES (2,1,1,1,'12345602',1,'Equipamento na tomada 2','2012-03-01','2012-03-01',19);
INSERT INTO `equipamento` (`codEquip`,`codMarca`,`codModelo`,`codTipo`,`rfid`,`codPatrimonio`,`desc`,`dataUltimaFalha`,`dataUltimaManutencao`,`tempoUso`) VALUES (3,1,1,1,'12345603',2,'Equipamento na tomada 3','2012-03-01','2012-03-01',52);
INSERT INTO `equipamento` (`codEquip`,`codMarca`,`codModelo`,`codTipo`,`rfid`,`codPatrimonio`,`desc`,`dataUltimaFalha`,`dataUltimaManutencao`,`tempoUso`) VALUES (4,1,1,1,'12345604',3,'Equipamento na tomada 3','2012-03-01','2012-03-01',100);
INSERT INTO `equipamento` (`codEquip`,`codMarca`,`codModelo`,`codTipo`,`rfid`,`codPatrimonio`,`desc`,`dataUltimaFalha`,`dataUltimaManutencao`,`tempoUso`) VALUES (5,1,1,1,'12345605',4,'Equipamento na tomada 4','2012-03-01','2012-03-01',200);
INSERT INTO `equipamento` (`codEquip`,`codMarca`,`codModelo`,`codTipo`,`rfid`,`codPatrimonio`,`desc`,`dataUltimaFalha`,`dataUltimaManutencao`,`tempoUso`) VALUES (6,1,1,1,'12345606',5,'Equipamento na tomada 5','2012-03-01','2012-03-01',0);
INSERT INTO `equipamento` (`codEquip`,`codMarca`,`codModelo`,`codTipo`,`rfid`,`codPatrimonio`,`desc`,`dataUltimaFalha`,`dataUltimaManutencao`,`tempoUso`) VALUES (7,1,1,1,'12345607',6,'Equipamento na tomada 6','2012-03-01','2012-03-01',0);
INSERT INTO `equipamento` (`codEquip`,`codMarca`,`codModelo`,`codTipo`,`rfid`,`codPatrimonio`,`desc`,`dataUltimaFalha`,`dataUltimaManutencao`,`tempoUso`) VALUES (8,1,1,2,'123',222,'Outro teste','2012-07-02','2014-07-31',0);


-- --------------------------------------------------------
--
-- Estrutura da tabela `eventos`
--

DROP TABLE IF EXISTS `eventos`;
CREATE TABLE IF NOT EXISTS `eventos` (
  `codEvento` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) NOT NULL,
  `formaOnda` tinyint(4) NOT NULL,
  PRIMARY KEY (`codEvento`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `eventos`
--

INSERT INTO `eventos` (`codEvento`, `desc`, `formaOnda`) VALUES
(1, 'Evento de Fuga', 1),
(2, 'Acompanhamento - Fase', 1),
(3, 'Acompanhamento - Diferencial', 1),
(4, 'Equipamento Ligado', 1),
(5, 'Equipamento Desligado', 0),
(6, 'Término de Fuga', 0),
(7, 'Oi', 0),
(8, 'Protegemed Inicializando', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `marca`
--

DROP TABLE IF EXISTS `marca`;
CREATE TABLE IF NOT EXISTS `marca` (
  `codMarca` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codMarca`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `marca`
--

INSERT INTO `marca` (`codMarca`, `desc`) VALUES
(1, 'Marca Padrão'),
(2, 'TESTEEEEE');

-- --------------------------------------------------------

--
-- Estrutura da tabela `modelo`
--

DROP TABLE IF EXISTS `modelo`;
CREATE TABLE IF NOT EXISTS `modelo` (
  `codModelo` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codModelo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `modelo`
--

INSERT INTO `modelo` (`codModelo`, `desc`) VALUES
(1, 'Modelo Padrão');

-- --------------------------------------------------------

--
-- Estrutura da tabela `procedimento`
--

DROP TABLE IF EXISTS `procedimento`;
CREATE TABLE IF NOT EXISTS `procedimento` (
  `codProced` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codProced`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Extraindo dados da tabela `procedimento`
--

INSERT INTO `procedimento` (`codProced`, `desc`) VALUES
(1, 'teste'),
(6, 'opaaa'),
(7, 'opaaa');

-- --------------------------------------------------------

--
-- Estrutura da tabela `responsavel`
--

DROP TABLE IF EXISTS `responsavel`;
CREATE TABLE IF NOT EXISTS `responsavel` (
  `codResp` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codResp`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Extraindo dados da tabela `responsavel`
--

INSERT INTO `responsavel` (`codResp`, `desc`) VALUES
(1, 'teste'),
(9, 'jose'),
(10, 'jose');

-- --------------------------------------------------------

--
-- Estrutura da tabela `salacirurgia`
--

DROP TABLE IF EXISTS `salacirurgia`;
CREATE TABLE IF NOT EXISTS `salacirurgia` (
  `codSala` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codSala`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Extraindo dados da tabela `salacirurgia`
--

INSERT INTO `salacirurgia` (`codSala`, `desc`) VALUES
(1, 'Sala de Testes'),
(2, 'Sala dois'),
(3, 'Sala tres'),
(4, 'Sala quatro'),
(5, 'Sala cinco');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo`
--

DROP TABLE IF EXISTS `tipo`;
CREATE TABLE IF NOT EXISTS `tipo` (
  `codTipo` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codTipo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Extraindo dados da tabela `tipo`
--

INSERT INTO `tipo` (`codTipo`, `desc`) VALUES
(1, 'Fase'),
(2, 'Fuga'),
(7, 'TESTEEEEE');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipoonda`
--

DROP TABLE IF EXISTS `tipoonda`;
CREATE TABLE IF NOT EXISTS `tipoonda` (
  `codTipoOnda` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codTipoOnda`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `tipoonda`
--

INSERT INTO `tipoonda` (`codTipoOnda`, `desc`) VALUES
(1, 'Fase'),
(2, 'Fuga');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipopadrao`
--

DROP TABLE IF EXISTS `tipopadrao`;
CREATE TABLE IF NOT EXISTS `tipopadrao` (
  `codTipoPadrao` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codTipoPadrao`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `tipopadrao`
--

INSERT INTO `tipopadrao` (`codTipoPadrao`, `desc`) VALUES
(1, 'Funcionamento Normal'),
(2, 'Erro - Fuga de corrente'),
(4, 'oy');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tomada`
--

DROP TABLE IF EXISTS `tomada`;
CREATE TABLE IF NOT EXISTS `tomada` (
  `codTomada` int(11) NOT NULL,
  `codSala` int(11) NOT NULL,
  `indice` int(11) DEFAULT NULL,
  `modulo` int(11) DEFAULT NULL,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codTomada`),
  KEY `codUsoSala3` (`codSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tomada`
--

INSERT INTO `tomada` (`codTomada`, `codSala`, `indice`, `modulo`, `desc`) VALUES
(1, 1, 1, 1, 'Tomada 1'),
(2, 1, 2, 2, 'Tomada 2'),
(3, 1, 3, 3, 'Tomada 3'),
(4, 1, 4, 4, 'Tomada 4'),
(5, 1, 5, 5, 'Tomada 5'),
(6, 1, 6, 6, 'Tomada 6'),
(7, 3, 7, 7, 'Tomada 7');

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `equipamento`
--
ALTER TABLE `equipamento`
  ADD CONSTRAINT `fk_equipamento_1` FOREIGN KEY (`codTipo`) REFERENCES `tipo` (`codTipo`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_equipamento_2` FOREIGN KEY (`codMarca`) REFERENCES `marca` (`codMarca`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_equipamento_3` FOREIGN KEY (`codModelo`) REFERENCES `modelo` (`codModelo`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para a tabela `tomada`
--
ALTER TABLE `tomada`
  ADD CONSTRAINT `codSala2` FOREIGN KEY (`codSala`) REFERENCES `salacirurgia` (`codSala`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- --------------------------------------------------------

--
-- Estrutura da tabela `capturaatual`
--

DROP TABLE IF EXISTS `capturaatual`;
CREATE TABLE IF NOT EXISTS `capturaatual` (
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
  `VM2` float DEFAULT NULL,
  `under` int(11) DEFAULT NULL,
  `over` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`codCaptura`),
  KEY `codTomada2` (`codTomada`),
  KEY `codEquipamento2` (`codEquip`),
  KEY `codTipoOnda2` (`codTipoOnda`),
  KEY `codEvento` (`codEvento`),
  KEY `fk_capturaatual_1_idx` (`codEvento`),
  KEY `fk_capturaatual_2_idx` (`codTipoOnda`),
  KEY `fk_capturaatual_3_idx` (`codEquip`),
  KEY `fk_capturaatual_4_idx` (`codTomada`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;


--
-- Extraindo dados da tabela `capturaatual`
--

INSERT INTO `capturaatual` (`codCaptura`, `codTomada`, `codTipoOnda`, `codEquip`, `codEvento`, `valorMedio`, `offset`, `gain`, `eficaz`, `dataAtual`, `VM2`, `under`, `over`, `duration`) VALUES
(1, 1, 1, 1, 4, 532676, 2082, 119.4, 0.164743, '2014-10-01 17:19:34', 2080.77, 0, 0, 0),
(2, 1, 1, 1, 5, 2.53376e-29, 2082, 119.4, 0.0166602, '2014-10-01 17:19:38', 2081.25, 0, 0, 0),
(3, 1, 1, 1, 4, 532347, 2082, 119.4, 0.136841, '2014-10-01 17:25:11', 2079.48, 0, 0, 0),
(4, 1, 1, 1, 5, 3.23055e-41, 2082, 119.4, 0.0158165, '2014-10-01 17:25:17', 2081.22, 0, 0, 0),
(5, 1, 1, 1, 4, 530281, 2080, 116.18, 1.0838, '2014-04-22 10:19:25', NULL, NULL, NULL, NULL),
(6, 1, 1, 1, 5, 5.42162e-42, 2080, 116.18, 0.234814, '2014-04-22 10:19:31', NULL, NULL, NULL, NULL),
(7, 1, 1, 1, 4, 533476, 2080, 116.18, 0.696517, '2014-04-22 10:21:12', NULL, NULL, NULL, NULL),
(8, 1, 1, 1, 5, 6.59731e-42, 2080, 116.18, 0.236939, '2014-04-22 10:21:18', NULL, NULL, NULL, NULL),
(9, 1, 1, 1, 4, 532238, 2080, 116.18, 0.125567, '2014-04-22 09:42:56', NULL, NULL, NULL, NULL),
(10, 1, 1, 1, 5, 4.29358e-42, 2080, 116.18, 0.0517196, '2014-04-22 09:43:13', NULL, NULL, NULL, NULL),
(11, 3, 1, 3, 4, 534505, 2082, 112.06, 0.973241, '2014-05-22 10:44:58', 2087.91, 0, 0, 0),
(12, 3, 1, 3, 5, 2.79153e-41, 2082, 112.06, 0.0168617, '2014-05-22 10:45:01', 2083.23, 0, 0, 0),
(13, 2, 2, 2, 1, 541996, 2082, 750, 1.06001, '2014-10-01 17:52:05', 2117.17, 0, 0, 0),
(14, 2, 2, 2, 6, 2.53376e-29, 2082, 750, 0.00416666, '2014-10-01 17:52:09', 2082.72, 0, 0, 4460),
(15, 2, 2, 2, 1, 526300, 2082, 750, 0.58395, '2014-10-01 18:07:13', 2055.86, 0, 0, 0),
(16, 3, 2, 3, 1, 545369, 2092, 820, 2.23744, '2014-10-01 18:07:13', 2130.35, 80, 0, 0),
(17, 1, 2, 1, 1, 497302, 2096, 750, 2.46836, '2014-10-01 18:07:13', 1942.59, 84, 0, 0),
(18, 1, 2, 1, 6, 3.23055e-41, 2096, 750, 0.0137876, '2014-10-01 18:07:20', 2095.59, 0, 0, 7991),
(19, 2, 2, 2, 6, 3.23055e-41, 2082, 750, 0.00442374, '2014-10-01 18:07:20', 2082.57, 0, 0, 8000),
(20, 3, 2, 3, 6, 3.23055e-41, 2092, 820, 0.0383474, '2014-10-01 18:07:20', 2091.84, 0, 0, 8009);


--
-- Gatilhos `capturaatual`
--
DROP TRIGGER IF EXISTS `atualiza`;
DELIMITER //
CREATE TRIGGER `atualiza` AFTER INSERT ON `capturaatual`
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
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `harmatual`
--

DROP TABLE IF EXISTS `harmatual`;
CREATE TABLE IF NOT EXISTS `harmatual` (
  `codCaptura` int(11) NOT NULL,
  `codHarmonica` int(11) NOT NULL,
  `sen` float DEFAULT NULL,
  `cos` float DEFAULT NULL,
  PRIMARY KEY (`codCaptura`,`codHarmonica`),
  KEY `codOndaAtual` (`codCaptura`),
  KEY `fk_ondaatual_1_idx` (`codCaptura`),
  KEY `fk_ondaatual_1_idx1` (`codCaptura`),
  KEY `fk_harmatual_1_idx` (`codCaptura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Extraindo dados da tabela `harmatual`
--

INSERT INTO `harmatual` (`codCaptura`, `codHarmonica`, `sen`, `cos`) VALUES
(1, 1, 3413.36, -928.515),
(1, 2, -198.781, 27.3738),
(1, 3, -126.72, 17.0906),
(1, 4, -72.4663, 6.11848),
(1, 5, -88.8516, 22.4799),
(1, 6, -51.2998, -12.3804),
(1, 7, -43.2307, -14.9758),
(1, 8, -46.5318, 14.4433),
(1, 9, -24.8939, 14.2197),
(1, 10, -26.3819, -16.7292),
(1, 11, -29.2011, -24.5308),
(1, 12, -31.5677, -5.204),
(2, 1, 0, 0),
(2, 2, 0, 0),
(2, 3, 0, 0),
(2, 4, 0, 0),
(2, 5, 0, 0),
(2, 6, 0, 0),
(2, 7, 0, 0),
(2, 8, 0, 0),
(2, 9, 0, 0),
(2, 10, 0, 0),
(2, 11, 0, 0),
(2, 12, 0, 0),
(3, 1, -255.463, -1954.23),
(3, 2, 26.1853, -330.125),
(3, 3, -58.4394, -1616.08),
(3, 4, 54.4126, -93.6923),
(3, 5, 96.6451, -967.689),
(3, 6, 100.611, 127.045),
(3, 7, 307.487, -414.071),
(3, 8, 13.7409, 218.214),
(3, 9, 299.295, -130.81),
(3, 10, -121.71, 238.733),
(3, 11, 159.13, 49.0927),
(3, 12, -263.53, 209.51),
(4, 1, 0, 0),
(4, 2, 0, 0),
(4, 3, 0, 0),
(4, 4, 0, 0),
(4, 5, 0, 0),
(4, 6, 0, 0),
(4, 7, 0, 0),
(4, 8, 0, 0),
(4, 9, 0, 0),
(4, 10, 0, 0),
(4, 11, 0, 0),
(4, 12, 0, 0),
(5, 1, -7486.22, -20541.6),
(5, 2, 163.807, -268.841),
(5, 3, -2044.87, -5476.83),
(5, 4, 641.61, 650.267),
(5, 5, 780.422, -812.192),
(5, 6, 33.4019, 305.325),
(5, 7, -302.348, -564.282),
(5, 8, 456.756, 616.563),
(5, 9, 405.23, 235.05),
(5, 10, 289.082, 151.279),
(5, 11, 669.923, 253.291),
(5, 12, -309.318, 109.224),
(6, 1, 0, 0),
(6, 2, 0, 0),
(6, 3, 0, 0),
(6, 4, 0, 0),
(6, 5, 0, 0),
(6, 6, 0, 0),
(6, 7, 0, 0),
(6, 8, 0, 0),
(6, 9, 0, 0),
(6, 10, 0, 0),
(6, 11, 0, 0),
(6, 12, 0, 0),
(7, 1, -6000.54, 12438.5),
(7, 2, 41.6054, -655.556),
(7, 3, -2959.83, -3123.91),
(7, 4, 763.835, 456.58),
(7, 5, 1259.32, 583.596),
(7, 6, 16.1573, 44.8774),
(7, 7, 153.394, 499.039),
(7, 8, 42.2991, -191.756),
(7, 9, -64.6356, 68.5764),
(7, 10, 262.151, -174.667),
(7, 11, 179.943, 21.1996),
(7, 12, 156.772, -114.178),
(8, 1, 0, 0),
(8, 2, 0, 0),
(8, 3, 0, 0),
(8, 4, 0, 0),
(8, 5, 0, 0),
(8, 6, 0, 0),
(8, 7, 0, 0),
(8, 8, 0, 0),
(8, 9, 0, 0),
(8, 10, 0, 0),
(8, 11, 0, 0),
(8, 12, 0, 0),
(9, 1, -445.706, -1429.65),
(9, 2, -139.726, -105.619),
(9, 3, -950.944, -939.51),
(9, 4, -56.3135, 117.619),
(9, 5, -1012.61, -224.428),
(9, 6, 184.096, 199.806),
(9, 7, -622.564, 243.668),
(9, 8, 374.075, 125.59),
(9, 9, -162.897, 356.652),
(9, 10, 435.175, -100.582),
(9, 11, 138.747, 212.993),
(9, 12, 330.646, -210.082),
(10, 1, 0, 0),
(10, 2, 0, 0),
(10, 3, 0, 0),
(10, 4, 0, 0),
(10, 5, 0, 0),
(10, 6, 0, 0),
(10, 7, 0, 0),
(10, 8, 0, 0),
(10, 9, 0, 0),
(10, 10, 0, 0),
(10, 11, 0, 0),
(10, 12, 0, 0),
(11, 1, -13948.1, 13741.6),
(11, 2, 815.409, -316.856),
(11, 3, 49.8062, -158.215),
(11, 4, 352.033, 237.829),
(11, 5, -318.259, 1275.51),
(11, 6, 583.27, -228.826),
(11, 7, 767.723, 435.682),
(11, 8, 221.79, -400.341),
(11, 9, 690.161, -161.041),
(11, 10, -177.43, -282.106),
(11, 11, 110.729, -353.218),
(11, 12, -170.966, -4.5928),
(12, 1, 0, 0),
(12, 2, 0, 0),
(12, 3, 0, 0),
(12, 4, 0, 0),
(12, 5, 0, 0),
(12, 6, 0, 0),
(12, 7, 0, 0),
(12, 8, 0, 0),
(12, 9, 0, 0),
(12, 10, 0, 0),
(12, 11, 0, 0),
(12, 12, 0, 0),
(13, 1, 96781.8, 105838),
(13, 2, -6085.74, -3401.26),
(13, 3, -4175.25, -1068.58),
(13, 4, -2560.82, -981.098),
(13, 5, -3727.07, -1289.13),
(13, 6, -590.136, -303.451),
(13, 7, 160.759, -408.045),
(13, 8, -1456.71, -198.75),
(13, 9, -1196, -271.626),
(13, 10, -762.657, -121.363),
(13, 11, -723.56, -245.055),
(13, 12, -815.024, -73.0836),
(14, 1, 0, 0),
(14, 2, 0, 0),
(14, 3, 0, 0),
(14, 4, 0, 0),
(14, 5, 0, 0),
(14, 6, 0, 0),
(14, 7, 0, 0),
(14, 8, 0, 0),
(14, 9, 0, 0),
(14, 10, 0, 0),
(14, 11, 0, 0),
(14, 12, 0, 0),
(15, 1, -52530.3, -44700.7),
(15, 2, 5148.96, -37471.2),
(15, 3, 1019.39, 1982.89),
(15, 4, -3591.57, -5128.02),
(15, 5, 1981.55, 1730.12),
(15, 6, -1308.8, 859.336),
(15, 7, 1126.88, 1816.58),
(15, 8, -611.19, 796.704),
(15, 9, 1731.21, 513.268),
(15, 10, 552.308, 1036.47),
(15, 11, 1383.29, 252.353),
(15, 12, 690.643, 750.886),
(16, 1, 263760, 180014),
(16, 2, -21302.7, 7270.83),
(16, 3, -19416.4, 79145.8),
(16, 4, -9956.75, -12302),
(16, 5, -27257.7, 2217.42),
(16, 6, 3677.03, -6187.15),
(16, 7, -1854.62, -5701.91),
(16, 8, -104.176, 360.076),
(16, 9, -911.271, 1616.15),
(16, 10, -1365.24, -3233.72),
(16, 11, -2898.1, -947.301),
(16, 12, 2382.43, -2112.59),
(17, 1, -267682, -176133),
(17, 2, 18013.2, -10530.4),
(17, 3, 16637.4, -82330.8),
(17, 4, 13425.3, 7364.25),
(17, 5, 30376.9, -3382.03),
(17, 6, 760.638, 8394.46),
(17, 7, 2236.73, 8895.99),
(17, 8, -1488.84, 2298.09),
(17, 9, -1529.2, -1241.3),
(17, 10, 164.238, 1817.51),
(17, 11, 2737.67, -10.0219),
(17, 12, -1346.53, 1962.1),
(18, 1, 0, 0),
(18, 2, 0, 0),
(18, 3, 0, 0),
(18, 4, 0, 0),
(18, 5, 0, 0),
(18, 6, 0, 0),
(18, 7, 0, 0),
(18, 8, 0, 0),
(18, 9, 0, 0),
(18, 10, 0, 0),
(18, 11, 0, 0),
(18, 12, 0, 0),
(19, 1, 0, 0),
(19, 2, 0, 0),
(19, 3, 0, 0),
(19, 4, 0, 0),
(19, 5, 0, 0),
(19, 6, 0, 0),
(19, 7, 0, 0),
(19, 8, 0, 0),
(19, 9, 0, 0),
(19, 10, 0, 0),
(19, 11, 0, 0),
(19, 12, 0, 0),
(20, 1, 0, 0),
(20, 2, 0, 0),
(20, 3, 0, 0),
(20, 4, 0, 0),
(20, 5, 0, 0),
(20, 6, 0, 0),
(20, 7, 0, 0),
(20, 8, 0, 0),
(20, 9, 0, 0),
(20, 10, 0, 0),
(20, 11, 0, 0),
(20, 12, 0, 0);



-- --------------------------------------------------------

--
-- Estrutura da tabela `harmpadrao`
--

DROP TABLE IF EXISTS `harmpadrao`;
CREATE TABLE IF NOT EXISTS `harmpadrao` (
  `codHarmonica` int(11) NOT NULL,
  `codOndaPadrao` int(11) NOT NULL,
  `sen` float DEFAULT NULL,
  `cos` float DEFAULT NULL,
  PRIMARY KEY (`codHarmonica`,`codOndaPadrao`),
  KEY `codOndaP` (`codOndaPadrao`),
  KEY `fk_harmpadrao_1_idx` (`codOndaPadrao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ondapadrao`
--

DROP TABLE IF EXISTS `ondapadrao`;
CREATE TABLE IF NOT EXISTS `ondapadrao` (
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
  KEY `fk_ondapadrao_2_idx` (`codTipoPadrao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usosala`
--

DROP TABLE IF EXISTS `usosala`;
CREATE TABLE IF NOT EXISTS `usosala` (
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
  KEY `codSala` (`codSala`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usosalacaptura`
--

DROP TABLE IF EXISTS `usosalacaptura`;
CREATE TABLE IF NOT EXISTS `usosalacaptura` (
  `codCaptura` int(11) NOT NULL,
  `codUsoSala` int(11) NOT NULL,
  PRIMARY KEY (`codCaptura`,`codUsoSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usosalaequip`
--

DROP TABLE IF EXISTS `usosalaequip`;
CREATE TABLE IF NOT EXISTS `usosalaequip` (
  `codEquip` int(11) NOT NULL,
  `codUsoSala` int(11) NOT NULL,
  PRIMARY KEY (`codEquip`,`codUsoSala`),
  KEY `codEquip3` (`codEquip`),
  KEY `codUsoSala` (`codUsoSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `capturaatual`
--
ALTER TABLE `capturaatual`
  ADD CONSTRAINT `fk_capturaatual_1` FOREIGN KEY (`codEvento`) REFERENCES `eventos` (`codEvento`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_capturaatual_2` FOREIGN KEY (`codTipoOnda`) REFERENCES `tipoonda` (`codTipoOnda`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_capturaatual_3` FOREIGN KEY (`codEquip`) REFERENCES `equipamento` (`codEquip`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_capturaatual_4` FOREIGN KEY (`codTomada`) REFERENCES `tomada` (`codTomada`) ON UPDATE NO ACTION;

--
-- Restrições para a tabela `harmatual`
--
ALTER TABLE `harmatual`
  ADD CONSTRAINT `fk_harmatual_1` FOREIGN KEY (`codCaptura`) REFERENCES `capturaatual` (`codCaptura`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para a tabela `harmpadrao`
--
ALTER TABLE `harmpadrao`
  ADD CONSTRAINT `fk_harmpadrao_1` FOREIGN KEY (`codOndaPadrao`) REFERENCES `ondapadrao` (`codOndaPadrao`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Restrições para a tabela `ondapadrao`
--
ALTER TABLE `ondapadrao`
  ADD CONSTRAINT `codEquip` FOREIGN KEY (`codEquip`) REFERENCES `equipamento` (`codEquip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `codTomada` FOREIGN KEY (`codTomada`) REFERENCES `tomada` (`codTomada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ondapadrao_1` FOREIGN KEY (`codTipoOnda`) REFERENCES `tipoonda` (`codTipoOnda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ondapadrao_2` FOREIGN KEY (`codTipoPadrao`) REFERENCES `tipopadrao` (`codTipoPadrao`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para a tabela `usosala`
--
ALTER TABLE `usosala`
  ADD CONSTRAINT `codProced` FOREIGN KEY (`codProced`) REFERENCES `procedimento` (`codProced`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `codResp` FOREIGN KEY (`codResp`) REFERENCES `responsavel` (`codResp`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `codSala` FOREIGN KEY (`codSala`) REFERENCES `salacirurgia` (`codSala`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

