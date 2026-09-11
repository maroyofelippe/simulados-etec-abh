// Serviço de conversão de NOTA -> MENÇÃO (critério ETEC)
//  0 a 4,9  = I  (Insatisfatório)
//  5,0 a 6,9 = R (Regular)
//  7,0 a 8,9 = B (Bom)
//  >= 9,0   = MB (Muito Bom)
exports.calcularMencao = (nota) => {
  const n = Number(nota);
  if (n >= 9.0) return 'MB';
  if (n >= 7.0) return 'B';
  if (n >= 5.0) return 'R';
  return 'I';
};

exports.descricaoMencao = (m) => ({
  I: 'Insatisfatório',
  R: 'Regular',
  B: 'Bom',
  MB: 'Muito Bom'
}[m] || m);
