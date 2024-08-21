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




