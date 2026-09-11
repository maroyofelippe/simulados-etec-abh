# Coleção de Rotas / Endpoints

> Legenda de proteção: 🔓 pública · 🔑 autenticada (JWT) · 👤 perfil exigido (RBAC)

## Autenticação
| Método | Rota | Proteção | Descrição |
|---|---|---|---|
| GET | `/login` | 🔓 | Tela de login |
| POST | `/login` | 🔓 | Autentica (email **ou** RM + senha), emite JWT e registra sessão |
| GET/POST | `/logout` | 🔑 | Encerra sessão e contabiliza tempo logado |
| POST | `/root/elevar` | 🔑 👤 coordenador | Eleva privilégio a **root** (exige `ROOT_PASSWORD`) |
| POST | `/root/rebaixar` | 🔑 👤 root | Desativa privilégio root |
| POST | `/tema` | 🔑 | Persiste tema (claro/escuro) |

## Auto-cadastro
| Método | Rota | Proteção | Descrição |
|---|---|---|---|
| GET | `/cadastro` | 🔓 | Tela de auto-cadastro (tipo de conta: aluno, professor ou visitante da Feira de Profissões) |
| POST | `/cadastro` | 🔓 | Cria a conta. Aluno: RM+turma+código de convite, liberado na hora. Professor: código de convite, fica pendente de aprovação. Visitante da feira: telefone, nascimento, relação com a ETEC e curso de interesse — associado à turma "Feira de Profissões", acesso liberado com a senha padrão (`SENHA_PADRAO_VISITANTE_FEIRA`) |

## Aluno / Visitante da Feira — execução de prova
| Método | Rota | Proteção | Descrição |
|---|---|---|---|
| GET | `/aluno/provas` | 🔑 👤 aluno/visitante_feira | Lista simulados disponíveis da turma |
| POST | `/aluno/provas/:simuladoId/iniciar` | 🔑 👤 aluno/visitante_feira | Gera prova individual (sorteio ≤20) e inicia |
| GET | `/aluno/provas/:id/resolver` | 🔑 👤 aluno/visitante_feira | Tela de resolução (cronômetro, anti‑cola) |
| GET | `/aluno/provas/:id/resultado` | 🔑 | Espelho da prova (gabarito, menção, foco) |
| GET | `/aluno/provas/:id/pdf` | 🔑 | Download do espelho em PDF (assinatura de ciência) |

## API AJAX da prova (consumida pelo front)
| Método | Rota | Proteção | Descrição |
|---|---|---|---|
| GET | `/api/provas/:id/questao/:ordem` | 🔑 👤 aluno/visitante_feira | Retorna a questão N (sem gabarito) |
| POST | `/api/provas/:id/responder` | 🔑 👤 aluno/visitante_feira | Salva resposta (obrigatória, 1 chance) |
| POST | `/api/provas/:id/foco` | 🔑 👤 aluno/visitante_feira | Registra perda de foco/copy/paste e anula questão |
| POST | `/api/provas/:id/finalizar` | 🔑 👤 aluno/visitante_feira | Finaliza, calcula nota e menção |

## Professor — simulados e questões
| Método | Rota | Proteção | Descrição |
|---|---|---|---|
| GET | `/professor/simulados` | 🔑 👤 professor/coord | Lista simulados |
| GET | `/professor/simulados/novo` | 🔑 👤 professor/coord | Formulário de novo simulado |
| POST | `/professor/simulados` | 🔑 👤 professor/coord | Cria simulado parametrizado (≤20 questões) |
| POST | `/professor/simulados/:id/publicar` | 🔑 👤 professor/coord | Publica/despublica |
| GET | `/professor/questoes` | 🔑 👤 professor/coord | Banco de questões (com filtros) |
| GET | `/professor/questoes/nova` | 🔑 👤 professor/coord | Formulário de nova questão |
| POST | `/professor/questoes` | 🔑 👤 professor/coord | Cadastra questão + alternativas |
| POST | `/professor/questoes/importar` | 🔑 👤 professor/coord | Importa questões via CSV |

## Administração (coordenador/root)
| Método | Rota | Proteção | Descrição |
|---|---|---|---|
| GET | `/admin/unidades` | 🔑 👤 coordenador | Lista unidades |
| POST | `/admin/unidades` | 🔑 👤 coordenador | Cria unidade (upload de logo) |
| GET/POST | `/admin/turmas` | 🔑 👤 coordenador | Lista/cria turmas |
| GET/POST | `/admin/disciplinas` | 🔑 👤 coordenador | Lista/cria disciplinas |
| GET | `/admin/usuarios` | 🔑 👤 coordenador | Lista usuários (último login, tempo logado) |
| GET | `/admin/importar-usuarios` | 🔑 👤 coordenador | Tela de importação CSV |
| POST | `/admin/importar-usuarios` | 🔑 👤 coordenador | Importa usuários (relatório) |

## Dashboards
| Método | Rota | Proteção | Descrição |
|---|---|---|---|
| GET | `/dashboard?periodo=` | 🔑 👤 professor/coord | Visão geral por unidade (filtros: todos/semana/mes/ano) |
| GET | `/dashboard/turma/:id` | 🔑 👤 professor/coord | Visão por turma |
| GET | `/dashboard/aluno/:id` | 🔑 👤 professor/coord | Evolução do aluno |
| GET | `/dashboard/comparar?turmas=1,2` | 🔑 👤 professor/coord | Comparação lado a lado |
| GET | `/dashboard/feira` | 🔑 👤 coordenador | Captação ativa: estatísticas dos visitantes da Feira de Profissões (curso de interesse, faixa etária, relação com a ETEC, desempenho no simulado) |
| GET | `/dashboard/feira/exportar` | 🔑 👤 coordenador | Exporta o relatório de captação em CSV (contato, idade, curso de interesse, resultado no simulado) |
