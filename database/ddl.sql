-- ==========================================================
--  Sistema de Simulados Educacionais - ETEC ABH
--  Script DDL (criação do banco e tabelas) - MySQL 8+
-- ==========================================================
CREATE DATABASE IF NOT EXISTS simulados_etec_abh
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE simulados_etec_abh;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS resultados, respostas, eventos_foco, prova_questoes, provas_aplicadas,
  simulados, alternativas, questoes, textos_apoio, professor_turmas, sessoes, usuarios, turmas, disciplinas, unidades;
SET FOREIGN_KEY_CHECKS = 1;

-- ---------- Unidades ----------
CREATE TABLE unidades (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  sigla VARCHAR(20),
  cidade VARCHAR(100),
  logo_path VARCHAR(255),
  codigo_aluno VARCHAR(40),        -- código de convite para auto-cadastro de alunos
  codigo_professor VARCHAR(40),    -- código de convite para auto-cadastro de professores
  ativo BOOLEAN DEFAULT TRUE,      -- inativa = oculta de listas/dropdowns (root)
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------- Turmas ----------
CREATE TABLE turmas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  serie VARCHAR(40),
  periodo ENUM('Manhã','Tarde','Noite','Integral') NOT NULL,
  ano_letivo INT NOT NULL,
  unidade_id INT NOT NULL,
  ativo BOOLEAN DEFAULT TRUE,      -- inativa = oculta de listas/dropdowns (root)
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_turma_unidade FOREIGN KEY (unidade_id) REFERENCES unidades(id)
) ENGINE=InnoDB;

-- ---------- Disciplinas ----------
CREATE TABLE disciplinas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE,
  area VARCHAR(100),
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------- Usuários ----------
CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE,
  rm VARCHAR(30) UNIQUE,
  telefone VARCHAR(20),                -- auto-cadastro de visitante_feira
  data_nascimento DATE,                -- auto-cadastro de visitante_feira
  -- Relação do visitante com a ETEC (auto-cadastro de visitante_feira)
  relacao_etec ENUM('ex_aluno','candidato','responsavel','aluno'),
  -- Curso de interesse informado no auto-cadastro (captação ativa - feira de profissões)
  curso_interesse ENUM('Desenvolvimento de Sistemas','Jogos Digitais','Administração','Farmácia','Biotecnologia','Marketing'),
  senha_hash VARCHAR(255) NOT NULL,
  perfil ENUM('aluno','professor','coordenador','visitante_feira') NOT NULL DEFAULT 'aluno',
  is_root BOOLEAN DEFAULT FALSE,
  -- Situação do cadastro: 'aprovado' (seed/importação/aluno ou visitante auto-cadastrado),
  -- 'auto_pendente' (professor auto-cadastrado aguardando liberação), 'recusado'
  status_cadastro ENUM('auto_pendente','aprovado','recusado') NOT NULL DEFAULT 'aprovado',
  periodo ENUM('Manhã','Tarde','Noite','Integral'),
  tema_preferido ENUM('claro','escuro') DEFAULT 'claro',
  ativo BOOLEAN DEFAULT TRUE,
  ultimo_login DATETIME,
  tempo_logado_total INT DEFAULT 0,   -- segundos acumulados
  turma_id INT,
  unidade_id INT,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_usuario_turma FOREIGN KEY (turma_id) REFERENCES turmas(id),
  CONSTRAINT fk_usuario_unidade FOREIGN KEY (unidade_id) REFERENCES unidades(id)
) ENGINE=InnoDB;

-- ---------- Sessões (controle de tempo logado) ----------
CREATE TABLE sessoes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  inicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ultima_atividade DATETIME,
  fim DATETIME,
  duracao_segundos INT,
  ip VARCHAR(45),
  encerrada_por ENUM('logout','timeout','ativa','forcado') DEFAULT 'ativa',
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_sessao_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
) ENGINE=InnoDB;

-- ---------- Professor <-> Turmas (turmas que cada professor leciona) ----------
CREATE TABLE professor_turmas (
  professor_id INT NOT NULL,
  turma_id INT NOT NULL,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (professor_id, turma_id),
  CONSTRAINT fk_pt_prof FOREIGN KEY (professor_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  CONSTRAINT fk_pt_turma FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------- Textos de apoio (trechos/textos-base compartilhados por questões) ----------
CREATE TABLE textos_apoio (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(200),
  conteudo TEXT NOT NULL,
  disciplina_id INT,
  autor_id INT,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_texto_apoio_disciplina FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id),
  CONSTRAINT fk_texto_apoio_autor FOREIGN KEY (autor_id) REFERENCES usuarios(id)
) ENGINE=InnoDB;

-- ---------- Questões ----------
CREATE TABLE questoes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  enunciado TEXT NOT NULL,
  dificuldade ENUM('Fácil','Médio','Difícil') NOT NULL,
  tema VARCHAR(150),
  serie VARCHAR(40),
  gabarito CHAR(1) NOT NULL,
  disciplina_id INT NOT NULL,
  turma_id INT,
  autor_id INT,
  texto_apoio_id INT,
  ativa BOOLEAN DEFAULT TRUE,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_questao_disciplina FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id),
  CONSTRAINT fk_questao_turma FOREIGN KEY (turma_id) REFERENCES turmas(id),
  CONSTRAINT fk_questao_autor FOREIGN KEY (autor_id) REFERENCES usuarios(id),
  CONSTRAINT fk_questao_texto_apoio FOREIGN KEY (texto_apoio_id) REFERENCES textos_apoio(id),
  INDEX idx_questao_filtro (disciplina_id, dificuldade, ativa),
  INDEX idx_questao_texto_apoio (texto_apoio_id)
) ENGINE=InnoDB;

-- ---------- Alternativas ----------
CREATE TABLE alternativas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  questao_id INT NOT NULL,
  letra CHAR(1) NOT NULL,
  texto TEXT NOT NULL,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_alt_questao FOREIGN KEY (questao_id) REFERENCES questoes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------- Simulados ----------
CREATE TABLE simulados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  tipo ENUM('aleatorio_aluno','geral') NOT NULL,
  disciplina_id INT,
  tema VARCHAR(150),
  turma_id INT,
  qtd_questoes INT NOT NULL DEFAULT 20,
  distribuicao_dificuldade JSON,
  duracao_minutos INT NOT NULL DEFAULT 60,
  max_perdas_foco INT DEFAULT 0,
  criado_por INT,
  publicado BOOLEAN DEFAULT FALSE,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT chk_max_20 CHECK (qtd_questoes <= 20),
  CONSTRAINT fk_sim_disciplina FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id),
  CONSTRAINT fk_sim_turma FOREIGN KEY (turma_id) REFERENCES turmas(id),
  CONSTRAINT fk_sim_criador FOREIGN KEY (criado_por) REFERENCES usuarios(id)
) ENGINE=InnoDB;

-- ---------- Provas aplicadas (aluno <-> simulado) ----------
CREATE TABLE provas_aplicadas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  simulado_id INT NOT NULL,
  aluno_id INT NOT NULL,
  status ENUM('gerada','em_andamento','concluida','expirada') DEFAULT 'gerada',
  iniciada_em DATETIME,
  finalizada_em DATETIME,
  tempo_gasto_segundos INT,
  perdas_foco INT DEFAULT 0,
  assinatura_ciencia VARCHAR(255),
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_pa_simulado FOREIGN KEY (simulado_id) REFERENCES simulados(id),
  CONSTRAINT fk_pa_aluno FOREIGN KEY (aluno_id) REFERENCES usuarios(id),
  UNIQUE KEY uq_prova_aluno (simulado_id, aluno_id)   -- 1 prova por aluno/simulado
) ENGINE=InnoDB;

-- ---------- Questões sorteadas da prova ----------
CREATE TABLE prova_questoes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  prova_aplicada_id INT NOT NULL,
  questao_id INT NOT NULL,
  ordem INT NOT NULL,
  anulada BOOLEAN DEFAULT FALSE,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_pq_prova FOREIGN KEY (prova_aplicada_id) REFERENCES provas_aplicadas(id) ON DELETE CASCADE,
  CONSTRAINT fk_pq_questao FOREIGN KEY (questao_id) REFERENCES questoes(id),
  UNIQUE KEY uq_prova_questao (prova_aplicada_id, questao_id)  -- sem repetição
) ENGINE=InnoDB;

-- ---------- Respostas ----------
CREATE TABLE respostas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  prova_aplicada_id INT NOT NULL,
  questao_id INT NOT NULL,
  letra_marcada CHAR(1),
  correta BOOLEAN,
  respondida_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_resp_prova FOREIGN KEY (prova_aplicada_id) REFERENCES provas_aplicadas(id) ON DELETE CASCADE,
  CONSTRAINT fk_resp_questao FOREIGN KEY (questao_id) REFERENCES questoes(id),
  UNIQUE KEY uq_resposta (prova_aplicada_id, questao_id)
) ENGINE=InnoDB;

-- ---------- Eventos de perda de foco (auditoria) ----------
CREATE TABLE eventos_foco (
  id INT AUTO_INCREMENT PRIMARY KEY,
  prova_aplicada_id INT NOT NULL,
  questao_id INT,
  tipo ENUM('blur','visibilitychange','copy','paste') NOT NULL,
  ocorrido_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_ef_prova FOREIGN KEY (prova_aplicada_id) REFERENCES provas_aplicadas(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------- Resultados ----------
CREATE TABLE resultados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  prova_aplicada_id INT NOT NULL UNIQUE,
  total_questoes INT NOT NULL,
  acertos INT NOT NULL,
  nota DECIMAL(4,2) NOT NULL,
  mencao ENUM('I','R','B','MB') NOT NULL,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_res_prova FOREIGN KEY (prova_aplicada_id) REFERENCES provas_aplicadas(id) ON DELETE CASCADE
) ENGINE=InnoDB;
