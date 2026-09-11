// ==========================================================
//  Serviço de geração do ESPELHO da prova em PDF (PDFKit)
//  Inclui: logo da unidade, dados do aluno, respostas,
//  gabarito, menção, perdas de foco e campo de assinatura.
// ==========================================================
const PDFDocument = require('pdfkit');
const path = require('path');
const fs = require('fs');

const AZUL = '#005C6D';
const VERMELHO = '#B20000';
const CINZA = '#666666';

/**
 * Gera o PDF do espelho e faz stream para "res".
 * @param {Object} dados { unidade, aluno, prova, simulado, itens, resultado }
 * @param {Object} res   response do Express
 */
function gerarEspelhoPDF(dados, res) {
  const { unidade, aluno, prova, simulado, itens, resultado } = dados;
  const doc = new PDFDocument({ size: 'A4', margin: 40 });

  res.setHeader('Content-Type', 'application/pdf');
  res.setHeader('Content-Disposition', `attachment; filename=espelho_prova_${prova.id}.pdf`);
  doc.pipe(res);

  // Cabeçalho com logo (se existir)
  if (unidade && unidade.logo_path) {
    const logoAbs = path.join(__dirname, '..', 'public', unidade.logo_path);
    if (fs.existsSync(logoAbs)) {
      try { doc.image(logoAbs, 40, 36, { height: 48 }); } catch (_) {}
    }
  }
  doc.fontSize(16).fillColor(AZUL).text(unidade ? unidade.nome : 'ETEC ABH', 180, 42);
  doc.fontSize(11).fillColor(CINZA).text('Espelho de Prova / Simulado', 180, 64);
  doc.moveTo(40, 92).lineTo(555, 92).strokeColor(AZUL).stroke();

  // Dados do aluno
  doc.moveDown(2).fontSize(11).fillColor('#000');
  doc.text(`Aluno: ${aluno.nome}`, 40, 104);
  doc.text(`RM: ${aluno.rm || '-'}    Turma: ${aluno.turma ? aluno.turma.nome : '-'}`);
  doc.text(`Ano letivo: ${aluno.turma ? aluno.turma.ano_letivo : '-'}`);
  doc.text(`Simulado: ${simulado.titulo}`);
  doc.text(`Realizada em: ${prova.finalizada_em ? new Date(prova.finalizada_em).toLocaleString('pt-BR') : '-'}`);
  doc.text(`Saídas de foco registradas: ${prova.perdas_foco}`);

  // Resultado / menção
  doc.moveDown(0.5).fontSize(13).fillColor(AZUL)
     .text(`Nota: ${Number(resultado.nota).toFixed(1)}  |  Menção: ${resultado.mencao}  (${resultado.acertos}/${resultado.total_questoes} acertos)`);

  // Itens
  doc.moveDown(1).fontSize(10).fillColor('#000');
  let ultimoTextoApoioId = null;
  itens.forEach((it, idx) => {
    if (doc.y > 720) doc.addPage();
    if (it.texto_apoio && it.texto_apoio_id !== ultimoTextoApoioId) {
      doc.fillColor(AZUL).fontSize(9).text(`Texto de apoio${it.texto_apoio.titulo ? ' — ' + it.texto_apoio.titulo : ''}:`, { width: 515 });
      doc.fillColor(CINZA).fontSize(9).text(it.texto_apoio.conteudo, { width: 515 });
      doc.moveDown(0.4);
      ultimoTextoApoioId = it.texto_apoio_id;
    }
    const acertou = it.correta;
    doc.fillColor('#000').fontSize(10).text(`${idx + 1}. ${it.enunciado}`, { width: 515 });
    const marcada = it.letra_marcada || '—';
    doc.fillColor(acertou ? '#3ACF1F' : VERMELHO)
       .text(`   Sua resposta: ${marcada}${it.anulada ? ' (questão ANULADA por perda de foco)' : ''}`);
    if (!acertou) doc.fillColor(AZUL).text(`   Gabarito: ${it.gabarito}`);
    doc.moveDown(0.3);
  });

  // Assinatura de ciência
  if (doc.y > 680) doc.addPage();
  doc.moveDown(2).fillColor('#000').fontSize(10)
     .text('Declaro estar ciente da nota e menção obtidas nesta avaliação.', 40);
  doc.moveDown(2).text('___________________________________________', 40);
  doc.text(`${aluno.nome}  —  Assinatura do aluno`, 40);

  doc.end();
}

module.exports = { gerarEspelhoPDF };
