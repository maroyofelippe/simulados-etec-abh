-- ==========================================================
--  Migração IDEMPOTENTE: usuarios.curso_interesse ENUM -> VARCHAR(100)
--  ----------------------------------------------------------
--  O formulário de auto-cadastro da feira envia nomes completos de curso
--  (ex.: "Farmácia-M-Tec-Tarde"), que não cabiam no ENUM original e geravam
--  "Data truncated for column 'curso_interesse'". Os valores já gravados são
--  preservados. Reexecutar não gera erro (redefinir o mesmo tipo é seguro).
--  Uso:  npm run db:migrate
-- ==========================================================
ALTER TABLE usuarios MODIFY COLUMN curso_interesse VARCHAR(100) NULL;
