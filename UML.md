# Diagrama de Classes (UML)

Visão de classes da camada de aplicação (Models + Services principais).

```mermaid
classDiagram
    class Unidade {
      +int id
      +string nome
      +string sigla
      +string cidade
      +string logo_path
    }
    class Turma {
      +int id
      +string nome
      +string serie
      +Periodo periodo
      +int ano_letivo
    }
    class Disciplina {
      +int id
      +string nome
      +string area
    }
    class Usuario {
      +int id
      +string nome
      +string email
      +string rm
      +string senha_hash
      +Perfil perfil
      +bool is_root
      +datetime ultimo_login
      +int tempo_logado_total
      +verificarSenha(senha) bool
      +gerarHash(senha)$ string
      +toJSON() object
    }
    class Sessao {
      +int id
      +datetime inicio
      +datetime fim
      +int duracao_segundos
      +EncerradaPor encerrada_por
    }
    class Questao {
      +int id
      +text enunciado
      +Dificuldade dificuldade
      +string tema
      +char gabarito
      +bool ativa
    }
    class TextoApoio {
      +int id
      +string titulo
      +text conteudo
    }
    class Alternativa {
      +int id
      +char letra
      +text texto
    }
    class Simulado {
      +int id
      +string titulo
      +TipoSimulado tipo
      +int qtd_questoes
      +json distribuicao_dificuldade
      +int duracao_minutos
      +bool publicado
    }
    class ProvaAplicada {
      +int id
      +Status status
      +datetime iniciada_em
      +datetime finalizada_em
      +int perdas_foco
    }
    class ProvaQuestao {
      +int id
      +int ordem
      +bool anulada
    }
    class Resposta {
      +int id
      +char letra_marcada
      +bool correta
    }
    class EventoFoco {
      +int id
      +TipoFoco tipo
      +datetime ocorrido_em
    }
    class Resultado {
      +int id
      +int total_questoes
      +int acertos
      +decimal nota
      +Mencao mencao
    }

    class SorteioService {
      <<service>>
      +sortearQuestoes(questoes, qtd, distribuicao) Questao[]
      +embaralhar(array) array
    }
    class MencaoService {
      <<service>>
      +calcularMencao(nota) Mencao
      +descricaoMencao(m) string
    }
    class JwtService {
      <<service>>
      +assinar(payload) string
      +verificar(token) object
    }
    class CsvService {
      <<service>>
      +importarUsuarios(buffer, unidadeId) Relatorio
    }
    class PdfService {
      <<service>>
      +gerarEspelhoPDF(dados, res) void
    }

    Unidade "1" --> "*" Turma
    Unidade "1" --> "*" Usuario
    Turma "1" --> "*" Usuario
    Usuario "1" --> "*" Sessao
    Disciplina "1" --> "*" Questao
    Questao "1" --> "*" Alternativa
    Usuario "1" --> "*" Questao : autor
    TextoApoio "1" --> "*" Questao : apoia (opcional)
    Disciplina "1" --> "*" TextoApoio
    Usuario "1" --> "*" TextoApoio : autor
    Disciplina "1" --> "*" Simulado
    Turma "1" --> "*" Simulado
    Simulado "1" --> "*" ProvaAplicada
    Usuario "1" --> "*" ProvaAplicada : aluno
    ProvaAplicada "1" --> "*" ProvaQuestao
    ProvaAplicada "1" --> "*" Resposta
    ProvaAplicada "1" --> "*" EventoFoco
    ProvaAplicada "1" --> "1" Resultado
    ProvaQuestao "*" --> "1" Questao
    Resposta "*" --> "1" Questao

    ProvaAplicada ..> SorteioService : usa
    Resultado ..> MencaoService : usa
    Usuario ..> JwtService : autentica
    Usuario ..> CsvService : importa
    ProvaAplicada ..> PdfService : exporta
```

## Enumerações
- **Perfil**: `aluno` · `professor` · `coordenador` (+ flag `is_root`)
- **Periodo**: `Manhã` · `Tarde` · `Noite` · `Integral`
- **Dificuldade**: `Fácil` · `Médio` · `Difícil`
- **TipoSimulado**: `aleatorio_aluno` · `geral`
- **Status** (prova): `gerada` · `em_andamento` · `concluida` · `expirada`
- **TipoFoco**: `blur` · `visibilitychange` · `copy` · `paste`
- **Mencao**: `I` · `R` · `B` · `MB`
