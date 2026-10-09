-- ==========================================================
--  Migração de conteúdo: Banco de questões SARESP 2023 — 1ª Série EM
--  Caderno 009-LC-CN (Linguagens/Inglês + Ciências da Natureza), Cad01,
--  aplicado como Provão Paulista Seriado 2023 (01.12.2023) — Versão 1.
--  Fonte: caderno de questões + gabarito oficial (Fundação Vunesp) fornecidos pela coordenação.
--  ----------------------------------------------------------
--  Origem das questões: SARESP (coluna questoes.origem, criada pela
--  migração 2026-10_origem_questoes.sql — por isso este arquivo vem depois dela).
--
--  Escopo: das 48 questões do caderno, foram importadas as 47. Ficou de fora
--  a questão 40 (energia liberada pela fusão em uma estrela supermassiva):
--  com os dados impressos no enunciado (2 · 10²⁹ kg) o resultado é da ordem
--  de 10⁴³ J, valor que não coincide com o gabarito oficial (alternativa A,
--  10⁴⁶ J) — não foi cadastrada para não registrar um gabarito inconsistente.
--  Nas questões 1, 6, 22, 29, 31, 32, 36, 39, 42, 43, 47 e 48, a figura/tirinha/
--  gráfico foi descrito em texto no enunciado. Nas questões 4, 5 e 19, as palavras
--  sublinhadas no caderno aparecem entre _ _.
--
--  Gabarito: Versão 1 do gabarito oficial (Cad01).
--
--  Idempotente: variável de sessão travada no início (@ja_existe_23b), sem
--  DELIMITER/stored procedures (incompatível com a execução via db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-10_origem_questoes_saresp2023_1serie.sql)
-- ==========================================================
SET @db := DATABASE();

-- Garante que a disciplina "Língua Inglesa" existe (idempotente)
INSERT INTO disciplinas (nome, area)
SELECT 'Língua Inglesa', 'Linguagens'
WHERE NOT EXISTS (SELECT 1 FROM disciplinas WHERE nome = 'Língua Inglesa');

-- Guarda travada: já aplicamos este lote antes?
SET @ja_existe_23b := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'Examine a tirinha publicada pelo perfil "The Square Comics"%'
);


-- Q01
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Examine a tirinha publicada pelo perfil "The Square Comics" no Instagram em 14.08.2023. No primeiro quadrinho, um peixinho amarelo que acaba de ganhar pernas diz: "Finalmente, eu posso andar!". No segundo, já na beira do mar, diz: "Abandonar o mar valeu a pena!". No terceiro, vê um pássaro cinza voando e diz: "Eu posso voar!". No quarto quadrinho, o peixinho aparece com expressão contrariada.

Do ponto de vista temático, a tirinha dialoga, sobretudo, com o seguinte ditado popular:','Fácil','Interpretação de tirinha - ditados populares','1ª Série EM','SARESP','D',1,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Antes só do que mal acompanhado.' AS texto
  UNION ALL SELECT @qid,'B','Mais vale um pássaro na mão do que dois voando.'
  UNION ALL SELECT @qid,'C','A mentira tem perna curta.'
  UNION ALL SELECT @qid,'D','A grama do vizinho é sempre mais verde.'
  UNION ALL SELECT @qid,'E','A pressa é a inimiga da perfeição.'
) alts WHERE @ja_existe_23b = 0;

-- ---------- Texto de apoio: Esopo — "A cigarra e a raposa" — Q02, 03, 04, 05
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Esopo — "A cigarra e a raposa"',
'Uma cigarra estava cantando no alto de uma árvore, quando uma raposa, ávida por comê-la, arquitetou o seguinte plano: parada diante da cigarra, ficou admirando sua bela voz e incentivando-a a descer, dizendo que queria ver de que tamanho era o animal que emitia um som tão alto. Suspeitando da armadilha, a cigarra arrancou uma folha e a deixou cair. A raposa correu para a folha, pensando que fosse a cigarra. Esta, então, lhe disse: "Mas você se enganou, minha cara, se achava que eu iria descer. É que eu fico esperta com vocês, desde o dia em que avistei asas de cigarras nos excrementos de uma raposa."
(Esopo. Fábulas completas, 2013. Adaptado)',
1, 2
WHERE @ja_existe_23b = 0;
SET @tid = LAST_INSERT_ID();

-- Q02
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Depreende-se da leitura da fábula a seguinte moral:','Médio','Fábula - moral','1ª Série EM','SARESP','E',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Aqueles que enfrentam os primeiros agressores tornam-se temíveis para os demais.' AS texto
  UNION ALL SELECT @qid,'B','Por medo de perigos menores, alguns homens lançam-se em males maiores.'
  UNION ALL SELECT @qid,'C','Aqueles que em tempo de fartura não se preocupam com o futuro sofrem quando a situação muda.'
  UNION ALL SELECT @qid,'D','Os homens ambiciosos, por desejarem mais bens, deixam escapar até o que têm em mãos.'
  UNION ALL SELECT @qid,'E','Para os homens prudentes, as desgraças do próximo são instrutivas.'
) alts WHERE @ja_existe_23b = 0;

-- Q03
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A ideia do plano arquitetado pela raposa era a de explorar','Fácil','Fábula - interpretação','1ª Série EM','SARESP','C',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a preguiça da cigarra.' AS texto
  UNION ALL SELECT @qid,'B','a indignação da cigarra.'
  UNION ALL SELECT @qid,'C','a vaidade da cigarra.'
  UNION ALL SELECT @qid,'D','a hipocrisia da cigarra.'
  UNION ALL SELECT @qid,'E','a perspicácia da cigarra.'
) alts WHERE @ja_existe_23b = 0;

-- Q04
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Releia a fábula "A cigarra e a raposa", de Esopo, atentando para os verbos sublinhados (indicados entre _ _ nas alternativas).

Está empregado em sentido figurado o verbo sublinhado em:','Médio','Linguagem figurada - sentido figurado do verbo','1ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"_Suspeitando_ da armadilha, a cigarra arrancou uma folha".' AS texto
  UNION ALL SELECT @qid,'B','"uma raposa, ávida por comê-la, _arquitetou_ o seguinte plano".'
  UNION ALL SELECT @qid,'C','"Uma cigarra estava _cantando_ no alto de uma árvore".'
  UNION ALL SELECT @qid,'D','"o animal que _emitia_ um som tão alto".'
  UNION ALL SELECT @qid,'E','"A raposa _correu_ para a folha, pensando que fosse a cigarra".'
) alts WHERE @ja_existe_23b = 0;

-- Q05
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Releia a fábula "A cigarra e a raposa", de Esopo, atentando para as palavras sublinhadas (indicadas entre _ _ nas alternativas).

Retoma um termo mencionado anteriormente no texto a palavra sublinhada em:','Médio','Coesão referencial - pronomes e artigos','1ª Série EM','SARESP','D',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"pensando que fosse _a_ cigarra".' AS texto
  UNION ALL SELECT @qid,'B','"desde _o_ dia em que avistei asas de cigarras".'
  UNION ALL SELECT @qid,'C','"admirando sua bela voz e incentivando-a _a_ descer".'
  UNION ALL SELECT @qid,'D','"a cigarra arrancou uma folha e _a_ deixou cair".'
  UNION ALL SELECT @qid,'E','"ávida por comê-la, arquitetou _o_ seguinte plano".'
) alts WHERE @ja_existe_23b = 0;

-- Q06
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Examine a tirinha do cartunista Silva João, publicada em sua conta do Instagram em 30.03.2023. No primeiro quadrinho, uma personagem pergunta: "QUE LIVRO É ESSE?", e a outra, que segura um livro, responde: "BÍBLIA". No segundo, a primeira pergunta: "POSSO LER UMA PASSAGEM?", e a outra responde: "PODE". No terceiro, a primeira lê, no que a outra está segurando: "ÔNIBUS RUMO A BELO HORIZONTE; SAÍDA ÀS SETE NA PLATAFORMA DOZE - C", e a outra responde: "AMÉM".

Para obter seu efeito de humor, a tirinha mobiliza fundamentalmente o seguinte recurso expressivo:','Médio','Recursos expressivos - ambiguidade em tirinha','1ª Série EM','SARESP','A',1,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ambiguidade: a presença, num texto, de palavra ou expressão que pode significar coisas diferentes, admitir mais de uma leitura.' AS texto
  UNION ALL SELECT @qid,'B','eufemismo: o emprego de palavra ou expressão no lugar de outra palavra ou expressão considerada desagradável, grosseira.'
  UNION ALL SELECT @qid,'C','antítese: a oposição, em uma mesma expressão ou frase, de duas palavras de sentido contrário.'
  UNION ALL SELECT @qid,'D','hipérbole: a ênfase resultante do exagero na expressão ou comunicação de uma ideia.'
  UNION ALL SELECT @qid,'E','pleonasmo: a repetição desnecessária de palavras ou expressões na enunciação de uma ideia.'
) alts WHERE @ja_existe_23b = 0;

-- ---------- Texto de apoio: Yaguarê Yamã — "A origem da vitória-régia" — Q07, 08, 09, 10, 11
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Yaguarê Yamã — "A origem da vitória-régia"',
'Yaçanã era uma moça bonita. Sua beleza era admirada por toda a aldeia, e todos os rapazes queriam namorá-la. Apesar de muitos daqueles jovens serem bonitos e grandes guerreiros, ela tinha uma paixão impossível. Yaçanã imaginava que a lua fosse um guerreiro celestial que todas as noites descia para se banhar no lago. Para ela, aquele ser lindo, brilhante, tão cheio, era um grande pote de mel que se derramava no infinito. Mas seu namoro era feito apenas de desejo e vontade, pois na verdade nunca tinha sido amante da lua. E todas as noites era a mesma coisa. Yaçanã passava horas olhando para o reflexo da lua. Depois voltava para casa e ia dormir, inconformada por viver longe de seu amado.
Certo dia, ao escurecer, Yaçanã olhou para o céu à procura de seu amor e viu que era noite de lua cheia. Sem avisar ninguém, saiu de casa pela porta dos fundos e rumou para o lago. Chegando lá, desceu a ribanceira e, ao ver aquele reflexo perfeito da lua cheia, não resistiu. Caiu na água tentando alcançá-lo e, em seu desespero, acabou afogando. Lá do alto, a lua assistiu àquela grande demonstração de amor sem poder fazer nada, pois não era o guerreiro que Yaçanã imaginava. Sentindo pena daquela moça linda e ingênua, resolveu fazer de seu corpo alguma coisa que vivesse no lago para sempre, junto do reflexo de seu brilho. Transformou-o então na vitória-régia, a flor do amor e da paixão que vemos flutuando nos lagos.
(Yaguarê Yamã. Murugawa: mitos, contos e fábulas do povo Maraguá, 2007. Adaptado)',
1, 2
WHERE @ja_existe_23b = 0;
SET @tid = LAST_INSERT_ID();

-- Q07
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No mito, o amor de Yaçanã pela lua é caracterizado como','Fácil','Mito - caracterização','1ª Série EM','SARESP','E',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'efêmero.' AS texto
  UNION ALL SELECT @qid,'B','sensual.'
  UNION ALL SELECT @qid,'C','dissimulado.'
  UNION ALL SELECT @qid,'D','interesseiro.'
  UNION ALL SELECT @qid,'E','platônico.'
) alts WHERE @ja_existe_23b = 0;

-- Q08
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Observa-se o emprego de palavra formada com prefixo que exprime ideia de negação no seguinte trecho:','Médio','Formação de palavras - prefixo de negação','1ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"nunca tinha sido amante da lua" (1º parágrafo).' AS texto
  UNION ALL SELECT @qid,'B','"ela tinha uma paixão impossível" (1º parágrafo).'
  UNION ALL SELECT @qid,'C','"Sem avisar ninguém, saiu de casa" (2º parágrafo).'
  UNION ALL SELECT @qid,'D','"não era o guerreiro que Yaçanã imaginava" (2º parágrafo).'
  UNION ALL SELECT @qid,'E','"Transformou-o então na vitória-régia" (2º parágrafo).'
) alts WHERE @ja_existe_23b = 0;

-- Q09
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o trecho: "Lá do alto, a lua assistiu àquela grande demonstração de amor sem poder fazer nada, pois não era o guerreiro que Yaçanã imaginava."

O conectivo "pois" (sublinhado no texto original) pode ser substituído, sem prejuízo para o seu sentido original, por:','Médio','Conectivos - valor causal/explicativo','1ª Série EM','SARESP','C',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'logo que.' AS texto
  UNION ALL SELECT @qid,'B','à medida que.'
  UNION ALL SELECT @qid,'C','já que.'
  UNION ALL SELECT @qid,'D','desde que.'
  UNION ALL SELECT @qid,'E','ainda que.'
) alts WHERE @ja_existe_23b = 0;

-- Q10
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o trecho: "Sentindo pena daquela moça linda e ingênua, resolveu fazer de seu corpo alguma coisa que vivesse no lago para sempre, junto do reflexo de seu brilho. Transformou-o então na vitória-régia, a flor do amor e da paixão que vemos flutuando nos lagos."

O referente do pronome sublinhado ("o", em "Transformou-o") no texto é','Médio','Coesão referencial - pronome oblíquo','1ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"reflexo".' AS texto
  UNION ALL SELECT @qid,'B','"corpo".'
  UNION ALL SELECT @qid,'C','"brilho".'
  UNION ALL SELECT @qid,'D','"lago".'
  UNION ALL SELECT @qid,'E','"guerreiro".'
) alts WHERE @ja_existe_23b = 0;

-- Q11
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Releia o seguinte trecho do mito, atentando para a oração sublinhada: "Yaçanã era uma moça bonita. _Sua beleza era admirada por toda a aldeia_, e todos os rapazes queriam namorá-la."

Ao se transpor a oração sublinhada para a voz ativa, a forma verbal resultante será:','Médio','Vozes verbais - passiva para ativa','1ª Série EM','SARESP','A',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'admirava.' AS texto
  UNION ALL SELECT @qid,'B','admiraram.'
  UNION ALL SELECT @qid,'C','admiraria.'
  UNION ALL SELECT @qid,'D','admira.'
  UNION ALL SELECT @qid,'E','admiravam.'
) alts WHERE @ja_existe_23b = 0;

-- ---------- Texto de apoio: Bocage — soneto "De cima dessas pedras escabrosas" — Q12, 13, 14, 15
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Bocage — soneto "De cima dessas pedras escabrosas"',
'De cima dessas pedras escabrosas¹,
Que pouco a pouco as ondas têm minado,
Da lua com o reflexo prateado
Distingo de Marília as mãos formosas.

Ah!, que lindas que são, que melindrosas²!
Sinto-me louco, sinto-me encantado.
Ah!, quando elas vos colhem lá no prado,
Nem vós, lírios, brilhais, nem vós, ó rosas!

Deuses! Céus! Tudo o mais que tendes feito,
Vendo tão belas mãos, me dá desgosto;
Nada, onde elas estão, nada é perfeito.

Oh!, quem pudera uni-las ao meu rosto!
Quem pudera apertá-las no meu peito!
Dar-lhes mil beijos e expirar³ de gosto!
(Manuel Maria Barbosa du Bocage. Poemas escolhidos, 1974)

¹ escabrosas: escarpadas.
² melindrosas: delicadas.
³ expirar: exalar o último suspiro; morrer.',
1, 2
WHERE @ja_existe_23b = 0;
SET @tid = LAST_INSERT_ID();

-- Q12
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'De acordo com o eu lírico,','Médio','Interpretação de poema','1ª Série EM','SARESP','E',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'todas as criações dos Deuses mostram-se perfeitas.' AS texto
  UNION ALL SELECT @qid,'B','as mãos de Marília conferem maior encanto às demais criações dos Deuses.'
  UNION ALL SELECT @qid,'C','as mãos de Marília revelam-se tão cruéis quanto os Deuses.'
  UNION ALL SELECT @qid,'D','todas as criações dos Deuses mostram-se imperfeitas.'
  UNION ALL SELECT @qid,'E','as mãos de Marília ofuscam as demais criações dos Deuses.'
) alts WHERE @ja_existe_23b = 0;

-- Q13
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma característica presente no soneto que antecipa a estética romântica é','Médio','Pré-Romantismo - subjetividade','1ª Série EM','SARESP','D',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a tonalidade satírica.' AS texto
  UNION ALL SELECT @qid,'B','a rigorosa contenção lírica.'
  UNION ALL SELECT @qid,'C','a referência a entidades mitológicas.'
  UNION ALL SELECT @qid,'D','a ênfase na expressão subjetiva.'
  UNION ALL SELECT @qid,'E','a representação bucólica da paisagem.'
) alts WHERE @ja_existe_23b = 0;

-- Q14
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na segunda estrofe, o eu lírico dirige-se, mediante vocativos,','Fácil','Vocativo','1ª Série EM','SARESP','D',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ao prado, apenas.' AS texto
  UNION ALL SELECT @qid,'B','às mãos de Marília e ao prado, apenas.'
  UNION ALL SELECT @qid,'C','às mãos de Marília, aos lírios e às rosas.'
  UNION ALL SELECT @qid,'D','aos lírios e às rosas, apenas.'
  UNION ALL SELECT @qid,'E','às mãos de Marília, apenas.'
) alts WHERE @ja_existe_23b = 0;

-- Q15
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Há no soneto um verso em que o eu lírico conjuga habilmente uma hipérbole e um eufemismo. Trata-se do seguinte verso:','Difícil','Figuras de linguagem - hipérbole e eufemismo','1ª Série EM','SARESP','C',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"Nem vós, lírios, brilhais, nem vós, ó rosas!" (2ª estrofe)' AS texto
  UNION ALL SELECT @qid,'B','"Vendo tão belas mãos, me dá desgosto;" (3ª estrofe)'
  UNION ALL SELECT @qid,'C','"Dar-lhes mil beijos e expirar de gosto!" (4ª estrofe)'
  UNION ALL SELECT @qid,'D','"Ah!, que lindas que são, que melindrosas!" (2ª estrofe)'
  UNION ALL SELECT @qid,'E','"Nada, onde elas estão, nada é perfeito." (3ª estrofe)'
) alts WHERE @ja_existe_23b = 0;

-- ---------- Texto de apoio: José de Alencar — Iracema (trecho) — Q16, 17, 18, 19, 20
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'José de Alencar — Iracema (trecho)',
'Além, muito além daquela serra, que ainda azula no horizonte, nasceu Iracema. Iracema, a virgem dos lábios de mel, que tinha os cabelos mais negros que a asa da graúna¹, e mais longos que seu talhe de palmeira. O favo da jati² não era doce como seu sorriso, nem a baunilha recendia no bosque como seu hálito perfumado.
Um dia, ao pino do Sol, ela repousava em um claro da floresta. Banhava-lhe o corpo a sombra da oiticica³, mais fresca do que o orvalho da noite. Os ramos da acácia silvestre esparziam flores sobre os úmidos cabelos. Escondidos na folhagem os pássaros ameigavam o canto.
Rumor suspeito quebra a doce harmonia da sesta. Ergue a virgem os olhos, que o sol não deslumbra; sua vista perturba-se. Diante dela e todo a contemplá-la, está um guerreiro estranho, se é guerreiro e não algum mau espírito da floresta. Tem nas faces o branco das areias que bordam o mar, nos olhos o azul triste das águas profundas. Ignotas⁴ armas e tecidos ignotos cobrem-lhe o corpo.
Foi rápido, como o olhar, o gesto de Iracema. A flecha embebida no arco partiu. Gotas de sangue borbulham na face do desconhecido. Sofreu mais d''alma que da ferida. O sentimento que ele pôs nos olhos e no rosto, não o sei eu. Porém a virgem lançou de si o arco e a uiraçaba⁵ e correu para o guerreiro, sentida da mágoa que causara. A mão que rápida ferira estancou mais rápida e compassiva o sangue que gotejava.
(José de Alencar. Iracema, 2006. Adaptado)

¹ graúna: pássaro de cor negra.
² jati: pequena abelha.
³ oiticica: árvore frondosa.
⁴ ignoto: desconhecido.
⁵ uiraçaba: estojo em que se guardam flechas.',
1, 2
WHERE @ja_existe_23b = 0;
SET @tid = LAST_INSERT_ID();

-- Q16
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um traço característico da prosa romântica que pode ser encontrado no trecho transcrito é','Médio','Romantismo - prosa','1ª Série EM','SARESP','A',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a descrição idealizada da personagem retratada.' AS texto
  UNION ALL SELECT @qid,'B','a inserção de eventos fantásticos na narrativa.'
  UNION ALL SELECT @qid,'C','a descrição bucólica da paisagem retratada.'
  UNION ALL SELECT @qid,'D','a inserção de eventos políticos na narrativa.'
  UNION ALL SELECT @qid,'E','a descrição animalizada da personagem retratada.'
) alts WHERE @ja_existe_23b = 0;

-- Q17
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Observa-se a intromissão do narrador no curso da narrativa no seguinte trecho:','Médio','Foco narrativo - intromissão do narrador','1ª Série EM','SARESP','D',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"Foi rápido, como o olhar, o gesto de Iracema." (4º parágrafo)' AS texto
  UNION ALL SELECT @qid,'B','"Rumor suspeito quebra a doce harmonia da sesta." (3º parágrafo)'
  UNION ALL SELECT @qid,'C','"Escondidos na folhagem os pássaros ameigavam o canto." (2º parágrafo)'
  UNION ALL SELECT @qid,'D','"O sentimento que ele pôs nos olhos e no rosto, não o sei eu." (4º parágrafo)'
  UNION ALL SELECT @qid,'E','"Um dia, ao pino do Sol, ela repousava em um claro da floresta." (2º parágrafo)'
) alts WHERE @ja_existe_23b = 0;

-- Q18
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O chamado discurso indireto livre não costuma deixar claro quem está com a palavra, se o narrador ou a personagem. O que permite distinguir é estar sendo relatado o pensamento da personagem, o qual é dela e não do narrador, por mais que este com ela se identifique.

A voz da protagonista parece mesclar-se à voz do narrador, exemplificando assim o discurso indireto livre, no seguinte trecho:','Difícil','Discurso indireto livre','1ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"Um dia, ao pino do Sol, ela repousava em um claro da floresta." (2º parágrafo)' AS texto
  UNION ALL SELECT @qid,'B','"Diante dela e todo a contemplá-la, está um guerreiro estranho, se é guerreiro e não algum mau espírito da floresta." (3º parágrafo)'
  UNION ALL SELECT @qid,'C','"Porém a virgem lançou de si o arco e a uiraçaba e correu para o guerreiro, sentida da mágoa que causara." (4º parágrafo)'
  UNION ALL SELECT @qid,'D','"O favo da jati não era doce como seu sorriso, nem a baunilha recendia no bosque como seu hálito perfumado." (1º parágrafo)'
  UNION ALL SELECT @qid,'E','"Iracema, a virgem dos lábios de mel, que tinha os cabelos mais negros que a asa da graúna, e mais longos que seu talhe de palmeira." (1º parágrafo)'
) alts WHERE @ja_existe_23b = 0;

-- Q19
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o trecho do romance Iracema: "Porém a virgem _lançou_ de si o arco e a uiraçaba e _correu_ para o guerreiro, sentida da mágoa que causara. A mão que rápida _ferira_ _estancou_ mais rápida e compassiva o sangue que _gotejava_."

Nesse trecho, o narrador relata vários fatos ocorridos no passado. Um fato anterior a esse tempo passado está indicado pela seguinte forma verbal:','Médio','Tempos verbais - mais-que-perfeito','1ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"correu".' AS texto
  UNION ALL SELECT @qid,'B','"ferira".'
  UNION ALL SELECT @qid,'C','"lançou".'
  UNION ALL SELECT @qid,'D','"estancou".'
  UNION ALL SELECT @qid,'E','"gotejava".'
) alts WHERE @ja_existe_23b = 0;

-- Q20
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Está reescrito em ordem direta o seguinte trecho:','Fácil','Ordem direta da frase','1ª Série EM','SARESP','C',1,2,@tid,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"Tem nas faces o branco das areias" (2º parágrafo) → O branco das areias tem nas faces.' AS texto
  UNION ALL SELECT @qid,'B','"Banhava-lhe o corpo a sombra da oiticica" (1º parágrafo) → O corpo banhava-lhe a sombra da oiticica.'
  UNION ALL SELECT @qid,'C','"Ergue a virgem os olhos" (2º parágrafo) → A virgem ergue os olhos.'
  UNION ALL SELECT @qid,'D','"Os ramos da acácia silvestre esparziam flores" (1º parágrafo) → Esparziam flores os ramos da acácia silvestre.'
  UNION ALL SELECT @qid,'E','"A flecha embebida no arco partiu" (3º parágrafo) → Partiu a flecha embebida no arco.'
) alts WHERE @ja_existe_23b = 0;

-- Q21
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto.

"The greatest glory in living lies not in never falling, but in rising every time we fall." — NELSON MANDELA
(https://blog.hubspot.com. Acesso em: 01.08.2023)

A citação de Nelson Mandela, Prêmio Nobel da Paz (1993) e presidente da África do Sul de 1994 a 1999, contém uma reflexão sobre a vida baseada na ideia de','Fácil','Reading comprehension - citação','1ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'civilidade.' AS texto
  UNION ALL SELECT @qid,'B','arrependimento.'
  UNION ALL SELECT @qid,'C','cumplicidade.'
  UNION ALL SELECT @qid,'D','competição.'
  UNION ALL SELECT @qid,'E','perseverança.'
) alts WHERE @ja_existe_23b = 0;

-- Q22
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a tira "Busy Times" (Disponível em: https://geekandpoke.typepad.com. Acesso em 28.07.2023). No primeiro quadrinho, um homem de gravata pensa: "OH MY DEAR! THESE ARE SO BUSY TIMES. I HAVE SO MANY THINGS TO DO. I DON''T KNOW WHAT I SHOULD DO FIRST". O segundo quadrinho mostra o homem parado, em silêncio. No terceiro, ele pensa: "FIRST I SHOULD TWITTER ABOUT THIS".

A partir da leitura da tirinha, infere-se que os pensamentos do personagem indicam','Fácil','Reading comprehension - tira','1ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'objetivo de alcançar promoção no emprego.' AS texto
  UNION ALL SELECT @qid,'B','satisfação na realização de tarefas diversas.'
  UNION ALL SELECT @qid,'C','expectativa de imprevistos na rotina diária.'
  UNION ALL SELECT @qid,'D','receio de dividir responsabilidades.'
  UNION ALL SELECT @qid,'E','atitude de procrastinação das obrigações.'
) alts WHERE @ja_existe_23b = 0;

-- Q23
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

When your alarm goes off in the morning, it''s often easier to start the day with a quick scroll through TikTok, a look at the headlines and a look at what your favorite Instagram influencers are making for their breakfast.
The ease of browsing on your phone first thing in the morning is an easy way to postpone (*) getting out of bed. But, according to neuroscientist Emily McDonald, this is one of many habits which could cause more harm to your brain health.
McDonald has discouraged people from using their phones for the first hour after they wake up because of how it affects brain activity so early in the day.
"As we wake up, brain activity is high in theta and alpha activity (Theta and alpha frequencies both suggest a very relaxed state). Our minds are very susceptible to the information we put into it during this time," McDonald said.
"Going on the phone will cause brain activity to transition to higher beta power, which primes(**) us for a more stressful day. Starting the day with a phone also provides a big dopamine hit, which leads us to continue to check our phone throughout the day."
(Allice Collins. Three Things to Avoid to Protect Your Brain, According to a Neuroscientist. https://www.newsweek.com. 20.06.2023. Acesso em 28.07.2023. Adaptado)
(*) postpone: adiar.
(**) prime: predispor.

De acordo com o texto, a neurocientista Emily McDonald argumenta que verificar o celular, logo pela manhã, pode prejudicar a saúde do cérebro, pois esse hábito','Médio','Reading comprehension - causa e efeito','1ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'intensifica a sensação de cansaço extremo acumulado durante a semana.' AS texto
  UNION ALL SELECT @qid,'B','bloqueia a liberação de melatonina, por conta das luzes emitidas pela tela.'
  UNION ALL SELECT @qid,'C','pode compelir a pessoa a responder a e-mails relacionados ao trabalho.'
  UNION ALL SELECT @qid,'D','favorece a propensão ao mau humor e comportamento temperamental.'
  UNION ALL SELECT @qid,'E','aumenta a frequência da checagem do aparelho ao longo do dia.'
) alts WHERE @ja_existe_23b = 0;

-- Q24
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Would you eat food that''s been predigested?
Experts say that''s what we''re doing when we consume many popular packaged foods – those breads, cereals, snack chips and frozen meals that have been refined, heated, melted, shaped, and packed with additives.
A growing body of(*) research suggests that the extent of industrial processing that your food undergoes can alter its effects on your body, determining its impact on your appetite, hormones, weight gain, and likelihood (**) of developing obesity and chronic diseases.
Almost all foods undergo some level of processing. Even fresh vegetables like baby carrots are washed, peeled, cut and packed by machines at processing facilities before they arrive at grocery stores. But ultra-processed foods are transformed from simple ingredients into industrial products with unusual combinations of flavors, additives, and textures, many of which are not found in nature.
Across the globe, governments are embracing the idea that ultra-processed foods are a big contributor to poor health.
(Anahad O''Connor and Aaron Steckelberg. Melted, pounded, extruded: Why many ultra-processed foods are unhealthy. https://www.washingtonpost.com. 27.06.2023. Acesso em 30.07.2023. Adaptado)
(*) A growing body of: quantidade relevante.
(**) likelihood: propensão.

Entre as informações apresentadas no texto, sobre alimentos ultraprocessados, inclui-se o fato de eles','Médio','Reading comprehension - informações do texto','1ª Série EM','SARESP','B',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'acelerarem o declínio cognitivo observado em consumidores jovens.' AS texto
  UNION ALL SELECT @qid,'B','envolverem associações inusitadas de elementos por vezes ausentes na natureza.'
  UNION ALL SELECT @qid,'C','serem acessíveis economicamente e substituírem a ingestão diária de nutrientes.'
  UNION ALL SELECT @qid,'D','ativarem o sistema de recompensa no cérebro, por conta da alta palatabilidade.'
  UNION ALL SELECT @qid,'E','fazerem uso de embalagens plásticas fabricadas com componentes tóxicos.'
) alts WHERE @ja_existe_23b = 0;

-- Q25
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Indígenas de 14 regiões na Terra Yanomami estão com altos níveis de contaminação por mercúrio. É o que revela um laudo de perícia da Polícia Federal feito a partir da coleta de amostras de cabelo de 43 indígenas. O estudo identificou que 76,7% das pessoas estudadas vivem sob alta exposição desse metal pesado tóxico. As 43 amostras de cabelo foram coletadas no dia 13 fevereiro de 2023, em indígenas na Casa de Saúde Indígena (Casai) Yanomami, na zona Rural de Boa Vista.
(https://g1.globo.com. Acesso: 03.09.2023. Adaptado)

A principal ação antrópica que está relacionada à contaminação dos indígenas por mercúrio é','Fácil','Impactos ambientais - contaminação por mercúrio','1ª Série EM','SARESP','A',3,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o garimpo.' AS texto
  UNION ALL SELECT @qid,'B','a pecuária.'
  UNION ALL SELECT @qid,'C','a queimada.'
  UNION ALL SELECT @qid,'D','a caça predatória.'
  UNION ALL SELECT @qid,'E','a pesca predatória.'
) alts WHERE @ja_existe_23b = 0;

-- Q26
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um jovem estudante viu uma colmeia de abelhas jataí (Tetragonisca angustula) na caixa de luz e uma colmeia de abelhas uruçu (Melipona scutellaris) no tronco de uma árvore. Em ecologia, cada colmeia, isoladamente, e as duas colmeias citadas se referem','Médio','Ecologia - hábitat, população e comunidade','1ª Série EM','SARESP','D',3,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ao hábitat e ao nicho ecológico.' AS texto
  UNION ALL SELECT @qid,'B','à comunidade e ao hábitat.'
  UNION ALL SELECT @qid,'C','ao ecossistema e à população.'
  UNION ALL SELECT @qid,'D','à população e à comunidade.'
  UNION ALL SELECT @qid,'E','ao ecossistema e ao nicho ecológico.'
) alts WHERE @ja_existe_23b = 0;

-- Q27
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O mês de junho de 2023 foi o mais quente do planeta desde que registros globais de temperatura começaram, em 1850, afirmou a Administração Nacional Oceânica e Atmosférica dos Estados Unidos em sua atualização climática mensal. Junto a isso, o mês registrou diversos recordes de temperaturas máximas e, segundo especialistas, com o aumento das emissões de gases poluentes, que prendem calor na atmosfera a cada ano, os verões continuam cada vez mais intensos e agora as temperaturas impressionantes fazem parte da nova realidade climática que milhões de pessoas em todo mundo enfrentam.
(https://veja.abril.com.br. Acesso: 02.09.2023. Adaptado)

O texto descreve um problema ambiental crescente dos dias de hoje, mas que pode ser atenuado com medidas como','Fácil','Mudanças climáticas - medidas de mitigação','1ª Série EM','SARESP','C',3,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'reduzir as queimadas das florestas e aumentar a produção de energia fóssil.' AS texto
  UNION ALL SELECT @qid,'B','reduzir a produção industrial e aumentar o consumo de carvão mineral.'
  UNION ALL SELECT @qid,'C','reduzir o consumo de petróleo e aumentar a produção de energia renovável.'
  UNION ALL SELECT @qid,'D','reduzir o uso de combustíveis renováveis e aumentar o consumo de gás natural.'
  UNION ALL SELECT @qid,'E','reduzir a produção automobilística e aumentar a produção de energia não renovável.'
) alts WHERE @ja_existe_23b = 0;

-- Q28
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O nitrogênio é um elemento essencial para formar alguns compostos orgânicos, como os nucleotídeos e os aminoácidos, presentes nos seres vivos. Sobre o ciclo do nitrogênio, é correto afirmar que','Médio','Ciclos biogeoquímicos - nitrogênio','1ª Série EM','SARESP','B',3,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'os fungos participam de todas as etapas do ciclo do nitrogênio, que resulta na produção de nitrato e nitrito.' AS texto
  UNION ALL SELECT @qid,'B','uma planta leguminosa enriquece mais o solo com compostos nitrogenados do que uma planta não leguminosa.'
  UNION ALL SELECT @qid,'C','as plantas absorvem diretamente o gás nitrogênio do ar para sintetizar os dois compostos orgânicos nitrogenados.'
  UNION ALL SELECT @qid,'D','as bactérias realizam a síntese de compostos orgânicos nitrogenados, que são absorvidos pelas raízes das plantas.'
  UNION ALL SELECT @qid,'E','os animais obtêm a amônia do ambiente e conseguem transformá-la em compostos orgânicos nitrogenados.'
) alts WHERE @ja_existe_23b = 0;

-- Q29
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em 1952, Stanley Miller e Harold Urey montaram um aparelho que simulou as condições que existiam na Terra pré-biótica. Miller e Urey simularam as condições da Terra primitiva, que era formada basicamente por gases simples, descargas elétricas e alta temperatura. A figura ilustra o aparelho: um balão com eletrodos (que produzem descargas elétricas), ligado a um condensador e a um segundo balão com água aquecida por uma fonte de calor, de onde sobe vapor, formando um circuito fechado.
(www.eurekalert.org. Acesso: 30.09.2023. Adaptado)

O objetivo deles com esse experimento era','Fácil','Origem da vida - experimento de Miller e Urey','1ª Série EM','SARESP','E',3,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'confirmar a origem dos seres vivos pela biogênese.' AS texto
  UNION ALL SELECT @qid,'B','reforçar a origem das primeiras membranas plasmáticas.'
  UNION ALL SELECT @qid,'C','entender o mecanismo de transcrição da molécula de RNA.'
  UNION ALL SELECT @qid,'D','elucidar a forma de transmissão genética das células.'
  UNION ALL SELECT @qid,'E','testar a hipótese da origem química da vida.'
) alts WHERE @ja_existe_23b = 0;

-- Q30
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Três espécies de plantas aquáticas apresentam aerênquima, ou seja, tecido especial que reserva ar e mantém as plantas sobre a superfície da água. Sabendo-se que as três espécies não pertencem a grupos evolutivos próximos e vivem em diferentes locais de um país, é possível prever que o ambiente aquático selecionou essas três espécies de plantas. Este é um exemplo de um processo evolutivo denominado','Médio','Evolução - convergência adaptativa','1ª Série EM','SARESP','D',3,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'homologia.' AS texto
  UNION ALL SELECT @qid,'B','divergência evolutiva.'
  UNION ALL SELECT @qid,'C','deriva genética.'
  UNION ALL SELECT @qid,'D','convergência adaptativa.'
  UNION ALL SELECT @qid,'E','especiação alopátrica.'
) alts WHERE @ja_existe_23b = 0;

-- Q31
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A imagem mostra as aves que ficaram conhecidas como os tentilhões de Charles Darwin, cientista que verificou certas semelhanças físicas e também diferenças, como os diferentes bicos. São quatro cabeças de aves: 1. Geospiza magnirostris; 2. Geospiza fortis; 3. Geospiza parvula; 4. Certhidea olivasea — com bicos de formatos e tamanhos diferentes (grosso e curvo, grosso, curto e fino, longo e fino).
(www.thoughtco.com)

De acordo a teoria evolutiva de Charles Darwin, os tentilhões apresentam diferenças físicas porque','Médio','Evolução - teoria de Darwin','1ª Série EM','SARESP','A',3,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'cada tipo de bico surgiu de forma aleatória e aumentou a chance de sobrevivência das aves.' AS texto
  UNION ALL SELECT @qid,'B','as aves precisaram gerar bicos diferentes para buscar os alimentos específicos.'
  UNION ALL SELECT @qid,'C','cada ave foi se acostumando ao tipo de alimento até resultar nas características atuais.'
  UNION ALL SELECT @qid,'D','forças ambientais e genéticas transformaram as aves em organismos adaptados.'
  UNION ALL SELECT @qid,'E','a alta frequência de uso de cada bico provocou a adaptação das aves ao tipo de alimento.'
) alts WHERE @ja_existe_23b = 0;

-- Q32
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise o esquema que ilustra as transformações químicas que ocorrem com algumas moléculas úteis, X e Y, nas atividades metabólicas que ocorrem em todas as células vivas de um animal.

Descrição do esquema: a molécula X é formada por adenosina + ribose + trifosfato (três grupos fosfato). Ao perder um fosfato, X libera energia e se converte em Y. A molécula Y é formada por adenosina + ribose + difosfato (dois grupos fosfato). Ao receber um fosfato e absorver energia, Y se converte novamente em X.
(www.biologyonline.com. Adaptado)

Considerando que o processo ocorre em uma célula viva animal, a molécula','Médio','Bioenergética - ATP e ADP','1ª Série EM','SARESP','C',3,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'X é o ATP, que é sintetizado em grande quantidade por meio das descarboxilações que ocorrem no ciclo de Krebs.' AS texto
  UNION ALL SELECT @qid,'B','X é o ADP, que é sintetizado em grande quantidade por meio das desidrogenações que ocorrem na glicólise.'
  UNION ALL SELECT @qid,'C','X é o ATP, que é sintetizado em grande quantidade por meio da transferência de íons hidrogênio que ocorrem na cadeia respiratória.'
  UNION ALL SELECT @qid,'D','Y é o ATP, que é sintetizado em grande quantidade por meio da transferência de íons hidrogênio na cadeia respiratória.'
  UNION ALL SELECT @qid,'E','Y é o ADP, que é sintetizado em grande quantidade por meio das descarboxilações que ocorrem no ciclo de Krebs.'
) alts WHERE @ja_existe_23b = 0;

-- Q33
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em 1883, a explosão do vulcão Krakatoa gerou uma onda sonora tão poderosa que deu a volta no planeta. Admitindo que a velocidade média da propagação do som no ar é de 1 200 km/h, que o raio da Terra é aproximadamente 6 400 km e π = 3, quanto tempo o som dessa explosão precisou para dar uma volta completa na Terra?','Fácil','Cinemática - velocidade média','1ª Série EM','SARESP','B',4,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'28 horas.' AS texto
  UNION ALL SELECT @qid,'B','32 horas.'
  UNION ALL SELECT @qid,'C','21 horas.'
  UNION ALL SELECT @qid,'D','18 horas.'
  UNION ALL SELECT @qid,'E','5 horas.'
) alts WHERE @ja_existe_23b = 0;

-- Q34
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No momento inicial da queda de um granizo (pequeno glóbulo de gelo), inicialmente em repouso no interior de nuvens altas de tempestade, atua sobre ele apenas a força peso. Nos momentos seguintes, passa a atuar a força de resistência do ar, também de direção vertical só que de sentido contrário ao da força peso e que tem sua intensidade aumentada de acordo com a velocidade da queda do granizo.

Em função das forças atuantes, a partir de determinado instante, a velocidade da queda atinge um valor máximo, denominado velocidade limite. Desse momento até o granizo atingir o solo, a força resultante sobre ele é vertical, de intensidade','Médio','Dinâmica - velocidade limite','1ª Série EM','SARESP','A',4,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'nula, mantendo o valor da velocidade do granizo constante.' AS texto
  UNION ALL SELECT @qid,'B','constante e de sentido para cima, mantendo constante a velocidade do granizo.'
  UNION ALL SELECT @qid,'C','variável e de sentido para baixo, aumentando a velocidade do granizo.'
  UNION ALL SELECT @qid,'D','variável e de sentido para cima, mantendo constante a velocidade do granizo.'
  UNION ALL SELECT @qid,'E','constante e de sentido para baixo, diminuindo a velocidade do granizo.'
) alts WHERE @ja_existe_23b = 0;

-- Q35
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A intensidade da força gravitacional (F) entre dois corpos é dada pela equação F = G · (m1 · m2) / d², na qual G é a constante universal da gravitação, m1 e m2 a massa dos corpos e d a distância entre eles.

Considere o planeta Marte e seus dois satélites naturais, Fobos e Deimos. Sabendo que a massa de Fobos e sua distância em relação a Marte são respectivamente 1 · 10¹⁶ kg e 6 · 10⁶ m, enquanto que para Deimos os valores são, respectivamente, 2 · 10¹⁵ kg e 24 · 10⁶ m, a intensidade da força gravitacional exercida por Marte sobre Fobos (F_Fobos) em relação a intensidade da força gravitacional exercida por Marte sobre Deimos (F_Deimos) pode ser descrita pela equação','Médio','Gravitação universal','1ª Série EM','SARESP','C',4,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'F_Fobos = 40 · F_Deimos' AS texto
  UNION ALL SELECT @qid,'B','F_Fobos = 90 · F_Deimos'
  UNION ALL SELECT @qid,'C','F_Fobos = 80 · F_Deimos'
  UNION ALL SELECT @qid,'D','F_Fobos = 16 · F_Deimos'
  UNION ALL SELECT @qid,'E','F_Fobos = 5 · F_Deimos'
) alts WHERE @ja_existe_23b = 0;

-- Q36
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Após assistir um vídeo na internet, um aluno decidiu reproduzir o experimento e determinar a altura de sua geladeira. Então, colocou um pouco de água em um prato raso com fundo preto e procurou a melhor posição para visualizar o vértice superior da geladeira refletido no centro do prato.

Em seguida, com a trena, mediu a altura do chão aos seus olhos (160 cm), a distância de seu pé ao centro do prato (56 cm) e do centro do prato até o vértice inferior da geladeira (70 cm). A partir desses dados, por semelhança de triângulos, calculou a altura da geladeira. (Figura ilustrativa e fora de escala: a geladeira à esquerda, o prato no chão a 70 cm da geladeira e o aluno à direita, a 56 cm do prato, com os olhos a 160 cm do chão.)

No entanto, como a altura da geladeira pode ser medida diretamente, para comparar, ele efetuou a medida direta (190 cm). O valor absoluto da diferença de altura obtida experimentalmente comparada com o valor medido diretamente na geladeira é','Médio','Óptica - reflexão e semelhança de triângulos','1ª Série EM','SARESP','B',4,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'4 cm.' AS texto
  UNION ALL SELECT @qid,'B','10 cm.'
  UNION ALL SELECT @qid,'C','2 cm.'
  UNION ALL SELECT @qid,'D','40 cm.'
  UNION ALL SELECT @qid,'E','14 cm.'
) alts WHERE @ja_existe_23b = 0;

-- Q37
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Com objetivo de determinar o valor energético liberado pelo amendoim quando ingerido, um aluno promoveu a combustão de 1 g de amendoim e, com o calor liberado, aqueceu determinada massa de água de 24 ºC até 84 ºC.

No rótulo do pacote desse amendoim, constatou que o valor energético de 1 g de amendoim equivale a 6 000 cal. Considerando que, devido a inúmeras perdas durante o experimento, apenas 50% da energia liberada na combustão foi efetivamente utilizada para aquecer a água, sabendo que o calor específico da água é igual a 1 cal/(g · ºC), a massa de água que foi aquecida era de','Médio','Calorimetria','1ª Série EM','SARESP','E',4,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'35 g.' AS texto
  UNION ALL SELECT @qid,'B','100 g.'
  UNION ALL SELECT @qid,'C','60 g.'
  UNION ALL SELECT @qid,'D','70 g.'
  UNION ALL SELECT @qid,'E','50 g.'
) alts WHERE @ja_existe_23b = 0;

-- Q38
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em algumas cidades do litoral Paulista, durante a noite, é comum transeuntes sentirem a passagem de morcegos. Sempre muito rápidos, esses animais são atraídos pelos frutos de uma árvore típica, a amendoeira-da-praia, também conhecidas como chapéu-de-sol.

Apesar de sua velocidade, mesmo voando entre pedestres e ciclistas também em movimento, esses incríveis mamíferos voadores não colidem com os obstáculos, pois além de identificar as ondas sonoras que produzem, os morcegos recebem informações de seu próprio eco e são capazes de perceber mudanças de frequência decorrentes dos movimentos.

Suponha que, por curiosidade, um estudante coloque um detector de frequências sonoras sobre um banco. Se um morcego voa na direção do detector com velocidade 40 m/s e emite um som de frequência 31 500 Hz, considerando a velocidade do som no ar igual a 340 m/s, a frequência detectada será de, aproximadamente,','Difícil','Ondulatória - efeito Doppler','1ª Série EM','SARESP','D',4,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'28 200 Hz.' AS texto
  UNION ALL SELECT @qid,'B','34 200 Hz.'
  UNION ALL SELECT @qid,'C','31 000 Hz.'
  UNION ALL SELECT @qid,'D','35 600 Hz.'
  UNION ALL SELECT @qid,'E','27 800 Hz.'
) alts WHERE @ja_existe_23b = 0;

-- Q39
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A Agência Nacional de Energia Elétrica (ANEEL) publicou que 27 novas usinas começaram a operar no mês de abril de 2023, resultando numa expansão de 593,0 MW fornecidos, sendo 11 usinas Eólicas (153,5 MW), 8 Solares Fotovoltaicas (324,0 MW), 5 Termelétricas, uma pequena central Hidrelétrica e uma central geradora Hidrelétrica. Neste cenário, Minas Gerais foi o Estado com maior expansão no mês, respondendo por 231,0 MW.

Gráfico (ANEEL, total instalado nas usinas do país: 191.702,7 MW), com o percentual de energia gerado pelas diferentes usinas:
- Em operação: UHE 53,29%; UTE 24,60%; EOL 13,25%; UFV 4,43%; PCH 2,95%; UTN 1,03%; CGH 0,45%.
- Em construção: UFV 32,44%; EOL 31,79%; UTE 25,89%; UTN 7,35%; PCH 2,24%; UHE 0,27%; CGH 0,01%.
- Construção não iniciada: UFV 79,63%; EOL 16,25%; UTE 2,96%; PCH 0,93%; UHE 0,22%; CGH 0,01%.
(https://www.gov.br/aneel. Acesso em 02/09/2023. Adaptado)

Dado: UHE – Usina Hidrelétrica; UTE – Usina Termelétrica; UTN – Usina Termonuclear; CGH – Central Geradora Elétrica; EOL – Usina Eólica; PCH – Pequena Central Hidrelétrica; UFV – Usina Fotovoltaica.

De acordo com as informações fornecidas, pode-se afirmar que','Médio','Matriz energética - interpretação de dados','1ª Série EM','SARESP','D',4,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'as Usinas Hidrelétricas (UHE) são responsáveis por gerar 53 GW do total instalado.' AS texto
  UNION ALL SELECT @qid,'B','Minas Gerais é o Estado responsável por 50% da expansão total em 2023.'
  UNION ALL SELECT @qid,'C','as usinas Eólicas (EOL) fornecem mais energia do que as usinas Solares Fotovoltaicas (UFV).'
  UNION ALL SELECT @qid,'D','em média, no mês de abril, cada nova Usina Fotovoltaica (UFV) gerou 40,5 MW.'
  UNION ALL SELECT @qid,'E','os planos de construção indicam maior investimento em usinas termelétricas (UTE).'
) alts WHERE @ja_existe_23b = 0;

-- Q41
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Ciclos biogeoquímicos são processos naturais que envolvem a circulação de elementos químicos e descrevem a forma como esses elementos são absorvidos, transformados, armazenados e liberados ao longo do tempo, passando por diferentes compartimentos, como atmosfera, solo, água e organismos.

Uma das etapas de um dos ciclos biogeoquímicos tem uma substância simples (substância elementar) no estado sólido. Essa substância está presente no ciclo biogeoquímico do elemento representado pelo símbolo químico','Médio','Ciclos biogeoquímicos - substâncias simples','1ª Série EM','SARESP','E',5,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'P.' AS texto
  UNION ALL SELECT @qid,'B','O.'
  UNION ALL SELECT @qid,'C','N.'
  UNION ALL SELECT @qid,'D','C.'
  UNION ALL SELECT @qid,'E','S.'
) alts WHERE @ja_existe_23b = 0;

-- Q42
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No quadro, são apresentados dados de algumas substâncias (estado físico a 25 ºC e densidade):
- Poliuretano: sólido, 0,50 g/cm³
- Isooctano: líquido, 0,69 g/cm³
- Polietileno: sólido, 0,93 g/cm³
- Politetrafluoretileno: sólido, 2,2 g/cm³
- Água: líquido, 1,0 g/cm³
- Dissulfeto de carbono: líquido, 1,3 g/cm³

Miscibilidade: a água não é miscível no isooctano nem no dissulfeto de carbono; o isooctano e o dissulfeto de carbono são miscíveis entre si.

A figura apresenta o resultado da mistura, em temperatura ambiente, de porções de quatro das substâncias do quadro, em um tubo: há duas fases líquidas (o líquido 1 na fase superior e o líquido 2 na fase inferior), um sólido 1 flutuando na interface entre as duas fases líquidas e um sólido 2 depositado no fundo do tubo.

O sólido 1 e o líquido 2 indicados na figura são, respectivamente,','Médio','Propriedades da matéria - densidade e miscibilidade','1ª Série EM','SARESP','C',5,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'poliuretano e dissulfeto de carbono.' AS texto
  UNION ALL SELECT @qid,'B','polietileno e dissulfeto de carbono.'
  UNION ALL SELECT @qid,'C','polietileno e água.'
  UNION ALL SELECT @qid,'D','poliuretano e isooctano.'
  UNION ALL SELECT @qid,'E','poliuretano e água.'
) alts WHERE @ja_existe_23b = 0;

-- Q43
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O estudo do comportamento térmico de uma determinada amostra foi realizado por meio do seu aquecimento. O tempo do experimento e a temperatura da amostra foram monitorados e anotados ao longo do estudo. O resultado é apresentado no gráfico de temperatura × tempo, dividido em cinco regiões: (1) trecho inclinado, em que a temperatura aumenta; (2) patamar horizontal, em que a temperatura permanece constante; (3) trecho muito inclinado, em que a temperatura aumenta; (4) trecho de inclinação suave, em que a temperatura aumenta lentamente; (5) trecho muito inclinado, em que a temperatura aumenta.

Essa amostra, classificada como uma mistura ______, estava em dois estados físicos nas regiões do gráfico indicadas pelos números ______.

Os termos que completam corretamente a frase anterior são:','Difícil','Misturas - curva de aquecimento','1ª Série EM','SARESP','B',5,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'eutética … 1 e 3' AS texto
  UNION ALL SELECT @qid,'B','eutética … 2 e 4'
  UNION ALL SELECT @qid,'C','eutética … 1 e 5'
  UNION ALL SELECT @qid,'D','azeotrópica … 1 e 3'
  UNION ALL SELECT @qid,'E','azeotrópica … 2 e 4'
) alts WHERE @ja_existe_23b = 0;

-- Q44
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere as equações termoquímicas das reações 1, 2 e 3.
reação 1: A + B → AB   ΔH°1 > 0
reação 2: 2A + D → A2D   ΔH°2 > 0
reação 3: C + D → CD   ΔH°3 > 0

Analise a reação representada pela seguinte equação:
A2D + C + 2B → 2AB + CD

Essa última reação será endotérmica se a relação dos valores das entalpias das reações 1, 2 e 3 em módulo for','Difícil','Termoquímica - lei de Hess','1ª Série EM','SARESP','D',5,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'(ΔH°3 + 2ΔH°1) < ΔH°2' AS texto
  UNION ALL SELECT @qid,'B','(ΔH°3 + ΔH°1) = 2ΔH°2'
  UNION ALL SELECT @qid,'C','(2ΔH°3 + ΔH°1) > ΔH°2'
  UNION ALL SELECT @qid,'D','(ΔH°3 + 2ΔH°1) > ΔH°2'
  UNION ALL SELECT @qid,'E','(2ΔH°3 + ΔH°1) = ΔH°2'
) alts WHERE @ja_existe_23b = 0;

-- Q45
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O composto pentafluoreto de nióbio, NbF5, (massa molar = 187,9 g/mol) é um catalisador para reações de polimerização. Sua síntese é feita pela reação do metal nióbio, Nb, e o gás flúor, F2, representada pela equação não balanceada:

Nb (s) + F2 (g) → NbF5 (s)

De acordo com essa reação, a quantidade de F2 que reage na preparação de 751,6 g de NbF5 é igual a','Médio','Estequiometria','1ª Série EM','SARESP','C',5,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'5 mol.' AS texto
  UNION ALL SELECT @qid,'B','8 mol.'
  UNION ALL SELECT @qid,'C','10 mol.'
  UNION ALL SELECT @qid,'D','4 mol.'
  UNION ALL SELECT @qid,'E','2 mol.'
) alts WHERE @ja_existe_23b = 0;

-- Q46
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Desde as primeiras especulações de John Dalton até os avançados experimentos de Thomson e de Ernest Rutherford, a busca por entender a natureza dos átomos tem sido um processo fascinante e gradual que resultou em modelos atômicos.

As bases da teoria atômica moderna têm a contribuição de','Fácil','Modelos atômicos','1ª Série EM','SARESP','C',5,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Dalton, que propôs átomos formados por núcleos muito pequenos, com massa e carga positiva.' AS texto
  UNION ALL SELECT @qid,'B','Thomson, que propôs átomos constituídos por uma massa negativa incrustradas por partículas com cargas positivas.'
  UNION ALL SELECT @qid,'C','Rutherford, que propôs átomos com uma região muito pequena, com massa e carga positiva, circundada por região orbitada por partículas negativas.'
  UNION ALL SELECT @qid,'D','Dalton, que propôs átomos indivisíveis, constituídos por elétrons e prótons.'
  UNION ALL SELECT @qid,'E','Thomson, que propôs átomos indivisíveis, formados por um núcleo neutro e pesado, circundado por elétrons.'
) alts WHERE @ja_existe_23b = 0;

-- Q47
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em um béquer, foi preparada uma solução saturada de brometo de amônio, NH4Br, usando-se 50 g de água destilada a 50 ºC. O conteúdo desse béquer foi transferido para um balão volumétrico e foi adicionada água destilada em temperatura ambiente, até atingir a capacidade volumétrica do balão volumétrico, que era de 100 mL.

O gráfico representa a curva de solubilidade do brometo de amônio (coeficiente de solubilidade, em g de NH4Br/100 g de H2O, em função da temperatura): a curva é crescente, passando por cerca de 60 g/100 g de H2O a 0 ºC e por 100 g/100 g de H2O a 50 ºC.

A concentração da solução de brometo de amônio no balão volumétrico é igual a','Médio','Soluções - curva de solubilidade e concentração','1ª Série EM','SARESP','B',5,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'100 g/L.' AS texto
  UNION ALL SELECT @qid,'B','500 g/L.'
  UNION ALL SELECT @qid,'C','50 g/L.'
  UNION ALL SELECT @qid,'D','10 g/L.'
  UNION ALL SELECT @qid,'E','5 g/L.'
) alts WHERE @ja_existe_23b = 0;

-- Q48
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A rotulagem do produto químico perigoso é um dos meios utilizados pelo fornecedor para transferir ao público-alvo as informações essenciais sobre os seus perigos. (ABNT NBR 14725-3:2012. Adaptado)

Uma das formas de informar os perigos de produtos químicos é o uso de pictogramas. Um deles é representado na figura: um losango com borda vermelha e fundo branco, contendo o desenho de uma chama preta sobre uma linha horizontal (pictograma de substância inflamável).

Dentre os produtos químicos que as pessoas empregam em suas residências em atividades de limpeza, o produto que informa em seu rótulo o perigo descrito no pictograma dessa figura é','Fácil','Segurança química - pictogramas','1ª Série EM','SARESP','A',5,2,NULL,TRUE
WHERE @ja_existe_23b = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o removedor, um solvente orgânico usado para limpeza e remoção de cera do piso e de graxas em equipamentos e tecidos.' AS texto
  UNION ALL SELECT @qid,'B','o ácido muriático, uma solução de ácido clorídrico usada para limpar rejunte de pisos.'
  UNION ALL SELECT @qid,'C','o desentupidor de pias e ralos, que tem a soda cáustica, usada para remover gordura de encanamentos.'
  UNION ALL SELECT @qid,'D','o sapólio, uma pasta abrasiva usada para lavar panelas de alumínio.'
  UNION ALL SELECT @qid,'E','a água sanitária, uma solução de hipoclorito de sódio usada para alvejar roupas.'
) alts WHERE @ja_existe_23b = 0;
