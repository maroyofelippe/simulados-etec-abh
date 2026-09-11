const router = require('express').Router();
const admin = require('../controllers/adminController');
const importacao = require('../controllers/importacaoController');
const { autenticar } = require('../middlewares/auth');
const { rbac, exigirRoot } = require('../middlewares/rbac');
const { uploadLogo, uploadCsv } = require('./_upload');

router.use(autenticar, rbac('coordenador'));

// Unidades (com logo)
router.get('/unidades', admin.listarUnidades);
router.post('/unidades', uploadLogo.single('logo'), admin.criarUnidade);
router.get('/unidades/:id/editar', admin.editarUnidadeForm);
router.post('/unidades/:id', uploadLogo.single('logo'), admin.atualizarUnidade);
router.post('/unidades/:id/status', exigirRoot, admin.alternarStatusUnidade);

// Turmas / Disciplinas / Usuários
router.get('/turmas', admin.listarTurmas);
router.post('/turmas', admin.criarTurma);
router.post('/turmas/:id/status', exigirRoot, admin.alternarStatusTurma);
router.get('/disciplinas', admin.listarDisciplinas);
router.post('/disciplinas', admin.criarDisciplina);
router.get('/usuarios', admin.listarUsuarios);
router.get('/usuarios/:id/editar', admin.editarUsuarioForm);
router.post('/usuarios/:id', admin.atualizarUsuario);
router.post('/usuarios/:id/resetar-senha', admin.resetarSenha);
router.post('/usuarios/:id/excluir', exigirRoot, admin.excluirUsuario);

// Aprovação de auto-cadastro de professores
router.get('/aprovacoes', admin.listarPendentes);
router.post('/aprovacoes/:id/aprovar', admin.aprovarUsuario);
router.post('/aprovacoes/:id/recusar', admin.recusarUsuario);

// Importação de usuários via CSV
router.get('/importar-usuarios', importacao.tela);
router.post('/importar-usuarios', uploadCsv.single('arquivo'), importacao.importar);

module.exports = router;
