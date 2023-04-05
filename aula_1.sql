-- Criação do banco de dados
CREATE DATABASE ALURA;

-- Criação da tabela aluno
CREATE TABLE aluno (
   id SERIAL,
   nome VARCHAR(255),
   cpf CHAR(11),
   observacao TEXT,
   idade INTEGER,
   dinheiro NUMERIC(10,2),
   altura REAL,
   ativo BOOLEAN,
   data_nascimento DATE,
   hora_aula TIME,
   data_matricula TIMESTAMP
);
