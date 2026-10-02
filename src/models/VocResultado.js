// Model: pontuação de uma área no resultado do teste vocacional
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const VocResultado = sequelize.define('VocResultado', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  aplicacao_id: { type: DataTypes.INTEGER, allowNull: false },
  area_codigo: { type: DataTypes.STRING(5), allowNull: false },
  pontos: { type: DataTypes.INTEGER, allowNull: false },   // soma das 3 notas (3 a 15)
  posicao: { type: DataTypes.INTEGER, allowNull: false }   // 1 = maior afinidade
}, {
  tableName: 'voc_resultados',
  indexes: [{ unique: true, fields: ['aplicacao_id', 'area_codigo'] }]
});

module.exports = VocResultado;
