-- Return next
CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
	DECLARE
	BEGIN
		RETURN NEXT numero * 1;
		RETURN NEXT numero * 2;
	END;
$$ LANGUAGE PLPGSQL;

SELECT tabuada(7);

-- Usando loop
CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
	DECLARE 
		multiplicador INTEGER DEFAULT 1;
	BEGIN
		LOOP
			RETURN NEXT CONCAT(numero, ' * ', multiplicador, ' = ', numero * multiplicador);
			multiplicador := multiplicador + 1;
			EXIT WHEN multiplicador = 11;
		END LOOP;
	END;
$$ LANGUAGE PLPGSQL;

SELECT tabuada(7);

-- Usando When
CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
	DECLARE 
		multiplicador INTEGER DEFAULT 1;
	BEGIN
		WHILE multiplicador < 11 LOOP
			RETURN NEXT CONCAT(numero, ' * ', multiplicador, ' = ', numero * multiplicador);
			multiplicador := multiplicador + 1;
		END LOOP;
	END;
$$ LANGUAGE PLPGSQL;

SELECT tabuada(7);

-- Usando For
CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
	BEGIN
		FOR multiplicador IN 1..10 LOOP
			RETURN NEXT CONCAT(numero, ' * ', multiplicador, ' = ', numero * multiplicador);
		END LOOP;
	END;
$$ LANGUAGE PLPGSQL;

SELECT tabuada(7);

-- 
CREATE FUNCTION instrutor_com_salario(OUT nome VARCHAR, OUT salario_ok VARCHAR) RETURNS SETOF record AS $$
	DECLARE
		instrutor instrutor;
	BEGIN 
		FOR instrutor IN SELECT * FROM instrutor LOOP
			nome := instrutor.nome;
			salario_ok := salario_ok(instrutor.id);
			
			RETURN NEXT;
		END LOOP;
	END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM instrutor_com_salario();