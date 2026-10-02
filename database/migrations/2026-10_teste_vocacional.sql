-- ==========================================================
--  Migração IDEMPOTENTE: Teste Vocacional (Feira de Profissões)
--  ----------------------------------------------------------
--  Módulo separado do simulado, reaproveitando apenas a tabela "usuarios"
--  (perfil visitante_feira). Cria:
--    - voc_areas              12 áreas/cursos da unidade + grande área
--    - voc_afirmacoes         36 afirmações (3 por área), nota 1 a 5
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
  grupo ENUM('tec','saude','gestao','servicos') NOT NULL,
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

-- 8) Reset de dados do questionário antigo (8 áreas) --------------------------
--  Só executa enquanto a área antiga 'QUI' (Química) ainda existir, ou seja,
--  uma única vez: pontuações do modelo anterior não são comparáveis com as
--  novas áreas. Participantes voltam para 'pendente' e refazem o teste; as
--  respostas abertas são mantidas. Reexecutar a migração não apaga mais nada.
UPDATE voc_aplicacoes SET status = 'pendente', ordem_afirmacoes = NULL, iniciada_em = NULL,
  finalizada_em = NULL, area_principal = NULL, area_alternativa = NULL,
  empate_tecnico = NULL, perfil_indefinido = FALSE
WHERE EXISTS (SELECT 1 FROM voc_areas WHERE codigo = 'QUI');
DELETE FROM voc_resultados WHERE EXISTS (SELECT 1 FROM voc_areas WHERE codigo = 'QUI');
DELETE FROM voc_respostas  WHERE EXISTS (SELECT 1 FROM voc_areas WHERE codigo = 'QUI');

-- 9) Conteúdo do questionário (ids fixos => re-execução apenas atualiza) -----
-- Grupo novo 'servicos' (comunicação, comércio e turismo) para bases já criadas
ALTER TABLE voc_areas MODIFY COLUMN grupo ENUM('tec','saude','gestao','servicos') NOT NULL;

INSERT INTO voc_areas (codigo, nome, grupo, descricao, ordem) VALUES
  ('DS', 'Desenvolvimento de Sistemas', 'tec', 'Você gosta de lógica, de resolver problemas e de ver como as coisas funcionam por dentro. O curso trabalha programação, banco de dados e criação de aplicativos.', 1),
  ('IPI', 'Informática para Internet', 'tec', 'Você junta criatividade visual com tecnologia. O curso trabalha criação de sites, design de interfaces e presença digital.', 2),
  ('JD', 'Programação de Jogos Digitais', 'tec', 'Você se interessa por personagens, cenários e histórias interativas. O curso une programação, arte digital e design de jogos.', 3),
  ('ELE', 'Eletrônica e Eletroeletrônica', 'tec', 'Você gosta de mexer em aparelhos, circuitos e sensores e de entender como a eletrônica controla máquinas. O curso trabalha eletrônica analógica e digital, microcontroladores e automação.', 4),
  ('ETC', 'Eletrotécnica', 'tec', 'Você se interessa por energia elétrica, instalações e segurança no uso da eletricidade. O curso trabalha instalações elétricas, motores, geração e distribuição de energia.', 5),
  ('FAR', 'Farmácia', 'saude', 'Você presta atenção em detalhes e quer cuidar das pessoas. O curso trabalha medicamentos, atendimento e orientação sobre o uso correto.', 6),
  ('BIO', 'Biotecnologia', 'saude', 'Você tem curiosidade sobre seres vivos, DNA e microrganismos, e gosta de laboratório. O curso aplica a biologia em saúde, alimentos e meio ambiente.', 7),
  ('ADM', 'Administração', 'gestao', 'Você gosta de organizar, planejar e liderar. O curso trabalha gestão, finanças, processos e rotinas administrativas das empresas.', 8),
  ('RH', 'Recursos Humanos', 'gestao', 'Você se interessa por pessoas, por como elas trabalham em equipe e como se sentem na empresa. O curso trabalha recrutamento, treinamento, folha de pagamento e clima organizacional.', 9),
  ('GP', 'Gestão de Projetos (Especialização EAD)', 'gestao', 'Você gosta de planejar do início ao fim, cumprir prazos e coordenar equipes e recursos. A especialização trabalha escopo, cronograma, custos e riscos de projetos.', 10),
  ('SEC', 'Secretariado (EAD)', 'gestao', 'Você é organizado, comunicativo e gosta de apoiar a rotina de executivos e equipes. O curso trabalha agenda, documentos, eventos e atendimento profissional.', 11),
  ('MKT', 'Marketing', 'servicos', 'Você gosta de criar ideias, entender o que as pessoas desejam e divulgar produtos e marcas. O curso trabalha pesquisa de mercado, redes sociais, publicidade e comunicação.', 12),
  ('COM', 'Comércio (EAD)', 'servicos', 'Você gosta de vender, atender clientes e entender como funciona uma loja. O curso trabalha vendas, estoque, atendimento e negociação.', 13),
  ('TUR', 'Guia de Turismo (EAD)', 'servicos', 'Você gosta de viajar, conhecer lugares e culturas e contar histórias para as pessoas. O curso trabalha roteiros, patrimônio histórico, atendimento a turistas e eventos.', 14),
  ('TI', 'Transações Imobiliárias (EAD)', 'servicos', 'Você se interessa por casas, negócios e por ajudar pessoas a realizar o sonho da casa própria. O curso trabalha avaliação de imóveis, contratos, financiamento e negociação.', 15)
ON DUPLICATE KEY UPDATE nome = VALUES(nome), grupo = VALUES(grupo), descricao = VALUES(descricao), ordem = VALUES(ordem);

INSERT INTO voc_afirmacoes (id, area_codigo, texto, ativa) VALUES
  (1, 'DS', 'Gosto de entender como aplicativos e sistemas funcionam por dentro.', TRUE),
  (2, 'DS', 'Tenho prazer em resolver desafios de lógica e raciocínio.', TRUE),
  (3, 'DS', 'Me interessa criar programas que automatizem tarefas.', TRUE),
  (4, 'IPI', 'Gosto de personalizar páginas, perfis ou layouts para ficarem bonitos.', TRUE),
  (5, 'IPI', 'Tenho curiosidade sobre como sites e redes sociais são construídos.', TRUE),
  (6, 'IPI', 'Gosto de unir criatividade visual com tecnologia.', TRUE),
  (7, 'JD', 'Já imaginei como seria criar meu próprio jogo.', TRUE),
  (8, 'JD', 'Me chamam atenção os personagens, cenários e histórias dos jogos.', TRUE),
  (9, 'JD', 'Gostaria de trabalhar com animação, arte digital ou programação de jogos.', TRUE),
  (10, 'ELE', 'Gosto de desmontar aparelhos para descobrir como funcionam por dentro.', TRUE),
  (11, 'ELE', 'Me interessa montar circuitos, robôs ou projetos com sensores e placas como Arduino.', TRUE),
  (12, 'ELE', 'Tenho curiosidade sobre como a eletrônica controla máquinas e equipamentos automaticamente.', TRUE),
  (13, 'ETC', 'Tenho curiosidade sobre como a energia elétrica chega até as casas e fábricas.', TRUE),
  (14, 'ETC', 'Me interessa aprender a fazer instalações elétricas, como tomadas, quadros e iluminação.', TRUE),
  (15, 'ETC', 'Gosto de trabalhos práticos que exigem atenção às normas de segurança.', TRUE),
  (16, 'FAR', 'Tenho curiosidade sobre como os medicamentos agem no corpo.', TRUE),
  (17, 'FAR', 'Sou atento a detalhes, como doses e instruções.', TRUE),
  (18, 'FAR', 'Gostaria de orientar pessoas sobre o uso correto de medicamentos.', TRUE),
  (19, 'BIO', 'Tenho curiosidade sobre DNA, microrganismos e seres vivos.', TRUE),
  (20, 'BIO', 'Gosto de experimentos e aulas de laboratório.', TRUE),
  (21, 'BIO', 'Me interessam soluções biológicas para saúde, alimentos ou meio ambiente.', TRUE),
  (22, 'ADM', 'Gosto de organizar, planejar e liderar grupos.', TRUE),
  (23, 'ADM', 'Me interesso por como empresas funcionam: finanças, processos e gestão.', TRUE),
  (24, 'ADM', 'Gosto de manter documentos, planilhas e rotinas em ordem.', TRUE),
  (25, 'RH', 'Gosto de ouvir as pessoas e ajudar a resolver conflitos entre elas.', TRUE),
  (26, 'RH', 'Me interessa saber como as empresas escolhem, contratam e treinam seus funcionários.', TRUE),
  (27, 'RH', 'Acredito que um bom ambiente de trabalho faz a equipe render mais.', TRUE),
  (28, 'GP', 'Gosto de planejar uma tarefa grande em etapas, com prazos definidos.', TRUE),
  (29, 'GP', 'Me sinto bem coordenando pessoas e recursos para entregar um resultado combinado.', TRUE),
  (30, 'GP', 'Gosto de prever problemas e buscar soluções antes que eles aconteçam.', TRUE),
  (31, 'SEC', 'Gosto de organizar agendas, compromissos e documentos para outras pessoas.', TRUE),
  (32, 'SEC', 'Tenho facilidade para me comunicar com educação e profissionalismo, por escrito e pessoalmente.', TRUE),
  (33, 'SEC', 'Gostaria de organizar reuniões e eventos e apoiar a rotina de uma empresa.', TRUE),
  (34, 'MKT', 'Gosto de criar ideias para divulgar um produto, uma marca ou um evento.', TRUE),
  (35, 'MKT', 'Tenho curiosidade sobre o que faz as pessoas desejarem comprar determinadas coisas.', TRUE),
  (36, 'MKT', 'Me interesso por redes sociais, propaganda e campanhas de comunicação.', TRUE),
  (37, 'COM', 'Gosto de atender bem as pessoas e entender o que elas precisam.', TRUE),
  (38, 'COM', 'Tenho facilidade para negociar, vender e convencer.', TRUE),
  (39, 'COM', 'Me interessa saber como funciona uma loja: estoque, preços e atendimento.', TRUE),
  (40, 'TUR', 'Gosto de conhecer lugares, culturas e histórias diferentes.', TRUE),
  (41, 'TUR', 'Me sinto à vontade para falar em público e contar histórias.', TRUE),
  (42, 'TUR', 'Gostaria de acompanhar turistas e apresentar a eles pontos turísticos e a história da região.', TRUE),
  (43, 'TI', 'Me interesso por casas, apartamentos e pelo mercado imobiliário.', TRUE),
  (44, 'TI', 'Gostaria de ajudar pessoas a comprar, vender ou alugar um imóvel.', TRUE),
  (45, 'TI', 'Tenho curiosidade sobre como funcionam contratos, financiamentos e negociações.', TRUE)
ON DUPLICATE KEY UPDATE area_codigo = VALUES(area_codigo), texto = VALUES(texto), ativa = TRUE;

INSERT INTO voc_perguntas_abertas (id, texto, ordem) VALUES
  (1, 'Quais matérias você mais gosta na escola e por quê?', 1),
  (2, 'O que você faz no tempo livre que perde a noção das horas?', 2),
  (3, 'Onde você se imagina trabalhando daqui a 10 anos?', 3)
ON DUPLICATE KEY UPDATE texto = VALUES(texto), ordem = VALUES(ordem);

-- 10) Atribui o teste a todos os visitantes da feira já cadastrados ------------
INSERT IGNORE INTO voc_aplicacoes (usuario_id, status)
SELECT id, 'pendente' FROM usuarios WHERE perfil = 'visitante_feira';


-- 11) Remove as áreas antigas que a unidade não oferece (Química e Nutrição) -
DELETE FROM voc_areas WHERE codigo IN ('QUI','NUT');
