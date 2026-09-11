// Model: Simulado / prova parametrizada pelo professor
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Simulado = sequelize.define('Simulado', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  titulo: { type: DataTypes.STRING(150), allowNull: false },
  // 'aleatorio_aluno' = sorteio individual por aluno (até 20 questões)
  // 'geral' = mesmo conjunto para a turma, filtrado por dificuldade
  tipo: { type: DataTypes.ENUM('aleatorio_aluno', 'geral'), allowNull: false },
  disciplina_id: { type: DataTypes.INTEGER },
  tema: { type: DataTypes.STRING(150) },
  turma_id: { type: DataTypes.INTEGER },               // turma de aplicação
  qtd_questoes: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 20 },
  // Distribuição de dificuldade (JSON): {"Fácil":8,"Médio":8,"Difícil":4}
  distribuicao_dificuldade: { type: DataTypes.JSON },
  duracao_minutos: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 60 },
  max_perdas_foco: { type: DataTypes.INTEGER, defaultValue: 0 },
  criado_por: { type: DataTypes.INTEGER },
  publicado: { type: DataTypes.BOOLEAN, defaultValue: false }
}, {
  tableName: 'simulados',
  validate: {
    limiteVinteQuestoes() {
      if (this.qtd_questoes > 20) {
        throw new Error('Um simulado/prova é limitado a 20 questões.');
      }
    }
  }
});

module.exports = Simulado;
