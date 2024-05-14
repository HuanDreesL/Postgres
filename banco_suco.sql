CREATE TABLE tabela_de_clientes
(
	CPF 						VARCHAR (11) PRIMARY KEY,
	nome 						VARCHAR	(100),
	endereco_1 					VARCHAR	(150),
	endereco_2 					VARCHAR	(150),
	bairro 						VARCHAR (50),
	cidade 						VARCHAR (50),
	estado 						VARCHAR (50),
	cep 						VARCHAR (10),
	data_de_nascimento 			DATE,
	idade 						INT,
	sexo 						VARCHAR	(1),
	limite_de_credito 			FLOAT,
	volume_de_compra			FLOAT,
	primeira_compra 			VARCHAR	(1),
	total_pedidos_realizados	INT
);

INSERT INTO tabela_de_clientes (CPF, nome, endereco_1, endereco_2, bairro, cidade, estado, 
								cep, data_de_nascimento, idade, sexo, limite_de_credito, volume_de_compra,
							   primeira_compra, total_pedidos_realizados)
VALUES 	('13426537931','Huandres', 'Rua das Camelias', 'João Valdir de Borges', 'Di Fiori', 'Guatambu', 'Santa Catarina','89871-000', '2005-06-13', 18, 'M', 5000.0, 5.0, 'S', 5),
	   	('98765456789','Rafael', 'Rua das Bromelias', 'GreenVille', 'Centro', 'Chapéco', 'Santa Catarina', '98765-000', '2004-07-23', 24, 'M', 5000.0, 5.0, 'N', 10),
		('98765432100', 'Maria Silva', 'Avenida Paulista, 1234', 'Apto 101', 'Bela Vista', 'São Paulo', 'São Paulo','01310-100', '1985-04-25', 39, 'F', 15000.0, 1200.0, 'N', 20);					  

CREATE TABLE tabela_de_vendedores
(
	matricula 					INT PRIMARY KEY,
	nome 						VARCHAR	(100),
	porcentual_comissao			FLOAT,
	data_admissao				DATE,
	de_ferias					VARCHAR	(3),
	endereco 					VARCHAR	(100)
);

INSERT INTO tabela_de_vendedores (matricula, nome, porcentual_comissao, data_admissao, de_ferias, endereco)
VALUES 	(234, 'Diego', 2.5, '2023-06-25', 'Sim', 'Rua Greenvile'),

INSERT INTO tabela_de_vendedores (matricula, nome, porcentual_comissao, data_admissao, de_ferias, endereco)
VALUES (1001, 'João Pereira', 10.5, '2019-02-15', 'Não', 'Rua das Flores, 123');

INSERT INTO tabela_de_vendedores (matricula, nome, porcentual_comissao, data_admissao, de_ferias, endereco)
VALUES (1002, 'Ana Costa', 8.0, '2020-08-01', 'Sim', 'Avenida Central, 456');

CREATE TABLE tabela_de_produtos
(
	codigo_do_produto 			INT PRIMARY KEY,
	nome_do_produto 			VARCHAR (50),
	embalagem 					VARCHAR (20),
	tamanho 					VARCHAR (20),
	sabor 						VARCHAR (20),
	preco_de_lista 				FLOAT,
	quantidade_estoque 			INT
);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (402, 'Suco de Limão', 'Verde', '5 CM', 'Limão', 2.5, 500);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (101, 'Refrigerante Cola', 'Garrafa', '2L', 'Cola', 7.50, 150);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (102, 'Suco de Laranja', 'Caixa', '1L', 'Laranja', 4.25, 200);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (103, 'Biscoito Chocolate', 'Pacote', '200g', 'Chocolate', 3.00, 300);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (104, 'Chá Verde', 'Lata', '330ml', 'Verde', 2.50, 120);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (105, 'Água Mineral', 'Garrafa', '500ml', 'Sem gás', 1.00, 500);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (106, 'Chocolate ao Leite', 'Barra', '100g', 'Leite', 5.00, 250);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (107, 'Batata Chips', 'Pacote', '150g', 'Salgada', 3.50, 180);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (108, 'Iogurte Natural', 'Pote', '200g', 'Natural', 2.00, 220);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (109, 'Molho de Tomate', 'Garrafa', '340g', 'Tomate', 3.75, 130);

INSERT INTO tabela_de_produtos (codigo_do_produto, nome_do_produto, embalagem, tamanho, sabor, preco_de_lista, quantidade_estoque)
VALUES (110, 'Sorvete de Morango', 'Pote', '500ml', 'Morango', 8.00, 100);

CREATE TABLE notas_fiscais
(
	numero 						INT PRIMARY KEY,
	data_venda					DATE,
	imposto						FLOAT,
	CPF							VARCHAR (11),
	matricula					INT,
	
	FOREIGN KEY (CPF) 			REFERENCES 	tabela_de_clientes(CPF),
	FOREIGN KEY (matricula) 	REFERENCES 	tabela_de_vendedores(matricula)
);

CREATE TABLE itens_notas_fiscais
(
	numero 						INT,
	codigo_do_produto			INT,
	quantidade					INT,
	preco						FLOAT,
	
	FOREIGN KEY (numero) 			REFERENCES notas_fiscais(numero),
	FOREIGN KEY (codigo_do_produto) REFERENCES tabela_de_produtos(codigo_do_produto)
);
