// Seção CURSOS (landing pages) — visitante da Feira de Profissões
const cursos = require('../config/cursos');

// GET /cursos
exports.listar = (req, res) => {
  res.render('cursos/lista', { titulo: 'Cursos', cursos: cursos.listar() });
};

// GET /cursos/:slug
exports.detalhar = (req, res, next) => {
  const achado = cursos.buscar(req.params.slug);
  if (!achado) return next();
  res.render('cursos/detalhe', { titulo: achado.curso.nome, paragrafos: cursos.paragrafos, ...achado });
};
