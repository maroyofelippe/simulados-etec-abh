// Roteador principal - agrega todos os grupos de rotas
const router = require('express').Router();
const { autenticar } = require('../middlewares/auth');
const homeController = require('../controllers/homeController');

router.use('/', require('./authRoutes'));
router.use('/aluno', require('./alunoRoutes'));
router.use('/api/provas', require('./apiProvaRoutes'));
router.use('/professor', require('./professorRoutes'));
router.use('/admin', require('./adminRoutes'));
router.use('/dashboard', require('./dashboardRoutes'));

// Home: redireciona conforme o perfil
router.get('/', autenticar, (req, res, next) => {
  const u = req.usuario;
  if (['aluno', 'visitante_feira'].includes(u.perfil)) return res.redirect('/aluno/provas');
  return homeController.exibir(req, res, next);
});

module.exports = router;
