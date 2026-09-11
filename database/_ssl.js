// ==========================================================
//  Helper de TLS para os scripts que usam mysql2 diretamente
//  (setup.js, migrate.js, backup-questoes.js).
//  ------------------------------------------------------
//  Provedores gerenciados como o Aiven exigem conexão TLS.
//  Ative com DB_SSL=true no .env e (opcional) aponte o CA em
//  DB_CA_PATH (ex.: ./database/ca.pem).
//  Retorna o objeto pronto para espalhar no createConnection().
// ==========================================================
const fs = require('fs');
const path = require('path');

function sslOptions() {
  if (process.env.DB_SSL !== 'true') return {};

  const caPath = process.env.DB_CA_PATH;
  const ssl = { minVersion: 'TLSv1.2', rejectUnauthorized: true };

  if (caPath) {
    const abs = path.isAbsolute(caPath) ? caPath : path.join(process.cwd(), caPath);
    ssl.ca = fs.readFileSync(abs);
  }

  return { ssl };
}

module.exports = { sslOptions };
