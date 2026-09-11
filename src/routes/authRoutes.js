const router = require('express').Router();
const auth = require('../controllers/authController');
const { autenticar } = require('../middlewares/auth');

router.get('/login', auth.telaLogin);
router.post('/login', auth.login);

// Auto-cadastro (público)
router.get('/cadastro', auth.telaCadastro);
router.post('/cadastro', auth.cadastrar);
router.get('/logout', autenticar, auth.logout);
router.post('/logout', autenticar, auth.logout);

// Elevação/rebaixamento de root e persistência de tema (exige login)
router.post('/root/elevar', autenticar, auth.elevarRoot);
router.post('/root/rebaixar', autenticar, auth.rebaixarRoot);
router.post('/tema', autenticar, auth.salvarTema);

module.exports = router;
