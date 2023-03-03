-- Criar a base de dados
CREATE DATABASE ProgSCRIPT;
GO;

-- Utilizar o nosso banco
USE ProgSCRIPT;
GO;

-- Criando nossa primeira tabela
CREATE TABLE Aluno (
	id INT PRIMARY KEY,
	nome VARCHAR(50),
	idade INT 
)