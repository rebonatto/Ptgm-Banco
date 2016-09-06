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
  `codTomada` int(11) NOT NULL,
  `rfid` varchar(45) NOT NULL,
  `codPatrimonio` int(11) NOT NULL,
  `desc` varchar(45) DEFAULT NULL,
  `dataUltimaFalha` date DEFAULT NULL,
  `dataUltimaManutencao` date DEFAULT NULL,
  `tempoUso` int(11) DEFAULT NULL,
  `limiteFase` float DEFAULT 0,
  `limiteFuga` float DEFAULT 0,
  PRIMARY KEY (`codEquip`),
  KEY `codMarca` (`codMarca`),
  KEY `codTipo` (`codTipo`),
  KEY `codModelo` (`codModelo`),
  KEY `codTomada` (`codTomada`),
  KEY `fk_equipamento_1_idx` (`codTipo`),
  KEY `fk_equipamento_2_idx` (`codMarca`),
  KEY `fk_equipamento_3_idx` (`codModelo`),
  KEY `fk_equipamento_4_idx` (`codTomada`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `equipamento`
--


INSERT INTO `equipamento` (`codEquip`,`codMarca`,`codModelo`,`codTipo`,`codTomada`,`rfid`,`codPatrimonio`,`desc`,`dataUltimaFalha`,`dataUltimaManutencao`,`tempoUso`,`limiteFase`,`limiteFuga`) VALUES 
(1,1,1,1,0,'FFFF0001',0,'Equipamento na Tomada 1','2012-03-01','2012-03-01',198,0.5,0.5),
(2,1,1,1,0,'FFFF0002',1,'Equipamento na Tomada 2','2012-03-01','2012-03-01',19,0.5,0.5),
(3,1,1,1,0,'FFFF0003',2,'Equipamento na Tomada 3','2012-03-01','2012-03-01',52,0.5,0.5),
(4,1,1,1,0,'FFFF0004',3,'Equipamento na Tomada 4','2012-03-01','2012-03-01',100,0.5,0.5),
(5,1,1,1,0,'FFFF0005',4,'Equipamento na Tomada 5','2012-03-01','2012-03-01',200,0.5,0.5),
(6,1,1,1,0,'FFFF0006',5,'Equipamento na Tomada 6','2012-03-01','2012-03-01',0,0.5,0.5),
(7,1,1,1,0,'FFFF0007',6,'Equipamento na Tomada 7','2012-03-01','2012-03-01',0,0.5,0.5),
(8,1,1,2,0,'FFFF0008',222,'Outro teste','2012-07-02','2014-07-31',0,0.5,0.5);


-- --------------------------------------------------------
--
-- Estrutura da tabela `eventos`
--

DROP TABLE IF EXISTS `eventos`;
CREATE TABLE `eventos` (
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
(8, 'Protegemed Inicializando', 0),
(9, 'Captura Externa Fase', 1),
(10, 'Captura Externa Fuga', 1);


-- --------------------------------------------------------

--
-- Estrutura da tabela `marca`
--

DROP TABLE IF EXISTS `marca`;
CREATE TABLE `marca` (
  `codMarca` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codMarca`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `marca`
--

INSERT INTO `marca` (`codMarca`, `desc`) VALUES
(1, 'Marca Padrão'),
(2, 'Teste');

-- --------------------------------------------------------

--
-- Estrutura da tabela `modelo`
--

DROP TABLE IF EXISTS `modelo`;
CREATE TABLE `modelo` (
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
CREATE TABLE `procedimento` (
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
CREATE TABLE `responsavel` (
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
CREATE TABLE `salacirurgia` (
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
CREATE TABLE `tipo` (
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
(7, 'Teste');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipoonda`
--

DROP TABLE IF EXISTS `tipoonda`;
CREATE TABLE `tipoonda` (
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
CREATE TABLE `tipopadrao` (
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
CREATE TABLE `tomada` (
  `codTomada` int(11) NOT NULL,
  `codSala` int(11) NOT NULL,
  `indice` int(11) DEFAULT NULL,
  `limiteFase` float DEFAULT 0.0,
  `limiteFuga` float DEFAULT 0.0,
  `codModulo` int(11) DEFAULT NULL,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codTomada`),
  KEY `codUsoSala3` (`codSala`),
  KEY `codModulo2` (`codModulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tomada`
--

INSERT INTO `tomada` (`codTomada`, `codSala`, `indice`,`limiteFase`,`limiteFuga`, `codModulo`, `desc`) VALUES
(0, 1, 1, 0, 0, 0, 'Equipamento sem Tomada'),
(1, 1, 1, 0.5, 0.5, 1, 'Tomada 1'),
(2, 1, 2, 0.5, 0.5, 1, 'Tomada 2'),
(3, 1, 3, 0.5, 0.5, 1, 'Tomada 3'),
(4, 1, 4, 0.5, 0.5, 2, 'Tomada 4'),
(5, 1, 5, 0.5, 0.5, 2, 'Tomada 5'),
(6, 1, 6, 0.5, 0.5, 2, 'Tomada 6');

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `equipamento`
--
ALTER TABLE `equipamento`
  ADD CONSTRAINT `fk_equipamento_1` FOREIGN KEY (`codTipo`) REFERENCES `tipo` (`codTipo`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_equipamento_2` FOREIGN KEY (`codMarca`) REFERENCES `marca` (`codMarca`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_equipamento_3` FOREIGN KEY (`codModelo`) REFERENCES `modelo` (`codModelo`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_equipamento_4` FOREIGN KEY (`codTomada`) REFERENCES `tomada` (`codTomada`) ON DELETE CASCADE ON UPDATE NO ACTION;

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
(1, 1, 2, 1, 1, 0, 2096, 1043, 0.985126, '2015-05-24 11:14:17', 0, 0, 0, 0),
(2, 1, 2, 1, 1, 0, 2096, 1043, 0.50516, '2015-05-24 11:14:34', 0, 0, 0, 0),
(3, 1, 2, 1, 1, 0, 2096, 1043, 0.556648, '2015-05-24 11:17:02', 0, 0, 0, 0),
(4, 1, 1, 1, 4, 0, 2091, 115.55, 0.186089, '2015-05-24 11:18:41', 0, 0, 0, 0),
(5, 1, 1, 1, 4, 0, 2091, 115.55, 0.28232, '2015-05-24 11:20:40', 0, 0, 0, 0),
(6, 1, 1, 1, 4, 0, 2091, 115.55, 0.200798, '2015-05-24 11:21:33', 0, 0, 0, 0),
(7, 1, 1, 1, 4, 0, 2091, 115.55, 0.0856553, '2015-05-24 11:25:50', 0, 0, 0, 0),
(8, 1, 2, 1, 1, 0, 2096, 757, 2.19691, '2015-05-24 11:43:21', 0.00219727, 54, 0, 0);


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
CREATE TABLE `harmatual` (
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

CREATE TABLE IF NOT EXISTS `harmatual` (
  `codCaptura` int(11) NOT NULL,
  `codHarmonica` int(11) NOT NULL,
  `sen` float DEFAULT NULL,
  `cos` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `harmatual`
--

INSERT INTO `harmatual` (`codCaptura`, `codHarmonica`, `sen`, `cos`) VALUES
(1, 1, -1428.46, -232.767),
(1, 2, 90.1312, 7.51492),
(1, 3, 48.0291, 0.171923),
(1, 4, 37.8526, 2.31123),
(1, 5, 37.0748, 0.771017),
(1, 6, 19.3785, 4.17857),
(1, 7, 15.1203, 18.5427),
(1, 8, 17.7631, -10.7352),
(1, 9, 16.275, -6.67653),
(1, 10, 11.6532, -2.16256),
(1, 11, 11.1139, -3.32237),
(1, 12, 10.6478, -0.43098),
(2, 1, 285.999, 687.068),
(2, 2, -17.7241, -21.58),
(2, 3, -11.0692, -8.35081),
(2, 4, -6.53174, -3.69786),
(2, 5, -5.2324, 1.89548),
(2, 6, -2.20017, -4.3712),
(2, 7, 4.70934, -7.0896),
(2, 8, -6.87618, 0.970771),
(2, 9, -3.9104, -1.15881),
(2, 10, -4.09066, 0.774818),
(2, 11, -2.55919, 0.311121),
(2, 12, -3.47504, 0.200202),
(3, 1, -476.024, -543.969),
(3, 2, 217.571, 312.009),
(3, 3, -8.11216, -26.048),
(3, 4, -39.1952, -52.9208),
(3, 5, 8.37364, 7.5659),
(3, 6, 25.1747, 13.7207),
(3, 7, 3.75623, -1.26186),
(3, 8, -21.0635, -6.87093),
(3, 9, 12.5784, 0.236628),
(3, 10, 10.704, 1.13988),
(3, 11, -3.91881, -0.279367),
(3, 12, -4.32963, 1.69589),
(4, 1, 12.5556, 27.6217),
(4, 2, -0.907658, -0.790046),
(4, 3, -0.398673, -0.392534),
(4, 4, -0.432962, -0.0972585),
(4, 5, -0.121282, -0.156301),
(4, 6, -0.361008, 0.0804916),
(4, 7, -0.227823, 0.296428),
(4, 8, -0.183537, -0.229706),
(4, 9, -0.0716343, -0.0284829),
(4, 10, -0.210425, 0.000920182),
(4, 11, -0.147829, 0.0111107),
(4, 12, -0.242523, -0.0230518),
(5, 1, -42.0549, -18.5068),
(5, 2, 2.67686, 0.364371),
(5, 3, 1.86645, -0.0177553),
(5, 4, 1.01068, -0.0611348),
(5, 5, 0.80154, -0.381494),
(5, 6, 0.762166, 0.0767424),
(5, 7, 1.10502, -0.245908),
(5, 8, 0.08277, 0.0986508),
(5, 9, 0.208727, 0.0765877),
(5, 10, 0.356205, -0.188673),
(5, 11, 0.225709, 0.0841409),
(5, 12, 0.290215, -0.0779049),
(6, 1, -22.5612, -12.4091),
(6, 2, 1.15253, 2.20712),
(6, 3, -0.694227, 16.0172),
(6, 4, 1.38119, -2.77471),
(6, 5, 5.20733, -6.2106),
(6, 6, -1.91751, 1.81091),
(6, 7, -4.80559, 2.75847),
(6, 8, 2.76264, -0.497085),
(6, 9, 3.23159, 0.457415),
(6, 10, -1.10272, -0.610915),
(6, 11, -0.967335, 0.00736896),
(6, 12, 1.34647, -0.374188),
(7, 1, 5.55454, 7.75249),
(7, 2, 0.267815, 0.337786),
(7, 3, 4.57103, 4.35371),
(7, 4, -0.253324, -0.790065),
(7, 5, 4.77399, 0.252274),
(7, 6, -1.48406, -0.806203),
(7, 7, 1.93056, -2.11734),
(7, 8, -1.99741, 0.134352),
(7, 9, -0.644069, -2.03067),
(7, 10, -1.56853, 1.3738),
(7, 11, -1.82115, -0.644259),
(7, 12, -0.30297, 1.49161),
(8, 1, 2196.16, -764.291),
(8, 2, -97.8153, 24.4413),
(8, 3, 107.309, -253.978),
(8, 4, -80.1706, 62.924),
(8, 5, -55.5683, 78.6058),
(8, 6, -47.4704, 19.0743),
(8, 7, 1.61394, 51.9225),
(8, 8, -53.3866, -9.39166),
(8, 9, -32.4453, -1.8506),
(8, 10, -39.4528, -2.60131),
(8, 11, -37.2217, 8.62096),
(8, 12, -19.4419, -5.7716);



-- --------------------------------------------------------

--
-- Estrutura da tabela `harmpadrao`
--

DROP TABLE IF EXISTS `harmpadrao`;
CREATE TABLE `harmpadrao` (
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
  KEY `fk_ondapadrao_2_idx` (`codTipoPadrao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usosala`
--

DROP TABLE IF EXISTS `usosala`;
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
  KEY `codSala` (`codSala`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usosalacaptura`
--

DROP TABLE IF EXISTS `usosalacaptura`;
CREATE TABLE `usosalacaptura` (
  `codCaptura` int(11) NOT NULL,
  `codUsoSala` int(11) NOT NULL,
  PRIMARY KEY (`codCaptura`,`codUsoSala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usosalaequip`
--

DROP TABLE IF EXISTS `usosalaequip`;
CREATE TABLE `usosalaequip` (
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
  
--
-- Banco de Dados do Mateus
--
#
# Structure for table "alerta"
#

DROP TABLE IF EXISTS `alerta`;
CREATE TABLE `alerta` (
  `codAlerta` int(10) NOT NULL AUTO_INCREMENT,
  `codCaptura` int(11) NOT NULL,
  `codUsoSala` int(11) NOT NULL,
  `usuario` varchar(60) NOT NULL,
  `comentario` varchar(400) NOT NULL,
  PRIMARY KEY (`codAlerta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for table "login"
#

DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `email` varchar(80) NOT NULL,
  `senha` varchar(80) NOT NULL,
  `nivel` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Data for table "login"
#

INSERT INTO `login` (`id`, `nome`, `email`, `senha`, `nivel`) VALUES 
(1,'Administrador','admin@admin.com.br','admin',1);

INSERT INTO `usosala` VALUES 
(1,1,1,1,'2014-04-28 07:38:00','0000-00-00 00:00:00',1),
(2,2,1,1,'2014-04-28 07:38:00','0000-00-00 00:00:00',1);

INSERT INTO `usosalacaptura` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,2),(8,2);

#
# Structure for table "modulo"
#

DROP TABLE IF EXISTS `modulo`;
CREATE TABLE `modulo` (
  `idModulo` int(10) NOT NULL AUTO_INCREMENT,
  `ip` varchar(16),
  `idWebSocket` int(10),
  `desc` varchar(400),
  PRIMARY KEY (`idModulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "modulo"
#

INSERT INTO `modulo` VALUES 
(0,'0.0.0.0',NULL,'Módulo 0'),
(1,'192.168.1.101',NULL,'Módulo 1'),
(2,'192.168.1.102',NULL,'Módulo 2');
  
ALTER TABLE `tomada`
  ADD CONSTRAINT `fktomadaModulo` FOREIGN KEY (`codModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE NO ACTION;




/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
