// Model: resultado consolidado de uma prova aplicada
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Resultado = sequelize.define('Resultado', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  prova_aplicada_id: { type: DataTypes.INTEGER, allowNull: false, unique: true },
  total_questoes: { type: DataTypes.INTEGER, allowNull: false },
  acertos: { type: DataTypes.INTEGER, allowNull: false },
  nota: { type: DataTypes.DECIMAL(4, 2), allowNull: false }, // 0.00 a 10.00
  // Menção: I (0-4,9) | R (5,0-6,9) | B (7,0-8,9) | MB (>=9,0)
  mencao: { type: DataTypes.ENUM('I', 'R', 'B', 'MB'), allowNull: false }
}, { tableName: 'resultados' });

module.exports = Resultado;
