// Seção CURSOS (landing pages) — visitante da Feira de Profissões
const router = require('express').Router();
const cursos = require('../controllers/cursosController');
const { autenticar } = require('../middlewares/auth');
const { rbac } = require('../middlewares/rbac');

router.use(autenticar);

router.get('/', rbac('visitante_feira'), cursos.listar);
router.get('/:slug', rbac('visitante_feira'), cursos.detalhar);

module.exports = router;
