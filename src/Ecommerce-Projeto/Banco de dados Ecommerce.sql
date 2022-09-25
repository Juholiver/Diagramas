DROP TABLE IF EXISTS clients;

CREATE TABLE clients (
  idCliente int NOT NULL AUTO_INCREMENT,
  Minit char(3) DEFAULT NULL,
  CEP int NOT NULL,
  PRIMARY KEY (idClients),
  KEY CEP_idx (CEP),
  CONSTRAINT CEP FOREIGN KEY (CEP) REFERENCES endereco (CEP)
) ;


INSERT INTO clients Values(1,NULL,23061220),(2,NULL,23063200);

DROP TABLE IF EXISTS cliente_fisico;

CREATE TABLE cliente_fisico (
  idCliente_Fisico int NOT NULL AUTO_INCREMENT,
  CPF varchar(45) NOT NULL,
  Pnome varchar(45) NOT NULL,
  Unome varchar(45) NOT NULL,
  IdCliente int NOT NULL,
  PRIMARY KEY (idCliente_Fisico),
  UNIQUE KEY CPF_UNIQUE (CPF),
  KEY IdCliente_idx (IdCliente),
  CONSTRAINT IdClienteFis FOREIGN KEY (IdCliente) REFERENCES cliente (idCliente)
) ;

INSERT INTO cliente_fisico VALUES (1,'1111111111','Jose','Mario',1);

DROP TABLE IF EXISTS cliente_juridico;

CREATE TABLE cliente_juridico (
  idCliente_Juridico int NOT NULL AUTO_INCREMENT,
  CNPJ varchar(45) NOT NULL,
  Razao_Social varchar(45) DEFAULT NULL,
  IdCliente int NOT NULL,
  PRIMARY KEY (idCliente_Juridico),
  UNIQUE KEY CNPJ_UNIQUE (CNPJ),
  KEY IdCliente_idx (IdCliente),
  CONSTRAINT IdClienteJus FOREIGN KEY (IdCliente) REFERENCES cliente (idCliente) ON DELETE CASCADE ON UPDATE CASCADE
) ;

INSERT INTO cliente_juridico VALUES (1,'111111111111','JOse Mario',2);

DROP TABLE IF EXISTS endereco;

CREATE TABLE endereco (
  CEP int NOT NULL,
  Valor_Frete float NOT NULL,
  PRIMARY KEY (CEP)
) ;

INSERT INTO endereco VALUES (23061220,20),(23063200,50);

DROP TABLE IF EXISTS entrega;

CREATE TABLE entrega (
  idEntrega int NOT NULL AUTO_INCREMENT,
  StatusEntrega enum('Aguardando Envio','Enviado','Entregue','Não Recebido') NOT NULL DEFAULT 'Aguardando Envio',
  Codigo_Rastreio varchar(45) DEFAULT NULL,
  IdPedido int NOT NULL,
  PRIMARY KEY (idEntrega),
  KEY idPedido_idx (IdPedido),
  CONSTRAINT idPedido FOREIGN KEY (IdPedido) REFERENCES pedido (IdPedido)
) ;

INSERT INTO entrega VALUES (1,'Enviado','QWER15233',1),(2,'Aguardando Envio',NULL,2);

DROP TABLE IF EXISTS estoque;

CREATE TABLE estoque (
  idEstoque int NOT NULL AUTO_INCREMENT,
  Localizacao varchar(45) NOT NULL,
  PRIMARY KEY (idEstoque)
) ;

INSERT INTO estoque VALUES (1,'Itape'),(2,'Sorocaba'),(3,'São paulo');

DROP TABLE IF EXISTS formapagamento;

CREATE TABLE formaPagamento (
  idFormaPagamento int NOT NULL AUTO_INCREMENT,
  Descricao varchar(45) NOT NULL,
  PRIMARY KEY (idFormaPagamento)
) ;

INSERT INTO formaPagamento VALUES (1,'Cartao'),(2,'Boleto'),(3,'Dinheiro');

DROP TABLE IF EXISTS fornecedor;

CREATE TABLE fornecedor (
  idFornecedor int NOT NULL AUTO_INCREMENT,
  Razao_Social varchar(45) NOT NULL,
  CNPJ varchar(45) NOT NULL,
  Contato char(11) NOT NULL,
  PRIMARY KEY (idFornecedor),
  UNIQUE KEY CNPJ_UNIQUE (CNPJ)
) ;

INSERT INTO fornecedor VALUES (1,'Shopping','11111121111121','111111111'),(2,'Loja','22212222122221','241253489');

DROP TABLE IF EXISTS fornecedordeProtudo;

CREATE TABLE fornecedordeProtudo(
  idFornecimento int NOT NULL AUTO_INCREMENT,
  IdFornecedor int NOT NULL,
  IdProduto int NOT NULL,
  PRIMARY KEY (idFornecimento),
  KEY IdFornecedor_idx (IdFornecedor),
  KEY IdProduto_idx (IdProduto),
  CONSTRAINT IdFornecedor FOREIGN KEY (IdFornecedor) REFERENCES Fornecedor (idFornecedor),
  CONSTRAINT IdProdutos FOREIGN KEY (IdProduto) REFERENCES produto (Idproduto)
) ;

INSERT INTO fornecedordeProtudo VALUES (1,1,2),(2,2,3);

DROP TABLE IF EXISTS itens_pedido;

CREATE TABLE itens_pedido (
  IdItem_Pedido int NOT NULL AUTO_INCREMENT,
  IdPedido int NOT NULL,
  IdProduto int NOT NULL,
  Qtd int NOT NULL DEFAULT '1',
  PRIMARY KEY (IdItem_Pedido),
  KEY IdPedido_idx (IdPedido),
  KEY IdProduto_idx (IdProduto),
  CONSTRAINT IdPedidos FOREIGN KEY (IdPedido) REFERENCES pedido (`IdPedido`),
  CONSTRAINT IdProduto FOREIGN KEY (IdProduto) REFERENCES produto(Idproduto)
) ;

INSERT INTO itens_pedido VALUES (1,1,2,5),(2,2,3,2);

DROP TABLE IF EXISTS pedido;

CREATE TABLE pedido (
  IdPedido int NOT NULL AUTO_INCREMENT,
  Descricao varchar(45) NOT NULL,
  Status_Pedido enum('Cancelado','Confirmado','Em Processamento') NOT NULL,
  IdCliente int NOT NULL,
  IdPgto int NOT NULL,
  PRIMARY KEY (IdPedido),
  KEY IdCliente_idx (IdCliente),
  KEY IdPgto_idx (IdPgto),
  CONSTRAINT IdCliente FOREIGN KEY (IdCliente) REFERENCES cliente (idCliente) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT IdPgto FOREIGN KEY (IdPgto) REFERENCES formapagamento (idFormaPagamento)
) ;

INSERT INTO pedido VALUES (1,'Pedido 1','Confirmado',1,1),(2,'Pedido 2','Confirmado',2,2);

DROP TABLE IF EXISTS produto;

CREATE TABLE produto (
  Idproduto int NOT NULL AUTO_INCREMENT,
  Pnome varchar(45) NOT NULL,
  Classificacao_infantil tinyint DEFAULT '0',
  Categoria enum('Eletronico','Vestimenta','Brinquedos','Alimentos','Moveis') NOT NULL,
  Avaliacao float DEFAULT '0',
  Tamanho varchar(10) DEFAULT NULL,
  PRIMARY KEY (Idproduto)
);

INSERT INTO produto VALUES (2,'Camiseta',1,'Vestimenta',4,'10'),(3,'Headset',0,'Eletronico',10,NULL);

DROP TABLE IF EXISTS qtd_estoque;

CREATE TABLE qtd_estoque (
  idQtd_Estoque int NOT NULL AUTO_INCREMENT,
  Qtd int NOT NULL,
  IdProduto int NOT NULL,
  IdEstoque int NOT NULL,
  PRIMARY KEY (idQtd_Estoque),
  KEY IdProduto_idx (IdProduto),
  KEY IdEstoque_idx (IdEstoque),
  CONSTRAINT IdEstoque FOREIGN KEY (IdEstoque) REFERENCES estoque (idEstoque) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT IdProds FOREIGN KEY (IdProduto) REFERENCES produto (Idproduto) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO qtd_estoque VALUES (5,50,2,2),(6,20,3,1),(7,10,3,3);

DROP TABLE IF EXISTS terceiros;

CREATE TABLE terceiros (
  idTerceiro int NOT NULL AUTO_INCREMENT,
  Razao_Social varchar(45) NOT NULL,
  Local varchar(45) NOT NULL,
  PRIMARY KEY (idTerceiro),
  UNIQUE KEY Razao_Social_UNIQUE (Razao_Social)
);

INSERT INTO terceiros VALUES (1,'Terceiro 1','Rosa'),(2,'Terceiro 2','Madeira');

DROP TABLE IF EXISTS TerceiroProduct;

CREATE TABLE TerceiroProduct (
  idTerceiroProduct int NOT NULL AUTO_INCREMENT,
  IdTerceiro int NOT NULL,
  IdProduto int NOT NULL,
  Qtd int NOT NULL,
  PRIMARY KEY (idTerceiroProduct),
  KEY `IdTerceiro_idx` (IdTerceiro),
  KEY `IdProduto_idx` (IdProduto),
  CONSTRAINT IdProd FOREIGN KEY (IdProduto) REFERENCES produto (Idproduto) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT IdTerceiro FOREIGN KEY (IdTerceiro) REFERENCES terceiros (idTerceiro) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO idTerceiroProduct VALUES (1,1,2,50),(2,2,3,60);
