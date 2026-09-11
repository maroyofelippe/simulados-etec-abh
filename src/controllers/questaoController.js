// ==========================================================
//  Controller do Banco de Questões
//  - Listar / criar (com alternativas e texto de apoio opcional)
//  - Importar questões via CSV
// ==========================================================
const { Questao, Alternativa, TextoApoio, Disciplina, Turma, sequelize } = require('../models');
const { parse } = require('csv-parse/sync');

exports.listar = async (req, res, next) => {
  try {
    const { disciplina_id, dificuldade } = req.query;
    const where = {};
    if (disciplina_id) where.disciplina_id = disciplina_id;
    if (dificuldade) where.dificuldade = dificuldade;

    const questoes = await Questao.findAll({
      where,
      include: [{ model: Disciplina, as: 'disciplina' }, { model: TextoApoio, as: 'textoApoio' }],
      order: [['criado_em', 'DESC']], limit: 200
    });
    const disciplinas = await Disciplina.findAll({ order: [['nome', 'ASC']] });

    // Placar: total de questões do banco e contagem por disciplina (sempre o total geral,
    // independente do filtro/limite de 200 aplicados à tabela acima)
    const totalQuestoes = await Questao.count();
    const contagemPorDisciplina = await Questao.count({ group: ['disciplina_id'] });
    const mapaContagem = new Map(contagemPorDisciplina.map((c) => [c.disciplina_id, c.count]));
    const placarDisciplinas = disciplinas.map((d) => ({ nome: d.nome, total: mapaContagem.get(d.id) || 0 }));

    res.render('professor/questoes', {
      titulo: 'Banco de Questões', questoes, disciplinas, filtro: req.query,
      totalQuestoes, placarDisciplinas
    });
  } catch (err) { next(err); }
};

exports.telaNova = async (req, res, next) => {
  try {
    const disciplinas = await Disciplina.findAll({ order: [['nome', 'ASC']] });
    const turmas = await Turma.findAll({ where: { ativo: true }, order: [['nome', 'ASC']] });
    const textosApoio = await TextoApoio.findAll({ order: [['criado_em', 'DESC']], limit: 100 });
    res.render('professor/questao_nova', { titulo: 'Nova Questão', disciplinas, turmas, textosApoio, erro: null });
  } catch (err) { next(err); }
};

exports.criar = async (req, res, next) => {
  const t = await sequelize.transaction();
  try {
    const { enunciado, dificuldade, tema, serie, gabarito, disciplina_id, turma_id,
      alt_a, alt_b, alt_c, alt_d, alt_e, texto_apoio_id, texto_apoio_titulo, texto_apoio_conteudo } = req.body;

    let textoApoioId = (texto_apoio_id && texto_apoio_id !== 'novo') ? parseInt(texto_apoio_id, 10) : null;
    if (!textoApoioId && texto_apoio_conteudo && texto_apoio_conteudo.trim()) {
      const novoTexto = await TextoApoio.create({
        titulo: (texto_apoio_titulo || '').trim() || null,
        conteudo: texto_apoio_conteudo.trim(),
        disciplina_id, autor_id: req.usuario.id
      }, { transaction: t });
      textoApoioId = novoTexto.id;
    }

    const questao = await Questao.create({
      enunciado, dificuldade, tema, serie, gabarito: (gabarito || 'A').toUpperCase(),
      disciplina_id, turma_id: turma_id || null, autor_id: req.usuario.id, texto_apoio_id: textoApoioId
    }, { transaction: t });

    const alternativas = [
      { letra: 'A', texto: alt_a }, { letra: 'B', texto: alt_b },
      { letra: 'C', texto: alt_c }, { letra: 'D', texto: alt_d },
      { letra: 'E', texto: alt_e }
    ].filter((a) => a.texto && a.texto.trim());

    await Alternativa.bulkCreate(
      alternativas.map((a) => ({ ...a, questao_id: questao.id })), { transaction: t }
    );
    await t.commit();
    res.redirect('/professor/questoes');
  } catch (err) { await t.rollback(); next(err); }
};

// Importação de questões via CSV
// Colunas: disciplina,dificuldade,tema,serie,enunciado,alt_a,alt_b,alt_c,alt_d,alt_e,gabarito,
//          texto_apoio_titulo,texto_apoio_conteudo (as duas últimas são opcionais)
// Linhas com o mesmo texto_apoio_titulo (não vazio) são agrupadas no mesmo texto de apoio,
// reutilizando um texto já existente no banco com o mesmo título quando houver.
exports.importarCsv = async (req, res, next) => {
  try {
    if (!req.file) return res.status(400).json({ erro: 'Envie um arquivo CSV.' });
    const registros = parse(req.file.buffer, {
      columns: (h) => h.map((c) => c.trim().toLowerCase()),
      skip_empty_lines: true, trim: true
    });

    const disciplinas = await Disciplina.findAll();
    const mapaDisc = new Map(disciplinas.map((d) => [d.nome.toLowerCase(), d.id]));
    const cacheTextosApoio = new Map(); // chave (título ou conteúdo) -> texto_apoio_id, dentro deste lote
    const relatorio = { total: registros.length, sucessos: 0, erros: [] };

    for (let i = 0; i < registros.length; i++) {
      const r = registros[i];
      const discId = mapaDisc.get(String(r.disciplina || '').toLowerCase());
      if (!discId) { relatorio.erros.push({ linha: i + 2, motivo: `Disciplina inexistente: ${r.disciplina}` }); continue; }
      try {
        const textoApoioId = await resolverTextoApoio(r, discId, req.usuario.id, cacheTextosApoio);

        const q = await Questao.create({
          enunciado: r.enunciado, dificuldade: r.dificuldade || 'Médio',
          tema: r.tema, serie: r.serie, gabarito: (r.gabarito || 'A').toUpperCase(),
          disciplina_id: discId, autor_id: req.usuario.id, texto_apoio_id: textoApoioId
        });
        await Alternativa.bulkCreate([
          { letra: 'A', texto: r.alt_a, questao_id: q.id },
          { letra: 'B', texto: r.alt_b, questao_id: q.id },
          { letra: 'C', texto: r.alt_c, questao_id: q.id },
          { letra: 'D', texto: r.alt_d, questao_id: q.id },
          { letra: 'E', texto: r.alt_e, questao_id: q.id }
        ].filter((a) => a.texto));
        relatorio.sucessos++;
      } catch (e) { relatorio.erros.push({ linha: i + 2, motivo: e.message }); }
    }
    res.json(relatorio);
  } catch (err) { next(err); }
};

// Resolve (reaproveitando ou criando) o texto_apoio_id de uma linha do CSV
async function resolverTextoApoio(registro, disciplinaId, autorId, cache) {
  const titulo = String(registro.texto_apoio_titulo || '').trim();
  const conteudo = String(registro.texto_apoio_conteudo || '').trim();
  if (!conteudo) return null;

  const chave = titulo ? `titulo:${titulo.toLowerCase()}` : `conteudo:${conteudo}`;
  if (cache.has(chave)) return cache.get(chave);

  let registroTexto = titulo ? await TextoApoio.findOne({ where: { titulo } }) : null;
  if (!registroTexto) {
    registroTexto = await TextoApoio.create({
      titulo: titulo || null, conteudo, disciplina_id: disciplinaId, autor_id: autorId
    });
  }
  cache.set(chave, registroTexto.id);
  return registroTexto.id;
}
