-- Relatório 1: total de cursos por aluno
SELECT  aluno.primeiro_nome, aluno.ultimo_nome,
		COUNT(aluno_curso.aluno_id) AS total_cursos
	FROM aluno
	LEFT JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	GROUP BY 1, 2
	ORDER BY aluno.primeiro_nome;
	
-- Relatório 2: cursos mais requisitados
SELECT nome, count(aluno_curso.curso_id) AS total_estudantes
	FROM curso
	LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	GROUP BY 1
	ORDER BY total_estudantes DESC
	
-- Relatório 3: categorias mais requisitadas
SELECT categoria.nome, count(curso.categoria_id) AS categoria
	FROM curso
	LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	LEFT JOIN categoria ON categoria.id = curso.categoria_id
	GROUP BY 1
	ORDER BY categoria DESC
