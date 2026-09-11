// Model: Alternativa de uma questão
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Alternativa = sequelize.define('Alternativa', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  questao_id: { type: DataTypes.INTEGER, allowNull: false },
  letra: { type: DataTypes.CHAR(1), allowNull: false }, // A, B, C, D, E
  texto: { type: DataTypes.TEXT, allowNull: false }
}, { tableName: 'alternativas' });

module.exports = Alternativa;
