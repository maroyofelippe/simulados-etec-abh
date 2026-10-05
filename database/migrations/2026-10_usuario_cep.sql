-- ==========================================================
--  Migração IDEMPOTENTE: usuarios.cep (auto-cadastro de visitante_feira)
--  Armazena apenas os 8 dígitos do CEP. Idempotente via information_schema
--  + PREPARE/EXECUTE (MySQL não aceita ADD COLUMN IF NOT EXISTS).
--  Uso:  npm run db:migrate
-- ==========================================================
SET @coluna_existe := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'usuarios' AND COLUMN_NAME = 'cep'
);
SET @sql := IF(@coluna_existe = 0,
  'ALTER TABLE usuarios ADD COLUMN cep CHAR(8) NULL AFTER data_nascimento',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
