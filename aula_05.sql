DO $$
	DECLARE
		cursor_salario refcursor;
		salario DECIMAL;
		total_instrutores INTEGER DEFAULT 0;
		instrutores_recebem_menos INTEGER DEFAULT 0;
		percentual DECIMAL(10, 2);
		
	BEGIN 
		SELECT instrutores_internos(12) INTO cursor_salario;
		
		LOOP FETCH cursor_salario INTO salario;
			EXIT WHEN NOT FOUND;
			total_instrutores := total_instrutores + 1;

			IF 600::DECIMAL > salario THEN
				instrutores_recebem_menos := instrutores_recebem_menos + 1;
			END IF;
		END LOOP;
		percentual = instrutores_recebem_menos::DECIMAL / total_instrutores::DECIMAL * 100;
		RAISE NOTICE 'Percentual: % %%', percentual;
	END;
$$;