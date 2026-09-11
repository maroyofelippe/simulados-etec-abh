// ==========================================================
//  Gera um backup em DML (INSERT ... ON DUPLICATE KEY UPDATE) do banco de
//  questões e de suas tabelas dependentes: disciplinas, textos_apoio,
//  questoes e alternativas — nessa ordem, para respeitar as FKs.
//
//  Uso:
//    npm run db:backup:questoes
//    (ou: node database/backup-questoes.js)
//
//  Gera dois arquivos em database/backups/:
//    - questoes_backup_<AAAAMMDD_HHMMSS>.sql  (arquivo com carimbo de data/hora)
//    - questoes_backup_latest.sql             (sempre sobrescrito com a versão mais recente)
//
//  O arquivo gerado é idempotente (ON DUPLICATE KEY UPDATE) e preserva os
//  IDs originais, então pode ser reaplicado com segurança em outro banco
//  (ex.: produção) via:
//    mysql -u USUARIO -p NOME_DO_BANCO < database/backups/questoes_backup_latest.sql
//
//  Atenção: questoes.autor_id / textos_apoio.autor_id referenciam
//  usuarios(id) e questoes.turma_id referencia turmas(id). O script desliga
//  temporariamente FOREIGN_KEY_CHECKS durante a restauração para não
//  depender da ordem/existência prévia desses registros; garanta, ainda
//  assim, que os usuários referenciados existam no banco de destino antes
//  de usar os dados restaurados em produção.
//
//  Requer as variáveis do .env (DB_HOST, DB_USER, DB_PASS, DB_NAME...).
// ==========================================================
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');
require('dotenv').config();
const { sslOptions } = require('./_ssl');

const TABELAS = [
  {
    nome: 'disciplinas',
    colunas: ['id', 'nome', 'area', 'criado_em', 'atualizado_em']
  },
  {
    nome: 'textos_apoio',
    colunas: ['id', 'titulo', 'conteudo', 'disciplina_id', 'autor_id', 'criado_em', 'atualizado_em']
  },
  {
    nome: 'questoes',
    colunas: ['id', 'enunciado', 'dificuldade', 'tema', 'serie', 'gabarito', 'disciplina_id', 'turma_id', 'autor_id', 'texto_apoio_id', 'ativa', 'criado_em', 'atualizado_em']
  },
  {
    nome: 'alternativas',
    colunas: ['id', 'questao_id', 'letra', 'texto', 'criado_em', 'atualizado_em']
  }
];

const LOTE = 200; // linhas por INSERT multi-valor

function timestamp() {
  const d = new Date();
  const p = (n) => String(n).padStart(2, '0');
  return `${d.getFullYear()}${p(d.getMonth() + 1)}${p(d.getDate())}_${p(d.getHours())}${p(d.getMinutes())}${p(d.getSeconds())}`;
}

async function gerarBackup() {
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '3306', 10),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    database: process.env.DB_NAME || 'simulados_etec_abh',
    ...sslOptions()
  });

  const linhas = [];
  linhas.push('-- ==========================================================');
  linhas.push('--  Backup DML — banco de questões (disciplinas, textos_apoio,');
  linhas.push('--  questoes, alternativas)');
  linhas.push(`--  Gerado em: ${new Date().toISOString()}`);
  linhas.push('--  Gerado por: database/backup-questoes.js (npm run db:backup:questoes)');
  linhas.push('--');
  linhas.push('--  Reaplicável com segurança (ON DUPLICATE KEY UPDATE), preserva IDs.');
  linhas.push('--  Requer que os usuarios/turmas referenciados por autor_id/turma_id');
  linhas.push('--  já existam no banco de destino para terem sentido funcional.');
  linhas.push('-- ==========================================================');
  linhas.push('SET FOREIGN_KEY_CHECKS=0;');
  linhas.push('');

  const resumo = {};

  for (const tabela of TABELAS) {
    const [rows] = await conn.query(`SELECT ${tabela.colunas.join(', ')} FROM ${tabela.nome} ORDER BY id`);
    resumo[tabela.nome] = rows.length;

    linhas.push(`-- ---------- ${tabela.nome} (${rows.length} linhas) ----------`);

    if (rows.length === 0) {
      linhas.push(`-- (nenhuma linha em ${tabela.nome})`);
      linhas.push('');
      continue;
    }

    const colunasNaoPk = tabela.colunas.filter((c) => c !== 'id');
    const updateClause = colunasNaoPk.map((c) => `${c}=VALUES(${c})`).join(', ');

    for (let i = 0; i < rows.length; i += LOTE) {
      const lote = rows.slice(i, i + LOTE);
      const valores = lote.map((row) => {
        const vals = tabela.colunas.map((c) => conn.escape(row[c]));
        return `(${vals.join(',')})`;
      });
      linhas.push(`INSERT INTO ${tabela.nome} (${tabela.colunas.join(',')}) VALUES`);
      linhas.push(valores.join(',\n') + '');
      linhas.push(`ON DUPLICATE KEY UPDATE ${updateClause};`);
      linhas.push('');
    }

    const [[{ maxId }]] = await conn.query(`SELECT MAX(id) AS maxId FROM ${tabela.nome}`);
    if (maxId) {
      linhas.push(`ALTER TABLE ${tabela.nome} AUTO_INCREMENT = ${maxId + 1};`);
      linhas.push('');
    }
  }

  linhas.push('SET FOREIGN_KEY_CHECKS=1;');

  await conn.end();

  const dir = path.join(__dirname, 'backups');
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });

  const conteudo = linhas.join('\n') + '\n';
  const arquivoComData = path.join(dir, `questoes_backup_${timestamp()}.sql`);
  const arquivoLatest = path.join(dir, 'questoes_backup_latest.sql');

  fs.writeFileSync(arquivoComData, conteudo, 'utf8');
  fs.writeFileSync(arquivoLatest, conteudo, 'utf8');

  console.log('✔ Backup gerado com sucesso:');
  for (const [tabela, qtd] of Object.entries(resumo)) {
    console.log(`  - ${tabela}: ${qtd} linhas`);
  }
  console.log(`\nArquivos:\n  ${arquivoComData}\n  ${arquivoLatest}`);
}

gerarBackup().catch((err) => {
  console.error('\n✖ Erro ao gerar backup:', err.message);
  process.exit(1);
});
