// ==========================================================
//  Middleware de AUTENTICAÇÃO (JWT)
//  Lê o token do cookie "token" ou do header Authorization.
//  Também aplica o TIMEOUT por inatividade (SESSION_TIMEOUT).
// ==========================================================
const jwtService = require('../services/jwtService');
const env = require('../config/env');
const { Usuario, Sessao } = require('../models');

async function autenticar(req, res, next) {
  try {
    const token =
      (req.cookies && req.cookies.token) ||
      (req.headers.authorization && req.headers.authorization.replace('Bearer ', ''));

    if (!token) return redirecionarOuErro(req, res, 'Sessão não encontrada. Faça login.');

    const payload = jwtService.verificar(token); // lança se expirado/inválido

    // A sessão precisa continuar aberta em banco — permite que o administrador
    // force a desconexão de um usuário (/admin/usuarios) mesmo com o JWT
    // ainda válido: basta encerrar o registro em "sessoes".
    const sessaoAtual = await Sessao.findByPk(payload.sessaoId);
    if (!sessaoAtual || sessaoAtual.fim) {
      res.clearCookie('token');
      res.clearCookie('ultima_atividade');
      return redirecionarOuErro(req, res, 'Sessão encerrada. Faça login novamente.');
    }

    // --- Controle de sessão por inatividade ---
    const agora = Date.now();
    const ultimaAtividade = req.cookies && req.cookies.ultima_atividade
      ? parseInt(req.cookies.ultima_atividade, 10)
      : agora;
    const inativoMin = (agora - ultimaAtividade) / 60000;

    if (inativoMin > env.sessionTimeoutMin) {
      await encerrarSessao(payload.sessaoId, 'timeout');
      res.clearCookie('token');
      res.clearCookie('ultima_atividade');
      return redirecionarOuErro(req, res, 'Sessão expirada por inatividade.');
    }

    // Renova o marcador de atividade (sliding session): no cookie (usado no cálculo
    // acima) e espelhado em banco (para o /admin/usuarios calcular "logado?"/tempo
    // restante). Não bloqueia a requisição se a escrita falhar.
    res.cookie('ultima_atividade', String(agora), { httpOnly: true, sameSite: 'lax' });
    sessaoAtual.update({ ultima_atividade: new Date(agora) }).catch(() => {});

    const usuario = await Usuario.findByPk(payload.id);
    if (!usuario || !usuario.ativo) {
      return redirecionarOuErro(req, res, 'Usuário inválido ou inativo.');
    }

    // Disponibiliza o usuário para controllers e views
    req.usuario = usuario;
    req.sessaoId = payload.sessaoId;
    res.locals.usuario = usuario;
    next();
  } catch (err) {
    return redirecionarOuErro(req, res, 'Sessão expirada ou inválida. Faça login novamente.');
  }
}

async function encerrarSessao(sessaoId, motivo) {
  if (!sessaoId) return;
  const sessao = await Sessao.findByPk(sessaoId);
  if (sessao && !sessao.fim) {
    const fim = new Date();
    const dur = Math.round((fim - sessao.inicio) / 1000);
    await sessao.update({ fim, duracao_segundos: dur, encerrada_por: motivo });
    const usuario = await Usuario.findByPk(sessao.usuario_id);
    if (usuario) {
      await usuario.update({ tempo_logado_total: (usuario.tempo_logado_total || 0) + dur });
    }
  }
}

function redirecionarOuErro(req, res, msg) {
  // APIs recebem JSON; navegação recebe redirect para login
  if (req.originalUrl.startsWith('/api') || req.xhr) {
    return res.status(401).json({ erro: msg });
  }
  return res.redirect('/login');
}

module.exports = { autenticar, encerrarSessao };
