-- ==========================================================
--  Migração de conteúdo: Avaliação-demonstração da Feira de Profissões
--  ----------------------------------------------------------
--  Público: visitantes candidatos (alunos do 9º ano do Ensino Fundamental
--  — Anos Finais), que só passam alguns minutos no estande. A avaliação
--  precisa ser simples e rápida, não um simulado de nível ETEC/EM:
--    - 10 questões, nível 'Fácil', sem texto de apoio (autocontidas).
--    - No máximo 2 por disciplina (5 disciplinas x 2 = 10), cobrindo temas
--      básicos de 9º ano — nada de Física/Química/inglês avançado.
--    - Todas marcadas com o mesmo tema (tag), único no banco, para que o
--      simulado "Feira Profissões - ABH" (criado pela coordenação em
--      /professor/simulados, turma "Feira de Profissões") monte seu pool
--      filtrando só por esse tema: como o pool fica com exatamente 10
--      questões e o simulado pede 10, o sorteio (services/sorteioService)
--      sempre devolve as mesmas 10 para todo visitante — só a ORDEM de
--      exibição varia entre um visitante e outro. Efetivamente "a mesma
--      prova para todos", sem precisar de um tipo de simulado novo.
--    - Sem alterar o comportamento de nenhum outro simulado: antes dessa
--      migração, "Feira Profissões - ABH" tinha disciplina_id/tema nulos e
--      sorteava 10 questões de TODO o banco (any dificuldade/disciplina,
--      inclusive Física/Química de nível EM) — diferentes por visitante.
--
--  Idempotente: guarda travada em @ja_existe (mesma técnica das demais
--  migrações de banco de questões), sem DELIMITER/stored procedures.
--  Uso:  npm run db:migrate
-- ==========================================================
SET @tema_feira := 'Demonstração - Feira de Profissões';

-- Comparação feita com a string literal (não com @tema_feira) para evitar
-- "Illegal mix of collations": variáveis de sessão do MySQL fixam a
-- collation da conexão, que pode divergir da collation da coluna "tema"
-- (utf8mb4_unicode_ci no ddl.sql, mas o servidor pode ter criado a tabela
-- com o default utf8mb4_0900_ai_ci) — literais soltos não têm esse problema.
SET @ja_existe := (
  SELECT COUNT(*) FROM questoes WHERE tema = 'Demonstração - Feira de Profissões'
);

-- ==========================================================
--  Língua Portuguesa (disciplina_id = 1)
-- ==========================================================
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa)
SELECT 'Leia a frase: "Depois da chuva, sempre vem o sol." Essa frase é um exemplo de:','Fácil',@tema_feira,'9º Ano EF','B',1,1,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Um trava-língua' AS texto
  UNION ALL SELECT @qid,'B','Um provérbio (ditado popular)'
  UNION ALL SELECT @qid,'C','Uma receita culinária'
  UNION ALL SELECT @qid,'D','Uma notícia de jornal'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa)
SELECT 'Assinale a alternativa que apresenta um antônimo (palavra de sentido oposto) de "rápido":','Fácil',@tema_feira,'9º Ano EF','C',1,1,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Veloz' AS texto
  UNION ALL SELECT @qid,'B','Ligeiro'
  UNION ALL SELECT @qid,'C','Lento'
  UNION ALL SELECT @qid,'D','Ágil'
) alts WHERE @ja_existe = 0;

-- ==========================================================
--  Matemática (disciplina_id = 2)
-- ==========================================================
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa)
SELECT 'Uma caixa tem 24 doces, divididos igualmente entre 6 crianças. Quantos doces cada criança recebe?','Fácil',@tema_feira,'9º Ano EF','B',2,1,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'3' AS texto
  UNION ALL SELECT @qid,'B','4'
  UNION ALL SELECT @qid,'C','5'
  UNION ALL SELECT @qid,'D','6'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa)
SELECT 'Um produto que custava R$ 80,00 recebeu um desconto de 25%. Qual é o novo preço?','Fácil',@tema_feira,'9º Ano EF','B',2,1,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'R$ 55,00' AS texto
  UNION ALL SELECT @qid,'B','R$ 60,00'
  UNION ALL SELECT @qid,'C','R$ 65,00'
  UNION ALL SELECT @qid,'D','R$ 70,00'
) alts WHERE @ja_existe = 0;

-- ==========================================================
--  Biologia (disciplina_id = 3)
-- ==========================================================
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa)
SELECT 'Qual das opções abaixo é um exemplo de fonte de energia renovável?','Fácil',@tema_feira,'9º Ano EF','C',3,1,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Carvão mineral' AS texto
  UNION ALL SELECT @qid,'B','Petróleo'
  UNION ALL SELECT @qid,'C','Energia solar'
  UNION ALL SELECT @qid,'D','Gás natural'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa)
SELECT 'O processo pelo qual as plantas produzem seu próprio alimento usando luz solar é chamado de:','Fácil',@tema_feira,'9º Ano EF','B',3,1,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Respiração' AS texto
  UNION ALL SELECT @qid,'B','Fotossíntese'
  UNION ALL SELECT @qid,'C','Digestão'
  UNION ALL SELECT @qid,'D','Fermentação'
) alts WHERE @ja_existe = 0;

-- ==========================================================
--  História (disciplina_id = 6)
-- ==========================================================
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa)
SELECT 'O Brasil foi colonizado, a partir de 1500, principalmente por qual país europeu?','Fácil',@tema_feira,'9º Ano EF','B',6,1,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Espanha' AS texto
  UNION ALL SELECT @qid,'B','Portugal'
  UNION ALL SELECT @qid,'C','França'
  UNION ALL SELECT @qid,'D','Holanda'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa)
SELECT 'A Proclamação da Independência do Brasil, em 1822, teve como principal figura:','Fácil',@tema_feira,'9º Ano EF','B',6,1,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Tiradentes' AS texto
  UNION ALL SELECT @qid,'B','Dom Pedro I'
  UNION ALL SELECT @qid,'C','Getúlio Vargas'
  UNION ALL SELECT @qid,'D','Dom João VI'
) alts WHERE @ja_existe = 0;

-- ==========================================================
--  Geografia (disciplina_id = 7)
-- ==========================================================
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa)
SELECT 'Qual é a capital do estado de São Paulo?','Fácil',@tema_feira,'9º Ano EF','C',7,1,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Campinas' AS texto
  UNION ALL SELECT @qid,'B','Santos'
  UNION ALL SELECT @qid,'C','São Paulo'
  UNION ALL SELECT @qid,'D','Guarulhos'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa)
SELECT 'O maior bioma brasileiro em extensão territorial é:','Fácil',@tema_feira,'9º Ano EF','D',7,1,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Caatinga' AS texto
  UNION ALL SELECT @qid,'B','Cerrado'
  UNION ALL SELECT @qid,'C','Pantanal'
  UNION ALL SELECT @qid,'D','Amazônia'
) alts WHERE @ja_existe = 0;

-- ==========================================================
--  Aponta o simulado já existente da Feira para este pool de 10 questões.
--  UPDATE simples (idempotente por natureza — reaplicar não tem efeito
--  colateral), roda sempre, mesmo em reexecuções da migração.
-- ==========================================================
UPDATE simulados
SET tema = @tema_feira,
    duracao_minutos = 20
WHERE titulo = 'Feira Profissões - ABH';
