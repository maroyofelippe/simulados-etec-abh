-- ==========================================================
--  Migração IDEMPOTENTE: inativação (soft-disable) de turmas e unidades
--  ----------------------------------------------------------
--  Excluir turma/unidade de verdade quebraria o histórico de alunos,
--  professores e provas vinculados a elas. Em vez disso, root pode
--  marcar turma/unidade como inativa: ela some das listas de seleção
--  e formulários, mas os registros e o histórico continuam intactos.
--
--  Pode ser executada mais de uma vez sem erro (verifica antes de alterar).
--
--  Uso:
--    mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-09_ativo_turma_unidade.sql
-- ==========================================================
SET @db := DATABASE();

-- 1) turmas.ativo --------------------------------------------------------
SET @sql := IF(
  NOT EXISTS(SELECT 1 FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'turmas' AND COLUMN_NAME = 'ativo'),
  'ALTER TABLE turmas ADD COLUMN ativo BOOLEAN DEFAULT TRUE AFTER unidade_id',
  'DO 0');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- 2) unidades.ativo -------------------------------------------------------
SET @sql := IF(
  NOT EXISTS(SELECT 1 FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'unidades' AND COLUMN_NAME = 'ativo'),
  'ALTER TABLE unidades ADD COLUMN ativo BOOLEAN DEFAULT TRUE AFTER codigo_professor',
  'DO 0');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;
