-- Parâmetros compostos
CREATE TABLE instrutor (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	salario DECIMAL(10, 2)
);

INSERT INTO instrutor (nome, salario)
VALUES ('Isabela Lala', 500), ('Dina Pereira', 200),
	   ('Betinho Fernandes', 300), ('Andrieli Gonçalves', 100);

CREATE FUNCTION dobro_do_salario (instrutor) RETURNS DECIMAL AS $$
	SELECT $1.salario * 2 AS dobro;
$$ LANGUAGE SQL;

SELECT nome, dobro_do_salario (instrutor.*) FROM instrutor;

-- Retorno composto
CREATE FUNCTION cria_instrutor_falso () RETURNS instrutor AS $$
	SELECT 22 AS id, 'nome_falso', 200::DECIMAL AS salario;
$$ LANGUAGE SQL

SELECT * from cria_instrutor_falso()
SELECT cria_instrutor_falso()

-- Retornando conjuntos
CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF instrutor AS $$
	SELECT * FROM instrutor WHERE salario >= valor_salario
$$ LANGUAGE SQL; 

SELECT * FROM instrutores_bem_pagos(200)

-- Parâmetros de saída
CREATE FUNCTION soma_e_produto(IN numero_1 INTEGER, IN numero_2 INTEGER,
	                       OUT soma INTEGER, OUT produto INTEGER) AS $$
	SELECT numero_1 + numero_2 AS soma, numero_1 * numero_2 AS produto;
$$ LANGUAGE SQL;

SELECT * FROM soma_e_produto(2, 8);

-- Parâmetros de saída com RECORD
CREATE FUNCTION instrutores_bem_pagos2(IN valor_salario DECIMAL,
				       OUT nome VARCHAR, OUT salario DECIMAL) 
				       RETURNS SETOF RECORD AS $$
	SELECT nome, salario FROM instrutor WHERE salario >= valor_salario
$$ LANGUAGE SQL; 

SELECT * FROM instrutores_bem_pagos2(200)
