-- ==========================================================
--  Migração: Auto-cadastro de alunos e professores
--  Aplique este script em bancos JÁ EXISTENTES (o setup.js recria tudo com DROP).
--    mysql -u USUARIO -p simulados_etec_abh < database/alter_autocadastro.sql
-- ==========================================================
USE simulados_etec_abh;

-- 1) Situação do cadastro do usuário
ALTER TABLE usuarios
  ADD COLUMN status_cadastro ENUM('auto_pendente','aprovado','recusado')
  NOT NULL DEFAULT 'aprovado' AFTER is_root;

-- Usuários que já existiam continuam liberados
UPDATE usuarios SET status_cadastro = 'aprovado';

-- 2) Códigos de convite para auto-cadastro (definidos pelo admin em /admin/unidades)
ALTER TABLE unidades
  ADD COLUMN codigo_aluno VARCHAR(40) AFTER logo_path,
  ADD COLUMN codigo_professor VARCHAR(40) AFTER codigo_aluno;

-- 3) Vínculo professor <-> turmas
CREATE TABLE IF NOT EXISTS professor_turmas (
  professor_id INT NOT NULL,
  turma_id INT NOT NULL,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (professor_id, turma_id),
  CONSTRAINT fk_pt_prof FOREIGN KEY (professor_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  CONSTRAINT fk_pt_turma FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE CASCADE
) ENGINE=InnoDB;
