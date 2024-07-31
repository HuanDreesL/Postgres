CREATE TABLE CLIENTE(
	id 					SERIAL PRIMARY KEY,
	nome 				VARCHAR(45),
	endereco 			VARCHAR(100),
	id_cidade			INT,
	
	FOREIGN KEY (id_cidade) REFERENCES CIDADE(id)
);

CREATE TABLE CONTA_CORRENTE(
	id 					SERIAL PRIMARY KEY,
	numero				INT,
	saldo 				FLOAT,
	id_cliente			INT,
	id_agencia 			INT,
	
	FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id),
	FOREIGN KEY (id_agencia) REFERENCES AGENCIA(id)
);

CREATE TABLE MOVIMENTACOES(
	id					SERIAL PRIMARY KEY,
	tipo 				VARCHAR(11),
	valor 				FLOAT,
	data_movimentacao 	DATE,
	numero_conta		INT
);

CREATE TABLE AGENCIA(
	id 					SERIAL PRIMARY KEY,
	nome 				VARCHAR(45),
	endereco			VARCHAR(100),
	id_cidade			INT,
	
	FOREIGN KEY (id_cidade) REFERENCES CIDADE(id)
);

CREATE TABLE CIDADE(
	id					SERIAL PRIMARY KEY,
	nome				VARCHAR(45),
	id_estado			INT,
	
	FOREIGN KEY (id_estado) REFERENCES ESTADO(id)
);

CREATE TABLE ESTADO(
	id		SERIAL PRIMARY KEY,
	nome	VARCHAR(45),
	sigla	VARCHAR(3)
);
