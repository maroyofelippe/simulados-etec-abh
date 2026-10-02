// ==========================================================
//  Serviço do Teste Vocacional (Feira de Profissões)
//  - Atribuição automática do teste a cada participante
//  - Cálculo da pontuação (soma das 3 notas de cada área, 3 a 15)
//  - Montagem do resultado completo (tela, JSON, PDF e CSV)
// ==========================================================
const {
  VocArea, VocAfirmacao, VocPerguntaAberta, VocAplicacao, VocResposta,
  VocRespostaAberta, VocResultado, Usuario
} = require('../models');

const LIMITE_BAIXO = 8;   // maior soma abaixo disso = perfil ainda indefinido
const DIF_PROXIMA = 1;    // diferença (pontos) considerada empate técnico
const MAX_POR_AREA = 15;  // 3 afirmações x nota 5

const ESCALA = ['Discordo totalmente', 'Discordo', 'Neutro', 'Concordo', 'Concordo totalmente'];
const ROTULOS_GRUPO = { tec: 'Tecnologia', saude: 'Saúde e ciências', gestao: 'Gestão e pessoas', servicos: 'Comunicação, comércio e turismo' };
const ROTULOS_STATUS = { pendente: 'Não iniciado', em_andamento: 'Em andamento', concluida: 'Concluído' };

// Garante que o usuário tenha o teste atribuído (chamado no auto-cadastro e,
// por segurança, no primeiro acesso a /vocacional).
async function atribuir(usuarioId, opcoes = {}) {
  const [aplicacao] = await VocAplicacao.findOrCreate({
    where: { usuario_id: usuarioId },
    defaults: { usuario_id: usuarioId, status: 'pendente' },
    ...opcoes
  });
  return aplicacao;
}

function embaralhar(arr) {
  const a = arr.slice();
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

// Cálculo puro. notas: { afirmacaoId: nota }; afirmacoes: [{id, area_codigo}]; areas: [{codigo, grupo, ordem}]
function calcular(notas, afirmacoes, areas) {
  const soma = {};
  areas.forEach((a) => { soma[a.codigo] = 0; });
  afirmacoes.forEach((q) => { soma[q.area_codigo] += notas[q.id] || 0; });

  // Desempate estável pela ordem das áreas
  const ranking = areas.slice().sort((a, b) => (soma[b.codigo] - soma[a.codigo]) || (a.ordem - b.ordem))
    .map((a, i) => ({ codigo: a.codigo, pontos: soma[a.codigo], posicao: i + 1 }));

  const topo = ranking[0].pontos;
  const proximos = ranking.filter((r) => topo - r.pontos <= DIF_PROXIMA);

  return {
    soma,
    ranking,
    principal: ranking[0].codigo,
    alternativa: ranking[1].codigo,
    empateTecnico: proximos.length > 1 ? proximos.map((r) => r.codigo) : [],
    perfilIndefinido: topo < LIMITE_BAIXO
  };
}

// Monta o resultado completo de uma aplicação concluída
async function carregarResultado(aplicacao) {
  const usuario = await Usuario.findByPk(aplicacao.usuario_id);
  const areas = await VocArea.findAll({ order: [['ordem', 'ASC']] });
  const mapaAreas = new Map(areas.map((a) => [a.codigo, a]));
  const resultados = await VocResultado.findAll({
    where: { aplicacao_id: aplicacao.id }, order: [['posicao', 'ASC']]
  });
  const abertas = await VocRespostaAberta.findAll({
    where: { aplicacao_id: aplicacao.id },
    include: [{ model: VocPerguntaAberta, as: 'pergunta' }]
  });
  abertas.sort((a, b) => a.pergunta.ordem - b.pergunta.ordem);
  const respostas = await VocResposta.findAll({ where: { aplicacao_id: aplicacao.id } });

  const pontuacao = {};
  const ranking = resultados.map((r) => {
    const area = mapaAreas.get(r.area_codigo);
    pontuacao[r.area_codigo] = r.pontos;
    return { codigo: r.area_codigo, curso: area.nome, grupo: area.grupo, pontos: r.pontos, posicao: r.posicao };
  });

  const grupos = Object.keys(ROTULOS_GRUPO).map((g) => {
    const doGrupo = areas.filter((a) => a.grupo === g);
    const pontos = doGrupo.reduce((s, a) => s + (pontuacao[a.codigo] || 0), 0);
    return { grupo: g, nome: ROTULOS_GRUPO[g], pontos, maximo: doGrupo.length * MAX_POR_AREA };
  }).sort((a, b) => (b.pontos / b.maximo) - (a.pontos / a.maximo));

  const respostasMapa = {};
  respostas.forEach((r) => { respostasMapa[r.afirmacao_id] = r.nota; });

  return {
    nome: usuario ? usuario.nome : '',
    data: aplicacao.finalizada_em,
    pontuacao,
    ranking,
    principal: aplicacao.area_principal,
    alternativo: aplicacao.area_alternativa,
    descricaoPrincipal: mapaAreas.get(aplicacao.area_principal).descricao,
    empateTecnico: aplicacao.empate_tecnico || [],
    perfilIndefinido: !!aplicacao.perfil_indefinido,
    grupos,
    respostas: respostasMapa,
    abertas: abertas.map((a) => ({ pergunta: a.pergunta.texto, resposta: (a.resposta || '').trim() })),
    nomesAreas: Object.fromEntries(areas.map((a) => [a.codigo, a.nome]))
  };
}

module.exports = {
  atribuir, embaralhar, calcular, carregarResultado,
  LIMITE_BAIXO, DIF_PROXIMA, MAX_POR_AREA, ESCALA, ROTULOS_GRUPO, ROTULOS_STATUS
};
