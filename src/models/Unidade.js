// Model: Unidade de ensino (ex.: ETEC ABH)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Unidade = sequelize.define('Unidade', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nome: { type: DataTypes.STRING(150), allowNull: false },
  sigla: { type: DataTypes.STRING(20) },
  cidade: { type: DataTypes.STRING(100) },
  // Caminho relativo do logo (usado no espelho/PDF da prova)
  logo_path: { type: DataTypes.STRING(255) },
  // Códigos de convite exigidos no auto-cadastro (vazio = auto-cadastro desabilitado)
  codigo_aluno: { type: DataTypes.STRING(40) },
  codigo_professor: { type: DataTypes.STRING(40) },
  // Inativa = oculta de listas/dropdowns de seleção (root); registro e histórico preservados
  ativo: { type: DataTypes.BOOLEAN, defaultValue: true }
}, { tableName: 'unidades' });

module.exports = Unidade;
