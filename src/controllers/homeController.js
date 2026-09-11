// ==========================================================
//  Controller da tela inicial (home)
//  Para o coordenador, monta o placar geral do sistema.
// ==========================================================
const { Turma, Usuario, Unidade, Questao } = require('../models');

// GET /
exports.exibir = async (req, res, next) => {
  try {
    const usuario = req.usuario;
    let placar = null;

    if (usuario.perfil === 'coordenador') {
      const [turmas, alunos, unidades, questoes, visitantesFeira] = await Promise.all([
        Turma.count(),
        Usuario.count({ where: { perfil: 'aluno' } }),
        Unidade.count(),
        Questao.count(),
        Usuario.count({ where: { perfil: 'visitante_feira' } })
      ]);
      placar = { turmas, alunos, unidades, questoes, visitantesFeira };
    }

    res.render('home', { titulo: 'Início', placar });
  } catch (err) { next(err); }
};
