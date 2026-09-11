const router = require('express').Router();
const prova = require('../controllers/provaController');
const { autenticar } = require('../middlewares/auth');
const { rbac } = require('../middlewares/rbac');

router.use(autenticar);

// Páginas (aluno e visitante da Feira de Profissões)
router.get('/provas', rbac('aluno', 'visitante_feira'), prova.listarDisponiveis);
router.post('/provas/:simuladoId/iniciar', rbac('aluno', 'visitante_feira'), prova.iniciar);
router.get('/provas/:id/resolver', rbac('aluno', 'visitante_feira'), prova.resolver);
router.get('/provas/:id/resultado', rbac('aluno', 'visitante_feira', 'professor', 'coordenador'), prova.resultado);
router.get('/provas/:id/pdf', rbac('aluno', 'visitante_feira', 'professor', 'coordenador'), prova.baixarPDF);

module.exports = router;
