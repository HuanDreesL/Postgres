CRIAÇÃO DAS TABELAS 
CREATE TABLE biblioteca(
		ID 			INT PRIMARY KEY,
		NOME 		VARCHAR(45),
		ENDERECO 	VARCHAR(45)
);

CREATE TABLE usuario(
	ID 				INT PRIMARY KEY,
	NOME 			VARCHAR(45),
	ENDERECO 		VARCHAR(100),
	CPF				VARCHAR(45),
	TELEFONE 		VARCHAR(30)
);

CREATE TABLE livros(
	ID				INT PRIMARY KEY,
	titulo 			VARCHAR(45),
	autor			VARCHAR(45),
	ano_publicacao	INT,
	genero			VARCHAR(45),
	id_biblioteca 	INT,
	id_emprestimo	INT,

	FOREIGN KEY (id_biblioteca) REFERENCES biblioteca(ID),
	FOREIGN KEY (id_emprestimo) REFERENCES biblioteca(ID)
);

CREATE TABLE emprestimo(
	ID 				INT PRIMARY KEY,
	status 			VARCHAR(45),
	data_emprestimo VARCHAR(45),
	data_devolucao 	VARCHAR(45),
	id_usuario 		INT,

	FOREIGN KEY (id_usuario) REFERENCES usuario(ID)
);
