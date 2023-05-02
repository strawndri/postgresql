-- Criando função que retorna cursor

CREATE OR REPLACE FUNCTION instrutores_internos(id_instrutor INTEGER) RETURNS refcursor AS $$
	DECLARE
		cursor_salario refcursor;
	BEGIN
		OPEN cursor_salario FOR SELECT instrutor.salario
								FROM instrutor
								WHERE id <> id_instrutor
								AND salario > 0;
		RETURN cursor_salario;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION cria_instrutor() 
RETURNS TRIGGER AS $$
	DECLARE
		id_instrutor_inserido INTEGER;
		media_salarial DECIMAL;
		instrutores_recebem_menos INTEGER DEFAULT 0;
		total_instrutores INTEGER DEFAULT 0;
		salario DECIMAL(10, 2); 
		percentual DECIMAL;
		cursor_salario refcursor;

	BEGIN 
		SELECT AVG (instrutor.salario) 
			INTO media_salarial 
			FROM instrutor
			WHERE id <> NEW.id;

		IF NEW.salario > media_salarial THEN
			INSERT 
				INTO log_instrutores (informacao) 
				VALUES (NEW.nome || ' recebe acima da média.');
		END IF;

		SELECT instrutores_internos(NEW.id) INTO cursor_salario;
		
		LOOP FETCH cursor_salario INTO salario;
			EXIT WHEN NOT FOUND;
			total_instrutores := total_instrutores + 1;

			IF NEW.salario > salario THEN
				instrutores_recebem_menos := instrutores_recebem_menos + 1;
			END IF;
		END LOOP;

		percentual = instrutores_recebem_menos::DECIMAL / total_instrutores::DECIMAL * 100;
		ASSERT percentual < 100::DECIMAL;

		INSERT INTO log_instrutores (informacao)
			VALUES (NEW.nome || ' recebe mais do que ' || percentual || '% da grade de instrutores');
		RETURN NEW;
		
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE TRIGGER cria_log_instrutores 
	BEFORE INSERT ON instrutor
	FOR EACH ROW EXECUTE FUNCTION cria_instrutor();

INSERT 
	INTO instrutor (nome, salario) 
	VALUES ('Melina Mel', 1000); 

SELECT * FROM instrutor;