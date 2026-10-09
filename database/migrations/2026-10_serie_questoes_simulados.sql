-- ==========================================================
--  Migração IDEMPOTENTE: ano/série das questões e dos simulados
--  ----------------------------------------------------------
--  - questoes.serie já existe ("1ª Série EM", "2ª Série EM", "3ª Série EM",
--    "9º Ano EF"). As questões do Vestibulinho ETEC (serie = 'Vestibulinho')
--    passam a ser classificadas como '9º Ano EF'.
--  - simulados.series (JSON, NULL = automático): séries das quais o simulado
--    sorteia questões. NULL = série da turma de aplicação (ou qualquer série,
--    se não houver turma/série). Ex.: ["1ª Série EM","2ª Série EM","3ª Série EM"].
-- ==========================================================
UPDATE questoes SET serie = '9º Ano EF' WHERE serie = 'Vestibulinho';

SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'simulados' AND COLUMN_NAME = 'series');
SET @sql := IF(@c = 0, 'ALTER TABLE simulados ADD COLUMN series JSON NULL AFTER origem', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
