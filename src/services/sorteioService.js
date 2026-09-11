// ==========================================================
//  Serviço de SORTEIO de questões (geração aleatória)
//  - Embaralhamento Fisher-Yates (função randômica)
//  - Limite rígido de 20 questões por prova
//  - Sem repetição dentro da mesma prova
//  - Suporte a distribuição por dificuldade
// ==========================================================
const LIMITE_MAXIMO = 20;

// Embaralha um array (Fisher-Yates) usando Math.random()
function embaralhar(array) {
  const a = [...array];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

/**
 * Sorteia questões respeitando (opcionalmente) uma distribuição por dificuldade.
 * @param {Array} questoes  lista de questões candidatas (objetos com .dificuldade e .id)
 * @param {number} qtd      quantidade desejada (será limitada a 20)
 * @param {Object} [distribuicao] ex.: { 'Fácil':8, 'Médio':8, 'Difícil':4 }
 * @returns {Array} questões sorteadas, sem repetição
 */
function sortearQuestoes(questoes, qtd, distribuicao = null) {
  const limite = Math.min(qtd || LIMITE_MAXIMO, LIMITE_MAXIMO);

  // Sem distribuição: sorteio simples
  if (!distribuicao) {
    return embaralhar(questoes).slice(0, limite);
  }

  // Com distribuição: sorteia por faixa de dificuldade
  const selecionadas = [];
  const usadas = new Set();

  for (const [dificuldade, quantidade] of Object.entries(distribuicao)) {
    const pool = embaralhar(
      questoes.filter((q) => q.dificuldade === dificuldade && !usadas.has(q.id))
    ).slice(0, quantidade);
    pool.forEach((q) => usadas.add(q.id));
    selecionadas.push(...pool);
  }

  // Completa (se faltou) com quaisquer questões restantes, sem repetir
  if (selecionadas.length < limite) {
    const restantes = embaralhar(questoes.filter((q) => !usadas.has(q.id)));
    for (const q of restantes) {
      if (selecionadas.length >= limite) break;
      selecionadas.push(q);
      usadas.add(q.id);
    }
  }

  return embaralhar(selecionadas).slice(0, limite);
}

module.exports = { sortearQuestoes, embaralhar, LIMITE_MAXIMO };
