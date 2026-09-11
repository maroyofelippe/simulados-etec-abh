// Model: Turma vinculada a uma unidade
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Turma = sequelize.define('Turma', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nome: { type: DataTypes.STRING(80), allowNull: false },       // ex.: "1º A"
  serie: { type: DataTypes.STRING(40) },                        // ex.: "1ª Série EM"
  periodo: { type: DataTypes.ENUM('Manhã', 'Tarde', 'Noite', 'Integral'), allowNull: false },
  ano_letivo: { type: DataTypes.INTEGER, allowNull: false },
  unidade_id: { type: DataTypes.INTEGER, allowNull: false },
  // Inativa = oculta de listas/dropdowns de seleção (root); registro e histórico preservados
  ativo: { type: DataTypes.BOOLEAN, defaultValue: true }
}, { tableName: 'turmas' });

module.exports = Turma;
