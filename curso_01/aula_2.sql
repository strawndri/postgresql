-- Inserindo dados na tabela
INSERT INTO aluno (
nome,
cpf,
observacao,
idade,
dinheiro,
altura,
ativo,
data_nascimento,
hora_aula,
data_matricula)

VALUES (
	'Andrieli Luci Gonçalves',
	'00000000000',
	'Ao longo dos anos, a Microsoft desenvolveu uma diversidade de ferramentas para o mercado. Um bom exemplo disso é o Excel. Ferramenta popular utilizada para diversas finalidades produtivas, permite a otimização do desempenho pela análise de dados, como: controle das finanças, controle de compra e venda de mercadorias. Por conta dessa sua versatilidade, essas são apenas algumas das formas de utilizar o Excel, que pode auxiliar tanto na vida pessoal, quanto no controle de gastos de uma organização.',
	17,
	5.99,
	1.56,
	TRUE,
	'2005-06-03',
	'17:30:00',
	'2023-04-04 17:30:00'
);

-- Atualizando registros
UPDATE aluno
SET hora_aula = '13:30:00'
WHERE id = 1;

-- Deletando registros
DELETE FROM aluno WHERE id = 1;