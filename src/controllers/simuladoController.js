// ==========================================================
//  Controller de Simulados (professor/coordenador)
//  - Criar simulado parametrizado (disciplina, tema, dificuldade,
//    qtd de questões <=20, turma, duração)
//  - Publicar / listar
// ==========================================================
const { Simulado, Disciplina, Turma, Questao } = require('../models');
const { Op } = require('sequelize');

// Turmas ativas, mais a turma já vinculada ao simulado (se houver) mesmo que tenha sido
// inativada nesse meio tempo — para não sumir do <select> ao editar.
function turmasParaSelect(turmaIdAtual) {
  return Turma.findAll({
    where: turmaIdAtual ? { [Op.or]: [{ ativo: true }, { id: turmaIdAtual }] } : { ativo: true },
    order: [['nome', 'ASC']]
  });
}

exports.listar = async (req, res, next) => {
  try {
    const simulados = await Simulado.findAll({
      include: [{ model: Disciplina, as: 'disciplina' }, { model: Turma, as: 'turma' }],
      order: [['criado_em', 'DESC']]
    });
    res.render('professor/simulados', { titulo: 'Simulados', simulados });
  } catch (err) { next(err); }
};

exports.telaNovo = async (req, res, next) => {
  try {
    const disciplinas = await Disciplina.findAll({ order: [['nome', 'ASC']] });
    const turmas = await Turma.findAll({ where: { ativo: true }, order: [['nome', 'ASC']] });
    res.render('professor/simulado_novo', { titulo: 'Novo Simulado', disciplinas, turmas, erro: null });
  } catch (err) { next(err); }
};

exports.criar = async (req, res, next) => {
  try {
    const {
      titulo, tipo, disciplina_id, tema, turma_id, qtd_questoes,
      dificuldade_facil, dificuldade_medio, dificuldade_dificil,
      duracao_minutos, max_perdas_foco
    } = req.body;

    const qtd = Math.min(parseInt(qtd_questoes || '20', 10), 20); // limite rígido de 20

    // Distribuição por dificuldade (opcional)
    let distribuicao = null;
    const f = parseInt(dificuldade_facil || '0', 10);
    const m = parseInt(dificuldade_medio || '0', 10);
    const d = parseInt(dificuldade_dificil || '0', 10);
    if (f + m + d > 0) distribuicao = { 'Fácil': f, 'Médio': m, 'Difícil': d };

    await Simulado.create({
      titulo,
      tipo: tipo === 'geral' ? 'geral' : 'aleatorio_aluno',
      disciplina_id: disciplina_id || null,
      tema: tema || null,
      turma_id: turma_id || null,
      qtd_questoes: qtd,
      distribuicao_dificuldade: distribuicao,
      duracao_minutos: parseInt(duracao_minutos || '60', 10),
      max_perdas_foco: parseInt(max_perdas_foco || '0', 10),
      criado_por: req.usuario.id,
      publicado: false
    });
    res.redirect('/professor/simulados');
  } catch (err) { next(err); }
};

exports.telaEditar = async (req, res, next) => {
  try {
    const simulado = await Simulado.findByPk(req.params.id);
    if (!simulado) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });
    const disciplinas = await Disciplina.findAll({ order: [['nome', 'ASC']] });
    const turmas = await turmasParaSelect(simulado.turma_id);
    res.render('professor/simulado_editar', { titulo: 'Editar Simulado', simulado, disciplinas, turmas, erro: null });
  } catch (err) { next(err); }
};

exports.atualizar = async (req, res, next) => {
  try {
    const simulado = await Simulado.findByPk(req.params.id);
    if (!simulado) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });

    const {
      titulo, tipo, disciplina_id, tema, turma_id, qtd_questoes,
      dificuldade_facil, dificuldade_medio, dificuldade_dificil,
      duracao_minutos, max_perdas_foco
    } = req.body;

    const qtd = Math.min(parseInt(qtd_questoes || '20', 10), 20); // limite rígido de 20

    let distribuicao = null;
    const f = parseInt(dificuldade_facil || '0', 10);
    const m = parseInt(dificuldade_medio || '0', 10);
    const d = parseInt(dificuldade_dificil || '0', 10);
    if (f + m + d > 0) distribuicao = { 'Fácil': f, 'Médio': m, 'Difícil': d };

    await simulado.update({
      titulo,
      tipo: tipo === 'geral' ? 'geral' : 'aleatorio_aluno',
      disciplina_id: disciplina_id || null,
      tema: tema || null,
      turma_id: turma_id || null,
      qtd_questoes: qtd,
      distribuicao_dificuldade: distribuicao,
      duracao_minutos: parseInt(duracao_minutos || '60', 10),
      max_perdas_foco: parseInt(max_perdas_foco || '0', 10)
    });
    res.redirect('/professor/simulados');
  } catch (err) { next(err); }
};

exports.publicar = async (req, res, next) => {
  try {
    const simulado = await Simulado.findByPk(req.params.id);
    if (!simulado) return res.status(404).json({ erro: 'Simulado não encontrado' });

    // Verifica se há questões suficientes no banco
    const where = { ativa: true };
    if (simulado.disciplina_id) where.disciplina_id = simulado.disciplina_id;
    if (simulado.tema) where.tema = simulado.tema;
    const disponiveis = await Questao.count({ where });
    if (disponiveis < simulado.qtd_questoes) {
      return res.status(422).json({
        erro: `Banco tem apenas ${disponiveis} questões; o simulado exige ${simulado.qtd_questoes}.`
      });
    }
    await simulado.update({ publicado: !simulado.publicado });
    res.json({ ok: true, publicado: simulado.publicado });
  } catch (err) { next(err); }
};
