-- EXEMPLO DE PROCEDURE

CREATE TABLE contas(
	id 		INT,
	nome	VARCHAR(100),
	saldo	DECIMAL
);

INSERT INTO contas(id, nome, saldo)
	VALUES
	(1, 'Jorge', 5000),
	(2, 'Marcelo', 2500),
	(3, 'Diego', 3500);
	
SELECT *FROM contas;

CREATE PROCEDURE transferencia
	(
		IN contaOrigem INT,
		IN contaDestino INT,
		IN valor DECIMAL
	)
LANGUAGE PLPGSQL
AS $$
BEGIN
	UPDATE contas SET saldo = saldo - valor
	WHERE id = contaOrigem;
	
	UPDATE contas SET saldo = saldo + valor
	WHERE id = contaDestino;
END $$;

CALL transferencia (1, 2, 500)

--------------------------------------------------

CREATE PROCEDURE transferencia_fundos 
	(
		IN p_id_conta_origem 	INT,
		IN p_id_conta_destino 	INT,
		IN p_valor 				DECIMAL
	)
LANGUAGE PLPGSQL
AS $$
BEGIN 
	IF p_valor <= 0
	THEN 
	RAISE EXCEPTION 'O VALOR DEVE SER POSITIVO';
	END IF;
	
	IF NOT EXISTS (
		SELECT * FROM contaCorrente
		WHERE id = p_id_conta_origem AND saldo >= p_valor
	) THEN
	RAISE EXCEPTION 'CONTA DE ORIGEM NÃO EXISTE OU SALDO INSUFICIENTE';
	END IF;
	
	INSERT INTO movimentacao(tipo, valor, datamovimentacao, idcontacorrente)
	VALUES
	('SAÍDA', p_valor, CURRENT_TIMESTAMP, p_id_conta_origem);
	
	INSERT INTO movimentacao(tipo, valor, datamovimentacao, idcontacorrente)
	VALUES
	('ENTRADA', p_valor, CURRENT_TIMESTAMP, p_id_conta_destino);
	
	UPDATE contacorrente SET saldo = saldo - p_valor
	WHERE id = p_id_conta_origem;
	
	UPDATE contacorrente SET saldo = saldo + p_valor
	WHERE id = p_id_conta_destino;
END $$;

CALL transferencia_fundos (5, 6, 200)

--------------------------------------------------

CREATE PROCEDURE verificar_saldo_msg
	(
		IN p_id_conta 	INT
	)
LANGUAGE PLPGSQL
AS $$
DECLARE v_saldo NUMERIC;
BEGIN
	SELECT saldo INTO v_saldo 
	FROM contacorrente
	WHERE id = p_id_conta;
	
	IF v_saldo < 2000
	THEN
	RAISE EXCEPTION 'ATENÇÃO: SALDO INFERIOR AO VALOR MINIMO 2000';
	END IF;
	
	RAISE NOTICE 'VALOR DA CONTA %: R$ %', p_id_conta, v_saldo;
END $$;

CALL verificar_saldo_msg (5);

--------------------------------------------------

CREATE PROCEDURE deletar_cliente 
	(
		IN p_id_cliente 	INT
	)
LANGUAGE PLPGSQL
AS $$
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
END $$;

CALL deletar_cliente (3);

--------------------------------------------------

CREATE OR REPLACE PROCEDURE criar_cliente
	(
		p_id_cliente 			INT,
		p_nome_cliente			VARCHAR,
		p_cpf_cliente			VARCHAR,
		p_endereco_cliente		VARCHAR,
		p_rua_cliente			VARCHAR,
		p_numero_rua_cliente	VARCHAR,
		p_complemente_cliente	VARCHAR,
		p_bairro_cliente		VARCHAR,
		p_cep_cliente			INT,
		p_cliente_telefone		VARCHAR,
		p_id_cidade_cliente		INT
	)
LANGUAGE PLPGSQL
AS $$
BEGIN
		INSERT INTO cliente
			(
				idcliente,
				nome, 
				cpf, 
				endereco,
				rua, 
				numero, 
				complemento, 
				bairro,
				cep, 
				telefone,
				idcidade
			)
			VALUES
			(
				p_id_cliente,
				p_nome_cliente,
				p_cpf_cliente,
				p_endereco_cliente, 
				p_rua_cliente, 
				p_numero_rua_cliente,
				p_complemente_cliente,
				p_bairro_cliente, 
				p_cep_cliente, 
				p_cliente_telefone,
				p_id_cidade_cliente
			);
RAISE NOTICE 'CLIENTE ADICIONADO COM SUCESSO.', p_nome_cliente;
END
$$;

CALL criar_cliente(40, 'Huandres', '13426537931', 'Rua Legal', 'Rua mais Legal', '1', 'Casa Branca', 'Di Fiori', '89809890', '123', 2);
 
select *from contaCorrente

-- CRIAR PROCEDURE PARA LISTAR OS CLIENTE A PARTIR DO ID DA CIDADE

CREATE OR REPLACE PROCEDURE lista_cliente_pela_cidade
	(
		p_id_cidade 	INT	
	)
LANGUAGE PLPGSQL AS $$
	DECLARE v_cliente RECORD;
BEGIN
	FOR v_cliente IN
		SELECT nome,cpf FROM cliente
		WHERE idcidade = p_id_cidade
	LOOP
		RAISE NOTICE 'CLIENTE %', v_cliente.nome;
	END LOOP;
END;
$$;

-- CRIAR UMA FUNÇÃO ANONIMA PARA CHAMAR A PROCEDURE

DO $$
BEGIN
	CALL lista_cliente_pela_cidade(2);
END;
$$;

-- CRIAR PROCEDURE PARA LISTAR AS AGENCIAS PELO ID DA CIDADE

CREATE OR REPLACE PROCEDURE lista_agencia_pelo_cidade 
	(
		p_id_cidade 	INT
	)
LANGUAGE PLPGSQL AS $$
	DECLARE v_agencia RECORD;
BEGIN
	FOR v_agencia IN
		SELECT nomeagencia, rua FROM agencia
		WHERE idcidade = p_id_cidade
	LOOP
		RAISE NOTICE 'AGENCIA %', v_agencia.nomeagencia;
	END LOOP;
END;
$$;

-- CRIAR UMA FUNÇÃO ANONIMA PARA CHAMAR A PROCEDURE

DO $$
BEGIN
	CALL lista_agencia_pelo_cidade(2);
END;
$$;

-- CRIAR PROCEDURE PARA ATUALIZAR SALDO SAIDA

CREATE OR REPLACE PROCEDURE atualizar_saldo_saida
	(
		IN p_idconta_corrente 	INT,
		IN p_novo_saldo		DECIMAL,
		OUT p_saldo_atual	DECIMAL
	)
LANGUAGE PLPGSQL AS $$
BEGIN
	UPDATE contaCorrente SET saldo = p_novo_saldo
	WHERE id = p_idconta_corrente;
	
	SELECT saldo INTO p_saldo_atual FROM contaCorrente
	WHERE id = p_idconta_corrente;
END;
$$;

CALL atualizar_saldo_saida(10, 5000, 8000);

SELECT *FROM contaCorrente







