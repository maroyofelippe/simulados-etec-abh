-- ==========================================================
--  Migração IDEMPOTENTE: Auto-cadastro de visitantes da Feira de Profissões
--  ----------------------------------------------------------
--  Acrescenta:
--    - perfil 'visitante_feira' em usuarios.perfil
--    - usuarios.telefone / data_nascimento / relacao_etec / curso_interesse
--    - turma "Feira de Profissões" (vinculada à primeira unidade cadastrada)
--
--  Pode ser executada mais de uma vez sem erro (verifica antes de alterar).
--
--  Uso:
--    mysql -u USUARIO -p simulados_etec_abh < database/migrations/2025-09_visitante_feira.sql
-- ==========================================================
SET @db := DATABASE();

-- 1) usuarios.perfil -> acrescenta 'visitante_feira' ao ENUM ------------------
ALTER TABLE usuarios
  MODIFY COLUMN perfil ENUM('aluno','professor','coordenador','visitante_feira')
  NOT NULL DEFAULT 'aluno';

-- 2) usuarios.telefone --------------------------------------------------------
SET @sql := IF(
  NOT EXISTS(SELECT 1 FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'usuarios' AND COLUMN_NAME = 'telefone'),
  'ALTER TABLE usuarios ADD COLUMN telefone VARCHAR(20) AFTER rm',
  'DO 0');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- 3) usuarios.data_nascimento -------------------------------------------------
SET @sql := IF(
  NOT EXISTS(SELECT 1 FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'usuarios' AND COLUMN_NAME = 'data_nascimento'),
  'ALTER TABLE usuarios ADD COLUMN data_nascimento DATE AFTER telefone',
  'DO 0');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- 4) usuarios.relacao_etec -----------------------------------------------------
SET @sql := IF(
  NOT EXISTS(SELECT 1 FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'usuarios' AND COLUMN_NAME = 'relacao_etec'),
  "ALTER TABLE usuarios ADD COLUMN relacao_etec ENUM('ex_aluno','candidato','responsavel','aluno') AFTER data_nascimento",
  'DO 0');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- 5) usuarios.curso_interesse --------------------------------------------------
SET @sql := IF(
  NOT EXISTS(SELECT 1 FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'usuarios' AND COLUMN_NAME = 'curso_interesse'),
  "ALTER TABLE usuarios ADD COLUMN curso_interesse ENUM('Desenvolvimento de Sistemas','Jogos Digitais','Administração','Farmácia','Biotecnologia','Marketing') AFTER relacao_etec",
  'DO 0');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- 6) Turma "Feira de Profissões" (vinculada à primeira unidade) ---------------
INSERT INTO turmas (nome, serie, periodo, ano_letivo, unidade_id)
SELECT 'Feira de Profissões', 'Visitantes', 'Integral', YEAR(CURDATE()), u.id
FROM (SELECT id FROM unidades ORDER BY id LIMIT 1) AS u
WHERE NOT EXISTS (SELECT 1 FROM turmas WHERE nome = 'Feira de Profissões');
