// ==========================================================
//  Gestão de alunos pelo PROFESSOR (correção de cadastro)
//  - Professor: enxerga/edita apenas alunos das turmas que leciona
//  - Coordenador/root: enxerga/edita qualquer aluno (usa também /admin/usuarios)
// ==========================================================
const { Op } = require('sequelize');
const { Usuario, Turma } = require('../models');

// É coordenador ou root elevado?
function ehGestor(u) {
  return u.perfil === 'coordenador' || u.is_root;
}

// Ids das turmas que o professor leciona (gestor => todas)
async function turmasPermitidas(u) {
  if (ehGestor(u)) {
    const todas = await Turma.findAll({ attributes: ['id'] });
    return todas.map((t) => t.id);
  }
  const turmas = await u.getTurmasLecionadas({ attributes: ['id'] });
  return turmas.map((t) => t.id);
}

// GET /professor/alunos
exports.listar = async (req, res, next) => {
  try {
    const idsTurmas = await turmasPermitidas(req.usuario);
    const alunos = idsTurmas.length
      ? await Usuario.findAll({
          where: { perfil: 'aluno', turma_id: { [Op.in]: idsTurmas } },
          include: [{ model: Turma, as: 'turma' }],
          order: [['nome', 'ASC']]
        })
      : [];
    res.render('professor/alunos', {
      titulo: 'Meus Alunos', alunos, semTurmas: !ehGestor(req.usuario) && idsTurmas.length === 0
    });
  } catch (err) { next(err); }
};

// GET /professor/alunos/:id/editar
exports.editarForm = async (req, res, next) => {
  try {
    const aluno = await Usuario.findByPk(req.params.id, { include: [{ model: Turma, as: 'turma' }] });
    if (!aluno || aluno.perfil !== 'aluno') {
      return res.status(404).render('erros/404', { titulo: 'Aluno não encontrado' });
    }
    const idsTurmas = await turmasPermitidas(req.usuario);
    if (!idsTurmas.includes(aluno.turma_id)) {
      return res.status(403).render('erros/403', { titulo: 'Acesso negado' });
    }
    // Só turmas ativas podem ser escolhidas como destino — exceto a turma atual do aluno,
    // que continua listada (mesmo inativa) para não sumir do <select> ao editar.
    const turmas = await Turma.findAll({
      where: { id: { [Op.in]: idsTurmas }, [Op.or]: [{ ativo: true }, { id: aluno.turma_id }] },
      order: [['nome', 'ASC']]
    });
    res.render('professor/aluno_editar', { titulo: `Editar — ${aluno.nome}`, aluno, turmas, erro: null });
  } catch (err) { next(err); }
};

// POST /professor/alunos/:id
exports.atualizar = async (req, res, next) => {
  try {
    const aluno = await Usuario.findByPk(req.params.id);
    if (!aluno || aluno.perfil !== 'aluno') {
      return res.status(404).render('erros/404', { titulo: 'Aluno não encontrado' });
    }
    const idsTurmas = await turmasPermitidas(req.usuario);
    // Precisa poder editar a turma ATUAL do aluno...
    if (!idsTurmas.includes(aluno.turma_id)) {
      return res.status(403).render('erros/403', { titulo: 'Acesso negado' });
    }

    const { nome, email, rm, periodo, turma_id } = req.body;
    const novaTurma = parseInt(turma_id, 10);
    const turma = await Turma.findByPk(novaTurma);
    // ...e a turma DESTINO também precisa estar entre as permitidas e ativa
    // (mover para a turma atual do aluno é sempre permitido, mesmo que ela tenha virado inativa)
    if (!idsTurmas.includes(novaTurma) || (!turma || (!turma.ativo && novaTurma !== aluno.turma_id))) {
      const turmas = await Turma.findAll({
        where: { id: { [Op.in]: idsTurmas }, [Op.or]: [{ ativo: true }, { id: aluno.turma_id }] },
        order: [['nome', 'ASC']]
      });
      return res.status(400).render('professor/aluno_editar', {
        titulo: `Editar — ${aluno.nome}`, aluno, turmas,
        erro: 'Selecione uma turma válida entre as que você leciona.'
      });
    }

    await aluno.update({
      nome,
      email: email || null,
      rm: rm || null,
      periodo: periodo || null,
      turma_id: novaTurma,
      unidade_id: turma ? turma.unidade_id : aluno.unidade_id
    });
    res.redirect('/professor/alunos');
  } catch (err) {
    if (err.name === 'SequelizeUniqueConstraintError') {
      const aluno = await Usuario.findByPk(req.params.id);
      const idsTurmas = await turmasPermitidas(req.usuario);
      const turmas = await Turma.findAll({
        where: { id: { [Op.in]: idsTurmas }, [Op.or]: [{ ativo: true }, { id: aluno.turma_id }] },
        order: [['nome', 'ASC']]
      });
      return res.status(400).render('professor/aluno_editar', {
        titulo: `Editar — ${aluno.nome}`, aluno, turmas, erro: 'E-mail ou RM já usado por outra conta.'
      });
    }
    next(err);
  }
};
