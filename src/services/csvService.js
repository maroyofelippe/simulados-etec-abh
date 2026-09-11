// ==========================================================
//  Serviço de importação/exportação de usuários via CSV
//  - Importação: colunas mínimas nome, rm, turma, periodo -> relatório (sucessos, erros, ignoradas)
//  - Exportação: serialização genérica de linhas em texto CSV (separador ";", padrão Excel BR)
// ==========================================================
const { parse } = require('csv-parse/sync');
const bcrypt = require('bcryptjs');
const env = require('../config/env');
const { Usuario, Turma } = require('../models');

const COLUNAS_OBRIGATORIAS = ['nome', 'rm', 'turma', 'periodo'];

async function importarUsuarios(bufferCsv, unidadeId) {
  const registros = parse(bufferCsv, {
    columns: (header) => header.map((h) => h.trim().toLowerCase()),
    skip_empty_lines: true,
    trim: true
  });

  // Valida cabeçalho
  const cabecalho = Object.keys(registros[0] || {});
  const faltando = COLUNAS_OBRIGATORIAS.filter((c) => !cabecalho.includes(c));
  if (faltando.length) {
    throw new Error(`Colunas obrigatórias ausentes: ${faltando.join(', ')}`);
  }

  const relatorio = { total: registros.length, sucessos: 0, erros: [], ignoradas: [] };
  const senhaHash = await bcrypt.hash(env.senhaPadraoImportacao, 10);

  // Cache de turmas por nome (dentro da unidade, só ativas)
  const turmas = await Turma.findAll({ where: { unidade_id: unidadeId, ativo: true } });
  const mapaTurmas = new Map(turmas.map((t) => [t.nome.toLowerCase(), t]));

  for (let i = 0; i < registros.length; i++) {
    const linha = registros[i];
    const numLinha = i + 2; // +1 cabeçalho, +1 base-1

    if (!linha.nome || !linha.rm) {
      relatorio.ignoradas.push({ linha: numLinha, motivo: 'nome/rm vazios' });
      continue;
    }

    // RM duplicado?
    const existe = await Usuario.findOne({ where: { rm: linha.rm } });
    if (existe) {
      relatorio.erros.push({ linha: numLinha, rm: linha.rm, motivo: 'RM já cadastrado' });
      continue;
    }

    // Turma existe?
    const turma = mapaTurmas.get(String(linha.turma).toLowerCase());
    if (!turma) {
      relatorio.erros.push({ linha: numLinha, rm: linha.rm, motivo: `Turma inexistente: ${linha.turma}` });
      continue;
    }

    try {
      await Usuario.create({
        nome: linha.nome,
        rm: String(linha.rm),
        email: `${String(linha.rm).replace(/\s/g, '')}@aluno.etecabh.sp.gov.br`,
        senha_hash: senhaHash,
        perfil: 'aluno',
        periodo: normalizarPeriodo(linha.periodo),
        turma_id: turma.id,
        unidade_id: unidadeId
      });
      relatorio.sucessos++;
    } catch (e) {
      relatorio.erros.push({ linha: numLinha, rm: linha.rm, motivo: e.message });
    }
  }

  return relatorio;
}

function normalizarPeriodo(p) {
  const v = String(p || '').trim().toLowerCase();
  if (v.startsWith('man')) return 'Manhã';
  if (v.startsWith('tar')) return 'Tarde';
  if (v.startsWith('noi') || v.startsWith('not')) return 'Noite';
  if (v.startsWith('int')) return 'Integral';
  return 'Manhã';
}

// Serializa uma lista de objetos em texto CSV.
// colunas: [{ titulo, chave }] na ordem desejada. linhas: objetos com essas chaves.
function paraCsv(colunas, linhas) {
  const escapar = (valor) => {
    const texto = valor === null || valor === undefined ? '' : String(valor);
    return /[;"\n]/.test(texto) ? `"${texto.replace(/"/g, '""')}"` : texto;
  };
  const cabecalho = colunas.map((c) => escapar(c.titulo)).join(';');
  const linhasTexto = linhas.map((linha) => colunas.map((c) => escapar(linha[c.chave])).join(';'));
  return [cabecalho, ...linhasTexto].join('\n');
}

module.exports = { importarUsuarios, COLUNAS_OBRIGATORIAS, paraCsv };
