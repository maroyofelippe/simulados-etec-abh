// Model: Usuário do sistema (aluno, professor, coordenador, root)
const { DataTypes } = require('sequelize');
const bcrypt = require('bcryptjs');
const sequelize = require('../config/database');

const Usuario = sequelize.define('Usuario', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nome: { type: DataTypes.STRING(150), allowNull: false },
  email: { type: DataTypes.STRING(150), unique: true, validate: { isEmail: true } },
  rm: { type: DataTypes.STRING(30), unique: true },  // Registro de Matrícula (aluno)
  senha_hash: { type: DataTypes.STRING(255), allowNull: false },
  perfil: {
    type: DataTypes.ENUM('aluno', 'professor', 'coordenador', 'visitante_feira'),
    allowNull: false,
    defaultValue: 'aluno'
  },
  // Flag de super-privilégio "root" (elevação a partir de coordenador + senha)
  is_root: { type: DataTypes.BOOLEAN, defaultValue: false },
  // Situação do cadastro: 'aprovado' (seed/importação/aluno auto-cadastrado),
  // 'auto_pendente' (professor auto-cadastrado aguardando liberação do admin), 'recusado'
  status_cadastro: {
    type: DataTypes.ENUM('auto_pendente', 'aprovado', 'recusado'),
    allowNull: false,
    defaultValue: 'aprovado'
  },
  periodo: { type: DataTypes.ENUM('Manhã', 'Tarde', 'Noite', 'Integral') },
  tema_preferido: { type: DataTypes.ENUM('claro', 'escuro'), defaultValue: 'claro' },
  ativo: { type: DataTypes.BOOLEAN, defaultValue: true },
  ultimo_login: { type: DataTypes.DATE },
  // Tempo total logado acumulado (em segundos) somando todas as sessões encerradas
  tempo_logado_total: { type: DataTypes.INTEGER, defaultValue: 0 },
  turma_id: { type: DataTypes.INTEGER },
  unidade_id: { type: DataTypes.INTEGER },
  // ---- Campos específicos do auto-cadastro de visitante_feira ----
  telefone: { type: DataTypes.STRING(20) },
  data_nascimento: { type: DataTypes.DATEONLY },
  // Relação do visitante com a ETEC
  relacao_etec: { type: DataTypes.ENUM('ex_aluno', 'candidato', 'responsavel', 'aluno') },
  // Curso de interesse (captação ativa da feira de profissões)
  curso_interesse: {
    type: DataTypes.ENUM(
      'Desenvolvimento de Sistemas', 'Jogos Digitais', 'Administração',
      'Farmácia', 'Biotecnologia', 'Marketing'
    )
  }
}, {
  tableName: 'usuarios',
  hooks: {
    // Nunca retornar o hash em serializações JSON
    afterFind: () => {}
  }
});

// Método de instância: verifica senha em texto puro contra o hash
Usuario.prototype.verificarSenha = function (senha) {
  return bcrypt.compare(senha, this.senha_hash);
};

// Helper estático: gera hash de senha
Usuario.gerarHash = function (senha) {
  return bcrypt.hash(senha, 10);
};

// Remove o hash ao serializar
Usuario.prototype.toJSON = function () {
  const values = { ...this.get() };
  delete values.senha_hash;
  return values;
};

module.exports = Usuario;
