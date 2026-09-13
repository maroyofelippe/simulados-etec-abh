-- ==========================================================
--  Migração: acompanhamento de atividade da sessão + desconexão forçada
--  ----------------------------------------------------------
--  - sessoes.ultima_atividade: espelha em banco o cookie "ultima_atividade"
--    (sliding session), atualizado a cada requisição autenticada. Usado pela
--    tela /admin/usuarios para mostrar se o usuário está logado e o tempo
--    restante até o timeout por inatividade (SESSION_TIMEOUT).
--  - encerrada_por ganha o valor 'forcado': sessão fechada pelo administrador
--    (botão "Desconectar" em /admin/usuarios), distinto de logout/timeout.
--
--  Idempotente: MySQL não aceita "ADD COLUMN IF NOT EXISTS" (isso é MariaDB),
--  então checamos a coluna via information_schema e montamos o ALTER TABLE
--  dinamicamente com PREPARE/EXECUTE — sem DELIMITER/stored procedures
--  (incompatível com a execução via db:migrate / mysql2).
--  Uso:  npm run db:migrate
-- ==========================================================
SET @coluna_existe := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'sessoes' AND COLUMN_NAME = 'ultima_atividade'
);
SET @sql := IF(@coluna_existe = 0,
  'ALTER TABLE sessoes ADD COLUMN ultima_atividade DATETIME AFTER inicio',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- MODIFY COLUMN é naturalmente idempotente (redefinir o mesmo ENUM não gera erro).
ALTER TABLE sessoes
  MODIFY COLUMN encerrada_por ENUM('logout','timeout','ativa','forcado') DEFAULT 'ativa';
