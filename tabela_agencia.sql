/* Criando Tabela de Agencia */
CREATE TABLE Agencia(
	id SERIAL PRIMARY KEY,
	numero INT,
	CNPJ varchar(16)
);

/* Criando Tabela de Agencia */
CREATE TABLE Cliente(
	id SERIAL PRIMARY KEY,
	nome varchar(68),
	CPF varchar(16)
);

/* Inserindo Clientes na tabela Clientes com nome e cpf */
INSERT INTO Cliente (nome, CPF) VALUES ('Huandres', '134.265.379-31');

/* Selecionando tabela Cliente */
SELECT * FROM Cliente

/* Inserindo agencia na tabela agencia com numero e cnpj */
INSERT INTO Agencia (numero, CNPJ) VALUES (640, '00000000/0001-91');

/* Selecionando a tabela agencia */
SELECT * FROM Agencia

/* Inserindo mais 4 clientes na tabela */
INSERT INTO Cliente (nome, CPF) VALUES ('Bruno', '123.356.488-22');
INSERT INTO Cliente (nome, CPF) VALUES ('Rafael', '245.376.487-42');
INSERT INTO Cliente (nome, CPF) VALUES ('Diego', '473.112.457-65');
INSERT INTO Cliente (nome, CPF) VALUES ('Gabriel', '532.146.219-21');

/* Inserindo mais 2 agencias, existe esse metodo de insert tambem */
INSERT INTO Agencia (numero, CNPJ) 
VALUES
		(540, '123456789'),
		(342, '987653212');
		
/* Selecionando tabela Cliente */
SELECT * FROM Cliente where id = 1;
SELECT * FROM Agencia where id = 1;

/* Deletando cliente apartir do id */
DELETE FROM Cliente Where id = 1;

/* Fazendo Update na tabela cliente e agencia mundando nome e numero */
UPDATE Cliente set nome = 'Huandres' where id = 3;
UPDATE Agencia set numero = 641 where id = 1;
		
		





