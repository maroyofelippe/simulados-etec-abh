// Endpoints AJAX consumidos pela tela de resolução da prova
const router = require('express').Router();
const prova = require('../controllers/provaController');
const { autenticar } = require('../middlewares/auth');
const { rbac } = require('../middlewares/rbac');

router.use(autenticar, rbac('aluno', 'visitante_feira'));

router.get('/:id/questao/:ordem', prova.questaoJson);
router.post('/:id/responder', prova.responder);
router.post('/:id/foco', prova.registrarFoco);
router.post('/:id/finalizar', prova.finalizar);

module.exports = router;
