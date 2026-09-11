// ==========================================================
//  Teste rápido de conexão com o banco (útil após migrar p/ Aiven).
//  Uso:  node database/test-connection.js
//  Verifica: alcance do servidor, TLS ativo, versão do MySQL,
//            existência do DB_NAME e o Sequelize.authenticate().
// ==========================================================
const mysql = require('mysql2/promise');
require('dotenv').config();
const { sslOptions } = require('./_ssl');

const cfg = {
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '3306', 10),
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASS || '',
  database: process.env.DB_NAME || 'simulados_etec_abh'
};

async function main() {
  console.log(`→ Host:   ${cfg.host}:${cfg.port}`);
  console.log(`→ Usuário: ${cfg.user}`);
  console.log(`→ TLS:    ${process.env.DB_SSL === 'true' ? 'habilitado' : 'desabilitado'}`);
  console.log('');

  // 1) Conexão ao servidor (sem selecionar database)
  const conn = await mysql.createConnection({
    host: cfg.host,
    port: cfg.port,
    user: cfg.user,
    password: cfg.password,
    ...sslOptions()
  });

  const [[ver]] = await conn.query('SELECT VERSION() AS v');
  console.log(`✔ Servidor acessível — MySQL ${ver.v}`);

  const [[cipher]] = await conn.query("SHOW STATUS LIKE 'Ssl_cipher'");
  console.log(cipher && cipher.Value
    ? `✔ Conexão criptografada (TLS): ${cipher.Value}`
    : '⚠ Conexão SEM TLS');

  // 2) A database já existe?
  const [rows] = await conn.query(
    'SELECT SCHEMA_NAME FROM information_schema.SCHEMATA WHERE SCHEMA_NAME = ?',
    [cfg.database]
  );
  if (rows.length) {
    const [[tab]] = await conn.query(
      'SELECT COUNT(*) AS n FROM information_schema.TABLES WHERE TABLE_SCHEMA = ?',
      [cfg.database]
    );
    console.log(`✔ Database "${cfg.database}" existe (${tab.n} tabela(s))`);
  } else {
    console.log(`⚠ Database "${cfg.database}" ainda NÃO existe — rode: npm run db:setup`);
  }

  await conn.end();

  // 3) Sequelize (mesma config da aplicação)
  const sequelize = require('../src/config/database');
  try {
    await sequelize.authenticate();
    console.log('✔ Sequelize.authenticate() OK');
  } catch (e) {
    if (/Unknown database/i.test(e.message)) {
      console.log('⚠ Sequelize: database ainda não criada (esperado antes do db:setup)');
    } else {
      throw e;
    }
  } finally {
    await sequelize.close();
  }

  console.log('\n✔ Teste concluído.');
}

main().catch((err) => {
  console.error('\n✖ Falha na conexão:', err.message);
  process.exit(1);
});
