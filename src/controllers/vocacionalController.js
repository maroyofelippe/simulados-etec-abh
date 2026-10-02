// ==========================================================
//  Controller do Teste Vocacional (Feira de Profissões)
//  - Visitante: início, execução (resposta salva a cada afirmação),
//    resultado e download dos próprios dados (JSON / PDF)
//  - Coordenador/leitura: relatório de captação + exportação CSV
// ==========================================================
const {
  VocArea, VocAfirmacao, VocPerguntaAberta, VocAplicacao, VocResposta,
  VocRespostaAberta, VocResultado, Usuario, sequelize
} = require('../models');
const vocService = require('../services/vocacionalService');
const pdfService = require('../services/pdfService');
const csvService = require('../services/csvService');

const ehVisitante = (u) => u.perfil === 'visitante_feira';

// Carrega (ou atribui, se faltar) o teste do usuário logado
const minhaAplicacao = (req) => vocService.atribuir(req.usuario.id);

// ---------- Visitante ----------

// GET /vocacional
exports.inicio = async (req, res, next) => {
  try {
    if (!ehVisitante(req.usuario)) return res.redirect('/vocacional/relatorio');
    const aplicacao = await minhaAplicacao(req);
    if (aplicacao.status === 'concluida') return res.redirect('/vocacional/resultado');

    const [totalAfirmacoes, totalAbertas, totalAreas] = await Promise.all([
      VocAfirmacao.count({ where: { ativa: true } }),
      VocPerguntaAberta.count({ where: { ativa: true } }),
      VocArea.count()
    ]);
    res.render('vocacional/inicio', {
      titulo: 'Teste Vocacional', aplicacao, totalAfirmacoes, totalAbertas, totalAreas
    });
  } catch (err) { next(err); }
};

// POST /vocacional/iniciar  -> sorteia a ordem das afirmações e abre o teste
exports.iniciar = async (req, res, next) => {
  try {
    if (!ehVisitante(req.usuario)) return res.redirect('/vocacional/relatorio');
    const aplicacao = await minhaAplicacao(req);
    if (aplicacao.status === 'concluida') return res.redirect('/vocacional/resultado');

    if (aplicacao.status === 'pendente') {
      const afirmacoes = await VocAfirmacao.findAll({ where: { ativa: true }, attributes: ['id'] });
      await aplicacao.update({
        status: 'em_andamento',
        ordem_afirmacoes: vocService.embaralhar(afirmacoes.map((a) => a.id)),
        iniciada_em: new Date()
      });
    }
    return res.redirect('/vocacional/responder');
  } catch (err) { next(err); }
};

// GET /vocacional/responder
exports.responder = async (req, res, next) => {
  try {
    if (!ehVisitante(req.usuario)) return res.redirect('/vocacional/relatorio');
    const aplicacao = await minhaAplicacao(req);
    if (aplicacao.status === 'concluida') return res.redirect('/vocacional/resultado');
    if (aplicacao.status === 'pendente') return res.redirect('/vocacional');

    const afirmacoes = await VocAfirmacao.findAll({ where: { id: aplicacao.ordem_afirmacoes } });
    const porId = new Map(afirmacoes.map((a) => [a.id, a]));
    const ordenadas = aplicacao.ordem_afirmacoes.filter((id) => porId.has(id))
      .map((id) => ({ id, texto: porId.get(id).texto }));  // área nunca vai ao navegador

    const respostas = await VocResposta.findAll({ where: { aplicacao_id: aplicacao.id } });
    const notas = {};
    respostas.forEach((r) => { notas[r.afirmacao_id] = r.nota; });

    const perguntas = await VocPerguntaAberta.findAll({ where: { ativa: true }, order: [['ordem', 'ASC']] });
    const abertas = await VocRespostaAberta.findAll({ where: { aplicacao_id: aplicacao.id } });
    const textos = {};
    abertas.forEach((a) => { textos[a.pergunta_id] = a.resposta || ''; });

    res.render('vocacional/responder', {
      titulo: 'Teste Vocacional',
      cfg: {
        afirmacoes: ordenadas,
        notas,
        perguntas: perguntas.map((p) => ({ id: p.id, texto: p.texto })),
        abertas: textos,
        escala: vocService.ESCALA
      }
    });
  } catch (err) { next(err); }
};

// POST /api/vocacional/responder  { afirmacao_id, nota }  -> salva/atualiza (editável até finalizar)
exports.salvarResposta = async (req, res, next) => {
  try {
    if (!ehVisitante(req.usuario)) return res.status(403).json({ erro: 'Acesso negado para o seu perfil.' });
    const aplicacao = await minhaAplicacao(req);
    if (aplicacao.status !== 'em_andamento') return res.status(400).json({ erro: 'Teste não está em andamento.' });

    const afirmacaoId = parseInt(req.body.afirmacao_id, 10);
    const nota = parseInt(req.body.nota, 10);
    if (!(nota >= 1 && nota <= 5)) return res.status(400).json({ erro: 'Nota inválida (1 a 5).' });
    if (!aplicacao.ordem_afirmacoes.includes(afirmacaoId)) return res.status(400).json({ erro: 'Afirmação inválida.' });

    await VocResposta.upsert({ aplicacao_id: aplicacao.id, afirmacao_id: afirmacaoId, nota });
    const respondidas = await VocResposta.count({ where: { aplicacao_id: aplicacao.id } });
    return res.json({ ok: true, respondidas, total: aplicacao.ordem_afirmacoes.length });
  } catch (err) { next(err); }
};

// POST /api/vocacional/finalizar  { abertas: { perguntaId: texto } }
exports.finalizar = async (req, res, next) => {
  const t = await sequelize.transaction();
  try {
    if (!ehVisitante(req.usuario)) { await t.rollback(); return res.status(403).json({ erro: 'Acesso negado para o seu perfil.' }); }
    const aplicacao = await minhaAplicacao(req);
    if (aplicacao.status !== 'em_andamento') {
      await t.rollback();
      return res.status(400).json({ erro: 'Teste não está em andamento.' });
    }

    const afirmacoes = await VocAfirmacao.findAll({ where: { id: aplicacao.ordem_afirmacoes }, transaction: t });
    const respostas = await VocResposta.findAll({ where: { aplicacao_id: aplicacao.id }, transaction: t });
    const notas = {};
    respostas.forEach((r) => { notas[r.afirmacao_id] = r.nota; });
    if (afirmacoes.some((a) => !notas[a.id])) {
      await t.rollback();
      return res.status(400).json({ erro: 'Responda todas as afirmações antes de finalizar.' });
    }

    // Perguntas abertas (opcionais)
    const perguntas = await VocPerguntaAberta.findAll({ where: { ativa: true }, transaction: t });
    const enviadas = req.body.abertas || {};
    await VocRespostaAberta.bulkCreate(
      perguntas.map((p) => ({
        aplicacao_id: aplicacao.id, pergunta_id: p.id,
        resposta: String(enviadas[p.id] || '').trim().slice(0, 2000)
      })),
      { updateOnDuplicate: ['resposta'], transaction: t }
    );

    // Cálculo sempre no servidor
    const areas = await VocArea.findAll({ transaction: t });
    const calc = vocService.calcular(notas, afirmacoes, areas);
    await VocResultado.destroy({ where: { aplicacao_id: aplicacao.id }, transaction: t });
    await VocResultado.bulkCreate(
      calc.ranking.map((r) => ({
        aplicacao_id: aplicacao.id, area_codigo: r.codigo, pontos: r.pontos, posicao: r.posicao
      })),
      { transaction: t }
    );
    await aplicacao.update({
      status: 'concluida',
      finalizada_em: new Date(),
      area_principal: calc.principal,
      area_alternativa: calc.alternativa,
      empate_tecnico: calc.empateTecnico,
      perfil_indefinido: calc.perfilIndefinido
    }, { transaction: t });

    await t.commit();
    return res.json({ ok: true, redirect: '/vocacional/resultado' });
  } catch (err) {
    await t.rollback();
    next(err);
  }
};

// GET /vocacional/resultado
exports.resultado = async (req, res, next) => {
  try {
    if (!ehVisitante(req.usuario)) return res.redirect('/vocacional/relatorio');
    const aplicacao = await minhaAplicacao(req);
    if (aplicacao.status !== 'concluida') return res.redirect('/vocacional');
    const r = await vocService.carregarResultado(aplicacao);
    res.render('vocacional/resultado', {
      titulo: 'Meu Resultado Vocacional', r, nomesAreas: r.nomesAreas, maxPorArea: vocService.MAX_POR_AREA
    });
  } catch (err) { next(err); }
};

// GET /vocacional/resultado/baixar?formato=json|pdf  -> download dos próprios dados
exports.baixar = async (req, res, next) => {
  try {
    if (!ehVisitante(req.usuario)) return res.redirect('/vocacional/relatorio');
    const aplicacao = await minhaAplicacao(req);
    if (aplicacao.status !== 'concluida') return res.redirect('/vocacional');
    const r = await vocService.carregarResultado(aplicacao);

    if (req.query.formato === 'pdf') {
      return pdfService.gerarVocacionalPDF({ r, maxPorArea: vocService.MAX_POR_AREA }, res);
    }

    // JSON no mesmo formato do protótipo (sem campos internos de apresentação)
    const { descricaoPrincipal, nomesAreas, ...dados } = r; // eslint-disable-line no-unused-vars
    res.setHeader('Content-Type', 'application/json; charset=utf-8');
    res.setHeader('Content-Disposition', 'attachment; filename=teste_vocacional.json');
    return res.send(JSON.stringify(dados, null, 2));
  } catch (err) { next(err); }
};

// ---------- Coordenador / leitura ----------

async function dadosRelatorio() {
  const aplicacoes = await VocAplicacao.findAll({
    include: [
      { model: Usuario, as: 'usuario' },
      { model: VocArea, as: 'principal' },
      { model: VocArea, as: 'alternativa' }
    ],
    order: [['criado_em', 'ASC']]
  });
  const porStatus = { pendente: 0, em_andamento: 0, concluida: 0 };
  const porArea = {};
  aplicacoes.forEach((a) => {
    porStatus[a.status] += 1;
    if (a.principal) porArea[a.principal.nome] = (porArea[a.principal.nome] || 0) + 1;
  });
  return { aplicacoes, porStatus, porArea, rotulosStatus: vocService.ROTULOS_STATUS };
}

// GET /vocacional/relatorio
exports.relatorio = async (req, res, next) => {
  try {
    const dados = await dadosRelatorio();
    res.render('vocacional/relatorio', { titulo: 'Teste Vocacional — Captação', ...dados });
  } catch (err) { next(err); }
};

// GET /vocacional/relatorio/exportar
exports.exportarCsv = async (req, res, next) => {
  try {
    const { aplicacoes, rotulosStatus } = await dadosRelatorio();
    const areas = await VocArea.findAll({ order: [['ordem', 'ASC']] });
    const resultados = await VocResultado.findAll();
    const pontos = new Map(resultados.map((r) => [`${r.aplicacao_id}:${r.area_codigo}`, r.pontos]));

    const rotulos = { principal: 'Coincide com o 1º', alternativa: 'Coincide com o 2º', outra: 'Fora do top 2', sem_area: 'Sem área equivalente', sem_interesse: 'Sem interesse informado' };
    const rotuloComparacao = (a) => {
      const ranking = areas.map((ar) => ({ codigo: ar.codigo, curso: ar.nome, pontos: pontos.get(`${a.id}:${ar.codigo}`) || 0 }))
        .sort((x, y) => (y.pontos - x.pontos) || (areas.findIndex((z) => z.codigo === x.codigo) - areas.findIndex((z) => z.codigo === y.codigo)))
        .map((r, i) => ({ ...r, posicao: i + 1 }));
      const c = vocService.compararInteresse(a.usuario.curso_interesse, ranking);
      return c.posicao > 2 ? `${rotulos[c.situacao]} (${c.posicao}º)` : rotulos[c.situacao];
    };

    const colunas = [
      { titulo: 'Nome', chave: 'nome' },
      { titulo: 'Telefone', chave: 'telefone' },
      { titulo: 'E-mail', chave: 'email' },
      { titulo: 'Curso de Interesse', chave: 'interesse' },
      { titulo: 'Status', chave: 'status' },
      { titulo: 'Curso Principal', chave: 'principal' },
      { titulo: 'Curso Alternativo', chave: 'alternativa' },
      { titulo: 'Interesse x Teste', chave: 'comparacao' },
      { titulo: 'Perfil Indefinido', chave: 'indefinido' },
      ...areas.map((a) => ({ titulo: `Pontos ${a.nome}`, chave: `p_${a.codigo}` })),
      { titulo: 'Concluído em', chave: 'concluidoEm' }
    ];
    const linhas = aplicacoes.map((a) => {
      const linha = {
        nome: a.usuario.nome,
        telefone: a.usuario.telefone,
        email: a.usuario.email,
        interesse: a.usuario.curso_interesse,
        status: rotulosStatus[a.status],
        principal: a.principal ? a.principal.nome : '',
        alternativa: a.alternativa ? a.alternativa.nome : '',
        comparacao: a.status === 'concluida' ? rotuloComparacao(a) : '',
        indefinido: a.status === 'concluida' ? (a.perfil_indefinido ? 'Sim' : 'Não') : '',
        concluidoEm: a.finalizada_em ? new Date(a.finalizada_em).toLocaleString('pt-BR') : ''
      };
      areas.forEach((ar) => { linha[`p_${ar.codigo}`] = pontos.get(`${a.id}:${ar.codigo}`) ?? ''; });
      return linha;
    });

    const csv = csvService.paraCsv(colunas, linhas);
    const dataArquivo = new Date().toISOString().slice(0, 10);
    res.setHeader('Content-Type', 'text/csv; charset=utf-8');
    res.setHeader('Content-Disposition', `attachment; filename=teste_vocacional_feira_${dataArquivo}.csv`);
    res.send(Buffer.concat([Buffer.from([0xEF, 0xBB, 0xBF]), Buffer.from(csv, 'utf8')]));
  } catch (err) { next(err); }
};
