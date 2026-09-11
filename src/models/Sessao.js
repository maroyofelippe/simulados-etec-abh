// Model: Sessão de usuário (controle de tempo logado)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Sessao = sequelize.define('Sessao', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  usuario_id: { type: DataTypes.INTEGER, allowNull: false },
  inicio: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW },
  fim: { type: DataTypes.DATE },                       // preenchido no logout/expiração
  duracao_segundos: { type: DataTypes.INTEGER },       // fim - inicio
  ip: { type: DataTypes.STRING(45) },
  encerrada_por: { type: DataTypes.ENUM('logout', 'timeout', 'ativa'), defaultValue: 'ativa' }
}, { tableName: 'sessoes' });

module.exports = Sessao;
