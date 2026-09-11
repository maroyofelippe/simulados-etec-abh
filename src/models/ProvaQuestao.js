// Model: questões sorteadas para uma prova aplicada (ordem individual)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const ProvaQuestao = sequelize.define('ProvaQuestao', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  prova_aplicada_id: { type: DataTypes.INTEGER, allowNull: false },
  questao_id: { type: DataTypes.INTEGER, allowNull: false },
  ordem: { type: DataTypes.INTEGER, allowNull: false },
  // Questão anulada por perda de foco durante sua exibição
  anulada: { type: DataTypes.BOOLEAN, defaultValue: false }
}, {
  tableName: 'prova_questoes',
  indexes: [{ unique: true, fields: ['prova_aplicada_id', 'questao_id'] }] // sem repetição
});

module.exports = ProvaQuestao;
