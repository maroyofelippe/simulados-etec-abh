// ==========================================================
//  Controller de Simulados (professor/coordenador)
//  - Criar simulado parametrizado (disciplina, tema, dificuldade,
//    qtd de questões <=20, turma, duração)
//  - Publicar / listar
// ==========================================================
const { Simulado, Disciplina, Turma, Questao, ProvaAplicada, Resultado, Resposta, Usuario } = require('../models');
const { Op } = require('sequelize');
const { ORIGENS } = require('../config/origens');
const { SERIES, seriesDoSimulado } = require('../config/series');

function seriesDoForm(v) {
  const lista = [].concat(v || []).filter((s) => SERIES.includes(s));
  return lista.length ? lista : null;
}

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
    // Média geral de cada simulado: todas as provas concluídas, de todas as turmas
    const resultados = await ProvaAplicada.findAll({
      where: { status: 'concluida', simulado_id: { [Op.in]: simulados.map((s) => s.id) } },
      attributes: ['simulado_id'],
      include: [{ model: Resultado, as: 'resultado', attributes: ['nota'], required: true }]
    });
    const acc = {};
    resultados.forEach((p) => {
      const a = acc[p.simulado_id] || (acc[p.simulado_id] = { soma: 0, n: 0 });
      a.soma += Number(p.resultado.nota);
      a.n += 1;
    });
    const medias = {};
    Object.keys(acc).forEach((id) => { medias[id] = acc[id].soma / acc[id].n; });
    res.render('professor/simulados', { titulo: 'Simulados', simulados, medias });
  } catch (err) { next(err); }
};

// GET /professor/simulados/:id/ranking (JSON, usado pelo popup)
//  Ranking dos alunos que concluíram o simulado + radar de % de acertos por disciplina.
exports.ranking = async (req, res, next) => {
  try {
    const simulado = await Simulado.findByPk(req.params.id);
    if (!simulado) return res.status(404).json({ erro: 'Simulado não encontrado.' });

    const provas = await ProvaAplicada.findAll({
      where: { simulado_id: simulado.id, status: 'concluida' },
      include: [
        { model: Resultado, as: 'resultado', required: true },
        { model: Usuario, as: 'aluno', attributes: ['id', 'nome', 'rm'], include: [{ model: Turma, as: 'turma', attributes: ['nome'] }] }
      ]
    });
    provas.sort((a, b) => Number(b.resultado.nota) - Number(a.resultado.nota) ||
      (a.tempo_gasto_segundos || 0) - (b.tempo_gasto_segundos || 0));
    const ranking = provas.map((p, i) => ({
      posicao: i + 1,
      nome: p.aluno ? p.aluno.nome : '—',
      turma: p.aluno && p.aluno.turma ? p.aluno.turma.nome : '—',
      nota: Number(p.resultado.nota),
      acertos: p.resultado.acertos,
      total: p.resultado.total_questoes,
      mencao: p.resultado.mencao
    }));
    const media = ranking.length ? ranking.reduce((t, r) => t + r.nota, 0) / ranking.length : null;

    const respostas = provas.length ? await Resposta.findAll({
      where: { prova_aplicada_id: { [Op.in]: provas.map((p) => p.id) } },
      include: [{ model: Questao, as: 'questao', include: [{ model: Disciplina, as: 'disciplina' }] }]
    }) : [];
    const porDisc = new Map();
    respostas.forEach((r) => {
      const nome = r.questao && r.questao.disciplina ? r.questao.disciplina.nome : 'Sem disciplina';
      const o = porDisc.get(nome) || porDisc.set(nome, { total: 0, acertos: 0 }).get(nome);
      o.total += 1;
      if (r.correta) o.acertos += 1;
    });
    const radar = Array.from(porDisc.entries()).map(([disciplina, v]) => ({
      disciplina, percentual: Math.round((v.acertos / v.total) * 1000) / 10
    }));

    res.json({ titulo: simulado.titulo, media, ranking, radar });
  } catch (err) { next(err); }
};

exports.telaNovo = async (req, res, next) => {
  try {
    const disciplinas = await Disciplina.findAll({ order: [['nome', 'ASC']] });
    const turmas = await Turma.findAll({ where: { ativo: true }, order: [['nome', 'ASC']] });
    res.render('professor/simulado_novo', { titulo: 'Novo Simulado', origens: ORIGENS, series: SERIES, disciplinas, turmas, erro: null });
  } catch (err) { next(err); }
};

exports.criar = async (req, res, next) => {
  try {
    const {
      titulo, tipo, disciplina_id, tema, origem, series, turma_id, qtd_questoes,
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
      origem: ORIGENS.includes(origem) ? origem : null,
      series: seriesDoForm(series),
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
    res.render('professor/simulado_editar', { titulo: 'Editar Simulado', origens: ORIGENS, series: SERIES, simulado, disciplinas, turmas, erro: null });
  } catch (err) { next(err); }
};

exports.atualizar = async (req, res, next) => {
  try {
    const simulado = await Simulado.findByPk(req.params.id);
    if (!simulado) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });

    const {
      titulo, tipo, disciplina_id, tema, origem, series, turma_id, qtd_questoes,
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
      origem: ORIGENS.includes(origem) ? origem : null,
      series: seriesDoForm(series),
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
    if (simulado.origem) where.origem = simulado.origem;
    const series = seriesDoSimulado(simulado, simulado.turma_id ? await Turma.findByPk(simulado.turma_id) : null);
    if (series) where.serie = { [Op.in]: series };
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
