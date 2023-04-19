-- Criando função que retorna TRIGGER c/ BEFORE

CREATE OR REPLACE FUNCTION calcula_percentual(salario_atual DECIMAL, id_atual INTEGER)
RETURNS DECIMAL AS $$
	DECLARE
	instrutores_recebem_menos INTEGER DEFAULT 0;
	total_instrutores INTEGER DEFAULT 0;
	salario DECIMAL(10, 2); 
	percentual DECIMAL(10, 2);
	
	BEGIN
		FOR salario IN 
			SELECT instrutor.salario 
				FROM instrutor 
				WHERE id <> id_atual LOOP
			total_instrutores := total_instrutores + 1;

			IF salario_atual > salario THEN
				instrutores_recebem_menos := instrutores_recebem_menos + 1;
			END IF;
		END LOOP;

		percentual = instrutores_recebem_menos::DECIMAL / total_instrutores::DECIMAL * 100;
		RETURN percentual;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION cria_instrutor() 
RETURNS TRIGGER AS $$
	DECLARE
		id_instrutor_inserido INTEGER;
		maior_salario DECIMAL;
		percentual DECIMAL(10, 2);
		
	BEGIN 
		SELECT MAX(salario) 
			INTO maior_salario 
			FROM instrutor
			WHERE id <> NEW.id;
			
		SELECT calcula_percentual(NEW.salario, NEW.id) 
		INTO percentual;
		
		IF percentual >= 100 THEN
			NEW.salario := maior_salario;
			SELECT calcula_percentual(NEW.salario, NEW.id) 
			INTO percentual;
		END IF;
		
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
	VALUES ('Catarina Gonçalves', 20000); 
	
SELECT * FROM instrutor;
SELECT * FROM log_instrutores;