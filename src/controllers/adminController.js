// ==========================================================
//  Controller de Administração (coordenador/root)
//  - Unidades (com upload de logo)
//  - Turmas
//  - Disciplinas
//  - Usuários (listagem/gestão)
// ==========================================================
const { Op } = require('sequelize');
const {
  Unidade, Turma, Disciplina, Usuario, Sessao, ProvaAplicada, Questao, Simulado, TextoApoio, sequelize
} = require('../models');
const env = require('../config/env');
const { encerrarSessao } = require('../middlewares/auth');

// ---- Unidades ----
exports.listarUnidades = async (req, res, next) => {
  try {
    const unidades = await Unidade.findAll({ order: [['nome', 'ASC']] });
    res.render('admin/unidades', { titulo: 'Unidades de Ensino', unidades });
  } catch (err) { next(err); }
};

exports.criarUnidade = async (req, res, next) => {
  try {
    const { nome, sigla, cidade, codigo_aluno, codigo_professor } = req.body;
    // Logo enviado via multer -> salvo em /public/uploads
    const logo_path = req.file ? `uploads/${req.file.filename}` : null;
    await Unidade.create({
      nome, sigla, cidade, logo_path,
      codigo_aluno: codigo_aluno ? codigo_aluno.trim() : null,
      codigo_professor: codigo_professor ? codigo_professor.trim() : null
    });
    res.redirect('/admin/unidades');
  } catch (err) { next(err); }
};

exports.editarUnidadeForm = async (req, res, next) => {
  try {
    const unidadeEditada = await Unidade.findByPk(req.params.id);
    if (!unidadeEditada) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });
    res.render('admin/unidade_editar', { titulo: 'Editar Unidade', unidadeEditada });
  } catch (err) { next(err); }
};

exports.atualizarUnidade = async (req, res, next) => {
  try {
    const unidade = await Unidade.findByPk(req.params.id);
    if (!unidade) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });
    const { nome, sigla, cidade, codigo_aluno, codigo_professor } = req.body;
    const dados = {
      nome,
      sigla: sigla || null,
      cidade: cidade || null,
      codigo_aluno: codigo_aluno ? codigo_aluno.trim() : null,
      codigo_professor: codigo_professor ? codigo_professor.trim() : null
    };
    if (req.file) dados.logo_path = `uploads/${req.file.filename}`;
    await unidade.update(dados);
    res.redirect('/admin/unidades');
  } catch (err) { next(err); }
};

// Inativar/reativar unidade (root). Excluir de verdade derrubaria em cascata todas as
// turmas, alunos/professores e histórico de provas vinculados a ela — em vez disso, a
// unidade inativa some das listas de seleção/dropdowns, preservando o histórico.
exports.alternarStatusUnidade = async (req, res, next) => {
  try {
    const unidade = await Unidade.findByPk(req.params.id);
    if (!unidade) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });
    await unidade.update({ ativo: !unidade.ativo });
    res.redirect('/admin/unidades');
  } catch (err) { next(err); }
};

// ---- Turmas ----
exports.listarTurmas = async (req, res, next) => {
  try {
    const turmas = await Turma.findAll({ include: [{ model: Unidade, as: 'unidade' }], order: [['nome', 'ASC']] });
    // Só unidades ativas podem receber novas turmas
    const unidades = await Unidade.findAll({ where: { ativo: true }, order: [['nome', 'ASC']] });
    res.render('admin/turmas', { titulo: 'Turmas', turmas, unidades });
  } catch (err) { next(err); }
};

exports.criarTurma = async (req, res, next) => {
  try {
    const { nome, serie, periodo, ano_letivo, unidade_id } = req.body;
    await Turma.create({ nome, serie, periodo, ano_letivo, unidade_id });
    res.redirect('/admin/turmas');
  } catch (err) { next(err); }
};

// Inativar/reativar turma (root). Excluir de verdade derrubaria em cascata os alunos e
// professores vinculados e o histórico de provas — em vez disso, a turma inativa some
// das listas de seleção/dropdowns, preservando o histórico.
exports.alternarStatusTurma = async (req, res, next) => {
  try {
    const turma = await Turma.findByPk(req.params.id);
    if (!turma) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });
    await turma.update({ ativo: !turma.ativo });
    res.redirect('/admin/turmas');
  } catch (err) { next(err); }
};

// ---- Disciplinas ----
exports.listarDisciplinas = async (req, res, next) => {
  try {
    const disciplinas = await Disciplina.findAll({ order: [['nome', 'ASC']] });
    res.render('admin/disciplinas', { titulo: 'Disciplinas', disciplinas });
  } catch (err) { next(err); }
};

exports.criarDisciplina = async (req, res, next) => {
  try {
    const { nome, area } = req.body;
    await Disciplina.create({ nome, area });
    res.redirect('/admin/disciplinas');
  } catch (err) { next(err); }
};

// ---- Usuários ----
exports.listarUsuarios = async (req, res, next) => {
  try {
    const usuarios = await Usuario.findAll({
      include: [
        { model: Turma, as: 'turma' },
        // Sessão aberta (fim IS NULL) mais recente de cada usuário — usada na view
        // para indicar "logado?" e o tempo restante até o timeout por inatividade.
        // Um mesmo usuário pode ter mais de uma sessão aberta simultânea (ex.: aba
        // antiga cujo navegador fechou sem passar pelo /logout) — ordena pela
        // atividade mais recente de fato (não pelo id) para pegar a que reflete
        // melhor "o usuário está usando o sistema agora". separate:true evita
        // duplicar linhas do JOIN principal (turma) e permite limit/order por usuário.
        {
          model: Sessao, as: 'sessoes', where: { fim: null }, required: false,
          separate: true, order: [[sequelize.literal('COALESCE(ultima_atividade, inicio)'), 'DESC']], limit: 1
        }
      ],
      order: [['nome', 'ASC']], limit: 500
    });
    const pendentes = await Usuario.count({ where: { status_cadastro: 'auto_pendente' } });
    res.render('admin/usuarios', {
      titulo: 'Usuários', usuarios, pendentes, sessionTimeoutMin: env.sessionTimeoutMin
    });
  } catch (err) { next(err); }
};

// Desconexão forçada: encerra TODAS as sessões abertas do usuário em banco (ele
// pode ter mais de uma — outra aba, outro dispositivo, ou uma antiga esquecida
// aberta). O cookie do JWT no navegador do usuário-alvo continua existindo, mas
// o middleware de autenticação rejeita o token assim que "sessoes.fim" for
// preenchido — a próxima requisição dele já cai de volta na tela de login.
exports.desconectarUsuario = async (req, res, next) => {
  try {
    const usuarioAlvo = await Usuario.findByPk(req.params.id);
    if (!usuarioAlvo) return res.status(404).json({ erro: 'Usuário não encontrado.' });
    if (usuarioAlvo.id === req.usuario.id) {
      return res.status(400).json({ erro: 'Não é possível desconectar o próprio usuário logado.' });
    }
    const sessoesAtivas = await Sessao.findAll({ where: { usuario_id: usuarioAlvo.id, fim: null } });
    if (!sessoesAtivas.length) return res.status(400).json({ erro: 'Usuário não está com sessão ativa.' });

    await Promise.all(sessoesAtivas.map((s) => encerrarSessao(s.id, 'forcado')));
    res.json({ ok: true, mensagem: `Sessão de ${usuarioAlvo.nome} encerrada.` });
  } catch (err) { next(err); }
};

exports.editarUsuarioForm = async (req, res, next) => {
  try {
    const usuarioEditado = await Usuario.findByPk(req.params.id, {
      include: [{ model: Turma, as: 'turmasLecionadas', through: { attributes: [] } }]
    });
    if (!usuarioEditado) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });
    const turmasLecionadasIds = (usuarioEditado.turmasLecionadas || []).map((t) => t.id);
    // Turmas ativas, mais as já vinculadas a este usuário (turma do aluno e/ou turmas que o
    // professor leciona) mesmo que tenham sido inativadas nesse meio tempo — para não sumir
    // dos <select>s e acabar desvinculando o usuário delas sem querer ao salvar o formulário.
    const idsVinculados = [usuarioEditado.turma_id, ...turmasLecionadasIds].filter(Boolean);
    const turmas = await Turma.findAll({
      where: idsVinculados.length
        ? { [Op.or]: [{ ativo: true }, { id: { [Op.in]: idsVinculados } }] }
        : { ativo: true },
      order: [['nome', 'ASC']]
    });
    const provasRealizadas = await ProvaAplicada.count({ where: { aluno_id: usuarioEditado.id } });
    res.render('admin/usuario_editar', {
      titulo: 'Editar Usuário', usuarioEditado, turmas, turmasLecionadasIds,
      erro: req.query.erro || null,
      provasRealizadas
    });
  } catch (err) { next(err); }
};

// Exclusão definitiva de usuário (aluno/visitante/professor) — ação exclusiva do root.
// Remove em cascata o que é pessoal do usuário (sessões, provas realizadas e toda a
// cadeia delas via ON DELETE CASCADE no banco). Conteúdo que ele possa ter autorado
// (questões, simulados, textos de apoio) é preservado — apenas desvinculado do autor —
// para não quebrar o material/histórico de outras turmas que ainda o utilizem.
exports.excluirUsuario = async (req, res, next) => {
  try {
    const usuarioAlvo = await Usuario.findByPk(req.params.id);
    if (!usuarioAlvo) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });

    if (usuarioAlvo.id === req.usuario.id) {
      return res.redirect(`/admin/usuarios/${usuarioAlvo.id}/editar?erro=${
        encodeURIComponent('Não é possível excluir o próprio usuário logado.')
      }`);
    }

    await sequelize.transaction(async (t) => {
      // Provas realizadas (prova_questoes/respostas/eventos_foco/resultados seguem via
      // ON DELETE CASCADE no banco).
      await ProvaAplicada.destroy({ where: { aluno_id: usuarioAlvo.id }, transaction: t });
      // Sessões de login (histórico de tempo logado).
      await Sessao.destroy({ where: { usuario_id: usuarioAlvo.id }, transaction: t });
      // Conteúdo autoral: mantém questões/simulados/textos de apoio, só desvincula o autor.
      await Questao.update({ autor_id: null }, { where: { autor_id: usuarioAlvo.id }, transaction: t });
      await Simulado.update({ criado_por: null }, { where: { criado_por: usuarioAlvo.id }, transaction: t });
      await TextoApoio.update({ autor_id: null }, { where: { autor_id: usuarioAlvo.id }, transaction: t });
      // Vínculos professor<->turma (professor_turmas) somem sozinhos via ON DELETE CASCADE.
      await usuarioAlvo.destroy({ transaction: t });
    });

    res.redirect('/admin/usuarios');
  } catch (err) {
    if (err.name === 'SequelizeForeignKeyConstraintError') {
      return res.redirect(`/admin/usuarios/${req.params.id}/editar?erro=${
        encodeURIComponent('Não foi possível excluir: usuário possui vínculos não previstos no sistema.')
      }`);
    }
    next(err);
  }
};

exports.atualizarUsuario = async (req, res, next) => {
  try {
    const usuarioEditado = await Usuario.findByPk(req.params.id);
    if (!usuarioEditado) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });
    const { nome, email, rm, perfil, periodo, turma_id, ativo, status_cadastro } = req.body;
    await usuarioEditado.update({
      nome,
      email: email || null,
      rm: rm || null,
      perfil,
      periodo: periodo || null,
      turma_id: turma_id || null,
      ativo: ativo === 'on',
      status_cadastro: ['auto_pendente', 'aprovado', 'recusado'].includes(status_cadastro)
        ? status_cadastro : usuarioEditado.status_cadastro
    });

    // Turmas que o professor leciona (multiselect). Só aplica se o perfil for professor.
    if (perfil === 'professor') {
      const ids = [].concat(req.body.turmas_lecionadas || []).filter(Boolean);
      await usuarioEditado.setTurmasLecionadas(ids);
    } else {
      await usuarioEditado.setTurmasLecionadas([]);
    }

    res.redirect('/admin/usuarios');
  } catch (err) { next(err); }
};

// ---- Aprovação de auto-cadastro de professores ----
exports.listarPendentes = async (req, res, next) => {
  try {
    const pendentes = await Usuario.findAll({
      where: { status_cadastro: 'auto_pendente' },
      include: [{ model: Unidade, as: 'unidade' }],
      order: [['criado_em', 'ASC']]
    });
    const turmas = await Turma.findAll({ where: { ativo: true }, order: [['nome', 'ASC']] });
    res.render('admin/aprovacoes', { titulo: 'Aprovações de cadastro', pendentes, turmas });
  } catch (err) { next(err); }
};

exports.aprovarUsuario = async (req, res, next) => {
  try {
    const usuario = await Usuario.findByPk(req.params.id);
    if (!usuario) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });
    await usuario.update({ ativo: true, status_cadastro: 'aprovado' });
    if (usuario.perfil === 'professor') {
      const ids = [].concat(req.body.turmas || []).filter(Boolean);
      await usuario.setTurmasLecionadas(ids);
    }
    res.redirect('/admin/aprovacoes');
  } catch (err) { next(err); }
};

exports.recusarUsuario = async (req, res, next) => {
  try {
    const usuario = await Usuario.findByPk(req.params.id);
    if (!usuario) return res.status(404).render('erros/404', { titulo: 'Não encontrado' });
    await usuario.update({ ativo: false, status_cadastro: 'recusado' });
    res.redirect('/admin/aprovacoes');
  } catch (err) { next(err); }
};

// Reset de senha do usuário (ação exclusiva do administrador/coordenador)
exports.resetarSenha = async (req, res, next) => {
  try {
    const usuario = await Usuario.findByPk(req.params.id);
    if (!usuario) return res.status(404).json({ erro: 'Usuário não encontrado.' });
    const senhaPadrao = usuario.perfil === 'visitante_feira' ? env.senhaPadraoVisitante : env.senhaPadraoImportacao;
    const senha_hash = await Usuario.gerarHash(senhaPadrao);
    await usuario.update({ senha_hash });
    res.json({
      ok: true,
      mensagem: 'Senha redefinida para a senha padrão institucional.',
      senha_padrao: senhaPadrao
    });
  } catch (err) { next(err); }
};
