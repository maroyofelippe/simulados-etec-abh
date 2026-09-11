// ==========================================================
//  Conexão Sequelize (ORM) com MySQL
//  ------------------------------------------------------
//  ESCOLHA: usamos Sequelize (ORM) em vez de mysql2 "puro".
//  Justificativa didática:
//   - Mantém os MODELS desacoplados dos CONTROLLERS (regra MVC).
//   - Migrations/associations declarativas e legíveis.
//   - Validações no nível do model.
//   - O driver interno continua sendo o mysql2.
// ==========================================================
const fs = require('fs');
const path = require('path');
const { Sequelize } = require('sequelize');
const env = require('./env');

// TLS para bancos gerenciados (Aiven exige). Ativado por DB_SSL=true.
let dialectOptions = {};
if (env.db.ssl) {
  const ssl = { minVersion: 'TLSv1.2', rejectUnauthorized: true };
  if (env.db.caPath) {
    const abs = path.isAbsolute(env.db.caPath)
      ? env.db.caPath
      : path.join(process.cwd(), env.db.caPath);
    ssl.ca = fs.readFileSync(abs);
  }
  dialectOptions = { ssl };
}

const sequelize = new Sequelize(env.db.name, env.db.user, env.db.pass, {
  host: env.db.host,
  port: env.db.port,
  dialect: 'mysql',
  dialectOptions,
  logging: env.nodeEnv === 'development' ? false : false,
  define: {
    timestamps: true,
    underscored: true,       // colunas em snake_case (criado_em, atualizado_em)
    createdAt: 'criado_em',
    updatedAt: 'atualizado_em',
    charset: 'utf8mb4',
    collate: 'utf8mb4_unicode_ci'
  },
  timezone: '-03:00'          // horário de Brasília
});

module.exports = sequelize;
