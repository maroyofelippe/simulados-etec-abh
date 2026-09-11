// Model: Disciplina (Língua Portuguesa, Matemática, etc.)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Disciplina = sequelize.define('Disciplina', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nome: { type: DataTypes.STRING(100), allowNull: false, unique: true },
  area: { type: DataTypes.STRING(100) }   // ex.: "Linguagens", "Ciências da Natureza"
}, { tableName: 'disciplinas' });

module.exports = Disciplina;
