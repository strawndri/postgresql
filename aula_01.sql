-- Criando nossa primeira função
CREATE FUNCTION primeira_funcao() RETURNS INTEGER AS '
	SELECT (5 * 12)/ 2
' LANGUAGE SQL

-- Chamando a função
SELECT * FROM primeira_funcao();
SELECT primeira_funcao();

-- Função com parâmetros
CREATE FUNCTION soma_dois_numeros(numero_1 INTEGER, numero_2 INTEGER) RETURNS INTEGER AS '
	SELECT numero_1 + numero_2
' LANGUAGE SQL;

SELECT * FROM soma_dois_numeros(100, 11);

-- Nova função -> inserindo registros!
CREATE TABLE tabela_teste (id VARCHAR(5) NOT NULL);
CREATE FUNCTION insere_registro(id VARCHAR(5)) RETURNS VARCHAR AS '
	INSERT INTO tabela_teste (id) VALUES (insere_registro.id);
	SELECT * FROM tabela_teste;
' LANGUAGE SQL; 

SELECT * FROM insere_registro('1');