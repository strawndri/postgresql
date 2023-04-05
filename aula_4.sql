-- Criando tabela com chave primária
CREATE TABLE CURSO (
   id SERIAL PRIMARY KEY NOT NULL,
   titulo VARCHAR(100) NOT NULL
);

-- Inserindo registros na tabela com PK
INSERT INTO CURSO (titulo) VALUES ('PostgreSQL'), ('Python Pandas'), ('Javascript para Web'), ('PowerBI');

-- Criando uma nova tabela de alunos (simplificada)
DROP TABLE ALUNO;

CREATE TABLE ALUNO (
   id SERIAL PRIMARY KEY NOT NULL,
   nome VARCHAR(100)
)

-- Inserindo dados na tabela ALUNO
INSERT INTO ALUNO (nome) VALUES ('Andrieli'), ('Rodrigo'), ('Larissa'), ('Eva'), ('Tutuba'), ('Hello Kitty');

-- Relacionando tabelas
CREATE TABLE CURSO_ALUNO (
   id_curso SERIAL NOT NULL,
   id_aluno SERIAL NOT NULL,
   FOREIGN KEY(id_curso) REFERENCES CURSO(id),
   FOREIGN KEY(id_aluno) REFERENCES ALUNO(id)
);

-- Inserindo dados na tabela CURSO_ALUNO
INSERT INTO CURSO_ALUNO (id_curso, id_aluno)
VALUES (1, 1), (1, 2), (2, 3), (1, 5), (2, 5), (3, 4)
SELECT * FROM CURSO_ALUNO

-- Consultando com relacionamentos
SELECT 
   aluno.nome AS aluno, 
   curso.titulo AS curso
FROM ALUNO
   JOIN curso_aluno on curso_aluno.id_aluno = aluno.id 
   JOIN curso on curso.id = curso_aluno.id_curso
	
-- Mais consultas com relacionamentos!

---- LEFT JOIN
SELECT 
   aluno.nome AS aluno, 
   curso.titulo AS curso
FROM ALUNO
   LEFT JOIN curso_aluno on curso_aluno.id_aluno = aluno.id 
   LEFT JOIN curso on curso.id = curso_aluno.id_curso
	
---- RIGHT JOIN
SELECT 
   aluno.nome AS aluno, 
   curso.titulo AS curso
FROM ALUNO
   RIGHT JOIN curso_aluno on curso_aluno.id_aluno = aluno.id 
   RIGHT JOIN curso on curso.id = curso_aluno.id_curso
	
---- FULL JOIN
SELECT 
   aluno.nome AS aluno, 
   curso.titulo AS curso
FROM ALUNO
   FULL JOIN curso_aluno on curso_aluno.id_aluno = aluno.id 
   FULL JOIN curso on curso.id = curso_aluno.id_curso
	
---- CROSS JOIN
SELECT 
   aluno.nome AS aluno, 
   curso.titulo AS curso
FROM ALUNO
   CROSS JOIN curso;
