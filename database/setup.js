// ==========================================================
//  Setup do banco: executa ddl.sql + seeds.sql + banco_questoes.sql
//  Uso:  node database/setup.js         (cria estrutura + seeds)
//        node database/setup.js --seed  (idem, explícito)
//  Requer as variáveis do .env (DB_HOST, DB_USER, DB_PASS...).
// ==========================================================
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');
require('dotenv').config();
const { sslOptions } = require('./_ssl');

async function run() {
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '3306', 10),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    multipleStatements: true,
    ...sslOptions()
  });

  const arquivos = ['ddl.sql', 'seeds.sql', 'banco_questoes.sql'];
  for (const arq of arquivos) {
    const caminho = path.join(__dirname, arq);
    const sql = fs.readFileSync(caminho, 'utf8');
    process.stdout.write(`→ Executando ${arq}... `);
    await conn.query(sql);
    console.log('OK');
  }

  await conn.end();
  console.log('\n✔ Banco criado e populado com sucesso!');
  console.log('  Credenciais de teste:');
  console.log('   Coordenador: coordenador@etecabh.sp.gov.br / Coord@2025');
  console.log('   Professor:   professor@etecabh.sp.gov.br / Prof@2025');
  console.log('   Aluno:       RM 12345 / Aluno@2025');
}

run().catch((err) => {
  console.error('\n✖ Erro no setup:', err.message);
  console.error('  Verifique o .env e se o MySQL está ativo.');
  process.exit(1);
});
