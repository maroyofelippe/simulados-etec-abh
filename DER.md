# Diagrama de Entidade‑Relacionamento (DER)

Modelo relacional do banco `simulados_etec_abh`. Renderiza no GitHub e em qualquer visualizador Mermaid.

```mermaid
erDiagram
    UNIDADES ||--o{ TURMAS : possui
    UNIDADES ||--o{ USUARIOS : lota
    TURMAS   ||--o{ USUARIOS : matricula
    USUARIOS ||--o{ SESSOES : registra
    DISCIPLINAS ||--o{ QUESTOES : classifica
    TURMAS   ||--o{ QUESTOES : "vincula (opcional)"
    USUARIOS ||--o{ QUESTOES : autora
    QUESTOES ||--o{ ALTERNATIVAS : contem
    TEXTOS_APOIO ||--o{ QUESTOES : "apoia (opcional)"
    DISCIPLINAS ||--o{ TEXTOS_APOIO : classifica
    USUARIOS ||--o{ TEXTOS_APOIO : autora
    DISCIPLINAS ||--o{ SIMULADOS : filtra
    TURMAS   ||--o{ SIMULADOS : aplica
    USUARIOS ||--o{ SIMULADOS : cria
    SIMULADOS ||--o{ PROVAS_APLICADAS : gera
    USUARIOS ||--o{ PROVAS_APLICADAS : "realiza (aluno)"
    PROVAS_APLICADAS ||--o{ PROVA_QUESTOES : sorteia
    QUESTOES ||--o{ PROVA_QUESTOES : compoe
    PROVAS_APLICADAS ||--o{ RESPOSTAS : recebe
    QUESTOES ||--o{ RESPOSTAS : referente
    PROVAS_APLICADAS ||--o{ EVENTOS_FOCO : audita
    PROVAS_APLICADAS ||--|| RESULTADOS : consolida

    UNIDADES {
      int id PK
      string nome
      string sigla
      string cidade
      string logo_path
    }
    TURMAS {
      int id PK
      string nome
      string serie
      enum periodo
      int ano_letivo
      int unidade_id FK
    }
    DISCIPLINAS {
      int id PK
      string nome
      string area
    }
    USUARIOS {
      int id PK
      string nome
      string email
      string rm
      string senha_hash
      enum perfil
      bool is_root
      enum periodo
      enum tema_preferido
      datetime ultimo_login
      int tempo_logado_total
      int turma_id FK
      int unidade_id FK
    }
    SESSOES {
      int id PK
      int usuario_id FK
      datetime inicio
      datetime fim
      int duracao_segundos
      enum encerrada_por
    }
    TEXTOS_APOIO {
      int id PK
      string titulo
      text conteudo
      int disciplina_id FK
      int autor_id FK
    }
    QUESTOES {
      int id PK
      text enunciado
      enum dificuldade
      string tema
      string serie
      char gabarito
      int disciplina_id FK
      int turma_id FK
      int autor_id FK
      int texto_apoio_id FK
      bool ativa
    }
    ALTERNATIVAS {
      int id PK
      int questao_id FK
      char letra
      text texto
    }
    SIMULADOS {
      int id PK
      string titulo
      enum tipo
      int disciplina_id FK
      string tema
      int turma_id FK
      int qtd_questoes
      json distribuicao_dificuldade
      int duracao_minutos
      int max_perdas_foco
      int criado_por FK
      bool publicado
    }
    PROVAS_APLICADAS {
      int id PK
      int simulado_id FK
      int aluno_id FK
      enum status
      datetime iniciada_em
      datetime finalizada_em
      int tempo_gasto_segundos
      int perdas_foco
    }
    PROVA_QUESTOES {
      int id PK
      int prova_aplicada_id FK
      int questao_id FK
      int ordem
      bool anulada
    }
    RESPOSTAS {
      int id PK
      int prova_aplicada_id FK
      int questao_id FK
      char letra_marcada
      bool correta
    }
    EVENTOS_FOCO {
      int id PK
      int prova_aplicada_id FK
      int questao_id
      enum tipo
      datetime ocorrido_em
    }
    RESULTADOS {
      int id PK
      int prova_aplicada_id FK
      int total_questoes
      int acertos
      decimal nota
      enum mencao
    }
```

## Regras de integridade destacadas
- `TEXTOS_APOIO` representa um trecho/texto-base opcional (comum em Humanas), compartilhável por várias `QUESTOES` via `texto_apoio_id` (FK nullable).
- `PROVAS_APLICADAS` tem chave única `(simulado_id, aluno_id)` → **uma prova por aluno/simulado** (1 tentativa).
- `PROVA_QUESTOES` tem chave única `(prova_aplicada_id, questao_id)` → **sem repetição** de questões na mesma prova.
- `RESPOSTAS` tem chave única `(prova_aplicada_id, questao_id)` → uma resposta por questão.
- `SIMULADOS.qtd_questoes` possui `CHECK (<= 20)` → **limite de 20 questões**.
- `RESULTADOS` é **1:1** com a prova aplicada.
