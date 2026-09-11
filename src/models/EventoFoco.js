// Model: registro de eventos de perda de foco (auditoria anti-cola)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const EventoFoco = sequelize.define('EventoFoco', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  prova_aplicada_id: { type: DataTypes.INTEGER, allowNull: false },
  questao_id: { type: DataTypes.INTEGER },             // questão exibida no momento
  tipo: { type: DataTypes.ENUM('blur', 'visibilitychange', 'copy', 'paste'), allowNull: false },
  ocorrido_em: { type: DataTypes.DATE, allowNull: false, defaultValue: DataTypes.NOW }
}, { tableName: 'eventos_foco' });

module.exports = EventoFoco;
