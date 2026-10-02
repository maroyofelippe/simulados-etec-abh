// API AJAX do Teste Vocacional (consumida por /js/vocacional.js)
const router = require('express').Router();
const voc = require('../controllers/vocacionalController');
const { autenticar } = require('../middlewares/auth');
const { rbac } = require('../middlewares/rbac');

router.use(autenticar, rbac('visitante_feira'));

router.post('/responder', voc.salvarResposta);
router.post('/finalizar', voc.finalizar);

module.exports = router;
