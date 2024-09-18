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

