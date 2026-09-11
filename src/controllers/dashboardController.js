// ==========================================================
//  Controller de Dashboard Estatístico
//  Visões: unidade -> turma -> aluno
//  Filtros temporais: simulado, semana, mês, ano
//  Comparação: duas ou mais turmas lado a lado
// ==========================================================
const { Op } = require('sequelize');
const {
  Unidade, Turma, Disciplina, Usuario, Simulado, ProvaAplicada, Resultado, EventoFoco, sequelize
} = require('../models');
const csvService = require('../services/csvService');

// Monta o include de Simulado usado para filtrar por disciplina (join até Disciplina)
function includeSimulado(disciplinaId, attrs) {
  const inc = { model: Simulado, as: 'simulado' };
  if (attrs) inc.attributes = attrs;
  if (disciplinaId) {
    inc.where = { disciplina_id: disciplinaId };
    inc.required = true;
  }
  return inc;
}

// Traduz um filtro temporal em intervalo [inicio, fim]
function intervalo(periodo) {
  const agora = new Date();
  const inicio = new Date(agora);
  if (periodo === 'semana') inicio.setDate(agora.getDate() - 7);
  else if (periodo === 'mes') inicio.setMonth(agora.getMonth() - 1);
  else if (periodo === 'ano') inicio.setFullYear(agora.getFullYear() - 1);
  else return null; // sem filtro temporal
  return { [Op.between]: [inicio, agora] };
}

// GET /dashboard  -> visão geral (por unidade)
exports.geral = async (req, res, next) => {
  try {
    const periodo = req.query.periodo || 'todos';
    const disciplinaId = req.query.disciplina_id ? parseInt(req.query.disciplina_id, 10) : null;
    const whereProva = { status: 'concluida' };
    const intv = intervalo(periodo);
    if (intv) whereProva.finalizada_em = intv;

    const unidades = await Unidade.findAll();
    const disciplinas = await Disciplina.findAll({ order: [['nome', 'ASC']] });
    const cards = [];
    for (const u of unidades) {
      const stats = await estatisticasUnidade(u.id, whereProva, disciplinaId);
      cards.push({ unidade: u, ...stats });
    }

    // Série temporal (últimos 6 meses) de média de notas
    const serie = await serieTemporalNotas(disciplinaId);

    res.render('dashboard/geral', {
      titulo: 'Dashboard Geral', cards, serie, periodo, disciplinas, disciplinaId
    });
  } catch (err) { next(err); }
};

async function estatisticasUnidade(unidadeId, whereProva, disciplinaId) {
  // provas concluídas por alunos daquela unidade (visitantes da feira ficam fora deste indicador acadêmico)
  const provas = await ProvaAplicada.findAll({
    where: whereProva,
    include: [
      { model: Usuario, as: 'aluno', where: { unidade_id: unidadeId, perfil: 'aluno' }, attributes: ['id'] },
      { model: Resultado, as: 'resultado' },
      includeSimulado(disciplinaId, [])
    ]
  });
  return agregarProvas(provas);
}

function agregarProvas(provas) {
  const concluidas = provas.filter((p) => p.resultado);
  const notas = concluidas.map((p) => Number(p.resultado.nota));
  const mediaNota = notas.length ? (notas.reduce((a, b) => a + b, 0) / notas.length) : 0;
  const totalFoco = provas.reduce((a, p) => a + (p.perdas_foco || 0), 0);
  const mencoes = { I: 0, R: 0, B: 0, MB: 0 };
  concluidas.forEach((p) => { mencoes[p.resultado.mencao] = (mencoes[p.resultado.mencao] || 0) + 1; });
  return {
    provasConcluidas: concluidas.length,
    mediaNota: Math.round(mediaNota * 10) / 10,
    totalPerdasFoco: totalFoco,
    mencoes
  };
}

// GET /dashboard/turma/:id
exports.porTurma = async (req, res, next) => {
  try {
    const turma = await Turma.findByPk(req.params.id, { include: [{ model: Unidade, as: 'unidade' }] });
    if (!turma) return res.status(404).render('erros/404', { titulo: 'Turma não encontrada' });

    const periodo = req.query.periodo || 'todos';
    const disciplinaId = req.query.disciplina_id ? parseInt(req.query.disciplina_id, 10) : null;
    const whereProva = { status: 'concluida' };
    const intv = intervalo(periodo);
    if (intv) whereProva.finalizada_em = intv;

    const disciplinas = await Disciplina.findAll({ order: [['nome', 'ASC']] });
    const alunos = await Usuario.findAll({ where: { turma_id: turma.id, perfil: 'aluno' } });
    const linhas = [];
    for (const aluno of alunos) {
      const provas = await ProvaAplicada.findAll({
        where: { ...whereProva, aluno_id: aluno.id },
        include: [{ model: Resultado, as: 'resultado' }, includeSimulado(disciplinaId, [])]
      });
      const stats = agregarProvas(provas);
      linhas.push({ aluno, ...stats });
    }

    const mediaTurma = linhas.length
      ? Math.round((linhas.reduce((a, l) => a + l.mediaNota, 0) / linhas.length) * 10) / 10 : 0;

    res.render('dashboard/turma', {
      titulo: `Dashboard — ${turma.nome}`, turma, linhas, mediaTurma, periodo, disciplinas, disciplinaId
    });
  } catch (err) { next(err); }
};

// Normaliza um parâmetro de query (string única, várias ou ausente) em array de inteiros
function normalizarIds(v) {
  if (!v) return [];
  const arr = Array.isArray(v) ? v : [v];
  return arr.map((x) => parseInt(x, 10)).filter((n) => !Number.isNaN(n));
}

// GET /dashboard/aluno/:id
exports.porAluno = async (req, res, next) => {
  try {
    const aluno = await Usuario.findByPk(req.params.id, { include: [{ model: Turma, as: 'turma' }] });
    if (!aluno) return res.status(404).render('erros/404', { titulo: 'Aluno não encontrado' });

    const periodo = req.query.periodo || 'todos';
    const disciplinaIds = normalizarIds(req.query.disciplina_id);
    const whereProva = { aluno_id: aluno.id, status: 'concluida' };
    const intv = intervalo(periodo);
    if (intv) whereProva.finalizada_em = intv;

    const disciplinas = await Disciplina.findAll({ order: [['nome', 'ASC']] });

    // Precisa da disciplina de cada prova para permitir plotar cada uma como uma linha separada
    const includeSim = {
      model: Simulado, as: 'simulado',
      include: [{ model: Disciplina, as: 'disciplina', attributes: ['id', 'nome'] }]
    };
    if (disciplinaIds.length) {
      includeSim.where = { disciplina_id: { [Op.in]: disciplinaIds } };
      includeSim.required = true;
    }

    const provas = await ProvaAplicada.findAll({
      where: whereProva,
      include: [{ model: Resultado, as: 'resultado' }, includeSim],
      order: [['finalizada_em', 'ASC']]
    });

    const evolucao = provas.filter((p) => p.resultado).map((p) => ({
      titulo: p.simulado ? p.simulado.titulo : `Prova ${p.id}`,
      data: p.finalizada_em,
      nota: Number(p.resultado.nota),
      mencao: p.resultado.mencao,
      foco: p.perdas_foco,
      disciplinaId: p.simulado && p.simulado.disciplina ? p.simulado.disciplina.id : null,
      disciplinaNome: p.simulado && p.simulado.disciplina ? p.simulado.disciplina.nome : 'Sem disciplina'
    }));

    res.render('dashboard/aluno', {
      titulo: `Desempenho — ${aluno.nome}`, aluno, evolucao, periodo, disciplinas, disciplinaIds
    });
  } catch (err) { next(err); }
};

// GET /dashboard/comparar?turmas=1,2,3  -> comparação lado a lado
exports.comparar = async (req, res, next) => {
  try {
    const ids = (req.query.turmas || '').split(',').map((s) => parseInt(s, 10)).filter(Boolean);
    const disciplinaId = req.query.disciplina_id ? parseInt(req.query.disciplina_id, 10) : null;
    const todasTurmas = await Turma.findAll({ where: { ativo: true }, order: [['nome', 'ASC']] });
    const disciplinas = await Disciplina.findAll({ order: [['nome', 'ASC']] });
    const comparativo = [];

    for (const id of ids) {
      const turma = todasTurmas.find((t) => t.id === id);
      if (!turma) continue;
      const alunos = await Usuario.findAll({ where: { turma_id: id, perfil: 'aluno' }, attributes: ['id'] });
      const alunoIds = alunos.map((a) => a.id);

      // Sempre traz a disciplina de cada prova: quando "Todas" está selecionada, isso permite
      // decompor a linha geral de cada turma em uma linha por disciplina no gráfico de linhas.
      const includeSim = {
        model: Simulado, as: 'simulado', attributes: ['disciplina_id'],
        include: [{ model: Disciplina, as: 'disciplina', attributes: ['id', 'nome'] }]
      };
      if (disciplinaId) { includeSim.where = { disciplina_id: disciplinaId }; includeSim.required = true; }

      const provas = alunoIds.length ? await ProvaAplicada.findAll({
        where: { aluno_id: { [Op.in]: alunoIds }, status: 'concluida' },
        include: [{ model: Resultado, as: 'resultado' }, includeSim]
      }) : [];

      const item = { turma, ...agregarProvas(provas) };

      if (!disciplinaId) {
        const grupos = {};
        provas.forEach((p) => {
          if (!p.resultado || !p.simulado || !p.simulado.disciplina) return;
          const d = p.simulado.disciplina;
          if (!grupos[d.id]) grupos[d.id] = { id: d.id, nome: d.nome, notas: [] };
          grupos[d.id].notas.push(Number(p.resultado.nota));
        });
        item.porDisciplina = Object.values(grupos).map((g) => ({
          id: g.id,
          nome: g.nome,
          media: Math.round((g.notas.reduce((a, b) => a + b, 0) / g.notas.length) * 10) / 10
        }));
      }

      comparativo.push(item);
    }

    res.render('dashboard/comparar', {
      titulo: 'Comparar Turmas', todasTurmas, comparativo, selecionadas: ids, disciplinas, disciplinaId
    });
  } catch (err) { next(err); }
};

// Calcula idade (em anos completos) a partir da data de nascimento
function calcularIdade(dataNascimento) {
  const hoje = new Date();
  const nasc = new Date(dataNascimento);
  let idade = hoje.getFullYear() - nasc.getFullYear();
  const aindaNaoFezAniversario =
    hoje.getMonth() < nasc.getMonth() ||
    (hoje.getMonth() === nasc.getMonth() && hoje.getDate() < nasc.getDate());
  if (aindaNaoFezAniversario) idade -= 1;
  return idade;
}

// Classifica a idade em uma faixa etária para o gráfico de captação
function faixaEtaria(idade) {
  if (idade < 15) return 'Até 14';
  if (idade <= 17) return '15 a 17';
  if (idade <= 24) return '18 a 24';
  if (idade <= 34) return '25 a 34';
  if (idade <= 44) return '35 a 44';
  return '45 ou mais';
}

const ROTULOS_RELACAO = { ex_aluno: 'Ex-aluno(a)', candidato: 'Candidato(a)', responsavel: 'Responsável', aluno: 'Aluno(a)' };
const ROTULOS_STATUS_PROVA = {
  concluida: 'Concluída', em_andamento: 'Em andamento', expirada: 'Expirada', nao_iniciada: 'Não iniciada'
};

// Coleta e agrega os dados de captação ativa (usado pela tela e pela exportação em CSV)
async function dadosFeira() {
  const visitantes = await Usuario.findAll({
    where: { perfil: 'visitante_feira' },
    order: [['criado_em', 'ASC']]
  });

  const porCurso = {};
  const porRelacao = {};
  const porFaixaEtaria = {};
  const porDia = {};

  visitantes.forEach((v) => {
    if (v.curso_interesse) porCurso[v.curso_interesse] = (porCurso[v.curso_interesse] || 0) + 1;
    if (v.relacao_etec) {
      const rotulo = ROTULOS_RELACAO[v.relacao_etec] || v.relacao_etec;
      porRelacao[rotulo] = (porRelacao[rotulo] || 0) + 1;
    }
    if (v.data_nascimento) {
      const faixa = faixaEtaria(calcularIdade(v.data_nascimento));
      porFaixaEtaria[faixa] = (porFaixaEtaria[faixa] || 0) + 1;
    }
    const dia = new Date(v.criado_em).toISOString().slice(0, 10);
    porDia[dia] = (porDia[dia] || 0) + 1;
  });

  const ordemFaixas = ['Até 14', '15 a 17', '18 a 24', '25 a 34', '35 a 44', '45 ou mais'];
  const idades = visitantes.filter((v) => v.data_nascimento).map((v) => calcularIdade(v.data_nascimento));
  const idadeMedia = idades.length ? Math.round((idades.reduce((a, b) => a + b, 0) / idades.length) * 10) / 10 : 0;

  // ---- Desempenho no simulado aplicado à turma "Feira de Profissões" ----
  const visitanteIds = visitantes.map((v) => v.id);
  const provas = visitanteIds.length ? await ProvaAplicada.findAll({
    where: { aluno_id: { [Op.in]: visitanteIds } },
    include: [{ model: Resultado, as: 'resultado' }]
  }) : [];
  const mapaProvaPorVisitante = new Map(provas.map((p) => [p.aluno_id, p]));

  const desempenho = agregarProvas(provas);
  const taxaConclusao = visitantes.length
    ? Math.round((desempenho.provasConcluidas / visitantes.length) * 1000) / 10
    : 0;

  // Média de nota por curso de interesse (correlaciona interesse x desempenho)
  const mapaCursoVisitante = new Map(visitantes.map((v) => [v.id, v.curso_interesse || 'Não informado']));
  const notasPorCurso = {};
  provas.forEach((p) => {
    if (!p.resultado) return;
    const curso = mapaCursoVisitante.get(p.aluno_id) || 'Não informado';
    if (!notasPorCurso[curso]) notasPorCurso[curso] = [];
    notasPorCurso[curso].push(Number(p.resultado.nota));
  });
  const mediaNotaPorCurso = Object.entries(notasPorCurso).map(([curso, notas]) => ({
    curso,
    media: Math.round((notas.reduce((a, b) => a + b, 0) / notas.length) * 10) / 10,
    total: notas.length
  }));

  const visitantesComProva = visitantes.map((v) => {
    const p = mapaProvaPorVisitante.get(v.id);
    return {
      ...v.toJSON(),
      provaStatus: p ? p.status : 'nao_iniciada',
      nota: p && p.resultado ? Number(p.resultado.nota) : null,
      mencao: p && p.resultado ? p.resultado.mencao : null
    };
  });

  return {
    total: visitantes.length,
    idadeMedia,
    porCurso,
    porRelacao,
    porFaixaEtaria: ordemFaixas.map((f) => ({ faixa: f, total: porFaixaEtaria[f] || 0 })),
    porDia: Object.entries(porDia).sort(([a], [b]) => a.localeCompare(b)).map(([dia, total]) => ({ dia, total })),
    visitantes: visitantesComProva,
    desempenho,
    taxaConclusao,
    mediaNotaPorCurso
  };
}

// GET /dashboard/feira -> captação ativa (visitantes auto-cadastrados na feira)
exports.feira = async (req, res, next) => {
  try {
    const dados = await dadosFeira();
    res.render('dashboard/feira', { titulo: 'Captação Ativa — Feira de Profissões', ...dados });
  } catch (err) { next(err); }
};

// GET /dashboard/feira/exportar -> relatório em CSV para uso na captação ativa
exports.exportarFeiraCsv = async (req, res, next) => {
  try {
    const { visitantes } = await dadosFeira();

    const colunas = [
      { titulo: 'Nome', chave: 'nome' },
      { titulo: 'Telefone', chave: 'telefone' },
      { titulo: 'E-mail', chave: 'email' },
      { titulo: 'Idade', chave: 'idade' },
      { titulo: 'Data de Nascimento', chave: 'dataNascimentoFmt' },
      { titulo: 'Relação com a ETEC', chave: 'relacaoFmt' },
      { titulo: 'Curso de Interesse', chave: 'curso_interesse' },
      { titulo: 'Status do Simulado', chave: 'provaStatusFmt' },
      { titulo: 'Nota', chave: 'notaFmt' },
      { titulo: 'Menção', chave: 'mencao' },
      { titulo: 'Cadastrado em', chave: 'criadoEmFmt' }
    ];

    const linhas = visitantes.map((v) => ({
      nome: v.nome,
      telefone: v.telefone,
      email: v.email,
      idade: v.data_nascimento ? calcularIdade(v.data_nascimento) : '',
      dataNascimentoFmt: v.data_nascimento ? new Date(v.data_nascimento).toLocaleDateString('pt-BR') : '',
      relacaoFmt: ROTULOS_RELACAO[v.relacao_etec] || v.relacao_etec || '',
      curso_interesse: v.curso_interesse,
      provaStatusFmt: ROTULOS_STATUS_PROVA[v.provaStatus] || v.provaStatus,
      notaFmt: v.nota !== null ? String(v.nota).replace('.', ',') : '',
      mencao: v.mencao || '',
      criadoEmFmt: new Date(v.criado_em).toLocaleString('pt-BR')
    }));

    const csv = csvService.paraCsv(colunas, linhas);
    const dataArquivo = new Date().toISOString().slice(0, 10);

    res.setHeader('Content-Type', 'text/csv; charset=utf-8');
    res.setHeader('Content-Disposition', `attachment; filename=captacao_feira_profissoes_${dataArquivo}.csv`);
    // BOM UTF-8 no início: garante acentuação correta ao abrir no Excel
    res.send(Buffer.concat([Buffer.from([0xEF, 0xBB, 0xBF]), Buffer.from(csv, 'utf8')]));
  } catch (err) { next(err); }
};

// Série temporal simplificada: média de notas por mês (últimos 6 meses)
// Visitantes da feira ficam fora deste indicador acadêmico (só alunos).
async function serieTemporalNotas(disciplinaId) {
  const resultados = await Resultado.findAll({
    include: [{
      model: ProvaAplicada,
      as: 'prova',
      attributes: ['finalizada_em'],
      required: true,
      include: [
        includeSimulado(disciplinaId, []),
        { model: Usuario, as: 'aluno', attributes: [], where: { perfil: 'aluno' }, required: true }
      ]
    }]
  });
  const buckets = {};
  resultados.forEach((r) => {
    if (!r.prova || !r.prova.finalizada_em) return;
    const d = new Date(r.prova.finalizada_em);
    const chave = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}`;
    if (!buckets[chave]) buckets[chave] = [];
    buckets[chave].push(Number(r.nota));
  });
  return Object.entries(buckets)
    .sort()
    .slice(-6)
    .map(([mes, notas]) => ({
      mes, media: Math.round((notas.reduce((a, b) => a + b, 0) / notas.length) * 10) / 10
    }));
}
