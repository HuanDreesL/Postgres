CREATE TABLE cliente(
	idCliente 	SERIAL PRIMARY KEY,
	nome 		VARCHAR(45),
	cidade		VARCHAR(45)
);

INSERT INTO cliente (idCliente, nome, cidade) 
	VALUES (2, 'Rafael', 'Chapecó'),(3, 'Jorge', 'Xaxim');
	
UPDATE cliente SET nome = 'Dominic' WHERE idCliente = 1;

DELETE FROM cliente WHERE idCliente = 1;

SELECT *FROM cliente WHERE nome = 'Rafael';

-- NOVO EXERCICIO

CREATE TABLE movimentacoes(
	id 					SERIAL PRIMARY KEY,
	tipo				VARCHAR(45),
	valor				FLOAT,
	dataMovimentacao 	DATE,
	
	id_contaCorrente 	INT
);

CREATE TABLE cliente2(
	idCliente2 			SERIAL PRIMARY KEY,
	nome				VARCHAR(45),
	cidade				VARCHAR(45)
);

INSERT INTO cliente2(idCliente2, nome, cidade)
	VALUES(1, 'John Doe', 'Chapecó'),
		  (2, 'Jane Smith', 'Urubici'),
		  (3, 'Bob Brown', 'Gramado');

CREATE TABLE pedido(
	id SERIAL PRIMARY KEY,
	idCliente	INT,
	dataPedido	DATE,
	valor		FLOAT,
	
	FOREIGN KEY (idCliente) REFERENCES cliente2(idCliente2)
);

INSERT INTO pedido(
	VALUES(1001, 1, '2024-01-15', 500),
		  (1002, 2, '2024-01-16', 300),
		  (1003, 3, '2024-01-17', 700),
	      (1004, 1, '2024-01-17', 250)
);

SELECT *FROM pedido WHERE idCliente IN(
	SELECT idCliente2 FROM cliente2 WHERE cidade = 'Chapecó')
)
