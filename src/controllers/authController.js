// ==========================================================
//  Controller de Autenticação
//  - Login (emite JWT + registra sessão + último login)
//  - Logout (encerra sessão + contabiliza tempo logado)
//  - Elevação de privilégio "root" (coordenador + senha extra)
//  - Persistência de tema (claro/escuro)
// ==========================================================
const jwtService = require('../services/jwtService');
const env = require('../config/env');
const { Usuario, Sessao, Unidade, Turma } = require('../models');
const { encerrarSessao } = require('../middlewares/auth');

// Avisos exibidos na tela de login após um auto-cadastro (via querystring ?aviso=)
const AVISOS_LOGIN = {
  aluno_ok: 'Cadastro concluído! Faça login com seu RM e senha.',
  professor_ok: 'Cadastro enviado. Aguarde a liberação do administrador para acessar o sistema.',
  visitante_feira_ok: `Cadastro realizado com sucesso! Faça login com seu e-mail e a senha padrão: ${env.senhaPadraoVisitante}`
};

// Turma à qual todo auto-cadastro de visitante_feira é automaticamente associado
const NOME_TURMA_FEIRA = 'Feira de Profissões';

const RELACOES_VISITANTE = ['ex_aluno', 'candidato', 'responsavel', 'aluno'];
const CURSOS_VISITANTE = [
'Desenvolvimento de Sistemas-M-Tec-Manhã', 'Eletrônica-M-Tec-Manhã', 'Marketing-M-Tec-Manhã', 'Recursos Humanos-M-Tec-Manhã', 'Programação de Jogos Digitais-M-Tec-Tarde', 'Farmácia-M-Tec-Tarde', 'Biotecnologia-Tarde', 'Administração-M-Tec-Tarde', 'Informática para Internet-M-Tec-Noite', 'Administração-M-Tec-Noite',  'Eletroeletrônica-M-Tec-Noite', 'Eletrotécnica-Noite', 'Especialização em Gestão de Projetos- EAD', 'Farmácia-Noite', 'Guia de Turismo-EAD','Comércio-EAD', 'Secretariado-EAD', 'Transações Imobiliárias-EAD'
];

// GET /login
exports.telaLogin = (req, res) => {
  res.render('auth/login', {
    titulo: 'Entrar',
    erro: null,
    aviso: AVISOS_LOGIN[req.query.aviso] || null,
    layout: false
  });
};

// POST /login  (aceita email OU rm + senha)
exports.login = async (req, res, next) => {
  try {
    const { identificador, senha } = req.body;
    if (!identificador || !senha) {
      return res.status(400).render('auth/login', {
        titulo: 'Entrar', erro: 'Informe usuário e senha.', aviso: null, layout: false
      });
    }

    const usuario = await Usuario.findOne({
      where: identificador.includes('@')
        ? { email: identificador }
        : { rm: identificador }
    });

    if (!usuario || !(await usuario.verificarSenha(senha))) {
      return res.status(401).render('auth/login', {
        titulo: 'Entrar', erro: 'Credenciais inválidas.', aviso: null, layout: false
      });
    }

    if (!usuario.ativo) {
      const erro = usuario.status_cadastro === 'auto_pendente'
        ? 'Cadastro em análise. Aguarde a liberação do administrador.'
        : usuario.status_cadastro === 'recusado'
          ? 'Cadastro não aprovado. Procure a coordenação.'
          : 'Usuário inativo. Procure a coordenação.';
      return res.status(401).render('auth/login', { titulo: 'Entrar', erro, aviso: null, layout: false });
    }

    // Registra a sessão (início) e o último login
    const sessao = await Sessao.create({
      usuario_id: usuario.id,
      inicio: new Date(),
      ip: req.ip,
      encerrada_por: 'ativa'
    });
    await usuario.update({ ultimo_login: new Date() });

    // Emite JWT contendo id, perfil e o id da sessão
    const token = jwtService.assinar({
      id: usuario.id,
      perfil: usuario.perfil,
      is_root: usuario.is_root,
      sessaoId: sessao.id
    });

    res.cookie('token', token, { httpOnly: true, sameSite: 'lax' });
    res.cookie('ultima_atividade', String(Date.now()), { httpOnly: true, sameSite: 'lax' });

    return res.redirect('/');
  } catch (err) {
    next(err);
  }
};

// ----------------------------------------------------------
//  AUTO-CADASTRO (aluno se associa a uma turma; professor fica pendente)
// ----------------------------------------------------------

async function dadosCadastro() {
  const unidades = await Unidade.findAll({ where: { ativo: true }, order: [['nome', 'ASC']] });
  const turmas = await Turma.findAll({
    where: { ativo: true },
    include: [{ model: Unidade, as: 'unidade' }],
    order: [['nome', 'ASC']]
  });
  return { unidades, turmas };
}

// GET /cadastro
exports.telaCadastro = async (req, res, next) => {
  try {
    const { unidades, turmas } = await dadosCadastro();
    res.render('auth/cadastro', {
      titulo: 'Criar conta', erro: null, dados: {}, unidades, turmas,
      relacoesVisitante: RELACOES_VISITANTE, cursosVisitante: CURSOS_VISITANTE, layout: false
    });
  } catch (err) { next(err); }
};

// POST /cadastro
exports.cadastrar = async (req, res, next) => {
  const {
    perfil, nome, email, rm, senha, confirmar_senha, unidade_id, turma_id, codigo_convite,
    telefone, data_nascimento, relacao_etec, curso_interesse
  } = req.body;

  const reexibir = async (erro) => {
    const { unidades, turmas } = await dadosCadastro();
    return res.status(400).render('auth/cadastro', {
      titulo: 'Criar conta', erro, dados: req.body, unidades, turmas,
      relacoesVisitante: RELACOES_VISITANTE, cursosVisitante: CURSOS_VISITANTE, layout: false
    });
  };

  try {
    // --- Validações básicas ---
    if (!['aluno', 'professor', 'visitante_feira'].includes(perfil)) return reexibir('Selecione o tipo de conta.');
    if (!nome || !email) return reexibir('Preencha todos os campos obrigatórios.');

    const ehVisitante = perfil === 'visitante_feira';

    // Visitante da feira não define senha própria (recebe a senha padrão institucional) nem usa código de convite
    if (!ehVisitante) {
      if (!senha || senha.length < 6) return reexibir('A senha deve ter no mínimo 6 caracteres.');
      if (senha !== confirmar_senha) return reexibir('As senhas não conferem.');
      if (!unidade_id) return reexibir('Selecione a unidade.');
    }
    if (perfil === 'aluno' && (!rm || !turma_id)) return reexibir('Aluno deve informar o RM e a turma.');
    if (ehVisitante) {
      if (!telefone || !data_nascimento || !relacao_etec || !curso_interesse) {
        return reexibir('Preencha telefone, data de nascimento, relação com a ETEC e curso de interesse.');
      }
      if (!RELACOES_VISITANTE.includes(relacao_etec)) return reexibir('Relação com a ETEC inválida.');
      if (!CURSOS_VISITANTE.includes(curso_interesse)) return reexibir('Curso de interesse inválido.');
      if (Number.isNaN(Date.parse(data_nascimento)) || new Date(data_nascimento) > new Date()) {
        return reexibir('Data de nascimento inválida.');
      }
    }

    let unidade = null;
    if (!ehVisitante) {
      unidade = await Unidade.findByPk(unidade_id);
      if (!unidade || !unidade.ativo) return reexibir('Unidade inválida.');

      // --- Código de convite (aluno/professor) ---
      const codigoEsperado = perfil === 'aluno' ? unidade.codigo_aluno : unidade.codigo_professor;
      if (!codigoEsperado) return reexibir('Auto-cadastro não habilitado para esta unidade. Procure a coordenação.');
      if ((codigo_convite || '').trim() !== codigoEsperado) return reexibir('Código de acesso inválido.');
    }

    // --- Unicidade ---
    if (await Usuario.findOne({ where: { email } })) return reexibir('Já existe uma conta com este e-mail.');

    const dadosNovo = {
      nome,
      email,
      perfil,
      senha_hash: await Usuario.gerarHash(ehVisitante ? env.senhaPadraoVisitante : senha)
    };

    if (perfil === 'aluno') {
      if (await Usuario.findOne({ where: { rm } })) return reexibir('Já existe uma conta com este RM.');
      const turma = await Turma.findByPk(turma_id);
      if (!turma || !turma.ativo || turma.unidade_id !== unidade.id) return reexibir('Turma inválida para a unidade selecionada.');
      dadosNovo.unidade_id = unidade.id;
      dadosNovo.rm = String(rm).trim();
      dadosNovo.turma_id = turma.id;
      dadosNovo.periodo = turma.periodo;
      dadosNovo.ativo = true;
      dadosNovo.status_cadastro = 'aprovado';
    } else if (perfil === 'professor') {
      // Professor: entra inativo até validação do administrador
      dadosNovo.unidade_id = unidade.id;
      dadosNovo.ativo = false;
      dadosNovo.status_cadastro = 'auto_pendente';
    } else {
      // Visitante da feira: associado automaticamente à turma da feira; acessa com a senha padrão
      const turmaFeira = await Turma.findOne({ where: { nome: NOME_TURMA_FEIRA, ativo: true } });
      if (!turmaFeira) return reexibir('Auto-cadastro da feira não habilitado. Procure a coordenação.');
      dadosNovo.unidade_id = turmaFeira.unidade_id;
      dadosNovo.turma_id = turmaFeira.id;
      dadosNovo.periodo = turmaFeira.periodo;
      dadosNovo.telefone = telefone.trim();
      dadosNovo.data_nascimento = data_nascimento;
      dadosNovo.relacao_etec = relacao_etec;
      dadosNovo.curso_interesse = curso_interesse;
      dadosNovo.ativo = true;
      dadosNovo.status_cadastro = 'aprovado';
    }

    await Usuario.create(dadosNovo);
    const aviso = { aluno: 'aluno_ok', professor: 'professor_ok', visitante_feira: 'visitante_feira_ok' }[perfil];
    return res.redirect(`/login?aviso=${aviso}`);
  } catch (err) {
    if (err.name === 'SequelizeUniqueConstraintError') return reexibir('Já existe uma conta com esses dados (e-mail ou RM).');
    return next(err);
  }
};

// GET|POST /logout
exports.logout = async (req, res, next) => {
  try {
    if (req.sessaoId) await encerrarSessao(req.sessaoId, 'logout');
    res.clearCookie('token');
    res.clearCookie('ultima_atividade');
    return res.redirect('/login');
  } catch (err) {
    next(err);
  }
};

// POST /root/elevar  (somente coordenador logado + senha root do .env)
exports.elevarRoot = async (req, res, next) => {
  try {
    const u = req.usuario;
    if (u.perfil !== 'coordenador') {
      return res.status(403).json({ erro: 'Apenas Coordenador/Administrador pode elevar a root.' });
    }
    const { senha_root } = req.body;
    if (senha_root !== env.rootPassword) {
      return res.status(401).json({ erro: 'Senha root incorreta.' });
    }
    await u.update({ is_root: true });
    // Reemite token já com is_root = true
    const token = jwtService.assinar({
      id: u.id, perfil: u.perfil, is_root: true, sessaoId: req.sessaoId
    });
    res.cookie('token', token, { httpOnly: true, sameSite: 'lax' });
    return res.json({ ok: true, mensagem: 'Privilégio root ativado.' });
  } catch (err) {
    next(err);
  }
};

// POST /root/rebaixar
exports.rebaixarRoot = async (req, res, next) => {
  try {
    const u = req.usuario;
    await u.update({ is_root: false });
    const token = jwtService.assinar({
      id: u.id, perfil: u.perfil, is_root: false, sessaoId: req.sessaoId
    });
    res.cookie('token', token, { httpOnly: true, sameSite: 'lax' });
    return res.json({ ok: true, mensagem: 'Privilégio root desativado.' });
  } catch (err) {
    next(err);
  }
};

// POST /tema  { tema: 'claro'|'escuro' } -> persiste no banco
exports.salvarTema = async (req, res, next) => {
  try {
    const { tema } = req.body;
    if (!['claro', 'escuro'].includes(tema)) {
      return res.status(400).json({ erro: 'Tema inválido.' });
    }
    if (req.usuario) await req.usuario.update({ tema_preferido: tema });
    res.cookie('tema', tema, { sameSite: 'lax' });
    return res.json({ ok: true });
  } catch (err) {
    next(err);
  }
};
