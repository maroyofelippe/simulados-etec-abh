// ==========================================================
//  Controller de Execução de Prova (modo aluno)
//  - Iniciar prova (1 tentativa)
//  - Servir questões uma a uma
//  - Salvar resposta progressivamente (obrigatória)
//  - Registrar eventos de perda de foco (blur/visibility/copy/paste)
//  - Finalizar (auto ou manual) + calcular resultado/menção
//  - Espelho da prova (view) e PDF com assinatura
// ==========================================================
const {
  Simulado, ProvaAplicada, ProvaQuestao, Questao, Alternativa, TextoApoio,
  Resposta, EventoFoco, Resultado, Usuario, Turma, Unidade, Disciplina, sequelize
} = require('../models');
const sorteio = require('../services/sorteioService');
const mencaoService = require('../services/mencaoService');
const pdfService = require('../services/pdfService');
const env = require('../config/env');

// GET /aluno/provas  -> lista simulados disponíveis para a turma do aluno
exports.listarDisponiveis = async (req, res, next) => {
  try {
    const aluno = req.usuario;
    const simulados = await Simulado.findAll({
      where: { turma_id: aluno.turma_id, publicado: true },
      include: [{ model: Disciplina, as: 'disciplina' }]
    });
    const aplicadas = await ProvaAplicada.findAll({ where: { aluno_id: aluno.id } });
    const mapa = new Map(aplicadas.map((p) => [p.simulado_id, p]));
    res.render('aluno/provas', { titulo: 'Minhas Provas', simulados, mapa });
  } catch (err) { next(err); }
};

// POST /aluno/provas/:simuladoId/iniciar
//   Gera (se ainda não existir) a prova individual sorteando questões.
exports.iniciar = async (req, res, next) => {
  const t = await sequelize.transaction();
  try {
    const aluno = req.usuario;
    const simulado = await Simulado.findByPk(req.params.simuladoId);
    if (!simulado || !simulado.publicado) {
      await t.rollback();
      return res.status(404).render('erros/404', { titulo: 'Simulado indisponível' });
    }

    // 1 tentativa por aluno/simulado
    let prova = await ProvaAplicada.findOne({
      where: { aluno_id: aluno.id, simulado_id: simulado.id }
    });

    if (prova && ['concluida', 'expirada'].includes(prova.status)) {
      await t.rollback();
      return res.redirect(`/aluno/provas/${prova.id}/resultado`);
    }

    if (!prova) {
      // ----- Sorteio das questões (função randômica) -----
      const candidatas = await montarPoolQuestoes(simulado);
      const distr = simulado.distribuicao_dificuldade || null;
      const sorteadas = sorteio.sortearQuestoes(candidatas, simulado.qtd_questoes, distr);

      if (sorteadas.length === 0) {
        await t.rollback();
        return res.status(422).render('erros/500', {
          titulo: 'Sem questões', mensagem: 'Não há questões suficientes no banco para gerar esta prova.'
        });
      }

      prova = await ProvaAplicada.create({
        simulado_id: simulado.id, aluno_id: aluno.id, status: 'em_andamento',
        iniciada_em: new Date(), perdas_foco: 0
      }, { transaction: t });

      await ProvaQuestao.bulkCreate(
        sorteadas.map((q, i) => ({
          prova_aplicada_id: prova.id, questao_id: q.id, ordem: i + 1
        })),
        { transaction: t }
      );
    } else if (prova.status === 'gerada') {
      await prova.update({ status: 'em_andamento', iniciada_em: new Date() }, { transaction: t });
    }

    await t.commit();
    return res.redirect(`/aluno/provas/${prova.id}/resolver`);
  } catch (err) {
    await t.rollback();
    next(err);
  }
};

// Monta o conjunto de questões candidatas conforme parametrização do simulado
async function montarPoolQuestoes(simulado) {
  const where = { ativa: true };
  if (simulado.disciplina_id) where.disciplina_id = simulado.disciplina_id;
  if (simulado.tema) where.tema = simulado.tema;
  const questoes = await Questao.findAll({ where });
  return questoes.map((q) => ({ id: q.id, dificuldade: q.dificuldade }));
}

// GET /aluno/provas/:id/resolver  -> tela do cronômetro + primeira questão
exports.resolver = async (req, res, next) => {
  try {
    const prova = await carregarProvaDoAluno(req);
    if (!prova) return res.status(404).render('erros/404', { titulo: 'Prova não encontrada' });
    if (prova.status === 'concluida') return res.redirect(`/aluno/provas/${prova.id}/resultado`);

    const simulado = await Simulado.findByPk(prova.simulado_id);
    const total = await ProvaQuestao.count({ where: { prova_aplicada_id: prova.id } });
    const respondidas = await Resposta.count({ where: { prova_aplicada_id: prova.id } });

    // Tempo restante em segundos
    const decorrido = Math.floor((Date.now() - new Date(prova.iniciada_em).getTime()) / 1000);
    const restante = Math.max(0, simulado.duracao_minutos * 60 - decorrido);

    res.render('aluno/resolver', {
      titulo: 'Resolvendo prova', prova, simulado, total, respondidas, restante,
      palavraCoringa: env.palavraCoringa,
      maxPerdasFoco: simulado.max_perdas_foco ?? env.maxPerdasFoco,
      layout: 'partials/layout_prova' // layout enxuto, anti-cola
    });
  } catch (err) { next(err); }
};

// GET /api/provas/:id/questao/:ordem  -> devolve a questão n (JSON)
exports.questaoJson = async (req, res, next) => {
  try {
    const prova = await carregarProvaDoAluno(req);
    if (!prova) return res.status(404).json({ erro: 'Prova não encontrada' });

    const pq = await ProvaQuestao.findOne({
      where: { prova_aplicada_id: prova.id, ordem: parseInt(req.params.ordem, 10) },
      include: [{
        model: Questao, as: 'questao',
        include: [{ model: Alternativa, as: 'alternativas' }, { model: TextoApoio, as: 'textoApoio' }]
      }]
    });
    if (!pq) return res.status(404).json({ erro: 'Questão não encontrada' });

    const jaRespondida = await Resposta.findOne({
      where: { prova_aplicada_id: prova.id, questao_id: pq.questao_id }
    });

    // Não expõe o gabarito durante a prova!
    const alternativas = pq.questao.alternativas
      .sort((a, b) => a.letra.localeCompare(b.letra))
      .map((a) => ({ letra: a.letra, texto: a.texto }));

    return res.json({
      ordem: pq.ordem,
      questao_id: pq.questao_id,
      enunciado: pq.questao.enunciado,
      dificuldade: pq.questao.dificuldade,
      textoApoio: pq.questao.textoApoio
        ? { titulo: pq.questao.textoApoio.titulo, conteudo: pq.questao.textoApoio.conteudo }
        : null,
      alternativas,
      anulada: pq.anulada,
      marcada: jaRespondida ? jaRespondida.letra_marcada : null
    });
  } catch (err) { next(err); }
};

// POST /api/provas/:id/responder  { questao_id, letra }  -> salva progressivamente
exports.responder = async (req, res, next) => {
  try {
    const prova = await carregarProvaDoAluno(req);
    if (!prova || prova.status !== 'em_andamento') {
      return res.status(400).json({ erro: 'Prova não está em andamento.' });
    }
    const { questao_id, letra } = req.body;
    if (!letra || !['A', 'B', 'C', 'D', 'E'].includes(letra)) {
      return res.status(400).json({ erro: 'Resposta obrigatória (A-E).' });
    }

    // Já respondida? (1 chance - não permite trocar)
    const existe = await Resposta.findOne({
      where: { prova_aplicada_id: prova.id, questao_id }
    });
    if (existe) return res.status(409).json({ erro: 'Questão já respondida.' });

    const questao = await Questao.findByPk(questao_id);
    const pq = await ProvaQuestao.findOne({
      where: { prova_aplicada_id: prova.id, questao_id }
    });
    // Questão anulada (perda de foco) conta como incorreta
    const correta = !pq.anulada && letra === questao.gabarito;

    await Resposta.create({
      prova_aplicada_id: prova.id, questao_id, letra_marcada: letra, correta
    });

    const total = await ProvaQuestao.count({ where: { prova_aplicada_id: prova.id } });
    const respondidas = await Resposta.count({ where: { prova_aplicada_id: prova.id } });
    return res.json({ ok: true, respondidas, total, concluiu: respondidas >= total });
  } catch (err) { next(err); }
};

// POST /api/provas/:id/foco  { tipo, questao_id }  -> registra perda de foco/copy/paste
exports.registrarFoco = async (req, res, next) => {
  try {
    const prova = await carregarProvaDoAluno(req);
    if (!prova || prova.status !== 'em_andamento') {
      return res.status(400).json({ erro: 'Prova não está em andamento.' });
    }
    const { tipo, questao_id } = req.body;
    await EventoFoco.create({
      prova_aplicada_id: prova.id,
      questao_id: questao_id || null,
      tipo: ['blur', 'visibilitychange', 'copy', 'paste'].includes(tipo) ? tipo : 'blur'
    });

    let anulou = false;
    // Perda de foco de janela/aba anula a questão exibida (política anti-consulta)
    if (['blur', 'visibilitychange'].includes(tipo)) {
      await prova.increment('perdas_foco');
      if (questao_id) {
        const pq = await ProvaQuestao.findOne({
          where: { prova_aplicada_id: prova.id, questao_id }
        });
        if (pq && !pq.anulada) { await pq.update({ anulada: true }); anulou = true; }
      }
    }
    await prova.reload();
    return res.json({ ok: true, perdas_foco: prova.perdas_foco, questao_anulada: anulou });
  } catch (err) { next(err); }
};

// POST /api/provas/:id/finalizar  (manual ou automática por tempo)
exports.finalizar = async (req, res, next) => {
  try {
    const prova = await carregarProvaDoAluno(req);
    if (!prova) return res.status(404).json({ erro: 'Prova não encontrada' });
    if (prova.status === 'concluida') {
      return res.json({ ok: true, redirect: `/aluno/provas/${prova.id}/resultado` });
    }

    const itens = await ProvaQuestao.findOne({ where: { prova_aplicada_id: prova.id } });
    const total = await ProvaQuestao.count({ where: { prova_aplicada_id: prova.id } });
    const acertos = await Resposta.count({
      where: { prova_aplicada_id: prova.id, correta: true }
    });

    const nota = total > 0 ? Math.round((acertos / total) * 100) / 10 : 0; // 0..10
    const mencao = mencaoService.calcularMencao(nota);

    const tempoGasto = prova.iniciada_em
      ? Math.floor((Date.now() - new Date(prova.iniciada_em).getTime()) / 1000)
      : null;

    await prova.update({
      status: 'concluida', finalizada_em: new Date(), tempo_gasto_segundos: tempoGasto
    });

    await Resultado.upsert({
      prova_aplicada_id: prova.id, total_questoes: total, acertos,
      nota: nota.toFixed(2), mencao
    });

    return res.json({ ok: true, redirect: `/aluno/provas/${prova.id}/resultado` });
  } catch (err) { next(err); }
};

// GET /aluno/provas/:id/resultado  -> espelho da prova (view)
exports.resultado = async (req, res, next) => {
  try {
    const prova = await carregarProvaDoAluno(req, true);
    if (!prova) return res.status(404).render('erros/404', { titulo: 'Resultado não encontrado' });

    const dados = await montarEspelho(prova);
    res.render('aluno/resultado', { titulo: 'Resultado da Prova', ...dados,
      descricaoMencao: mencaoService.descricaoMencao });
  } catch (err) { next(err); }
};

// GET /aluno/provas/:id/pdf  -> download do espelho em PDF (assinatura de ciência)
exports.baixarPDF = async (req, res, next) => {
  try {
    const prova = await carregarProvaDoAluno(req, true);
    if (!prova) return res.status(404).render('erros/404', { titulo: 'Prova não encontrada' });
    const dados = await montarEspelho(prova);
    pdfService.gerarEspelhoPDF(dados, res);
  } catch (err) { next(err); }
};

// ---------- Helpers ----------
async function carregarProvaDoAluno(req, comInclusoes = false) {
  const where = { id: req.params.id };
  // Aluno e visitante da feira só acessam suas próprias provas; professor/coordenador/root podem visualizar
  if (['aluno', 'visitante_feira'].includes(req.usuario.perfil)) where.aluno_id = req.usuario.id;
  return ProvaAplicada.findOne({ where });
}

async function montarEspelho(prova) {
  const simulado = await Simulado.findByPk(prova.simulado_id);
  const aluno = await Usuario.findByPk(prova.aluno_id, {
    include: [{ model: Turma, as: 'turma' }]
  });
  const unidade = aluno.unidade_id ? await Unidade.findByPk(aluno.unidade_id) : null;
  const resultado = await Resultado.findOne({ where: { prova_aplicada_id: prova.id } });

  const pqs = await ProvaQuestao.findAll({
    where: { prova_aplicada_id: prova.id }, order: [['ordem', 'ASC']],
    include: [{ model: Questao, as: 'questao', include: [{ model: TextoApoio, as: 'textoApoio' }] }]
  });
  const respostas = await Resposta.findAll({ where: { prova_aplicada_id: prova.id } });
  const mapaResp = new Map(respostas.map((r) => [r.questao_id, r]));

  const itens = pqs.map((pq) => {
    const r = mapaResp.get(pq.questao_id);
    return {
      ordem: pq.ordem,
      enunciado: pq.questao.enunciado,
      gabarito: pq.questao.gabarito,
      letra_marcada: r ? r.letra_marcada : null,
      correta: r ? r.correta : false,
      anulada: pq.anulada,
      texto_apoio_id: pq.questao.texto_apoio_id,
      texto_apoio: pq.questao.textoApoio
        ? { titulo: pq.questao.textoApoio.titulo, conteudo: pq.questao.textoApoio.conteudo }
        : null
    };
  });

  return { unidade, aluno, prova, simulado, itens, resultado };
}
