// Model: Texto de apoio (trecho/texto-base compartilhado por uma ou mais questões)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const TextoApoio = sequelize.define('TextoApoio', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  titulo: { type: DataTypes.STRING(200) },
  conteudo: { type: DataTypes.TEXT, allowNull: false },
  disciplina_id: { type: DataTypes.INTEGER },
  autor_id: { type: DataTypes.INTEGER }
}, { tableName: 'textos_apoio' });

module.exports = TextoApoio;
