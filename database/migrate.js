// ==========================================================
//  Executa TODOS os arquivos .sql de database/migrations em ordem alfabética.
//  Uso:  node database/migrate.js   (ou: npm run db:migrate)
//  As migrações devem ser IDEMPOTENTES (podem rodar novamente sem erro).
//  Requer as variáveis do .env (DB_HOST, DB_USER, DB_PASS, DB_NAME...).
// ==========================================================
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');
require('dotenv').config();
const { sslOptions } = require('./_ssl');

async function run() {
  const dir = path.join(__dirname, 'migrations');
  if (!fs.existsSync(dir)) {
    console.log('Nenhuma pasta database/migrations encontrada. Nada a fazer.');
    return;
  }
  const arquivos = fs.readdirSync(dir).filter((f) => f.endsWith('.sql')).sort();
  if (!arquivos.length) {
    console.log('Nenhuma migração .sql encontrada.');
    return;
  }

  const conn = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '3306', 10),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    database: process.env.DB_NAME || 'simulados_etec_abh',
    multipleStatements: true,
    ...sslOptions()
  });

  for (const arq of arquivos) {
    const sql = fs.readFileSync(path.join(dir, arq), 'utf8');
    process.stdout.write(`→ Aplicando ${arq}... `);
    await conn.query(sql);
    console.log('OK');
  }

  await conn.end();
  console.log('\n✔ Migrações aplicadas com sucesso!');
}

run().catch((err) => {
  console.error('\n✖ Erro na migração:', err.message);
  process.exit(1);
});
