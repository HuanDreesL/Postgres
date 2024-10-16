CREATE PROCEDURE verificar_saldo
	(
		IN p_id_conta		INT,
		IN p_tipo_operacao	VARCHAR,
		IN p_valor 			FLOAT,
		IN p_numero_conta	VARCHAR
	)
LANGUAGE PLPGSQL AS $$
	DECLARE 
		v_saldo				NUMERIC;
	BEGIN

		IF p_valor <= 0 THEN
			RAISE EXCEPTION 'O VALOR NÃO É VÁLIDO';
		END IF;

		SELECT saldo INTO v_saldo
		FROM ContaCorrente
		WHERE id = p_id_conta;

		IF NOT FOUND THEN
			RAISE EXCEPTION 'CONTA NÃO ENCONTRADA';
		END IF;

		IF p_tipo_operacao = 'SAQUE' THEN
			IF p_valor > v_saldo THEN
				RAISE EXCEPTION 'VALOR INDISPONIVEL';
		END IF;

		UPDATE ContaCorrente
		SET saldo = saldo - p_valor
		WHERE id = p_id_conta;

		ELSIF p_tipo_operacao = 'DEPOSITO' THEN
			UPDATE ContaCorrente
			SET saldo = saldo + p_valor
			WHERE id = p_id_conta;
		END IF;

		INSERT INTO Movimentacao (tipo, valor, dataMovimentacao, numeroConta, idContaCorrente)
			VALUES (p_tipo_operacao, p_valor, CURRENT_DATE, p_numero_conta,p_id_conta);

		RAISE NOTICE 'OPERAÇÃO REALIZADA COM SUCESSO!';
		RAISE NOTICE 'A CONTA: %', p_numero_conta;
		RAISE NOTICE 'FEZ A OPERAÇÃO DE: %', p_tipo_operacao;
		RAISE NOTICE 'NO VALOR DE R$ %', p_valor;
		RAISE NOTICE 'SALDO ATUAL R$ %', v_saldo;
END;
$$;

CALL verificar_saldo (1, 'SAQUE', 3000, '123456-SP');
CALL verificar_saldo (1, 'DEPOSITO', 2000, '123456-SP');

---------------------------------------------------------------

CREATE PROCEDURE atualizar_numero_telefone 
	(
		IN p_id_cliente		INT,
		IN p_novo_numero	VARCHAR
	)
LANGUAGE PLPGSQL AS $$
	DECLARE
		v_numero_telefone	VARCHAR;
	BEGIN
		SELECT telefone INTO v_numero_telefone
		FROM Cliente
		WHERE idcliente = p_id_cliente;

		IF NOT FOUND THEN 
			RAISE EXCEPTION 'NÚMERO NÃO ENCONTRADO';
		END IF;

		UPDATE Cliente
		SET telefone = p_novo_numero
		WHERE idCliente = p_id_cliente;

		RAISE NOTICE 'NÚMERO DO CLIENTE ATUALIZADO!';
		RAISE NOTICE 'NÚMERO ANTIGO: %', v_numero_telefone;
		RAISE NOTICE 'NÚMERO ATUAL: %', p_novo_numero;
END;
$$;

CALL atualizar_numero_telefone (3, '(49)98909-3709');

---------------------------------------------------------------

CREATE PROCEDURE mudar_cliente_agencia 
	(
		IN p_id_cliente		INT,
		IN p_id_agencia		INT
	)
LANGUAGE PLPGSQL AS $$
	DECLARE 
		v_id_cliente		INT;
		v_id_agencia		INT;
	BEGIN
		SELECT idCliente INTO v_id_cliente
		FROM Cliente
		WHERE idCliente = p_id_cliente;

		IF NOT FOUND THEN
			RAISE EXCEPTION 'CLIENTE NÃO ENCONTRADO!';
		END IF;

		SELECT idAgencia INTO v_id_agencia
		FROM Agencia
		WHERE idAgencia = p_id_agencia;

		IF NOT FOUND THEN
			RAISE EXCEPTION 'AGENCIA NÃO ENCONTRADA!';
		END IF;

		UPDATE Cliente
		SET idAgenic

		
		
	select *from CLIENTE
	select *from AGENCIA

---------------------------------------------------------------

CREATE PROCEDURE encerrar_conta 
	(
		IN p_id_conta_corrente		INT	
	)
LANGUAGE PLPGSQL AS $$
	DECLARE 
		v_saldo_corrente			DECIMAL;
	BEGIN

		SELECT saldo INTO v_saldo_corrente
		FROM ContaCorrente
		WHERE id = p_id_conta_corrente;

		IF NOT FOUND THEN
			RAISE EXCEPTION 'NENHUMA CONTA ENCONTRADA!';
		END IF;

    	IF v_saldo_corrente != 0 THEN
        	RAISE EXCEPTION 'A conta não pode ser encerrada porque o saldo não é zero. Saldo atual: %', v_saldo_corrente;
    	END IF;

		DELETE FROM Movimentacao
		WHERE idContaCorrente = p_id_conta_corrente;
		DELETE FROM ContaCorrente
		WHERE id = p_id_conta_corrente;
		RAISE NOTICE 'CONTA EXCLUÍDA %', p_id_conta_corrente;
END;
$$;
			
CALL encerrar_conta (2);

---------------------------------------------------------------

CREATE PROCEDURE transferencia 
	(
		IN p_id_conta_origem	INT,
		IN p_id_conta_destino	INT,
		IN p_valor				FLOAT
	)
LANGUAGE PLPGSQL AS $$
	DECLARE
		v_saldo_conta_origem	FLOAT;
		v_saldo_conta_destino	FLOAT;
	BEGIN
	
		SELECT saldo INTO v_saldo_conta_origem	
		FROM ContaCorrente
		WHERE id = p_id_conta_origem;

		IF NOT FOUND THEN
			RAISE EXCEPTION 'CONTA DE ORIGEM NÃO ENCONTRADA!';
		END IF;

		SELECT saldo INTO v_saldo_conta_destino
		FROM ContaCorrente
		WHERE id = p_id_conta_destino;

		IF NOT FOUND THEN
			RAISE EXCEPTION 'CONTA DE DESTINO NÃO ENCONTRADA!';
		END IF;

		IF v_saldo_conta_origem < p_valor THEN
			RAISE EXCEPTION 'VALOR INSUFICIENTE';
		END IF;

		UPDATE ContaCorrente
		SET saldo = saldo - p_valor
		WHERE id = p_id_conta_origem;

		UPDATE ContaCorrente
		SET saldo = saldo + p_valor
		WHERE id = p_id_conta_destino;

		RAISE NOTICE 'TRANSFERENCIA CONCLUÍDA COM SUCESSO';
		RAISE NOTICE 'CONTA ORIGEM: %', p_id_conta_origem;
		RAISE NOTICE 'CONTA DESTINO: %', p_id_conta_destino;
		RAISE NOTICE 'VALOR R$ %', p_valor;
END;
$$;

CALL transferencia (1, 2, 500);

---------------------------------------------------------------

CREATE PROCEDURE aplicar_taxa_manutencao 
	(
		IN p_valor_taxa		FLOAT
	)
LANGUAGE PLPGSQL AS $$
	DECLARE
		v_id_conta			INT;
		v_saldo				FLOAT;
	BEGIN

		FOR v_id_conta, v_saldo IN
			SELECT id, saldo FROM ContaCorrente
		LOOP

			IF v_saldo - p_valor_taxa < 0 THEN
            	RAISE EXCEPTION 'A conta % não pode ter saldo negativo após a dedução da taxa. Saldo atual: %, Taxa: %', v_id_conta, v_saldo, p_valor_taxa;
			END IF;

			UPDATE ContaCorrente
			SET Saldo = Saldo - p_valor_taxa
			WHERE id = v_id_conta;
 		
		INSERT INTO Movimentacao (idConta, tipo, valor, data)
        VALUES (v_id_conta, 'Taxa de Manutenção', -p_valor_taxa, CURRENT_DATE);
    END LOOP;
			
    RAISE NOTICE 'A taxa de manutenção de % foi aplicada com sucesso a todas as contas.', p_valor_taxa;

END;
$$;

CALL aplicar_taxa_manutencao (100);


