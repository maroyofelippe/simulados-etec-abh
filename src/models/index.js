// ==========================================================
//  Agregador de models + definição das associações (relacionamentos)
//  Importe SEMPRE os models a partir daqui: require('../models')
// ==========================================================
const sequelize = require('../config/database');

const Unidade = require('./Unidade');
const Turma = require('./Turma');
const Disciplina = require('./Disciplina');
const Usuario = require('./Usuario');
const Sessao = require('./Sessao');
const Questao = require('./Questao');
const TextoApoio = require('./TextoApoio');
const Alternativa = require('./Alternativa');
const Simulado = require('./Simulado');
const ProvaAplicada = require('./ProvaAplicada');
const ProvaQuestao = require('./ProvaQuestao');
const Resposta = require('./Resposta');
const EventoFoco = require('./EventoFoco');
const Resultado = require('./Resultado');
const VocArea = require('./VocArea');
const VocAfirmacao = require('./VocAfirmacao');
const VocPerguntaAberta = require('./VocPerguntaAberta');
const VocAplicacao = require('./VocAplicacao');
const VocResposta = require('./VocResposta');
const VocRespostaAberta = require('./VocRespostaAberta');
const VocResultado = require('./VocResultado');

// ---------- Unidade / Turma / Usuário ----------
Unidade.hasMany(Turma, { foreignKey: 'unidade_id', as: 'turmas' });
Turma.belongsTo(Unidade, { foreignKey: 'unidade_id', as: 'unidade' });

Unidade.hasMany(Usuario, { foreignKey: 'unidade_id', as: 'usuarios' });
Usuario.belongsTo(Unidade, { foreignKey: 'unidade_id', as: 'unidade' });

Turma.hasMany(Usuario, { foreignKey: 'turma_id', as: 'alunos' });
Usuario.belongsTo(Turma, { foreignKey: 'turma_id', as: 'turma' });

// Turmas lecionadas por um professor (N:N via tabela professor_turmas)
Usuario.belongsToMany(Turma, {
  through: 'professor_turmas', as: 'turmasLecionadas',
  foreignKey: 'professor_id', otherKey: 'turma_id', timestamps: false
});
Turma.belongsToMany(Usuario, {
  through: 'professor_turmas', as: 'professores',
  foreignKey: 'turma_id', otherKey: 'professor_id', timestamps: false
});

// ---------- Sessões ----------
Usuario.hasMany(Sessao, { foreignKey: 'usuario_id', as: 'sessoes' });
Sessao.belongsTo(Usuario, { foreignKey: 'usuario_id', as: 'usuario' });

// ---------- Questões / Alternativas / Disciplina ----------
Disciplina.hasMany(Questao, { foreignKey: 'disciplina_id', as: 'questoes' });
Questao.belongsTo(Disciplina, { foreignKey: 'disciplina_id', as: 'disciplina' });

Questao.belongsTo(Turma, { foreignKey: 'turma_id', as: 'turma' });
Questao.belongsTo(Usuario, { foreignKey: 'autor_id', as: 'autor' });

Questao.hasMany(Alternativa, { foreignKey: 'questao_id', as: 'alternativas', onDelete: 'CASCADE' });
Alternativa.belongsTo(Questao, { foreignKey: 'questao_id', as: 'questao' });

// ---------- Textos de apoio ----------
TextoApoio.belongsTo(Disciplina, { foreignKey: 'disciplina_id', as: 'disciplina' });
TextoApoio.belongsTo(Usuario, { foreignKey: 'autor_id', as: 'autor' });
TextoApoio.hasMany(Questao, { foreignKey: 'texto_apoio_id', as: 'questoes' });
Questao.belongsTo(TextoApoio, { foreignKey: 'texto_apoio_id', as: 'textoApoio' });

// ---------- Simulados ----------
Simulado.belongsTo(Disciplina, { foreignKey: 'disciplina_id', as: 'disciplina' });
Simulado.belongsTo(Turma, { foreignKey: 'turma_id', as: 'turma' });
Simulado.belongsTo(Usuario, { foreignKey: 'criado_por', as: 'criador' });
Simulado.hasMany(ProvaAplicada, { foreignKey: 'simulado_id', as: 'aplicacoes' });

// ---------- Provas aplicadas ----------
ProvaAplicada.belongsTo(Simulado, { foreignKey: 'simulado_id', as: 'simulado' });
ProvaAplicada.belongsTo(Usuario, { foreignKey: 'aluno_id', as: 'aluno' });

ProvaAplicada.hasMany(ProvaQuestao, { foreignKey: 'prova_aplicada_id', as: 'questoesProva', onDelete: 'CASCADE' });
ProvaQuestao.belongsTo(ProvaAplicada, { foreignKey: 'prova_aplicada_id', as: 'prova' });
ProvaQuestao.belongsTo(Questao, { foreignKey: 'questao_id', as: 'questao' });

ProvaAplicada.hasMany(Resposta, { foreignKey: 'prova_aplicada_id', as: 'respostas', onDelete: 'CASCADE' });
Resposta.belongsTo(ProvaAplicada, { foreignKey: 'prova_aplicada_id', as: 'prova' });
Resposta.belongsTo(Questao, { foreignKey: 'questao_id', as: 'questao' });

ProvaAplicada.hasMany(EventoFoco, { foreignKey: 'prova_aplicada_id', as: 'eventosFoco', onDelete: 'CASCADE' });
EventoFoco.belongsTo(ProvaAplicada, { foreignKey: 'prova_aplicada_id', as: 'prova' });

ProvaAplicada.hasOne(Resultado, { foreignKey: 'prova_aplicada_id', as: 'resultado', onDelete: 'CASCADE' });
Resultado.belongsTo(ProvaAplicada, { foreignKey: 'prova_aplicada_id', as: 'prova' });

// ---------- Teste vocacional (Feira de Profissões) ----------
VocArea.hasMany(VocAfirmacao, { foreignKey: 'area_codigo', as: 'afirmacoes' });
VocAfirmacao.belongsTo(VocArea, { foreignKey: 'area_codigo', as: 'area' });

Usuario.hasOne(VocAplicacao, { foreignKey: 'usuario_id', as: 'vocacional' });
VocAplicacao.belongsTo(Usuario, { foreignKey: 'usuario_id', as: 'usuario' });
VocAplicacao.belongsTo(VocArea, { foreignKey: 'area_principal', as: 'principal' });
VocAplicacao.belongsTo(VocArea, { foreignKey: 'area_alternativa', as: 'alternativa' });

VocAplicacao.hasMany(VocResposta, { foreignKey: 'aplicacao_id', as: 'respostas', onDelete: 'CASCADE' });
VocResposta.belongsTo(VocAplicacao, { foreignKey: 'aplicacao_id', as: 'aplicacao' });
VocResposta.belongsTo(VocAfirmacao, { foreignKey: 'afirmacao_id', as: 'afirmacao' });

VocAplicacao.hasMany(VocRespostaAberta, { foreignKey: 'aplicacao_id', as: 'respostasAbertas', onDelete: 'CASCADE' });
VocRespostaAberta.belongsTo(VocAplicacao, { foreignKey: 'aplicacao_id', as: 'aplicacao' });
VocRespostaAberta.belongsTo(VocPerguntaAberta, { foreignKey: 'pergunta_id', as: 'pergunta' });

VocAplicacao.hasMany(VocResultado, { foreignKey: 'aplicacao_id', as: 'resultados', onDelete: 'CASCADE' });
VocResultado.belongsTo(VocAplicacao, { foreignKey: 'aplicacao_id', as: 'aplicacao' });
VocResultado.belongsTo(VocArea, { foreignKey: 'area_codigo', as: 'area' });

module.exports = {
  sequelize,
  Unidade,
  Turma,
  Disciplina,
  Usuario,
  Sessao,
  Questao,
  TextoApoio,
  Alternativa,
  Simulado,
  ProvaAplicada,
  ProvaQuestao,
  Resposta,
  EventoFoco,
  Resultado,
  VocArea,
  VocAfirmacao,
  VocPerguntaAberta,
  VocAplicacao,
  VocResposta,
  VocRespostaAberta,
  VocResultado
};
