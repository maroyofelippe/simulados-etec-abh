# Sistema de Simulados Educacionais — ETEC ABH

Plataforma web para **criação, aplicação e análise de simulados educacionais** da ETEC Adhemar Batista Heméritas (ABH). Permite provas controladas (com detecção de perda de foco e bloqueio anti‑cola), geração aleatória de questões por aluno, importação de usuários e questões via CSV e dashboards estatísticos por unidade, turma e aluno.

Projeto **didático**, construído em **Node.js + Express (MVC) + MySQL (Sequelize)**, seguindo o Manual de Identidade Visual do **Centro Paula Souza** (cores, tipografia Roboto/Roboto Slab e componentes).

---

## 1. Requisitos

- **Node.js 18+** e **npm**
- **MySQL 8+** rodando localmente
- Navegador moderno

## 2. Instalação

```bash
# 1) Instalar dependências
npm install

# 2) Configurar variáveis de ambiente
cp .env.example .env
# edite o .env com o usuário/senha do seu MySQL e uma JWT_SECRET forte
#   node -e "console.log(require('crypto').randomBytes(48).toString('hex'))"

# 3) Criar e popular o banco (DDL + seeds + banco de questões)
npm run db:setup
```

## 3. Execução

```bash
npm run dev     # desenvolvimento (nodemon)
# ou
npm start       # produção
```

Acesse **http://localhost:3000**.

## 4. Credenciais de teste

| Perfil | Login | Senha |
|---|---|---|
| Coordenador/Administrador | `coordenador@etecabh.sp.gov.br` | `Coord@2025` |
| Professor | `professor@etecabh.sp.gov.br` | `Prof@2025` |
| Aluno | RM `12345` (ou `ana.souza@aluno.etecabh.sp.gov.br`) | `Aluno@2025` |

> **root:** logue como **Coordenador**, vá à tela inicial e clique em **"Elevar a root"**, informando a senha `ROOT_PASSWORD` do `.env` (padrão `RootEtec@2025`). O root pode alterar todos os dados do sistema, **exceto** a marcação de alternativas dos alunos.

## 5. Configuração do MySQL (resumo)

O `.env` controla a conexão:

```
DB_HOST=localhost
DB_PORT=3306
DB_NAME=simulados_etec_abh
DB_USER=root
DB_PASS=sua_senha
```

O comando `npm run db:setup` executa, em ordem: `database/ddl.sql`, `database/seeds.sql` e `database/banco_questoes.sql`. Também é possível rodar esses arquivos manualmente pelo MySQL Workbench ou CLI.

## 6. Fluxos principais

- **Aluno** → *Minhas Provas* → inicia (1 tentativa) → resolve **uma questão por vez** (resposta obrigatória) com cronômetro, **anti‑cópia/cola** e **detecção de perda de foco** → vê o **espelho** com gabarito, menção e perdas de foco → baixa **PDF com assinatura de ciência**.
- **Professor** → cria **simulados** (aleatório por aluno / geral, filtrando disciplina, tema, dificuldade, turma; até 20 questões) → gerencia o **banco de questões** (cadastro + importação CSV) → acessa **dashboards** das turmas.
- **Coordenador** → administra **unidades** (com logo), **turmas**, **disciplinas** e **usuários** → **importa alunos via CSV** → vê o **dashboard geral**.

## 7. Importação via CSV

- **Usuários:** `exemplos/usuarios_importacao.csv` — colunas `nome, rm, turma, periodo`.
- **Questões:** `exemplos/questoes_importacao.csv` — colunas `disciplina, dificuldade, tema, serie, enunciado, alt_a..alt_e, gabarito, texto_apoio_titulo, texto_apoio_conteudo`. As duas últimas colunas são opcionais (usadas em questões de Humanas com texto-base); repita o mesmo `texto_apoio_titulo` em várias linhas para vincular todas elas ao mesmo texto de apoio.

## 8. Estrutura de pastas (MVC)

```
simulados-etec-abh/
├── server.js                 # ponto de entrada
├── .env.example
├── database/                 # DDL, seeds, banco de questões, setup
├── docs/                     # endpoints, requisitos, DER, UML
├── exemplos/                 # CSVs de exemplo
└── src/
    ├── config/               # env + conexão Sequelize
    ├── models/               # camada MODEL (Sequelize)
    ├── controllers/          # camada CONTROLLER (regras de fluxo)
    ├── services/             # regras de negócio (sorteio, menção, csv, pdf, jwt)
    ├── middlewares/          # auth (JWT), rbac, timeout, erros
    ├── routes/               # definição de rotas
    ├── views/                # camada VIEW (EJS) + tema claro/escuro
    └── public/               # css/js/img/uploads
```

## 9. Critério de menção (ETEC)

| Nota | Menção |
|---|---|
| 0,0 – 4,9 | **I** (Insatisfatório) |
| 5,0 – 6,9 | **R** (Regular) |
| 7,0 – 8,9 | **B** (Bom) |
| ≥ 9,0 | **MB** (Muito Bom) |

## 10. Sobre o banco de questões (SARESP)

As provas oficiais do SARESP são protegidas por direitos autorais e foram fornecidas apenas como imagens digitalizadas. Por isso, o banco em `database/banco_questoes.js` é **original**, elaborado seguindo a **mesma estrutura do SARESP**: disciplinas, formato objetivo (A–E), níveis de dificuldade e habilidades do Currículo Paulista. Amplie-o à vontade — ele é a base didática do projeto.

## 11. Segurança

- Senhas com **bcrypt**; segredos no `.env` (nunca versione o `.env`).
- **JWT** em cookie httpOnly; **timeout** por inatividade (`SESSION_TIMEOUT`).
- RBAC por middleware; validação de entrada e **tratamento de erros centralizado**.

---

*Uso educacional — ETEC ABH / Centro Paula Souza.*
