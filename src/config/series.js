// Ano/série de uma questão (questoes.serie) e dos simulados (simulados.series, JSON).
// Os valores são gravados como texto e coincidem com turmas.serie ("1ª Série EM", ...).
const SERIES = ['9º Ano EF', '1ª Série EM', '2ª Série EM', '3ª Série EM'];

// Séries cujas questões o simulado pode sortear:
//  - simulado com séries marcadas  -> essas séries (ex.: geral de 1ª, 2ª e 3ª)
//  - sem séries marcadas           -> a série da turma de aplicação, se for uma série conhecida
//  - sem séries e sem turma/série  -> null (qualquer série)
function seriesDoSimulado(simulado, turma) {
  const marcadas = Array.isArray(simulado.series) ? simulado.series.filter((s) => SERIES.includes(s)) : [];
  if (marcadas.length) return marcadas;
  if (turma && SERIES.includes(turma.serie)) return [turma.serie];
  return null;
}

module.exports = { SERIES, seriesDoSimulado };
