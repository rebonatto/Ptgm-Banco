ALTER TABLE `protegemed`.`equipamento` ADD COLUMN `codTomada` INT(11) NOT NULL AFTER `codTipo`;
ALTER TABLE `protegemed`.`equipamento` ADD COLUMN `limiteFase` float DEFAULT 0.0 AFTER `tempoUso`;
ALTER TABLE `protegemed`.`equipamento` ADD COLUMN `limiteFuga` float DEFAULT 0.0 AFTER `limiteFase`;
ALTER TABLE `protegemed`.`equipamento` ADD COLUMN `limiteStandByFase` float DEFAULT 0.0 AFTER `limiteFuga`;
ALTER TABLE `protegemed`.`equipamento` ADD COLUMN `limiteStandByFuga` float DEFAULT 0.0 AFTER `limiteStandByFase`;

UPDATE `protegemed`.`equipamento` SET `codTomada`='1' WHERE `codEquip`>'0';
UPDATE `protegemed`.`equipamento` SET `rfid`='FFFF0001' WHERE `codEquip`>'0';
UPDATE `protegemed`.`equipamento` SET `limiteFase`='0.5' WHERE `codEquip`>'0';
UPDATE `protegemed`.`equipamento` SET `limiteFuga`='0.5' WHERE `codEquip`>'0';
UPDATE `protegemed`.`equipamento` SET `limiteStandByFase`='0.2' WHERE `codEquip`>'0';
UPDATE `protegemed`.`equipamento` SET `limiteStandByFuga`='0.2' WHERE `codEquip`>'0';

INSERT INTO `protegemed`.`eventos` (`codEvento`, `desc`, `formaOnda`) VALUES
(9, 'Captura Externa Fase', 1),
(10, 'Captura Externa Fuga', 1),
(11, 'Inicio StandBy Fase', 1),
(12, 'Inicio StandBy Fuga', 1),
(13, 'Término StandBy Fase', 0),
(14, 'Término StandBy Fuga', 0);

ALTER TABLE `protegemed`.`tomada` ADD COLUMN `limiteFase` float DEFAULT 0.0 AFTER `indice`;
ALTER TABLE `protegemed`.`tomada` ADD COLUMN `limiteFuga` float DEFAULT 0.0 AFTER `limiteFase`;
ALTER TABLE `protegemed`.`tomada` ADD COLUMN `limiteStandByFase` float DEFAULT 0.0 AFTER `limiteFuga`;
ALTER TABLE `protegemed`.`tomada` ADD COLUMN `limiteStandByFuga` float DEFAULT 0.0 AFTER `limiteStandByFase`;
ALTER TABLE `protegemed`.`tomada` CHANGE `modulo` `codModulo` int(11) DEFAULT NULL;

INSERT INTO `protegemed`.`tomada` (`codTomada`, `codSala`, `indice`,`limiteFase`,`limiteFuga`,`limiteStandByFase`,`limiteStandByFuga`,`codModulo`, `desc`) VALUES
(0, 1, 1, 0, 0, 0, 0, 0, 'Equipamento sem Tomada');

UPDATE `protegemed`.`tomada` SET `limiteFase`='0.5' WHERE `codTomada`>'0';
UPDATE `protegemed`.`tomada` SET `limiteFuga`='0.5' WHERE `codTomada`>'0';
UPDATE `protegemed`.`tomada` SET `limiteStandByFase`='0.2' WHERE `codTomada`>'0';
UPDATE `protegemed`.`tomada` SET `limiteStandByFuga`='0.2' WHERE `codTomada`>'0';

CREATE TABLE `protegemed`.`alerta` (
  `codAlerta` int(10) NOT NULL AUTO_INCREMENT,
  `codCaptura` int(11) NOT NULL,
  `codUsoSala` int(11) NOT NULL,
  `usuario` varchar(60) NOT NULL,
  `comentario` varchar(400) NOT NULL,
  PRIMARY KEY (`codAlerta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `protegemed`.`login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `email` varchar(80) NOT NULL,
  `senha` varchar(80) NOT NULL,
  `nivel` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `protegemed`.`login` (`id`, `nome`, `email`, `senha`, `nivel`) VALUES 
(1,'Administrador','admin@admin.com.br','admin',1);

CREATE TABLE `protegemed`.`modulo` (
  `idModulo` int(10) PRIMARY KEY,
  `ip` varchar(16),
  `idWebSocket` int(10),
  `desc` varchar(400)
  )ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `protegemed`.`modulo` (`idModulo`, `ip`, `idWebSocket`, `desc`) VALUES 
(0,'0.0.0.0',NULL,'Módulo 0'),
(1,'192.168.1.101',NULL,'Módulo 1'),
(2,'192.168.1.102',NULL,'Módulo 2'),
(3,'192.168.1.103',NULL,'Módulo 3'),
(4,'192.168.1.104',NULL,'Módulo 4'),
(5,'192.168.1.105',NULL,'Módulo 5'),
(6,'192.168.1.106',NULL,'Módulo 6'),
(7,'192.168.1.107',NULL,'Módulo 7');

ALTER TABLE `protegemed`.`equipamento` ADD INDEX `codTomada` (`codTomada` ASC);
ALTER TABLE `protegemed`.`equipamento` ADD CONSTRAINT `fk_equipamento_4` FOREIGN KEY (`codTomada`) REFERENCES `protegemed`.`tomada` (`codTomada`) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE `protegemed`.`tomada` ADD INDEX `fkTomadaModulo_idx` (`codModulo` ASC);
ALTER TABLE `protegemed`.`tomada` ADD CONSTRAINT `fkTomadaModulo` FOREIGN KEY (`codModulo`) REFERENCES `protegemed`.`modulo` (`idModulo`) ON DELETE NO ACTION ON UPDATE NO ACTION;
