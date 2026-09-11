// ==========================================================
//  Sistema de Simulados Educacionais - ETEC ABH
//  Ponto de entrada da aplicação (Express + EJS + Sequelize)
// ==========================================================
const path = require('path');
const express = require('express');
const cookieParser = require('cookie-parser');
const expressLayouts = require('express-ejs-layouts');

const env = require('./src/config/env');
const { sequelize } = require('./src/models');
const rotas = require('./src/routes');
const { errorHandler, notFound } = require('./src/middlewares/errorHandler');

const app = express();

// ----- View engine (EJS + layouts) -----
app.set('views', path.join(__dirname, 'src', 'views'));
app.set('view engine', 'ejs');
app.use(expressLayouts);
app.set('layout', 'partials/layout'); // layout padrão

// ----- Middlewares base -----
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'src', 'public')));

// Disponibiliza o tema (cookie) para todas as views
app.use((req, res, next) => {
  res.locals.tema = (req.cookies && req.cookies.tema) || 'claro';
  res.locals.usuario = null;
  next();
});

// ----- Rotas -----
app.use('/', rotas);

// ----- 404 e erros -----
app.use(notFound);
app.use(errorHandler);

// ----- Inicialização -----
async function iniciar() {
  try {
    await sequelize.authenticate();
    // eslint-disable-next-line no-console
    console.log('✔ Conexão com MySQL estabelecida.');
    app.listen(env.port, () => {
      // eslint-disable-next-line no-console
      console.log(`✔ Servidor rodando em http://localhost:${env.port} (${env.nodeEnv})`);
    });
  } catch (err) {
    // eslint-disable-next-line no-console
    console.error('✖ Falha ao conectar no banco:', err.message);
    console.error('  Verifique o .env e se o MySQL está ativo. Rode: npm run db:setup');
    process.exit(1);
  }
}

iniciar();

module.exports = app;
