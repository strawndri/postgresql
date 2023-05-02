-- Criando uma função com linguagem plpgsql
CREATE FUNCTION primeira_pl() RETURNS INTEGER AS $$
	DECLARE
		variavel INTEGER DEFAULT 3;
	BEGIN
		variavel := variavel + 2;
		RETURN variavel;
	END
$$ LANGUAGE PLPGSQL;

SELECT primeira_pl();
