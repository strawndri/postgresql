-- Usando CASCADE
ALTER TABLE curso_aluno DROP id_aluno;

ALTER TABLE curso_aluno ADD COLUMN id_aluno SERIAL NOT NULL;

ALTER TABLE curso_aluno ADD FOREIGN KEY (id_aluno)
REFERENCES aluno(id) 
ON UPDATE CASCADE
ON DELETE CASCADE;