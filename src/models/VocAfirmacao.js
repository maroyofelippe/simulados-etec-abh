// Model: afirmação do teste vocacional (nota de 1 a 5)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const VocAfirmacao = sequelize.define('VocAfirmacao', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  area_codigo: { type: DataTypes.STRING(5), allowNull: false },
  texto: { type: DataTypes.STRING(255), allowNull: false },
  ativa: { type: DataTypes.BOOLEAN, defaultValue: true }
}, { tableName: 'voc_afirmacoes' });

module.exports = VocAfirmacao;
