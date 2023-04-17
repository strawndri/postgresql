-- Desenvolvendo uma função de criação de cursos
CREATE OR REPLACE FUNCTION cria_curso(nome_curso VARCHAR, nome_categoria VARCHAR) RETURNS void AS $$
	DECLARE
		id_categoria INTEGER;
	BEGIN 
		SELECT id INTO id_categoria FROM categoria WHERE nome = nome_categoria;
		
		IF NOT FOUND THEN
			INSERT INTO categoria(nome) VALUES (nome_categoria) RETURNING id INTO id_categoria;
		END IF;
		
		INSERT INTO curso (nome, categoria_id) VALUES (nome_curso, id_categoria);
	END;
$$ LANGUAGE PLPGSQL;

SELECT cria_curso('Normalização de Banco de dados', 'Data Science');
SELECT * FROM curso;

-- Instrutores e salários

CREATE TABLE log_instrutores (
	id SERIAL PRIMARY KEY,
	informacao VARCHAR(255),
	momento_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION cria_instrutor (nome_instrutor VARCHAR, salario_instrutor DECIMAL) 
RETURNS void AS $$
	DECLARE
		id_instrutor_inserido INTEGER;
		media_salarial DECIMAL;
		instrutores_recebem_menos INTEGER DEFAULT 0;
		total_instrutores INTEGER DEFAULT 0;
		salario DECIMAL(10, 2); 
		percentual DECIMAL(10, 2);
		
	BEGIN 
		INSERT 
			INTO instrutor (nome, salario) 
			VALUES (nome_instrutor, salario_instrutor) 
			RETURNING id 
			INTO id_instrutor_inserido;
			
		SELECT AVG (instrutor.salario) 
			INTO media_salarial 
			FROM instrutor
			WHERE id <> id_instrutor_inserido;
			
		IF salario_instrutor > media_salarial THEN
			INSERT 
				INTO log_instrutores (informacao) 
				VALUES (nome_instrutor || ' recebe acima da média.');
		END IF;
		
		FOR salario IN 
			SELECT instrutor.salario 
				FROM instrutor 
				WHERE id <> id_instrutor_inserido LOOP
			total_instrutores := total_instrutores + 1;
			
			IF salario_instrutor > salario THEN
				instrutores_recebem_menos := instrutores_recebem_menos + 1;
			END IF;
		END LOOP;
		
		percentual = instrutores_recebem_menos::DECIMAL / total_instrutores::DECIMAL * 100;
		
		INSERT INTO log_instrutores (informacao)
			VALUES (nome_instrutor || ' recebe mais do que ' || percentual || '% da grade de instrutores');
	END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM instrutor;
SELECT cria_instrutor('Hello Kitty', 360);

SELECT * FROM log_instrutores;
