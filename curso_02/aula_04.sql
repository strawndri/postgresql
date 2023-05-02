-- Funções de strings
SELECT CONCAT(primeiro_nome, ' ' , ultimo_nome) AS nome_completo FROM ALUNO;

SELECT CONCAT(UPPER(ultimo_nome), ', ', primeiro_nome) AS nome_completo FROM ALUNO;

-- Funções de Data
SELECT primeiro_nome, EXTRACT(YEAR FROM AGE(data_nascimento)) as idade FROM ALUNO;

-- Funções matemáticas
SELECT log(10, 1000);
SELECT sin(45);

-- Funções de conversão
SELECT TO_CHAR(now(), 'DD/MM/YYYY');