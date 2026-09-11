const router = require('express').Router();
const simulado = require('../controllers/simuladoController');
const questao = require('../controllers/questaoController');
const alunoGestao = require('../controllers/professorAlunoController');
const { autenticar } = require('../middlewares/auth');
const { rbac } = require('../middlewares/rbac');
const { uploadCsv } = require('./_upload');

router.use(autenticar, rbac('professor', 'coordenador'));

// Correção de cadastro dos alunos (restrito às turmas do professor)
router.get('/alunos', alunoGestao.listar);
router.get('/alunos/:id/editar', alunoGestao.editarForm);
router.post('/alunos/:id', alunoGestao.atualizar);

// Simulados
router.get('/simulados', simulado.listar);
router.get('/simulados/novo', simulado.telaNovo);
router.post('/simulados', simulado.criar);
router.get('/simulados/:id/editar', simulado.telaEditar);
router.post('/simulados/:id', simulado.atualizar);
router.post('/simulados/:id/publicar', simulado.publicar);

// Banco de questões
router.get('/questoes', questao.listar);
router.get('/questoes/nova', questao.telaNova);
router.post('/questoes', questao.criar);
router.post('/questoes/importar', uploadCsv.single('arquivo'), questao.importarCsv);

module.exports = router;
