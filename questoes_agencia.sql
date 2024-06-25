-- Listar Todos os Cliente que tem contas correntes com saldo superiora 1000

SELECT nome FROM cliente WHERE id IN(
	SELECT id_cliente FROM conta_corrente WHERE saldo > 1000)

-- Listar todos os clientes que têm contas correntes na agencia X

SELECT * FROM cliente WHERE id = (
	SELECT id_cliente FROM conta_corrente WHERE id_agencia =(
		SELECT id FROM agencia WHERE id = 1))
	
-- Mostrar os nomes dos clientes que possuem contas correntes com saldo
-- superior ao saldo médio de todas as contas correntes

SELECT nome FROM cliente WHERE id IN(
	SELECT id_cliente FROM conta_corrente WHERE saldo >(
		SELECT AVG(saldo) FROM conta_corrente))
		

-- Mostrar o tipo de movimentação e o valor para todas as movimentações
-- realizadas por clientes que possuem contas correntes com saldo negativo

SELECT tipo, valor FROM movimentacoes WHERE id_conta_corrente IN(
	SELECT id FROM conta_corrente WHERE saldo < 0)

-- Mostrar o número da conta e o saldo atual para todas as contas correntes
-- que tiveram movimentações do tipo 'SAQUE'

SELECT numero, saldo FROM conta_corrente WHERE id IN (
	SELECT id_conta_corrente FROM movimentacoes WHERE tipo = 'SAQUE')
	
-- Mostrar o número da conta e o saldo atual para todas as contas correntes
-- que tiveram movimentações do tipo 'TRANSFERÊNCIA' com valores
-- superiores a 500 reais

SELECT numero, saldo FROM conta_corrente WHERE id IN(
	SELECT id_conta_corrente FROM movimentacoes WHERE tipo = 'TRANSFERÊNCIA'
		AND valor > 500)

-- Mostrar o número da conta e o saldo atual para todas as contas correntes
-- que tiveram movimentações do tipo 'DEPÓSITO' superiores a 1000 reais

SELECT numero, saldo FROM conta_corrente WHERE id IN(
	SELECT id_conta_corrente FROM movimentacoes WHERE tipo = 'DEPOSITO'
		AND valor > 1000)

-- Mostrar o número da conta e o saldo atual para todas as contas correntes
-- que têm movimentações realizadas antes de uma data específica (por
-- exemplo, 1º de janeiro de 2023)

SELECT numero, saldo FROM conta_corrente WHERE id IN(
	SELECT id_conta_corrente FROM movimentacoes WHERE 
		data_hora < '2023-01-01')
		






	
