// Origens possíveis de uma questão (banco de questões) e, por consequência, o "estilo"
// de avaliação de um simulado. Gravado como texto em questoes.origem / simulados.origem.
const ORIGENS = ['Professor', 'SARESP', 'Feira Profissões', 'ENEM', 'Vestibulinho ETEC', 'Outra'];
const ORIGEM_PADRAO = 'Professor';

// Normaliza um valor vindo de formulário/CSV; valores desconhecidos caem no padrão.
function normalizarOrigem(valor) {
  const v = String(valor || '').trim().toLowerCase();
  return ORIGENS.find((o) => o.toLowerCase() === v) || ORIGEM_PADRAO;
}

module.exports = { ORIGENS, ORIGEM_PADRAO, normalizarOrigem };
