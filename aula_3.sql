-- Buscando campos específicos de uma tabela
SELECT nome, idade FROM ALUNO;

-- Usando ALIAS
SELECT nome, data_nascimento AS "Data de nascimento" FROM ALUNO;

--  Filtros simples
SELECT * FROM ALUNO
WHERE idade > 10;

SELECT * FROM ALUNO
WHERE nome LIKE 'A%';

SELECT * FROM ALUNO
WHERE nome NOT LIKE 'A%';

SELECT * FROM ALUNO
WHERE nome LIKE 'Ann_%';

--  Filtros compostos
SELECT * FROM ALUNO
WHERE nome LIKE 'A%' AND data_nascimento BETWEEN '2000-01-01' AND '2020-01-01';

SELECT * FROM ALUNO
WHERE nome LIKE 'A%' OR data_nascimento BETWEEN '2000-01-01' AND '2020-01-01';