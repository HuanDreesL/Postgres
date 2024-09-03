-------------------FUNCÃO1-------------------
CREATE FUNCTION olaMundo() RETURNS varchar AS
$$
DECLARE msg VARCHAR(60) := 'TESTE';
DECLARE msg1 VARCHAR(60) := 'TESTE2';

BEGIN
	RETURN msg1 || msg;
END;
$$
LANGUAGE PLPGSQL;
----------------APAGAR FUNÇÃO---------------
DROP FUNCTION olaMundo();
----------------RODAR FUNÇÃO---------------
SELECT olaMundo();

-------------------FUNCÃO2-------------------
CREATE FUNCTION saudacao(nome TEXT) 
RETURNS TEXT AS $$
BEGIN
	RETURN 'Olá ' || nome || '!';
END;
$$ LANGUAGE PLPGSQL;
----------------APAGAR FUNÇÃO---------------
DROP FUNCTION saudacao();
----------------RODAR FUNÇÃO---------------
SELECT saudacao('Huandres');

-------------------FUNCÃO3-------------------
CREATE FUNCTION somar(n1 float, n2 float) 
RETURNS float AS $$
DECLARE total float(10);
BEGIN
	total := n1 + n2;
	RETURN total;
END;
$$
LANGUAGE PLPGSQL;
----------------APAGAR FUNÇÃO---------------
DROP FUNCTION somar();
----------------RODAR FUNÇÃO---------------
SELECT somar(25, 25);

-------------------FUNCÃO4-------------------
CREATE FUNCTION validarSaldo(saldo float) 
RETURNS text AS
$$
BEGIN
	IF saldo < 5000 THEN
		RETURN 'Valor Baixo';
	ELSIF saldo < 6000 THEN
		RETURN 'Valor Bom';
	ELSE
		RETURN 'Sem Paramentro';
	END IF;
END;
$$
LANGUAGE PLPGSQL;
----------------RODAR FUNÇÃO---------------
SELECT numero, validarSaldo(5000) FROM contacorrente;

-------------------FUNCÃO5-------------------
CREATE FUNCTION imc(altura float, peso float) 
RETURNS text AS
$$
DECLARE imc FLOAT(10);
BEGIN
	imc :=  peso / (altura * altura);
	RETURN imc;
END;
$$
LANGUAGE PLPGSQL;
----------------RODAR FUNÇÃO---------------
SELECT imc(1.85, 86);
----------------APAGAR FUNÇÃO---------------
DROP FUNCTION imc(altura float, peso float);

-------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION exibir_tabuada2(num INTEGER)
RETURNS TABLE(numero INTEGER, multiplicador INTEGER, resultado INTEGER) AS $$
BEGIN
    -- Cria uma tabela temporária para armazenar a tabuada
    CREATE TEMP TABLE temp_tabuada (
        numero INTEGER,
        multiplicador INTEGER,
        resultado INTEGER
    ) ON COMMIT DROP;
    -- Loop para calcular e armazenar a tabuada na tabela temporária
    FOR i IN 1..10 LOOP
        INSERT INTO temp_tabuada (numero, multiplicador, resultado)
        VALUES (num, i, num * i);
    END LOOP;
    -- Retorna o conteúdo da tabela temporária
    RETURN QUERY
    SELECT * FROM temp_tabuada;
END;
$$ LANGUAGE plpgsql;

SELECT *FROM exibir_tabuada2(2);


-- 1-Crie uma função que receba um nome como parâmetro e retorne uma saudação personalizada.

CREATE FUNCTION saudacao(mensagem VARCHAR) RETURNS TEXT
AS $$
BEGIN 
	RETURN mensagem;
END;
$$ LANGUAGE PLPGSQL;

-- 2-Crie uma função que aceite dois números inteiros e retorne a soma deles.

CREATE FUNCTION somar(n1 FLOAT, n2 FLOAT) RETURNS float AS
$$
BEGIN
	RETURN n1 + n2;
END;
$$
LANGUAGE PLPGSQL;

SELECT *FROM somar(10, 10);

-- 3-Crie uma função que calcule o imposto sobre um valor dado. Suponha que a alíquota do
-- imposto seja 15%.

CREATE FUNCTION imposto(valor FLOAT) RETURNS float AS
$$
DECLARE taxa FLOAT(10) := 0.15;
DECLARE valorTaxado FLOAT(10);
BEGIN
	valorTaxado := valor * taxa;
	RETURN valor + valorTaxado;
END;
$$
LANGUAGE PLPGSQL;

SELECT *FROM imposto(10);

-- 4-Crie uma função que calcule a média de três notas.

CREATE FUNCTION media(n1 FLOAT, n2 FLOAT, n3 FLOAT) RETURNS float AS
$$
DECLARE media FLOAT(10);
BEGIN
	media := (n1 + n2 + n3) / 3;
	RETURN media;
END;
$$
LANGUAGE PLPGSQL;

SELECT *FROM media(10, 20, 30);

-- 5-Crie uma função que receba rua, número e cidade e retorne um endereço completo.

CREATE FUNCTION endereco(rua TEXT, numero INTEGER, cidade TEXT) RETURNS text AS
$$
BEGIN
	RETURN rua || numero || cidade;
END;
$$
LANGUAGE PLPGSQL;

SELECT * FROM endereco('Rua das Camélias', 521, 'Guatambu');

DROP FUNCTION endereco(rua TEXT, numero INTEGER, cidade TEXT);

-- 6-Crie uma função que converta uma temperatura de Celsius para Fahrenheit.

CREATE FUNCTION temperatura(temperatura FLOAT) RETURNS float AS
$$
DECLARE valor FLOAT(10);
BEGIN
	valor = (temperatura * 9/5) + 32;
	RETURN valor;
END;
$$
LANGUAGE PLPGSQL;

SELECT *FROM temperatura(10);
	
-- 7-Crie uma função que verifique se um número é par ou ímpar

CREATE FUNCTION verificar(numero INTEGER) RETURNS text AS
$$
DECLARE resto FLOAT(10);
BEGIN
	resto := numero % 2;
	IF resto = 0 THEN
		RETURN 'É par';
	ELSE
		RETURN 'É impar';
	END IF;
END;
$$
LANGUAGE PLPGSQL;

SELECT * FROM verificar(11);

-- 8-Crie uma função que busque registros em uma tabela com base em um critério de
-- pesquisa (por exemplo, nome no where) e retorne os resultados.

CREATE OR REPLACE FUNCTION buscar_por_nome (nomeParam TEXT) 
RETURNS TABLE (idCliente INT, nome VARCHAR(100)) AS $$
BEGIN 
	RETURN QUERY
	SELECT c.idCliente, c.nome
	FROM cliente c
	WHERE c.nome ILIKE '%' || nomeParam || '%';
END;
$$
LANGUAGE PLPGSQL;

SELECT *FROM buscar_por_nome('João da Silva');

CREATE OR REPLACE FUNCTION buscar_por_id(idParam INT)
RETURNS TABLE(idCliente INT, nome VARCHAR(100), cidade VARCHAR(100)) AS $$
BEGIN 
	RETURN QUERY 
	SELECT c.idCliente, c.nome, cidade.nome
	FROM cliente c
	INNER JOIN
	cidade
	ON
	cidade.idcidade = c.idCidade
	WHERE
	idParam = c.idCidade;
END;
$$
LANGUAGE PLPGSQL;

select *from buscar_por_id(12);

-- 1-Crie uma função que atualize o saldo de uma conta corrente com
-- base no número da conta e o novo valor do saldo.

CREATE OR REPLACE FUNCTION atualizar_saldo (p_numero_conta VARCHAR, p_novo_saldo FLOAT)
RETURNS VOID AS $$
BEGIN 
	UPDATE contaCorrente 
	SET saldo = p_novo_saldo
	WHERE numero = p_numero_conta;
END;
$$ LANGUAGE PLPGSQL;

SELECT atualizar_saldo('1234567890', 1499);

-- 2-Crie uma função que exclua um cliente e todas as contas correntes
-- associadas a esse cliente. Isso deve incluir a exclusão de movimentos
-- associados às contas correntes do cliente.

CREATE OR REPLACE FUNCTION excluir_cliente (p_id_cliente INT)
RETURNS VOID AS $$
BEGIN

	DELETE FROM movimentacao
	WHERE idcontaCorrente IN (
		SELECT id
		FROM contaCorrente
		WHERE idcliente = p_id_cliente
	);
	
	DELETE FROM contaCorrente
	WHERE idcliente = p_id_cliente;
	
	DELETE FROM cliente
	WHERE idCliente = p_id_cliente;
	
END;
$$ LANGUAGE PLPGSQL;

SELECT excluir_cliente(1);

-- 3-Função para Atualizar o Endereço de uma Agência.
CREATE OR REPLACE FUNCTION atualizar_endereco(
	p_id_agencia INT,
	p_rua VARCHAR(255),
	p_numero VARCHAR(10),
	p_complemente VARCHAR(100),
	p_bairro VARCHAR(100),
	p_cep VARCHAR(10),
	p_id_cidade INTEGER
) 
RETURNS VOID AS $$
BEGIN 
	UPDATE agencia
	SET 
	rua = p_rua,
	numero = p_numero,
	complemento = p_complemente,
	bairro = p_bairro,
	cep = p_cep,
	idcidade = p_id_cidade
	WHERE idagencia = p_id_agencia;
END;
$$ LANGUAGE PLPGSQL;
	
SELECT atualizar_endereco(1, 'Paulista Avenida', '0001', '101 Sala', 'Vista Bela', '000-01310', 2);

-- 4- Função para Listar Movimentações de uma Conta Corrente com
-- Detalhes do Cliente.

	


