CREATE TABLE agencia (
	ID 						SERIAL PRIMARY KEY,
	NOME 					VARCHAR(50),
	ENDERECO 				VARCHAR(100),
	CNPJ 					VARCHAR(14)

);

CREATE TABLE conta_corrente (
	ID 						SERIAL PRIMARY KEY,
	NUMERO 					INT,
	SALDO 					FLOAT,
	ID_AGENCIA 				INT,
	ID_CLIENTE				INT,
	
	FOREIGN KEY (ID_AGENCIA) REFERENCES agencia(ID),
	FOREIGN KEY (ID_CLIENTE) REFERENCES cliente(ID)
	
);

CREATE TABLE cliente (
	ID 					SERIAL PRIMARY KEY,
	NOME 				VARCHAR(50),
	CPF 				VARCHAR(11)
);

CREATE TABLE movimentacoes (
	ID 					SERIAL PRIMARY KEY,
	VALOR 				FLOAT,
	DATA_HORA			DATE,
	TIPO 				VARCHAR(11),
	ID_CONTA_CORRENTE 	INT,
	
	FOREIGN KEY (ID_CONTA_CORRENTE) REFERENCES conta_corrente(ID)
);

INSERT INTO cliente (ID, NOME, CPF)
	VALUES
	(1, 'Huandres Schmidt', '13426537931'),
	(2, 'João Souza', '23456789012'),
	(3, 'Ana Pereira', '34567890123'),
	(4, 'Carlos Santos', '45678901234'),
	(5, 'Beatriz Lima', '56789012345'),
	(6, 'Pedro Alves', '67890123456'),
	(7, 'Fernanda Costa', '78901234567'),
	(8, 'Ricardo Ferreira', '89012345678'),
	(9, 'Julia Oliveira', '90123456789'),
	(10, 'Marcos Ribeiro', '01234567890');
	
INSERT INTO conta_corrente (ID, NUMERO, SALDO, ID_AGENCIA, ID_CLIENTE)
	VALUES
	(1, 123, 250000, 1, 1),
	(2, 124, 350000, 1, 2),
	(3, 125, 150000, 1, 3),
	(4, 126, 450000, 1, 4),
	(5, 127, 250000, 2, 5),
	(6, 128, 550000, 2, 6),
	(7, 129, 650000, 2, 7),
	(8, 130, 750000, 2, 8),
	(9, 131, 85000, 1, 9),
	(10, 132, 950000, 1, 10);
	
INSERT INTO agencia (ID, NOME, ENDERECO, CNPJ)
	VALUES
	(1, 'Agência Centro', 'Rua das Flores, 123, Centro, São Paulo, SP', '12345678000101'),
	(2, 'Agência Norte', 'Avenida Paulista, 456, Norte, São Paulo, SP', '23456789000102');
	
INSERT INTO movimentacoes (ID, VALOR, DATA_HORA, TIPO, ID_CONTA_CORRENTE)
	VALUES
	(1, 250, '17/06/2024', 'PIX', 1),
	(2, 300, '17/06/2024', 'TED', 2),
	(3, 450, '17/06/2024', 'DOC', 3),
	(4, 500, '17/06/2024', 'PIX', 4),
	(5, 750, '17/06/2024', 'TED', 5),
	(6, 100, '17/06/2024', 'DOC', 6),
	(7, 200, '17/06/2024', 'PIX', 7),
	(8, 350, '17/06/2024', 'TED', 8),
	(9, 400, '17/06/2024', 'DOC', 9),
	(10, 600, '17/06/2024', 'PIX', 10);

SELECT *FROM cliente;

SELECT *FROM cliente WHERE nome LIKE '%A%';

UPDATE cliente SET NOME = 'Rafael' WHERE ID = 1;

UPDATE movimentacoes SET VALOR = 500 WHERE ID = 1;

SELECT * FROM conta_corrente
ORDER BY ID DESC;

SELECT * FROM conta_corrente
ORDER BY ID;

SELECT * FROM movimentacoes WHERE valor > 20;

SELECT * FROM movimentacoes WHERE valor <= 10;

SELECT * FROM cliente WHERE NOME LIKE '%C%';



