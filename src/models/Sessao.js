// Model: Sessão de usuário (controle de tempo logado)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Sessao = sequelize.define('Sessao', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  usuario_id: { type: DataTypes.INTEGER, allowNull: false },
  inicio: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW },
  // Espelha em banco o cookie "ultima_atividade" (sliding session) a cada requisição
  // autenticada — usado por /admin/usuarios para mostrar se o usuário está logado e
  // o tempo restante até o timeout por inatividade (SESSION_TIMEOUT).
  ultima_atividade: { type: DataTypes.DATE },
  fim: { type: DataTypes.DATE },                       // preenchido no logout/expiração
  duracao_segundos: { type: DataTypes.INTEGER },       // fim - inicio
  ip: { type: DataTypes.STRING(45) },
  // 'forcado': sessão encerrada pelo administrador (botão "Desconectar" em /admin/usuarios)
  encerrada_por: { type: DataTypes.ENUM('logout', 'timeout', 'ativa', 'forcado'), defaultValue: 'ativa' }
}, { tableName: 'sessoes' });

module.exports = Sessao;
