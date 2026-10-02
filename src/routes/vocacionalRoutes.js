// Teste Vocacional — páginas (visitante da Feira) e relatório (coordenador)
const router = require('express').Router();
const voc = require('../controllers/vocacionalController');
const { autenticar } = require('../middlewares/auth');
const { rbac } = require('../middlewares/rbac');

router.use(autenticar);

// Visitante da Feira de Profissões
router.get('/', rbac('visitante_feira'), voc.inicio);
router.post('/iniciar', rbac('visitante_feira'), voc.iniciar);
router.get('/responder', rbac('visitante_feira'), voc.responder);
router.get('/resultado', rbac('visitante_feira'), voc.resultado);
router.get('/resultado/baixar', rbac('visitante_feira'), voc.baixar);

// Captação ativa (coordenador; perfil leitura acessa via GET)
router.get('/relatorio', rbac('coordenador'), voc.relatorio);
router.get('/relatorio/exportar', rbac('coordenador'), voc.exportarCsv);

module.exports = router;
