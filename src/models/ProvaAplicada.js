// Model: instância de prova aplicada a um aluno (aluno <-> simulado)
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const ProvaAplicada = sequelize.define('ProvaAplicada', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  simulado_id: { type: DataTypes.INTEGER, allowNull: false },
  aluno_id: { type: DataTypes.INTEGER, allowNull: false },
  status: {
    type: DataTypes.ENUM('gerada', 'em_andamento', 'concluida', 'expirada'),
    defaultValue: 'gerada'
  },
  iniciada_em: { type: DataTypes.DATE },
  finalizada_em: { type: DataTypes.DATE },
  tempo_gasto_segundos: { type: DataTypes.INTEGER },
  // Contador de perdas de foco (anti-consulta / anti-cola)
  perdas_foco: { type: DataTypes.INTEGER, defaultValue: 0 },
  // Snapshot do tema para PDF (assinatura de ciência)
  assinatura_ciencia: { type: DataTypes.STRING(255) }
}, {
  tableName: 'provas_aplicadas',
  indexes: [{ unique: true, fields: ['simulado_id', 'aluno_id'] }] // 1 prova por aluno/simulado
});

module.exports = ProvaAplicada;
