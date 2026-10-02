// Model: área/curso avaliado no teste vocacional
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const VocArea = sequelize.define('VocArea', {
  codigo: { type: DataTypes.STRING(5), primaryKey: true },
  nome: { type: DataTypes.STRING(100), allowNull: false },
  grupo: { type: DataTypes.ENUM('tec', 'saude', 'gestao', 'servicos'), allowNull: false },
  descricao: { type: DataTypes.TEXT, allowNull: false },
  ordem: { type: DataTypes.INTEGER, allowNull: false }
}, { tableName: 'voc_areas' });

module.exports = VocArea;
