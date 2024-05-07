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
UPDATE Cliente set id = 3 where id = 5;
		
/* Criando tabela conta corrente que irá referenciar o id da agencia e do cliente*/
CREATE TABLE ContaCorrente (
	id SERIAL PRIMARY KEY,
	numero_conta INT NOT NULL,
	saldo DECIMAL(12, 2) NOT NULL,
	agencia_id INT,
	cliente_id INT,
	
	FOREIGN KEY (agencia_id) REFERENCES Agencia(id),
	FOREIGN KEY (cliente_id) REFERENCES Cliente(id)
);

INSERT INTO ContaCorrente (numero_conta, saldo, agencia_id, cliente_id)
VALUES	(1001, 5000.00, 3, 2);

SELECT nome, saldo from ContaCorrente
JOIN cliente on ContaCorrente.cliente_id = cliente.id;

CREATE TABLE Movimentacoes (
	id SERIAL PRIMARY KEY,
	tipo varchar (12),
	valor DECIMAL(12, 2),
	horaeData varchar(68),
	movimentacao_id INT NOT NULL,
	
	FOREIGN KEY (movimentacao_id) REFERENCES ContaCorrente(id)
);

INSERT INTO Movimentacoes (tipo, valor, horaeData, movimentacao_id)
VALUES
		('PIX', 350.00, '06/05/2024 21 50', 1);

select * from Movimentacoes


						  

