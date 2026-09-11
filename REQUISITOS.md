# Requisitos Funcionais e Não Funcionais

## Requisitos Funcionais (RF)

| ID | Requisito | Situação |
|---|---|---|
| RF01 | Login com emissão de JWT (email ou RM) | ✅ |
| RF02 | Timeout de sessão por inatividade (configurável) + logout automático | ✅ |
| RF03 | Registro de último login de cada usuário | ✅ |
| RF04 | Controle de tempo logado (início, fim, duração por sessão) | ✅ |
| RF05 | Perfis de acesso: aluno, professor, coordenador e **root** | ✅ |
| RF06 | Elevação a root a partir de coordenador mediante senha | ✅ |
| RF07 | Cadastro de questões (enunciado, alternativas, gabarito, dificuldade, tema, turma) | ✅ |
| RF08 | Importação de questões via CSV | ✅ |
| RF09 | Geração aleatória de prova por aluno (≤ 20 questões, sem repetição) | ✅ |
| RF10 | Simulado geral por dificuldade e turma (distribuição configurável) | ✅ |
| RF11 | Parametrização: disciplina, aprofundamento, tema, qtd, turma | ✅ |
| RF12 | Cronômetro com submissão automática ao esgotar | ✅ |
| RF13 | Detecção de perda de foco (blur/visibilitychange) + auditoria | ✅ |
| RF14 | Anulação da questão em perda de foco (política configurável) | ✅ |
| RF15 | Bloqueio de seleção/cópia + armadilha anti‑IA (palavra‑coringa oculta) | ✅ |
| RF16 | Bloqueio de colagem de respostas | ✅ |
| RF17 | Questões exibidas uma a uma, resposta obrigatória, 1 tentativa | ✅ |
| RF18 | Salvamento progressivo das respostas | ✅ |
| RF19 | Espelho da prova (respostas, gabarito, perdas de foco) | ✅ |
| RF20 | Conversão nota→menção (I/R/B/MB) exibida ao aluno | ✅ |
| RF21 | Armazenamento das provas no banco + download em PDF com assinatura | ✅ |
| RF22 | Importação de usuários via CSV (nome, rm, turma, período) + relatório | ✅ |
| RF23 | Dashboards hierárquicos (unidade → turma → aluno) | ✅ |
| RF24 | Filtros temporais (simulado, semana, mês, ano) | ✅ |
| RF25 | Comparação de turmas lado a lado | ✅ |
| RF26 | Métricas: média, conclusão, dificuldade, evolução, perdas de foco | ✅ |
| RF27 | Administração de unidades (com logo), turmas e disciplinas | ✅ |
| RF28 | Logo + dados do aluno no espelho/PDF da prova | ✅ |
| RF29 | Tema claro/escuro alternável e persistido (localStorage + banco) | ✅ |
| RF30 | Auto-cadastro público de visitantes da Feira de Profissões (perfil **visitante_feira**), associado à turma "Feira de Profissões", com acesso via senha padrão institucional | ✅ |
| RF31 | Dashboard de captação ativa para a coordenação: quantidade de visitantes, idade/faixa etária, curso de interesse e relação com a ETEC | ✅ |
| RF32 | Visitante da feira acessa o módulo de prova como um aluno de sua turma ("Feira de Profissões"), com resultado isolado dos indicadores acadêmicos gerais | ✅ |

## Requisitos Não Funcionais (RNF)

| ID | Requisito |
|---|---|
| RNF01 | Arquitetura MVC estrita (models/views/controllers + routes/middlewares/services/config) |
| RNF02 | Senhas com hash bcrypt; segredos em `.env` |
| RNF03 | Validação de entrada e tratamento de erros centralizado |
| RNF04 | Models desacoplados dos controllers (ORM Sequelize) |
| RNF05 | Design conforme Manual do Centro Paula Souza (cores, tipografia, componentes) |
| RNF06 | Responsivido (desktop e mobile) |
| RNF07 | Execução 100% local (Node.js + MySQL), sem serviços pagos |
| RNF08 | Código comentado, em Português do Brasil, com nomes consistentes |
| RNF09 | Estrutura de pastas escalável |
