// Model: Questão do banco (objetiva, com nível de dificuldade)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Questao = sequelize.define('Questao', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  enunciado: { type: DataTypes.TEXT, allowNull: false },
  // Nível de dificuldade / aprofundamento
  dificuldade: { type: DataTypes.ENUM('Fácil', 'Médio', 'Difícil'), allowNull: false },
  tema: { type: DataTypes.STRING(150) },               // ex.: "Interpretação de texto"
  serie: { type: DataTypes.STRING(40) },               // ex.: "1ª Série EM"
  gabarito: { type: DataTypes.CHAR(1), allowNull: false }, // letra A..E
  disciplina_id: { type: DataTypes.INTEGER, allowNull: false },
  turma_id: { type: DataTypes.INTEGER },               // vínculo OPCIONAL a turma
  autor_id: { type: DataTypes.INTEGER },               // professor que cadastrou
  texto_apoio_id: { type: DataTypes.INTEGER },         // texto-base OPCIONAL (comum em Humanas)
  ativa: { type: DataTypes.BOOLEAN, defaultValue: true }
}, { tableName: 'questoes' });

module.exports = Questao;
