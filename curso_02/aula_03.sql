-- Operador IN
SELECT * FROM CATEGORIA
WHERE nome not in ('Programação');

-- Queries aninhadas
SELECT * FROM curso WHERE categoria_id IN (
   SELECT id FROM categoria WHERE nome NOT LIKE ('% %')
);

-- Subconsultas
SELECT categoria, quantidade_alunos FROM ( 
SELECT categoria.nome AS categoria, count(curso.categoria_id) AS quantidade_alunos
   FROM curso
   LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
   LEFT JOIN categoria ON categoria.id = curso.categoria_id
   GROUP BY 1) AS X
WHERE quantidade_alunos >= 2
