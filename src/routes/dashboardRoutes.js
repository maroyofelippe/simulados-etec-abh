const router = require('express').Router();
const dash = require('../controllers/dashboardController');
const { autenticar } = require('../middlewares/auth');
const { rbac } = require('../middlewares/rbac');

router.use(autenticar, rbac('professor', 'coordenador'));

router.get('/', dash.geral);
router.get('/turma/:id', dash.porTurma);
router.get('/aluno/:id', dash.porAluno);
router.get('/comparar', dash.comparar);
router.get('/feira', rbac('coordenador'), dash.feira);
router.get('/feira/exportar', rbac('coordenador'), dash.exportarFeiraCsv);

module.exports = router;
