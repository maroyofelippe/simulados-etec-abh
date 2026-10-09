-- ==========================================================
--  Migração IDEMPOTENTE: origem das questões e dos simulados
--  ----------------------------------------------------------
--  - questoes.origem  : SARESP | Provão Paulista | ENEM | Vestibulinho ETEC |
--                       Professor | Outra   (padrão: 'Professor')
--  - simulados.origem : NULL = qualquer origem; senão o simulado só sorteia
--                       questões dessa origem.
--  Questões já existentes ficam como 'Professor' (padrão) — reclassifique as
--  de bancos oficiais com UPDATE questoes SET origem='SARESP' WHERE ...
-- ==========================================================
SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'questoes' AND COLUMN_NAME = 'origem');
SET @sql := IF(@c = 0,
  'ALTER TABLE questoes ADD COLUMN origem VARCHAR(40) NOT NULL DEFAULT ''Professor'' AFTER serie, ADD INDEX idx_questao_origem (origem)',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'simulados' AND COLUMN_NAME = 'origem');
SET @sql := IF(@c = 0,
  'ALTER TABLE simulados ADD COLUMN origem VARCHAR(40) NULL AFTER tema',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
