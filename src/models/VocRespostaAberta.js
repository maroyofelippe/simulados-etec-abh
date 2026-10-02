// Model: resposta do participante a uma pergunta aberta
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const VocRespostaAberta = sequelize.define('VocRespostaAberta', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  aplicacao_id: { type: DataTypes.INTEGER, allowNull: false },
  pergunta_id: { type: DataTypes.INTEGER, allowNull: false },
  resposta: { type: DataTypes.TEXT }
}, {
  tableName: 'voc_respostas_abertas',
  indexes: [{ unique: true, fields: ['aplicacao_id', 'pergunta_id'] }]
});

module.exports = VocRespostaAberta;
