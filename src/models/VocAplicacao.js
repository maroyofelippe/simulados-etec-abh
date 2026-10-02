// Model: teste vocacional atribuído a um usuário (1 por participante)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const VocAplicacao = sequelize.define('VocAplicacao', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  usuario_id: { type: DataTypes.INTEGER, allowNull: false, unique: true },
  status: { type: DataTypes.ENUM('pendente', 'em_andamento', 'concluida'), defaultValue: 'pendente' },
  // ids das afirmações na ordem embaralhada sorteada para este participante
  ordem_afirmacoes: { type: DataTypes.JSON },
  iniciada_em: { type: DataTypes.DATE },
  finalizada_em: { type: DataTypes.DATE },
  area_principal: { type: DataTypes.STRING(5) },
  area_alternativa: { type: DataTypes.STRING(5) },
  // códigos das áreas a até 1 ponto da maior (empate técnico)
  empate_tecnico: { type: DataTypes.JSON },
  // maior soma abaixo do limite: o participante ainda não se identificou com nenhuma área
  perfil_indefinido: { type: DataTypes.BOOLEAN, defaultValue: false }
}, { tableName: 'voc_aplicacoes' });

module.exports = VocAplicacao;
