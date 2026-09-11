-- ==========================================================
--  SEEDS - Dados iniciais de exemplo
--  Rode APÓS o ddl.sql. As senhas estão com hash bcrypt.
--  Credenciais de teste (senha):
--    Coordenador  -> email: coordenador@etecabh.sp.gov.br  | senha: Coord@2025
--    Professor    -> email: professor@etecabh.sp.gov.br    | senha: Prof@2025
--    Aluno        -> RM: 12345                              | senha: Aluno@2025
--    Visitante da Feira -> email: diego.fernandes@exemplo.com | senha: Visitante@2026
-- ==========================================================
USE simulados_etec_abh;

-- ---------- Unidade ----------
INSERT INTO unidades (id, nome, sigla, cidade, logo_path, codigo_aluno, codigo_professor) VALUES
  (1, 'ETEC Adhemar Batista Heméritas', 'ABH', 'São Paulo', NULL, 'ABH-ALUNO-2025', 'ABH-PROF-2025');

-- ---------- Disciplinas (IDs fixos usados pelo banco de questões) ----------
INSERT INTO disciplinas (id, nome, area) VALUES
  (1, 'Língua Portuguesa', 'Linguagens'),
  (2, 'Matemática', 'Matemática'),
  (3, 'Biologia', 'Ciências da Natureza'),
  (4, 'Física', 'Ciências da Natureza'),
  (5, 'Química', 'Ciências da Natureza'),
  (6, 'História', 'Ciências Humanas'),
  (7, 'Geografia', 'Ciências Humanas');

-- ---------- Turmas ----------
INSERT INTO turmas (id, nome, serie, periodo, ano_letivo, unidade_id) VALUES
  (1, '1º A', '1ª Série EM', 'Manhã', 2025, 1),
  (2, '1º B', '1ª Série EM', 'Tarde', 2025, 1),
  (3, '2º A', '2ª Série EM', 'Manhã', 2025, 1),
  (4, 'Feira de Profissões', 'Visitantes', 'Integral', 2025, 1);

-- ---------- Usuários (hashes bcrypt já calculados) ----------
INSERT INTO usuarios (id, nome, email, rm, senha_hash, perfil, periodo, turma_id, unidade_id) VALUES
  (1, 'Coordenação ABH', 'coordenador@etecabh.sp.gov.br', NULL,
      '$2a$10$clids6Ujjtq/4UV9DP42wOcf4KTPFhMODhv2.WwhCYZQ4PYODC4KS', 'coordenador', 'Integral', NULL, 1),
  (2, 'Professor Exemplo', 'professor@etecabh.sp.gov.br', NULL,
      '$2a$10$xUhg3adaaPht0NlKYddJzO5Snvb0AXrhlssd/jYmKsrh7Y.LxzxCu', 'professor', 'Manhã', NULL, 1),
  (3, 'Ana Souza (aluna)', 'ana.souza@aluno.etecabh.sp.gov.br', '12345',
      '$2a$10$.R9krRwtSokTBjhXZjEZFOfVXFES3aZQ4O2Jgys3vg8kzWe1QX8GG', 'aluno', 'Manhã', 1, 1),
  (4, 'Bruno Lima (aluno)', 'bruno.lima@aluno.etecabh.sp.gov.br', '12346',
      '$2a$10$.R9krRwtSokTBjhXZjEZFOfVXFES3aZQ4O2Jgys3vg8kzWe1QX8GG', 'aluno', 'Manhã', 1, 1),
  (5, 'Carla Dias (aluna)', 'carla.dias@aluno.etecabh.sp.gov.br', '12347',
      '$2a$10$.R9krRwtSokTBjhXZjEZFOfVXFES3aZQ4O2Jgys3vg8kzWe1QX8GG', 'aluno', 'Tarde', 2, 1);

-- ---------- Turmas lecionadas pelo professor de exemplo ----------
INSERT INTO professor_turmas (professor_id, turma_id) VALUES
  (2, 1), (2, 3);

-- ---------- Visitantes da Feira de Profissões (auto-cadastro de exemplo) ----------
-- Acessam a plataforma com a senha padrão institucional (Visitante@2026).
INSERT INTO usuarios
  (nome, email, senha_hash, perfil, ativo, status_cadastro, turma_id, unidade_id,
   telefone, data_nascimento, relacao_etec, curso_interesse) VALUES
  ('Diego Fernandes (visitante)', 'diego.fernandes@exemplo.com',
    '$2a$10$VzR9jJR4ArUfYWa/xFdO9utxhvrESn8ACdwdjB..Jep.F1hRpVTcO', 'visitante_feira', TRUE, 'aprovado', 4, 1,
    '(11) 91234-5678', '2009-03-14', 'candidato', 'Desenvolvimento de Sistemas'),
  ('Marina Alves (visitante)', 'marina.alves@exemplo.com',
    '$2a$10$VzR9jJR4ArUfYWa/xFdO9utxhvrESn8ACdwdjB..Jep.F1hRpVTcO', 'visitante_feira', TRUE, 'aprovado', 4, 1,
    '(11) 99876-5432', '2008-07-22', 'candidato', 'Jogos Digitais'),
  ('Roberto Nogueira (responsável)', 'roberto.nogueira@exemplo.com',
    '$2a$10$VzR9jJR4ArUfYWa/xFdO9utxhvrESn8ACdwdjB..Jep.F1hRpVTcO', 'visitante_feira', TRUE, 'aprovado', 4, 1,
    '(11) 98765-4321', '1979-11-02', 'responsavel', 'Administração');

-- OBS.: o banco de questões é carregado pelo arquivo banco_questoes.sql

-- ---------- Simulados de exemplo (publicados após haver questões) ----------
-- Simulado aleatório por aluno (sorteio individual de até 20 questões)
INSERT INTO simulados (id, titulo, tipo, disciplina_id, qtd_questoes, duracao_minutos, max_perdas_foco, criado_por, turma_id, publicado)
VALUES (1, 'Simulado Diagnóstico - Língua Portuguesa', 'aleatorio_aluno', 1, 6, 30, 0, 2, 1, TRUE);

-- Simulado geral com distribuição por dificuldade
INSERT INTO simulados (id, titulo, tipo, disciplina_id, qtd_questoes, distribuicao_dificuldade, duracao_minutos, max_perdas_foco, criado_por, turma_id, publicado)
VALUES (2, 'Simulado Geral - Matemática (misto)', 'geral', 2, 6,
        JSON_OBJECT('Fácil', 2, 'Médio', 2, 'Difícil', 2), 45, 3, 2, 1, TRUE);
