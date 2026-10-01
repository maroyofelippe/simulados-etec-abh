// ==========================================================
//  Middleware de AUTORIZAÇÃO (RBAC - controle por perfil)
//  Uso: rbac('professor','coordenador')
//  root (is_root) tem acesso a tudo (exceto marcar respostas de alunos).
//  leitura tem acesso de apenas-leitura a tudo (ver ADR abaixo).
// ==========================================================
function rbac(...perfisPermitidos) {
  return (req, res, next) => {
    const u = req.usuario;
    if (!u) return res.status(401).json({ erro: 'Não autenticado.' });

    // root passa por qualquer verificação de leitura/gestão
    if (u.is_root) return next();

    if (perfisPermitidos.includes(u.perfil)) return next();

    // Perfil "leitura": conta institucional usada para exibir o sistema
    // completo (qualquer tela que outro perfil consiga abrir) durante a
    // Feira de Profissões, sem permitir nenhuma ação de escrita. Passa em
    // qualquer checagem de rbac() desde que o método HTTP seja seguro
    // (GET/HEAD); POST/PUT/PATCH/DELETE continuam bloqueados.
    if (u.perfil === 'leitura' && ['GET', 'HEAD'].includes(req.method)) return next();

    if (req.originalUrl.startsWith('/api') || req.xhr) {
      return res.status(403).json({ erro: 'Acesso negado para o seu perfil.' });
    }
    return res.status(403).render('erros/403', { titulo: 'Acesso negado' });
  };
}

// Middleware específico: exige perfil root já elevado
function exigirRoot(req, res, next) {
  if (req.usuario && req.usuario.is_root) return next();
  if (req.originalUrl.startsWith('/api') || req.xhr) {
    return res.status(403).json({ erro: 'Requer privilégio root.' });
  }
  return res.status(403).render('erros/403', { titulo: 'Requer privilégio root' });
}

module.exports = { rbac, exigirRoot };
