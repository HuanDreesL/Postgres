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

INSERINDO DADOS

INSERT INTO biblioteca (ID, NOME, ENDERECO)
	VALUES
	(1, 'Biblioteca Chapecó', 'Rua das Flores'),
	(2, 'Biblioteca Caxambu', 'Rua das Rosas'),
	(3, 'Biblioteca Xaxim', 'Rua do Sol'),
	(4, 'Biblioteca Guatambu', 'Rua dos Girassois'),
	(5, 'Biblioteca Palmitos', 'Rua dos Oreiudo');

INSERT INTO livros (ID, titulo, autor, ano_publicacao, genero, id_biblioteca, id_emprestimo) VALUES 
	(1, 'Dom Casmurro', 'Machado de Assis', 1899, 'Ficção', 1, NULL),
	(2, '1984', 'George Orwell', 1949, 'Ficção distópica', 1, NULL),
	(3, 'O Senhor dos Anéis', 'J.R.R. Tolkien', 1954, 'Fantasia', 2, NULL),
	(4, 'Harry Potter', 'J.K. Rowling', 1997, 'Fantasia', 2, NULL),
	(5, 'Cem Anos de Solidão', 'Gabriel García Márquez', 1967, 'Realismo mágico', 3, NULL),
	(6, 'A Culpa é das Estrelas', 'John Green', 2012, 'Romance', 4, NULL),
	(7, 'A Revolução dos Bichos', 'George Orwell', 1945, 'Fábula política', 5, NULL),
	(8, 'O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 1943, 'Fábula', 5, NULL),
	(9, 'Orgulho e Preconceito', 'Jane Austen', 1813, 'Romance', 3, NULL),
	(10, 'O Diário de Anne Frank', 'Anne Frank', 1947, 'Biografia', 2, NULL),
	(11, 'O Hobbit', 'J.R.R. Tolkien', 1937, 'Fantasia', 1, NULL),
	(12, 'Crime e Castigo', 'Fiódor Dostoiévski', 1866, 'Ficção psicológica', 5, NULL),
	(13, 'A Metamorfose', 'Franz Kafka', 1915, 'Ficção surrealista', 3, NULL),
	(14, 'As Crônicas de Nárnia', 'C.S. Lewis', 1950, 'Fantasia', 1, NULL),
	(15, 'O Alquimista', 'Paulo Coelho', 1988, 'Romance', 3, NULL),
	(16, 'Moby Dick', 'Herman Melville', 1851, 'Aventura', 4, NULL),
	(17, 'O Retrato de Dorian Gray', 'Oscar Wilde', 1890, 'Ficção gótica', 5, NULL),
	(18, 'A Guerra dos Tronos', 'George R.R. Martin', 1996, 'Fantasia épica', 3, NULL),
	(19, 'A Sangue Frio', 'Truman Capote', 1966, 'Não-ficção', 3, NULL),
	(20, 'Hamlet', 'William Shakespeare', 1603, 'Tragédia', 5, NULL);

INSERT INTO emprestimo (ID, STATUS, DATA_EMPRESTIMO, DATA_DEVOLUCAO, ID_USUARIO) VALUES
	
	(2, 'EMPRESTADO', '2023-07-01', '2023-07-08', NULL),
	(3, 'DEVOLVIDO', '2023-08-15', '2023-08-22', NULL),
	(4, 'EMPRESTADO', '2023-09-10', '2023-09-17', NULL),
	(5, 'EMPRESTADO', '2023-10-05', '2023-10-12', NULL),
	(6, 'DEVOLVIDO', '2023-11-20', '2023-11-27', NULL),
	(7, 'EMPRESTADO', '2023-12-03', '2023-12-10', NULL),
	(8, 'EMPRESTADO', '2024-01-15', '2024-01-22', NULL),
	(9, 'EMPRESTADO', '2024-02-08', '2024-02-15', NULL),
	(10, 'DEVOLVIDO', '2024-03-25', '2024-04-01', NULL);

INSERT INTO usuario (ID, NOME, ENDERECO, CPF, TELEFONE) VALUES
	(2, 'María López', 'Avenida Central 456', '987.654.321-00', '987-654-3210'),
	(3, 'Carlos Silva', 'Rua das Flores 789', '456.789.123-45', '456-789-1230'),
	(4, 'Ana Garcia', 'Praça da Paz 321', '321.654.987-00', '321-654-9870'),
	(5, 'Pedro Mendes', 'Rua dos Sonhos 987', '789.123.456-78', '789-123-4560'),
	(6, 'Sofía Martínez', 'Avenida dos Anjos 654', '234.567.890-12', '234-567-8901');


