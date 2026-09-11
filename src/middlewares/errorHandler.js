// Tratamento de erros centralizado
function errorHandler(err, req, res, next) { // eslint-disable-line
  // eslint-disable-next-line no-console
  console.error('[ERRO]', err.message);
  const status = err.status || 500;
  const msg = err.message || 'Erro interno do servidor.';

  if (req.originalUrl.startsWith('/api') || req.xhr) {
    return res.status(status).json({ erro: msg });
  }
  return res.status(status).render('erros/500', { titulo: 'Erro', mensagem: msg });
}

// 404
function notFound(req, res) {
  if (req.originalUrl.startsWith('/api')) {
    return res.status(404).json({ erro: 'Recurso não encontrado.' });
  }
  return res.status(404).render('erros/404', { titulo: 'Página não encontrada' });
}

module.exports = { errorHandler, notFound };
