// Controller de importação de USUÁRIOS via CSV (coordenador/root)
const csvService = require('../services/csvService');

exports.tela = (req, res) => {
  res.render('admin/importar_usuarios', { titulo: 'Importar Usuários (CSV)', relatorio: null, erro: null });
};

exports.importar = async (req, res, next) => {
  try {
    if (!req.file) {
      return res.status(400).render('admin/importar_usuarios',
        { titulo: 'Importar Usuários (CSV)', relatorio: null, erro: 'Envie um arquivo CSV.' });
    }
    const unidadeId = req.usuario.unidade_id || parseInt(req.body.unidade_id, 10);
    const relatorio = await csvService.importarUsuarios(req.file.buffer, unidadeId);
    res.render('admin/importar_usuarios', { titulo: 'Importar Usuários (CSV)', relatorio, erro: null });
  } catch (err) {
    res.status(400).render('admin/importar_usuarios',
      { titulo: 'Importar Usuários (CSV)', relatorio: null, erro: err.message });
  }
};
