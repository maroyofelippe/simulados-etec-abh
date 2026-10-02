-- ==========================================================
--  Migração IDEMPOTENTE: Teste Vocacional (Feira de Profissões)
--  ----------------------------------------------------------
--  Módulo separado do simulado, reaproveitando apenas a tabela "usuarios"
--  (perfil visitante_feira). Cria:
--    - voc_areas              8 áreas/cursos avaliados + grande área
--    - voc_afirmacoes         24 afirmações (3 por área), nota 1 a 5
--    - voc_perguntas_abertas  3 perguntas abertas
--    - voc_aplicacoes         1 teste por usuário (atribuído automaticamente)
--    - voc_respostas          nota dada a cada afirmação
--    - voc_respostas_abertas  respostas às perguntas abertas
--    - voc_resultados         pontuação por área (3 a 15) + posição no ranking
--  Também atribui o teste (status 'pendente') a todos os visitantes da
--  feira já cadastrados. Novos cadastros recebem o teste no auto-cadastro.
--
--  Pode ser executada mais de uma vez sem erro.
--  Uso:  npm run db:migrate
-- ==========================================================

-- 1) Áreas -------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS voc_areas (
  codigo VARCHAR(5) PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  grupo ENUM('tec','saude','gestao') NOT NULL,
  descricao TEXT NOT NULL,
  ordem INT NOT NULL,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2) Afirmações --------------------------------------------------------------
CREATE TABLE IF NOT EXISTS voc_afirmacoes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  area_codigo VARCHAR(5) NOT NULL,
  texto VARCHAR(255) NOT NULL,
  ativa BOOLEAN NOT NULL DEFAULT TRUE,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_voc_afirm_area FOREIGN KEY (area_codigo) REFERENCES voc_areas(codigo)
) ENGINE=InnoDB;

-- 3) Perguntas abertas -------------------------------------------------------
CREATE TABLE IF NOT EXISTS voc_perguntas_abertas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  texto VARCHAR(255) NOT NULL,
  ordem INT NOT NULL,
  ativa BOOLEAN NOT NULL DEFAULT TRUE,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 4) Aplicações (1 por usuário) ----------------------------------------------
CREATE TABLE IF NOT EXISTS voc_aplicacoes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  status ENUM('pendente','em_andamento','concluida') NOT NULL DEFAULT 'pendente',
  ordem_afirmacoes JSON,                 -- ids das afirmações na ordem embaralhada deste participante
  iniciada_em DATETIME,
  finalizada_em DATETIME,
  area_principal VARCHAR(5),
  area_alternativa VARCHAR(5),
  empate_tecnico JSON,                   -- códigos das áreas a até 1 ponto da maior
  perfil_indefinido BOOLEAN NOT NULL DEFAULT FALSE,   -- maior soma < 8
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_voc_apl_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  CONSTRAINT fk_voc_apl_principal FOREIGN KEY (area_principal) REFERENCES voc_areas(codigo),
  CONSTRAINT fk_voc_apl_alternativa FOREIGN KEY (area_alternativa) REFERENCES voc_areas(codigo),
  UNIQUE KEY uq_voc_aplicacao_usuario (usuario_id)   -- 1 teste por participante
) ENGINE=InnoDB;

-- 5) Respostas às afirmações -------------------------------------------------
CREATE TABLE IF NOT EXISTS voc_respostas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  aplicacao_id INT NOT NULL,
  afirmacao_id INT NOT NULL,
  nota TINYINT NOT NULL,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT chk_voc_nota CHECK (nota BETWEEN 1 AND 5),
  CONSTRAINT fk_voc_resp_apl FOREIGN KEY (aplicacao_id) REFERENCES voc_aplicacoes(id) ON DELETE CASCADE,
  CONSTRAINT fk_voc_resp_afirm FOREIGN KEY (afirmacao_id) REFERENCES voc_afirmacoes(id),
  UNIQUE KEY uq_voc_resposta (aplicacao_id, afirmacao_id)
) ENGINE=InnoDB;

-- 6) Respostas abertas -------------------------------------------------------
CREATE TABLE IF NOT EXISTS voc_respostas_abertas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  aplicacao_id INT NOT NULL,
  pergunta_id INT NOT NULL,
  resposta TEXT,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_voc_aberta_apl FOREIGN KEY (aplicacao_id) REFERENCES voc_aplicacoes(id) ON DELETE CASCADE,
  CONSTRAINT fk_voc_aberta_perg FOREIGN KEY (pergunta_id) REFERENCES voc_perguntas_abertas(id),
  UNIQUE KEY uq_voc_resposta_aberta (aplicacao_id, pergunta_id)
) ENGINE=InnoDB;

-- 7) Resultado por área ------------------------------------------------------
CREATE TABLE IF NOT EXISTS voc_resultados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  aplicacao_id INT NOT NULL,
  area_codigo VARCHAR(5) NOT NULL,
  pontos INT NOT NULL,                   -- soma das 3 notas (3 a 15)
  posicao INT NOT NULL,                  -- 1 = maior afinidade
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_voc_res_apl FOREIGN KEY (aplicacao_id) REFERENCES voc_aplicacoes(id) ON DELETE CASCADE,
  CONSTRAINT fk_voc_res_area FOREIGN KEY (area_codigo) REFERENCES voc_areas(codigo),
  UNIQUE KEY uq_voc_resultado (aplicacao_id, area_codigo)
) ENGINE=InnoDB;

-- 8) Conteúdo do questionário (ids fixos => re-execução apenas atualiza) -----
INSERT INTO voc_areas (codigo, nome, grupo, descricao, ordem) VALUES
  ('DS',  'Desenvolvimento de Sistemas', 'tec',    'Você gosta de lógica, de resolver problemas e de ver como as coisas funcionam por dentro. O curso trabalha programação, banco de dados e criação de aplicativos.', 1),
  ('IPI', 'Informática para Internet',   'tec',    'Você junta criatividade visual com tecnologia. O curso trabalha criação de sites, design de interfaces e presença digital.', 2),
  ('JD',  'Jogos Digitais',              'tec',    'Você se interessa por personagens, cenários e histórias interativas. O curso une programação, arte digital e design de jogos.', 3),
  ('FAR', 'Farmácia',                    'saude',  'Você presta atenção em detalhes e quer cuidar das pessoas. O curso trabalha medicamentos, atendimento e orientação sobre o uso correto.', 4),
  ('BIO', 'Biotecnologia',               'saude',  'Você tem curiosidade sobre seres vivos, DNA e microrganismos, e gosta de laboratório. O curso aplica a biologia em saúde, alimentos e meio ambiente.', 5),
  ('QUI', 'Química',                     'saude',  'Você gosta de entender reações, medidas e precisão. O curso trabalha análises, processos industriais e produção de materiais.', 6),
  ('NUT', 'Nutrição',                    'saude',  'Você se interessa por alimentação e por ajudar pessoas a criar hábitos saudáveis. O curso trabalha composição de alimentos e cardápios.', 7),
  ('ADM', 'Administração',               'gestao', 'Você gosta de organizar, planejar e liderar. O curso trabalha gestão, vendas, finanças e comunicação nas empresas.', 8)
ON DUPLICATE KEY UPDATE nome = VALUES(nome), grupo = VALUES(grupo), descricao = VALUES(descricao), ordem = VALUES(ordem);

INSERT INTO voc_afirmacoes (id, area_codigo, texto) VALUES
  (1,  'DS',  'Gosto de entender como aplicativos e sistemas funcionam por dentro.'),
  (2,  'DS',  'Tenho prazer em resolver desafios de lógica e raciocínio.'),
  (3,  'DS',  'Me interessa criar programas que automatizem tarefas.'),
  (4,  'IPI', 'Gosto de personalizar páginas, perfis ou layouts para ficarem bonitos.'),
  (5,  'IPI', 'Tenho curiosidade sobre como sites e redes sociais são construídos.'),
  (6,  'IPI', 'Gosto de unir criatividade visual com tecnologia.'),
  (7,  'JD',  'Já imaginei como seria criar meu próprio jogo.'),
  (8,  'JD',  'Me chamam atenção os personagens, cenários e histórias dos jogos.'),
  (9,  'JD',  'Gostaria de trabalhar com animação, arte digital ou programação de jogos.'),
  (10, 'FAR', 'Tenho curiosidade sobre como os medicamentos agem no corpo.'),
  (11, 'FAR', 'Sou atento a detalhes, como doses e instruções.'),
  (12, 'FAR', 'Gostaria de orientar pessoas sobre o uso correto de medicamentos.'),
  (13, 'BIO', 'Tenho curiosidade sobre DNA, microrganismos e seres vivos.'),
  (14, 'BIO', 'Gosto de experimentos e aulas de laboratório.'),
  (15, 'BIO', 'Me interessam soluções biológicas para saúde, alimentos ou meio ambiente.'),
  (16, 'QUI', 'Gosto de entender reações, misturas e transformações de substâncias.'),
  (17, 'QUI', 'Tenho facilidade com cálculos, medidas e precisão.'),
  (18, 'QUI', 'Me interessa saber como cosméticos, tintas e plásticos são produzidos.'),
  (19, 'NUT', 'Me interesso por alimentação e seus efeitos na saúde.'),
  (20, 'NUT', 'Gosto de ajudar pessoas a criar hábitos mais saudáveis.'),
  (21, 'NUT', 'Tenho curiosidade sobre a composição dos alimentos e a montagem de cardápios.'),
  (22, 'ADM', 'Gosto de organizar, planejar e liderar grupos.'),
  (23, 'ADM', 'Me interesso por como empresas funcionam: vendas, finanças e gestão.'),
  (24, 'ADM', 'Tenho facilidade para comunicar, negociar e convencer pessoas.')
ON DUPLICATE KEY UPDATE area_codigo = VALUES(area_codigo), texto = VALUES(texto);

INSERT INTO voc_perguntas_abertas (id, texto, ordem) VALUES
  (1, 'Quais matérias você mais gosta na escola e por quê?', 1),
  (2, 'O que você faz no tempo livre que perde a noção das horas?', 2),
  (3, 'Onde você se imagina trabalhando daqui a 10 anos?', 3)
ON DUPLICATE KEY UPDATE texto = VALUES(texto), ordem = VALUES(ordem);

-- 9) Atribui o teste a todos os visitantes da feira já cadastrados ------------
INSERT IGNORE INTO voc_aplicacoes (usuario_id, status)
SELECT id, 'pendente' FROM usuarios WHERE perfil = 'visitante_feira';
