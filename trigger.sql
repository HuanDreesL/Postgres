--CREATE TRIGGER nome
--	{BEFORE | AFTER}
--	{EVENT-INSERT | UPDATE | DELETE} ON TABLE
--FROM TABELA
--FOR EACH {ROW | STATEMENT}
--EXECUTE PROCEDURE {FUNCTION | PROCEDURE} PARAMETROS

--PARAMETROS DO TIPO NEW | OLD


CREATE TABLE PRODUTOS
	(
		COD_PRODUTO		INT PRIMARY KEY,
		DESCRICAO		VARCHAR(60),
		QTDE_DISPO		INT NOT NULL DEFAULT 0
	);

INSERT INTO PRODUTOS VALUES (1, 'ARROZ', 10);
INSERT INTO PRODUTOS VALUES (2, 'CARNE', 10);
INSERT INTO PRODUTOS VALUES (3, 'FEIJÃO', 10);

CREATE TABLE ITENSVENDIDOS 
	(
		ID_VENDA		SERIAL PRIMARY KEY,
		COD_VENDA		INT,
		ID_PRODUTO		INT,
		QTDE_VENDIDA	INT,
		
		FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTOS(COD_PRODUTO) ON DELETE CASCADE
	);
	
INSERT INTO ITENSVENDIDOS VALUES (2, 2, 2, 5);

CREATE TRIGGER t_atualiza_estoque 
	BEFORE INSERT ON ITENSVENDIDOS
		FOR EACH ROW 
			EXECUTE PROCEDURE f_atualiza_estoque();
			
CREATE OR REPLACE FUNCTION f_atualiza_estoque() RETURNS TRIGGER 
	AS $$
		DECLARE QTD INT;
		BEGIN
			SELECT QTDE_DISPO INTO QTD 
			FROM PRODUTOS
			WHERE COD_PRODUTO = NEW.ID_PRODUTO;
		
		IF QTD < NEW.QTDE_VENDIDA THEN
			RAISE EXCEPTION 'A QUANTIDADE NÃO ESTÁ DISPONIVEL NO ESTOQUE';
		ELSE
			UPDATE PRODUTOS SET QTDE_DISPO = QTDE_DISPO - NEW.QTDE_VENDIDA
			WHERE COD_PRODUTO = NEW.ID_PRODUTO;
		END IF;
		RETURN NEW;
		
END $$ LANGUAGE PLPGSQL;

SELECT *FROM PRODUTOS

CREATE TRIGGER t_verificar_produto_existente
	BEFORE INSERT ON PRODUTOS
		FOR EACH ROW
			EXECUTE PROCEDURE f_verificar_produto();

CREATE OR REPLACE FUNCTION f_verificar_produto() RETURNS TRIGGER
	AS $$
		BEGIN
			IF COD_PRODUTO = NEW.ID_PRODUTO THEN
				RAISE EXCEPTION 'CÓDIGO DO PRODUTO JÁ EXISTENTE';
			ELSE
				INSERT INTO PRODUTOS VALUES(NEW.COD_PRODUTO, NEW.DESCRICAO, NEW.QTDE_DISPO);
		END IF;
		RETURN NEW;
		
END $$ LANGUAGE PLPGSQL;


