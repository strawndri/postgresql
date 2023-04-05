-- Buscas com ordenação
SELECT * FROM ALUNO
ORDER BY nome;

-- Limitando registros
SELECT * FROM ALUNO
LIMIT 3;

SELECT * FROM ALUNO
LIMIT 3
OFFSET 2;

-- Funções de agrupamento
SELECT 	COUNT(id), 
   SUM(id),
   MAX(id),
   MIN(id)
FROM ALUNO;

-- Agrupando valores
SELECT 
   titulo, count(aluno.id) AS total_estudantes
FROM curso
LEFT JOIN curso_aluno ON curso_aluno.id_curso = curso.id
LEFT JOIN aluno ON aluno.id = curso_aluno.id_aluno
GROUP BY titulo;

-- Consultas a apartir de agrupamentos
SELECT 
   titulo, count(aluno.id) AS total_estudantes
FROM curso
LEFT JOIN curso_aluno ON curso_aluno.id_curso = curso.id
LEFT JOIN aluno ON aluno.id = curso_aluno.id_aluno
GROUP BY titulo
HAVING count(aluno.id) > 0;
