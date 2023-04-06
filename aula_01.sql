-- Criando as tabelas
CREATE TABLE aluno (
    id SERIAL PRIMARY KEY,
    primeiro_nome VARCHAR(255) NOT NULL,
    ultimo_nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL
);

CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE curso (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    categoria_id INTEGER NOT NULL REFERENCES categoria(id)
);

CREATE TABLE aluno_curso (
    aluno_id INTEGER NOT NULL REFERENCES aluno(id),
    curso_id INTEGER NOT NULL REFERENCES curso(id),
    PRIMARY KEY (aluno_id, curso_id)
);

-- Inserindo registros
INSERT INTO aluno (
    primeiro_nome,
	ultimo_nome, 
	data_nascimento
) VALUES ('Andrieli', 'Gonçalves', '2005-06-03'),
		 ('Eva', 'Reczcki', '1964-09-04'),
		 ('Tutuba', 'Gonçalves', '2010-04-04'),
		 ('Isadora', 'Bernardes', '2000-03-01'),
		 ('Jorge', 'Emilio', '1950-12-12');
		 
INSERT INTO categoria (
	nome
) VALUES ('Data Science'), ('Programação'), ('Front-end'), ('DevOps');

INSERT INTO curso (
	nome,
	categoria_id
) VALUES ('PostgreSQL', 1), ('Python Pandas', 1), 
		 ('Arrays com Javascript', 2), ('Git e Github', 4), 
		 ('Django', 2), ('ReactJs', 3);
		 
INSERT INTO aluno_curso (
	aluno_id,
	curso_id
) VALUES (1, 1), (1, 2), (2, 4), (3, 1), (3, 5), (5, 6), (5, 1), (2, 6)