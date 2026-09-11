-- ==========================================================
--  Migração IDEMPOTENTE: Auto-cadastro de alunos e professores
--  ----------------------------------------------------------
--  Corrige bancos criados ANTES da feature de auto-cadastro, onde faltam:
--    - unidades.codigo_aluno / unidades.codigo_professor  -> erro "Unknown column 'codigo_aluno' in 'field list'"
--    - usuarios.status_cadastro
--    - tabela professor_turmas
--
--  Pode ser executada mais de uma vez sem erro (verifica antes de alterar).
--
--  Uso:
--    mysql -u USUARIO -p simulados_etec_abh < database/migrations/2025-08_auto_cadastro.sql
-- ==========================================================
SET @db := DATABASE();

-- 1) usuarios.status_cadastro -------------------------------------------------
SET @sql := IF(
  NOT EXISTS(SELECT 1 FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'usuarios' AND COLUMN_NAME = 'status_cadastro'),
  "ALTER TABLE usuarios ADD COLUMN status_cadastro ENUM('auto_pendente','aprovado','recusado') NOT NULL DEFAULT 'aprovado' AFTER is_root",
  'DO 0');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- Usuários que já existiam continuam liberados
UPDATE usuarios SET status_cadastro = 'aprovado' WHERE status_cadastro IS NULL;

-- 2) unidades.codigo_aluno --------------------------------------------------
SET @sql := IF(
  NOT EXISTS(SELECT 1 FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'unidades' AND COLUMN_NAME = 'codigo_aluno'),
  'ALTER TABLE unidades ADD COLUMN codigo_aluno VARCHAR(40) AFTER logo_path',
  'DO 0');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- 3) unidades.codigo_professor --------------------------------------------
SET @sql := IF(
  NOT EXISTS(SELECT 1 FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'unidades' AND COLUMN_NAME = 'codigo_professor'),
  'ALTER TABLE unidades ADD COLUMN codigo_professor VARCHAR(40) AFTER codigo_aluno',
  'DO 0');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- 4) professor_turmas -----------------------------------------------------
CREATE TABLE IF NOT EXISTS professor_turmas (
  professor_id INT NOT NULL,
  turma_id INT NOT NULL,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (professor_id, turma_id),
  CONSTRAINT fk_pt_prof FOREIGN KEY (professor_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  CONSTRAINT fk_pt_turma FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 5) (opcional) define os códigos de convite da unidade seed, se ainda vazios
UPDATE unidades
   SET codigo_aluno     = COALESCE(codigo_aluno, 'ABH-ALUNO-2025'),
       codigo_professor = COALESCE(codigo_professor, 'ABH-PROF-2025')
 WHERE id = 1;
