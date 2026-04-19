CREATE DATABASE faculdade;
USE faculdade;

CREATE TABLE aluno (
  id_aluno INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  cpf CHAR(11) UNIQUE,
  rg VARCHAR(20),
  genero VARCHAR(20),
  etnia VARCHAR(50),
  email VARCHAR(100),
  endereco VARCHAR(150),
  numero VARCHAR(10)
);

CREATE TABLE atendente (
  cpf CHAR(11) PRIMARY KEY,
  nome VARCHAR(100),
  rg VARCHAR(20),
  genero VARCHAR(20),
  etnia VARCHAR(50),
  email VARCHAR(100),
  endereco VARCHAR(150),
  numero VARCHAR(10)
);

CREATE TABLE curso (
  id_curso INT AUTO_INCREMENT PRIMARY KEY,
  nome_curso VARCHAR(100)
);

CREATE TABLE turma (
  id_turma INT AUTO_INCREMENT PRIMARY KEY,
  semestre VARCHAR(10),
  id_curso INT,
  FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

CREATE TABLE matricula (
  id_matricula INT AUTO_INCREMENT PRIMARY KEY,
  data_matricula DATE,
  status VARCHAR(20),
  id_aluno INT,
  id_turma INT,
  FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
  FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
);

CREATE TABLE atendimento (
  id_atendimento INT AUTO_INCREMENT PRIMARY KEY,
  data DATE,
  tipo VARCHAR(50),
  status VARCHAR(20),
  descricao TEXT,
  id_aluno INT,
  cpf_atendente CHAR(11),
  FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
  FOREIGN KEY (cpf_atendente) REFERENCES atendente(cpf)
);

CREATE TABLE disciplina (
  id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
  nome_disciplina VARCHAR(100),
  carga_horaria INT,
  id_curso INT,
  FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

CREATE TABLE docente (
  id_docente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100)
);

CREATE TABLE disciplina_docente (
  id_disciplina INT,
  id_docente INT,
  PRIMARY KEY (id_disciplina, id_docente),
  FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina),
  FOREIGN KEY (id_docente) REFERENCES docente(id_docente)
);

INSERT INTO curso (nome_curso) VALUES ('Sistemas de Informação');

INSERT INTO aluno (nome, cpf, email)
VALUES ('João Silva', '12345678901', 'joao@email.com');

INSERT INTO atendente (cpf, nome)
VALUES ('11111111111', 'Maria Souza');

INSERT INTO turma (semestre, id_curso)
VALUES ('2025.1', 1);

INSERT INTO matricula (data_matricula, status, id_aluno, id_turma)
VALUES ('2025-02-10', 'Ativa', 1, 1);

INSERT INTO atendimento (data, tipo, status, descricao, id_aluno, cpf_atendente)
VALUES ('2025-03-01', 'Dúvida', 'Concluído', 'Dúvida sobre matrícula', 1, '11111111111');

-- Listar alunos
SELECT * FROM aluno;

-- Atendimentos com nome do aluno
SELECT a.nome, at.tipo, at.status
FROM atendimento at
JOIN aluno a ON at.id_aluno = a.id_aluno;

-- Matrículas com curso
SELECT a.nome, c.nome_curso
FROM matricula m
JOIN aluno a ON m.id_aluno = a.id_aluno
JOIN turma t ON m.id_turma = t.id_turma
JOIN curso c ON t.id_curso = c.id_curso;

UPDATE atendimento
SET status = 'Finalizado'
WHERE id_atendimento = 1;