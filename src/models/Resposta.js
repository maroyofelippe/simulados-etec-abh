// Model: resposta do aluno a uma questão da prova
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Resposta = sequelize.define('Resposta', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  prova_aplicada_id: { type: DataTypes.INTEGER, allowNull: false },
  questao_id: { type: DataTypes.INTEGER, allowNull: false },
  letra_marcada: { type: DataTypes.CHAR(1) },          // A..E (obrigatória na submissão)
  correta: { type: DataTypes.BOOLEAN },
  respondida_em: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, {
  tableName: 'respostas',
  indexes: [{ unique: true, fields: ['prova_aplicada_id', 'questao_id'] }]
});

module.exports = Resposta;
