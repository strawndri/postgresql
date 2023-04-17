-- Refazendo funções com plpgsql

-- Função 1
CREATE OR REPLACE FUNCTION cria_instrutor_falso() RETURNS instrutor AS $$
	DECLARE
		retorno instrutor;
	BEGIN
		SELECT 22, 'Nome Falso', 200::DECIMAL INTO retorno;
		RETURN retorno;
	END;
$$ LANGUAGE plpgsql;

SELECT cria_instrutor_falso();

-- Função 2 - retornando valores
CREATE OR REPLACE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF instrutor AS $$
	BEGIN
		RETURN QUERY SELECT * FROM instrutor WHERE salario >= valor_salario;
	END;
$$ LANGUAGE plpgsql; 

SELECT * FROM instrutores_bem_pagos(200)

-- Função 3 - usando if-else
CREATE OR REPLACE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
		instrutor instrutor;
	BEGIN 
		SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;
		IF instrutor.salario > 200 THEN
			RETURN 'Salário ok!';
		ELSEIF instrutor.salario = 200 THEN
			RETURN 'Salário pode aumentar';
		ELSE
			RETURN 'Salário defasado';
		END IF;
	END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM instrutor;

-- Função 4 - usando case (exemplo 1)
CREATE OR REPLACE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
		instrutor instrutor;
	BEGIN 
		SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;
		CASE 
			WHEN instrutor.salario < 100 THEN
				RETURN 'Salário baixo';
			WHEN instrutor.salario BETWEEN 100 AND 200 THEN
				RETURN 'Salário mediano';
			WHEN instrutor.salario > 200 THEN
				RETURN 'Salário alto';
		END CASE;
	END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM instrutor;

-- Função 4 - usando case (exemplo 2)
CREATE OR REPLACE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
		instrutor instrutor;
	BEGIN 
		SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;
		CASE instrutor.salario
			WHEN 100 THEN
				RETURN 'Salário baixo';
			WHEN 200 THEN
				RETURN 'Salário mediano';
			ELSE
				RETURN 'Salário alto';
		END CASE;
	END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM instrutor;
