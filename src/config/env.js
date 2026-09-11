// ==========================================================
//  Carrega e valida variáveis de ambiente (.env)
// ==========================================================
require('dotenv').config();

const env = {
  port: parseInt(process.env.PORT || '3000', 10),
  nodeEnv: process.env.NODE_ENV || 'development',
  db: {
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '3306', 10),
    name: process.env.DB_NAME || 'simulados_etec_abh',
    user: process.env.DB_USER || 'root',
    pass: process.env.DB_PASS || '',
    // TLS obrigatório em provedores gerenciados (ex.: Aiven). Ativado via DB_SSL=true.
    ssl: process.env.DB_SSL === 'true',
    caPath: process.env.DB_CA_PATH || null
  },
  jwt: {
    secret: process.env.JWT_SECRET || 'chave_insegura_apenas_dev',
    expiresIn: process.env.JWT_EXPIRES_IN || '8h'
  },
  sessionTimeoutMin: parseInt(process.env.SESSION_TIMEOUT || '30', 10),
  senhaPadraoImportacao: process.env.SENHA_PADRAO_IMPORTACAO || 'Etec@2025',
  senhaPadraoVisitante: process.env.SENHA_PADRAO_VISITANTE_FEIRA || 'Visitante@2026',
  rootPassword: process.env.ROOT_PASSWORD || 'RootEtec@2025',
  maxPerdasFoco: parseInt(process.env.MAX_PERDAS_FOCO || '0', 10),
  palavraCoringa: process.env.PALAVRA_CORINGA || 'abacaxi-quantico-etec'
};

// Aviso de segurança em produção
if (env.nodeEnv === 'production' && env.jwt.secret === 'chave_insegura_apenas_dev') {
  // eslint-disable-next-line no-console
  console.warn('[SEGURANÇA] Defina um JWT_SECRET forte no .env antes de usar em produção!');
}

module.exports = env;
