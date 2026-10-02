// Model: pergunta aberta do teste vocacional
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const VocPerguntaAberta = sequelize.define('VocPerguntaAberta', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  texto: { type: DataTypes.STRING(255), allowNull: false },
  ordem: { type: DataTypes.INTEGER, allowNull: false },
  ativa: { type: DataTypes.BOOLEAN, defaultValue: true }
}, { tableName: 'voc_perguntas_abertas' });

module.exports = VocPerguntaAberta;
