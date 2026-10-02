// Model: nota dada pelo participante a uma afirmação
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const VocResposta = sequelize.define('VocResposta', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  aplicacao_id: { type: DataTypes.INTEGER, allowNull: false },
  afirmacao_id: { type: DataTypes.INTEGER, allowNull: false },
  nota: { type: DataTypes.TINYINT, allowNull: false, validate: { min: 1, max: 5 } }
}, {
  tableName: 'voc_respostas',
  indexes: [{ unique: true, fields: ['aplicacao_id', 'afirmacao_id'] }]
});

module.exports = VocResposta;
