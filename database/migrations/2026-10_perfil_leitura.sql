-- ==========================================================
--  Migração IDEMPOTENTE: Perfil "leitura" (conta institucional de
--  apenas-leitura, para demonstrar o sistema completo durante a
--  Feira de Profissões, sem permitir nenhuma alteração).
--  ----------------------------------------------------------
--  Acrescenta:
--    - perfil 'leitura' em usuarios.perfil
--    - usuário institucional read@cps.sp.gov.br (senha padrão fixa,
--      redefinida automaticamente para o mesmo valor em qualquer
--      reset — nunca definida pelo próprio usuário)
--
--  Pode ser executada mais de uma vez sem erro.
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-10_perfil_leitura.sql)
-- ==========================================================

-- 1) usuarios.perfil -> acrescenta 'leitura' ao ENUM --------------------------
ALTER TABLE usuarios
  MODIFY COLUMN perfil ENUM('aluno','professor','coordenador','visitante_feira','leitura')
  NOT NULL DEFAULT 'aluno';

-- 2) Usuário institucional de leitura (vinculado à primeira unidade cadastrada)
-- Senha padrão: Leitura@2026 (hash bcrypt abaixo). Sempre que redefinida via
-- /admin/usuarios/:id/resetar-senha, volta para este mesmo valor (ver
-- adminController.resetarSenha) — não há caminho no sistema para trocá-la.
INSERT INTO usuarios (nome, email, senha_hash, perfil, ativo, status_cadastro, unidade_id)
SELECT 'Leitura (Feira de Profissões)', 'read@cps.sp.gov.br',
       '$2a$10$IMKSnHg.oc52Az.pyPyDsOHe9ieISG4gFxZVsnQNy9JkplfACEEpu',
       'leitura', TRUE, 'aprovado', u.id
FROM (SELECT id FROM unidades ORDER BY id LIMIT 1) AS u
WHERE NOT EXISTS (SELECT 1 FROM usuarios WHERE email = 'read@cps.sp.gov.br');
