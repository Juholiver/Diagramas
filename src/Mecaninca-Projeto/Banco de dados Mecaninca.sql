DROP TABLE IF EXISTS Carro;

CREATE TABLE Carro (
  idCarro int NOT NULL AUTO_INCREMENT,
  Placa varchar(45) NOT NULL,
  Modelo varchar(45) NOT NULL,
  Marca varchar(45) NOT NULL,
  IdCliente int NOT NULL,
  PRIMARY KEY (idCarro),
  UNIQUE KEY Placa_UNIQUE(Placa),
  KEY IdCliente_id (IdClient),
  CONSTRAINT IdClient FOREIGN KEY (IdClient) REFERENCES cliente(idClient)
) ;

INSERT INTO Carro VALUES (1,'ABC-2456','Fox','Wolks',3),(2,'AAA-6544','Gol','WOLKS',4);

DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
  idClient int NOT NULL AUTO_INCREMENT,
  Nome varchar(45) NOT NULL,
  CPF varchar(45) NOT NULL,
  PRIMARY KEY (idClient),
  UNIQUE KEY CPF_UNIQUE (CPF)
) 
;
INSERT INTO cliente VALUES (3,'Jose','2222222142145647888'),(4,'Gab','142145214563254');

DROP TABLE IF EXISTS Equipe;

CREATE TABLE Equipe (
  idEquipe int NOT NULL AUTO_INCREMENT,
  Descricao varchar(45) NOT NULL,
  PRIMARY KEY (idEquipe)
) ;

INSERT INTO Equipe VALUES (1,'TROCA PNEUS'),(2,'TROCA OLEO');

DROP TABLE IF EXISTS Funcionario;

CREATE TABLE Funcionario (
  idFuncionario int NOT NULL AUTO_INCREMENT,
  Nome varchar(45) NOT NULL,
  Endereco varchar(45) NOT NULL,
  Especialidade varchar(45) NOT NULL,
  IdEquipe int NOT NULL,
  PRIMARY KEY (idFuncionario),
  KEY IdEquipe_id (IdEquipe),
  CONSTRAINT IdEq FOREIGN KEY (IdEquipe) REFERENCES equipe (idEquipe)
) ;

INSERT INTO Funcionario VALUES (1,'Binho','Mechans','mecanico',1),(2,'Josehp','Souza cruz','mecanico',2),(3,'Zezinho','PAL','mecanico',1),(4,'zelao','ABC','mecanico',2);

DROP TABLE IF EXISTS Ordem_servico;

CREATE TABLE Ordem_servico (
  idOrdem_Servico int NOT NULL AUTO_INCREMENT,
  DataEmissao datetime NOT NULL,
  DataConclusao datetime NOT NULL,
  Status enum('Aguardando','Aprovado','Reprovada') NOT NULL DEFAULT 'Aguardando',
  IdCarro int NOT NULL,
  IdEquipe int DEFAULT NULL,
  PRIMARY KEY (idOrdem_Servico),
  KEY IdCarro_id (IdCarro),
  KEY IdEquipe_id (IdEquipe),
  CONSTRAINT IdCarro FOREIGN KEY (IdCarro) REFERENCES carro(idCarro),
  CONSTRAINT IdEquipe FOREIGN KEY (IdEquipe) REFERENCES equipe (idEquipe)
) ;



INSERT INTO Ordem_servico VALUES (2,'2022-09-23 00:00:00','2022-09-25 00:00:00','Aguardando',1,1),(3,'2022-09-23 00:00:00','2022-09-25 00:00:00','Aguardando',2,2);

DROP TABLE IF EXISTS Pecas;

CREATE TABLE Pecas (
  idPecas int NOT NULL AUTO_INCREMENT,
  Descricao varchar(45) NOT NULL,
  Valor float NOT NULL,
  PRIMARY KEY (idPecas)
) ;

INSERT INTO Pecas VALUES (1,'Pneu',90),(2,'Oleo',25);

DROP TABLE IF EXISTS pecasUtilizadas;

CREATE TABLE pecasUtilizadas (
  idPecasUtilizadas int NOT NULL AUTO_INCREMENT,
  Qtd varchar(45) NOT NULL DEFAULT '1',
  IdPecas int DEFAULT NULL,
  IdOS int DEFAULT NULL,
  PRIMARY KEY (idPecasUtilizadas),
  KEY IdPecas_id (IdPecas),
  KEY IdOS_id (`IdOS`),
  CONSTRAINT IdOS FOREIGN KEY (IdOS) REFERENCES ordem_servico (idOrdem_Servico),
  CONSTRAINT IdPecas FOREIGN KEY (IdPecas) REFERENCES pecas (idPecas)
) ;

INSERT INTO pecasUtilizadas VALUES (3,'4',1,2),(4,'2',2,3);

DROP TABLE IF EXISTS servicoRealizado;

CREATE TABLE servicoRealizado (
  idServicoRealizado int NOT NULL AUTO_INCREMENT,
  IdServico int NOT NULL,
  IdOS int NOT NULL,
  PRIMARY KEY (idServicoRealizado),
  KEY IdServico_id (IdServico),
  KEY IdOSs_id (IdOS),
  CONSTRAINT IdOSs FOREIGN KEY (IdOS) REFERENCES servicos (idServicos),
  CONSTRAINT IdServico FOREIGN KEY (IdServico) REFERENCES servicos (idServicos)
) ;

INSERT INTO servicoRealizado VALUES (1,1,1),(2,2,2);

DROP TABLE IF EXISTS Servicos;

CREATE TABLE Servicos (
  idServicos int NOT NULL AUTO_INCREMENT,
  Descricao varchar(45) NOT NULL,
  Valor float NOT NULL,
  PRIMARY KEY (idServicos)
) ;

INSERT INTO Servicos VALUES (1,'Troca Pneu',100),(2,'Troca Oleo',50);


