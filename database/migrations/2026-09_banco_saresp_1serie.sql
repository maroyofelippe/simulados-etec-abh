-- ==========================================================
--  Migração de conteúdo: Banco de questões SARESP 2025 — 1ª Série EM
--  Caderno 101-LT-CNT (Linguagens/Inglês + Ciências da Natureza), aplicação 03.11.2025
--  Fonte: prova oficial + gabarito (Fundação Vunesp) fornecidos pela coordenação.
--  ----------------------------------------------------------
--  Escopo: das 48 questões do caderno, foram importadas as 44 plenamente
--  respondíveis a partir do texto do enunciado. Ficaram de fora (não
--  cadastradas): questões 1, 13, 25 e 30 — dependem de uma imagem/gráfico/
--  figura do PDF original (meme, cartum, gráfico de velocidade e diagrama
--  do loop) que este sistema ainda não armazena por questão.
--
--  Cria também a disciplina "Língua Inglesa" (as questões 21-24 são de
--  interpretação de texto em inglês) e usa textos_apoio para os textos-base
--  compartilhados por mais de uma questão (RF07a).
--
--  Idempotente: usa uma variável de sessão travada no início (@ja_existe)
--  para decidir se o lote inteiro já foi aplicado — evita duplicar as 44
--  questões numa segunda execução, sem depender de DELIMITER/stored
--  procedures (incompatível com a execução via db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-09_banco_saresp_1serie.sql)
-- ==========================================================
SET @db := DATABASE();

-- 1) Disciplina "Língua Inglesa" ------------------------------------------
INSERT INTO disciplinas (nome, area)
SELECT 'Língua Inglesa', 'Linguagens'
WHERE NOT EXISTS (SELECT 1 FROM disciplinas WHERE nome = 'Língua Inglesa');

-- 2) Guarda travada: já aplicamos este lote antes? -------------------------
SET @ja_existe := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'Os ditados populares são frases curtas%'
);

-- ==========================================================
--  BLOCO A — Língua Portuguesa
-- ==========================================================

-- ---------- Texto de apoio: "Presente de Grego" (Márcio Cotrim) — Q02, Q03
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Presente de Grego',
'Páris, filho do rei Príamo, de Troia, rapta a belíssima Helena, esposa de Menelau, rei de Esparta. Para se vingar, Menelau forma um poderoso exército. Explode sangrento conflito, que dura dez anos.

Numas das investidas, os gregos, espertos, conseguem enganar os troianos. Como quem não quer nada, deixam à porta dos muros fortificados da cidade inimiga um enorme cavalo de madeira, o chamado Cavalo de Troia, autêntico presente de grego. Assim conta a lenda – e mostra o cinema, em filme de estrondoso sucesso.

Os ingênuos troianos, agradecidos pelo presente, abrem as portas e põem o equino para dentro. Na calada da noite, os soldados gregos, escondidos, saem do interior do cavalão e, graças ao efeito surpresa, quase sem resistência arrasam impiedosamente a cidade.

Esta é a origem da expressão presente de grego. Até hoje, muita gente também é seduzida por mimos que, na verdade, disfarçam um saco de maldades. É que o homem nunca deixou de ser o lobo do homem...
(Márcio Cotrim. O pulo do gato: o berço das palavras, 2005. Adaptado)',
1, 2
WHERE @ja_existe = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os ditados populares são frases curtas que condensam experiências de vida e conhecimentos acumulados ao longo do tempo. Um ditado popular brasileiro que teria sido de grande valia para os troianos é:','Médio','Interpretação de texto','1ª Série EM','E',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'A cavalo dado não se olha os dentes.' AS texto
  UNION ALL SELECT @qid,'B','Em terra de cego, quem tem olho é rei.'
  UNION ALL SELECT @qid,'C','Água mole em pedra dura, tanto bate até que fura.'
  UNION ALL SELECT @qid,'D','Quando um burro fala, o outro abaixa a orelha.'
  UNION ALL SELECT @qid,'E','Quando a esmola é demais, o santo desconfia.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Está empregada em sentido figurado a palavra sublinhada em','Médio','Sentido figurado','1ª Série EM','C',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"Assim conta a lenda – e mostra o cinema, em filme de estrondoso sucesso". (2º parágrafo)' AS texto
  UNION ALL SELECT @qid,'B','"Esta é a origem da expressão presente de grego". (4º parágrafo)'
  UNION ALL SELECT @qid,'C','"É que o homem nunca deixou de ser o lobo do homem". (4º parágrafo)'
  UNION ALL SELECT @qid,'D','"Na calada da noite, os soldados gregos, escondidos, saem do interior do cavalão". (3º parágrafo)'
  UNION ALL SELECT @qid,'E','"Para se vingar, Menelau forma um poderoso exército". (1º parágrafo)'
) alts WHERE @ja_existe = 0;

-- ---------- Texto de apoio: "Ondas do mare de Vigo" (Martim Codax) — Q04, Q05
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Ondas do mare de Vigo — Martim Codax',
'Ondas do mare de Vigo,
se vistes meu amigo?
E ai Deus! Se verrá cedo?

Ondas do mare levado,
se vistes meu amado?
E ai Deus! Se verrá cedo?

Se vistes meu amigo,
o por que eu sospiro?
E ai Deus! Se verrá cedo?

Se vistes meu amado,
o por que ei gran coidado!
E ai Deus! Se verrá cedo?

(Cantiga de amigo, meados do século XIII-início do século XIV. In: Segismundo Spina. Apresentação da lírica trovadoresca, 1956)',
1, 2
WHERE @ja_existe = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Nessa cantiga de amigo,','Médio','Cantiga de amigo','1ª Série EM','E',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'um eu lírico feminino ironiza o sofrimento do seu amado.' AS texto
  UNION ALL SELECT @qid,'B','um eu lírico masculino ironiza a distância de sua amada.'
  UNION ALL SELECT @qid,'C','um eu lírico masculino lamenta a partida de sua amada.'
  UNION ALL SELECT @qid,'D','um eu lírico feminino compartilha do sofrimento do amado.'
  UNION ALL SELECT @qid,'E','um eu lírico feminino lamenta a ausência do seu amado.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Do ponto de vista formal, essa cantiga caracteriza-se','Difícil','Estrutura poética medieval','1ª Série EM','C',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'pela repetição de poucas palavras e pelo emprego de rima.' AS texto
  UNION ALL SELECT @qid,'B','pela repetição de poucas palavras e pelo emprego de refrão.'
  UNION ALL SELECT @qid,'C','pela repetição de várias palavras e pelo emprego de refrão.'
  UNION ALL SELECT @qid,'D','pela repetição de várias palavras e pela ausência de rima.'
  UNION ALL SELECT @qid,'E','pela repetição de várias palavras e pela ausência de refrão.'
) alts WHERE @ja_existe = 0;

-- ---------- Texto de apoio: tirinha "As lágrimas sinceras de Júlio Gilson" (Richard Bittencourt) — Q06, Q07
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Tirinha — Richard Bittencourt, "As lágrimas sinceras de Júlio Gilson" (2023)',
'Diálogo da tirinha: Júlio Gilson, ao balcão de uma loja, diz: "Não gostei deste celular, vim devolvê-lo!". O vendedor pergunta: "Tem a nota?". Júlio Gilson responde: "Nota zero!".',
1, 2
WHERE @ja_existe = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para obter seu efeito humorístico, a tirinha explora o recurso expressivo','Médio','Recursos de humor','1ª Série EM','A',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'da ambiguidade: a presença, num texto, de palavra que pode significar coisas diferentes, admitir mais de uma leitura.' AS texto
  UNION ALL SELECT @qid,'B','do pleonasmo: a repetição desnecessária de palavras ou expressões na enunciação de uma ideia.'
  UNION ALL SELECT @qid,'C','do eufemismo: o emprego de palavra ou expressão no lugar de outra palavra ou expressão considerada desagradável ou grosseira.'
  UNION ALL SELECT @qid,'D','da antítese: a oposição, em uma mesma expressão ou frase, de duas palavras de sentido contrário.'
  UNION ALL SELECT @qid,'E','da intertextualidade: a referência que um texto faz a outro texto já existente, tomando-o como modelo ou ponto de partida.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A frase "Não gostei deste celular, vim devolvê-lo!" (1º quadrinho) pode ser reescrita, sem prejuízo para o seu sentido original, da seguinte forma:','Fácil','Reescrita de frases','1ª Série EM','B',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Não gostei deste celular, quando vim devolvê-lo!' AS texto
  UNION ALL SELECT @qid,'B','Como não gostei deste celular, vim devolvê-lo!'
  UNION ALL SELECT @qid,'C','Não gostei deste celular, mas vim devolvê-lo!'
  UNION ALL SELECT @qid,'D','Ainda não gostei deste celular, vim devolvê-lo!'
  UNION ALL SELECT @qid,'E','Não gostei deste celular, nem vim devolvê-lo!'
) alts WHERE @ja_existe = 0;

-- ---------- Texto de apoio: soneto de Gregório de Matos (1633-1696) — Q08 a Q12
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Soneto — Gregório de Matos',
'À margem de uma fonte, que corria,
Lira doce dos pássaros cantores,
A bela ocasião das minhas dores
Dormindo estava ao despertar do dia.

Mas como dorme Sílvia, não vestia
O céu seus horizontes de mil cores;
Dominava o silêncio sobre as flores,
Calava o mar, e rio não se ouvia.

Não dão o parabém à bela Aurora
Flores canoras, pássaros fragrantes,
Nem seu âmbar respira a rica Flora.

Porém abrindo Sílvia os dois diamantes,
Tudo a Sílvia festeja, e tudo a adora
Aves cheirosas, flores ressonantes.
(Gregório de Matos. Poemas atribuídos: Códice Asencio-Cunha, volume 4, 2013)

Glossário: fonte = nascente; lira = música; ocasião = razão, causa; parabém = parabéns; Aurora = personificação do nascer do dia; canoras = que cantam bem; fragrantes = cheirosos; âmbar = cor entre o castanho e o amarelo; Flora = personificação da vida vegetal; ressonantes = que ressoam, que produzem sons.',
1, 2
WHERE @ja_existe = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O soneto enquadra-se em uma conhecida vertente da poética de Gregório de Matos, a saber, sua poesia','Médio','Poesia barroca','1ª Série EM','D',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'metalinguística.' AS texto
  UNION ALL SELECT @qid,'B','político-social.'
  UNION ALL SELECT @qid,'C','satírica.'
  UNION ALL SELECT @qid,'D','lírico-amorosa.'
  UNION ALL SELECT @qid,'E','religiosa.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As dores a que eu lírico se refere na primeira estrofe do soneto são motivadas','Fácil','Interpretação de poema','1ª Série EM','C',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'pela fonte.' AS texto
  UNION ALL SELECT @qid,'B','pelo despertar do dia.'
  UNION ALL SELECT @qid,'C','por Sílvia.'
  UNION ALL SELECT @qid,'D','pelos pássaros cantores.'
  UNION ALL SELECT @qid,'E','pelo silêncio.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No soneto, os olhos de Sílvia são comparados','Fácil','Figuras de linguagem','1ª Série EM','A',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a diamantes.' AS texto
  UNION ALL SELECT @qid,'B','a pássaros.'
  UNION ALL SELECT @qid,'C','ao dia.'
  UNION ALL SELECT @qid,'D','ao céu.'
  UNION ALL SELECT @qid,'E','a flores.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O Dicionário Houaiss da Língua Portuguesa define "sinestesia" como "cruzamento de sensações; associação de palavras ou expressões em que ocorre combinação de sensações diferentes numa só impressão". Mesclam-se sensações percebidas por diferentes órgãos dos sentidos no seguinte verso:','Difícil','Sinestesia','1ª Série EM','E',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"À margem de uma fonte, que corria". (1ª estrofe)' AS texto
  UNION ALL SELECT @qid,'B','"O céu seus horizontes de mil cores". (2ª estrofe)'
  UNION ALL SELECT @qid,'C','"Dominava o silêncio sobre as flores". (2ª estrofe)'
  UNION ALL SELECT @qid,'D','"Tudo a Sílvia festeja, e tudo a adora". (4ª estrofe)'
  UNION ALL SELECT @qid,'E','"Flores canoras, pássaros fragrantes". (3ª estrofe)'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em "À margem de uma fonte, que corria," (1ª estrofe), o verbo sublinhado está empregado na acepção de','Médio','Polissemia verbal','1ª Série EM','B',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"percorrer determinada distância", como em "ela corre 5 km todos os dias".' AS texto
  UNION ALL SELECT @qid,'B','"mover-se apresentando ritmo contínuo, regular", como em "as águas correm".'
  UNION ALL SELECT @qid,'C','"dirigir-se de modo apressado", como em "ele correu à casa do amigo".'
  UNION ALL SELECT @qid,'D','"circular, tornar-se público, conhecido", como em "a notícia correu por toda a cidade".'
  UNION ALL SELECT @qid,'E','"ter continuidade no tempo; decorrer, transcorrer", como em "a manhã corria tranquila".'
) alts WHERE @ja_existe = 0;

-- ---------- Questão isolada (sem texto de apoio compartilhado): cartum Açúcar Refinado / Sal Grosso — Q14
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o cartum de Edu Francisco. No primeiro quadrinho, o personagem Açúcar Refinado, vestindo boina e cachecol, diz "Bom dia, meu caro..." ao personagem Sal Grosso, que responde "Só se for pra você!". Na construção do sentido do cartum, explorou-se','Fácil','Duplo sentido','1ª Série EM','C',1,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a grosseria no emprego da expressão "meu caro".' AS texto
  UNION ALL SELECT @qid,'B','a imprecisão da expressão "pra você".'
  UNION ALL SELECT @qid,'C','o duplo sentido dos termos "refinado" e "grosso".'
  UNION ALL SELECT @qid,'D','o bom humor dos personagens.'
  UNION ALL SELECT @qid,'E','a incoerência da expressão "só se for".'
) alts WHERE @ja_existe = 0;

-- ---------- Texto de apoio: Rashid, "Minha vida é um freestyle num beat que não para" — Q15 a Q18
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Rashid — "Minha vida é um freestyle num beat que não para"',
'Em algum momento na história, instaurou-se no imaginário popular a ideia de que a inspiração é algo mágico. Mágico e exclusivo dos artistas. Eu discordo.

É muito sedutora a possibilidade de parecer um super-herói, que tem como superpoder o dom de trazer grandiosos pensamentos do mundo das ideias e transformá-los em letras de música, que ainda por cima rimam em todos os finais de frases. Que baita herói eu seria...

Mas logo no início da minha caminhada artística, entendi duas coisas que se tornaram verdades que carrego comigo até hoje. A primeira é que sou um operário da minha arte, estou sempre trabalhando nisso, fazendo hora extra ou de plantão. Esse é um trabalho de 24 horas, depois que se veste o uniforme é difícil tirar. A segunda coisa é que ninguém me perguntou nada.

Como assim? Eu vivo de expressar meus pensamentos e opiniões sobre os acontecimentos, por livre e espontânea vontade. Pelo menos no começo, ninguém me perguntou o que eu achava das coisas para que eu saísse por aí dizendo o que penso. Eu sinto um impulso e escrevo, mas toda vez que vou trazer uma questão à tona, preciso entender que eu estou introduzindo um assunto novo nessa conversa e isso deve ser feito de uma forma sensível e sensata. Mesmo que a intenção seja chocar, o texto precisa ter um corpo para que aquilo seja um argumento.
(Rashid. "Minha vida é um freestyle num beat que não para", Antologia inspirada no universo da Mixtape: Pra quem já mordeu um cachorro por comida, até que eu cheguei longe, 2021)',
1, 2
WHERE @ja_existe = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Quando escreve suas letras de música, o autor tem a preocupação de','Médio','Interpretação de texto','1ª Série EM','D',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'alcançar pessoas sensíveis aos problemas sociais.' AS texto
  UNION ALL SELECT @qid,'B','oferecer respostas às questões do público.'
  UNION ALL SELECT @qid,'C','evitar assuntos incômodos ao público.'
  UNION ALL SELECT @qid,'D','expressar seus pontos de vista com sensatez.'
  UNION ALL SELECT @qid,'E','fazer bom uso da inspiração típica dos artistas.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A passagem do 3º parágrafo "sou um operário da minha arte" apresenta linguagem','Difícil','Linguagem conotativa e denotativa','1ª Série EM','E',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'conotativa e indica que o autor tem dificuldades financeiras por ser artista.' AS texto
  UNION ALL SELECT @qid,'B','denotativa e indica que o autor não encontra tempo livre para escrever.'
  UNION ALL SELECT @qid,'C','conotativa e indica que o autor lamenta a falta de valorização de seu trabalho.'
  UNION ALL SELECT @qid,'D','denotativa e indica que o autor exerce suas atividades em condições inadequadas.'
  UNION ALL SELECT @qid,'E','conotativa e indica que o autor considera o trabalho a base de sua escrita.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Identifica-se marca de linguagem coloquial em','Médio','Registro de linguagem','1ª Série EM','A',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"Que baita herói eu seria". (2º parágrafo)' AS texto
  UNION ALL SELECT @qid,'B','"É muito sedutora a possibilidade". (2º parágrafo)'
  UNION ALL SELECT @qid,'C','"instaurou-se no imaginário popular a ideia". (1º parágrafo)'
  UNION ALL SELECT @qid,'D','"transformá-los em letras de música". (2º parágrafo)'
  UNION ALL SELECT @qid,'E','"estou introduzindo um assunto novo". (4º parágrafo)'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na passagem do 4º parágrafo "Mesmo que a intenção seja chocar, o texto precisa ter um corpo", a expressão destacada pode ser corretamente substituída por','Fácil','Conectivos','1ª Série EM','B',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'desde que.' AS texto
  UNION ALL SELECT @qid,'B','ainda que.'
  UNION ALL SELECT @qid,'C','a fim de que.'
  UNION ALL SELECT @qid,'D','de modo que.'
  UNION ALL SELECT @qid,'E','já que.'
) alts WHERE @ja_existe = 0;

-- ---------- Texto de apoio: cartazes sobre economia de água — Q19, Q20
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Texto I e Texto II — cartazes sobre economia de água',
'Texto I: cartaz com a frase "SAVE WATER, SAVE NATURE", ilustrando o planeta Terra com uma torneira. (https://www.youtube.com/. Acesso em 20.06.2025)
Texto II: cartaz com a frase "SHORTEN YOUR SHOWER TIME", ilustrando uma pessoa tomando banho. (https://mediamodifier.com/. Acesso em 20.06.2025)',
1, 2
WHERE @ja_existe = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O conteúdo dos dois textos apresenta uma preocupação com o','Fácil','Interpretação de imagem/texto','1ª Série EM','C',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'risco de aumento de temperatura das águas.' AS texto
  UNION ALL SELECT @qid,'B','impacto do excesso de água sobre a vegetação.'
  UNION ALL SELECT @qid,'C','desperdício de água doce pelos humanos.'
  UNION ALL SELECT @qid,'D','aumento do nível dos oceanos na Terra.'
  UNION ALL SELECT @qid,'E','perigo de secas e enchentes no Brasil.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O texto II, em relação ao texto I, apresenta','Médio','Relação entre textos','1ª Série EM','B',1,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'uma alternativa para a recomendação de plantar árvores.' AS texto
  UNION ALL SELECT @qid,'B','um exemplo prático de como economizar água.'
  UNION ALL SELECT @qid,'C','um conflito entre o uso racional da água e a preservação da natureza.'
  UNION ALL SELECT @qid,'D','um alerta para a utilização da água para regar a vegetação.'
  UNION ALL SELECT @qid,'E','um incentivo para consertar vazamentos antigos de torneiras.'
) alts WHERE @ja_existe = 0;

-- ==========================================================
--  BLOCO B — Língua Inglesa
-- ==========================================================

-- ---------- Texto de apoio: "Artificial intelligence (AI) and education" — Q21, Q22
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Artificial intelligence (AI) and education',
'We''re still learning how Artificial Intelligence (AI) technologies will integrate into the education sector as they develop, and we don''t yet have a full picture of how AI will affect some critical issues. Before we dive into AI''s function in the education space, let''s define this technology in general terms. Artificial intelligence allows machines to execute tasks that have traditionally required human cognition. They can make decisions, solve problems, understand and mimic natural language and learn from free data.

OpenAI''s release of ChatGPT — a natural language processing chatbot — in the fall of 2022 brought AI to many people''s attention for the first time. However, AI tools have been part of our lives for years. If you''ve ever played chess against a bot, consulted a virtual assistant like Siri or Alexa or even gone through your social media feed, you''ve already interacted with artificial intelligence.
(https://www.forbes.com/. Acesso em 26.06.2025. Adaptado)',
(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'), 2
WHERE @ja_existe = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'De acordo com o texto, é possível afirmar que Inteligência Artificial','Médio','Reading comprehension - IA','1ª Série EM','D',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'precisa ser incorporada imediatamente às atividades cotidianas e escolares.' AS texto
  UNION ALL SELECT @qid,'B','deve ser testada no dia a dia antes de ser usada na educação.'
  UNION ALL SELECT @qid,'C','poderá ser usada na escola em um futuro remoto após legislação pertinente.'
  UNION ALL SELECT @qid,'D','tem sido usada em ferramentas anteriores ao ChatGPT.'
  UNION ALL SELECT @qid,'E','foi apresentada ao público pela primeira vez em 2022.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O primeiro parágrafo do texto','Médio','Reading comprehension - estrutura textual','1ª Série EM','E',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'apresenta exemplos concretos de uso da IA na educação e em outros campos.' AS texto
  UNION ALL SELECT @qid,'B','mostra casos bem-sucedidos de substituição de professores por IA na escola.'
  UNION ALL SELECT @qid,'C','aponta a função de tecnologias de IA desenvolvidas para uso em sala de aula.'
  UNION ALL SELECT @qid,'D','menciona algumas tarefas que devem ser desempenhadas apenas por seres humanos.'
  UNION ALL SELECT @qid,'E','reconhece a incerteza quanto ao uso de tecnologias de IA na educação.'
) alts WHERE @ja_existe = 0;

-- ---------- Questão isolada: manchete do NYT sobre Sam Altman — Q23
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o título de uma notícia sobre o ChatGPT publicada no jornal The New York Times: "Sam Altman, the chatgpt king, isn''t worried, but he knows you might be" (https://www.nytimes.com/. Acesso em 20.06.25. Adaptado). O título sugere que Sam Altman, um dos desenvolvedores da ferramenta mencionada,','Difícil','Reading comprehension - manchete','1ª Série EM','A',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'reconhece que algumas pessoas poderiam se preocupar com as possibilidades criadas por essa ferramenta.' AS texto
  UNION ALL SELECT @qid,'B','pensa que algumas pessoas têm razão de se preocupar com os efeitos do uso dessa ferramenta.'
  UNION ALL SELECT @qid,'C','não consegue compreender porque algumas pessoas imaginam que há problemas com a ferramenta.'
  UNION ALL SELECT @qid,'D','recomenda que as pessoas se preocupem com algumas possibilidades criadas pelo ChatGPT.'
  UNION ALL SELECT @qid,'E','acredita que o ChatGPT seja a mais avançada ferramenta de IA que o homem poderá criar.'
) alts WHERE @ja_existe = 0;

-- ---------- Questão isolada: tirinha Peanuts (Joe DiMaggio) — Q24
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a tirinha (Peanuts, adaptado, https://www.gocomics.com/peanuts/2025/07/31). No 1º quadrinho, o menino diz: "Joe DiMaggio* never complained about playing ball on a hot day!". No 2º quadrinho, ele responde a uma pergunta da menina dizendo: "One of the greatest baseball players who ever lived, that''s who!". No 3º quadrinho, a menina diz: "I thought he just drank coffee". *Joe DiMaggio – grande astro do baseball americano de meados do Século XX e garoto propaganda de marca de famosa cafeteira elétrica. Considerando o contexto da tirinha, a pergunta feita pela menina no balão no segundo quadrinho é:','Médio','Reading comprehension - tirinha','1ª Série EM','B',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'What do you mean by that?' AS texto
  UNION ALL SELECT @qid,'B','Who was Joe Di Maggio?'
  UNION ALL SELECT @qid,'C','What ball?'
  UNION ALL SELECT @qid,'D','Did he play baseball?'
  UNION ALL SELECT @qid,'E','Was he good?'
) alts WHERE @ja_existe = 0;

-- ==========================================================
--  BLOCO C — Física
-- ==========================================================

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As formigas da espécie Odontomachus bauri, mais conhecidas como formigas-de-estalo, fecham suas mandíbulas com extrema rapidez, a uma velocidade 2,3 mil vezes maior que a do piscar de um olho. As mandíbulas dessas formigas são capazes de desferirem mordidas poderosas contra suas presas, com uma força 300 vezes maior que seu próprio peso. Além de usar essa capacidade para captura de suas presas, em uma situação de perigo, essas formigas fecham suas mandíbulas contra uma superfície dura, e o impacto de suas mandíbulas nessa superfície lança a formiga para cima, em um breve voo, que despista seu predador. (https://www.bbc.com. Acesso em 03.08.2025. Adaptado) Ao morder algo duro como o chão, a formiga de estalo é arremessada para cima devido','Médio','Leis de Newton','1ª Série EM','C',4,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ao chão como referencial inercial.' AS texto
  UNION ALL SELECT @qid,'B','à primeira Lei de Newton.'
  UNION ALL SELECT @qid,'C','ao princípio da ação e reação.'
  UNION ALL SELECT @qid,'D','à inércia do chão.'
  UNION ALL SELECT @qid,'E','à Lei da Gravitação Universal.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para realizar obras de manutenção em uma estrada de mão dupla, o trânsito de veículos em um trecho de 1000 m de extensão precisa ser limitado a uma faixa e implantado um esquema de interrupção de tráfego. Dessa forma, uma fila de carros é mantida em espera em um dos extremos do trecho, enquanto, no outro extremo, outra fila de carros inicia sua travessia, movimentando-se com velocidade constante de 20 m/s. O tempo total para entrada e travessia do trecho de 1000 m é limitado a 120 s. Depois desse intervalo de tempo, os carros que aguardam do outro lado são liberados e iniciam sua travessia, tendo igualmente 120 s. O ciclo é então repetido indefinidamente. Considerando que cada carro em movimento dentro da fila tem resguardado 40 m de extensão de fila, qual é o número máximo de carros que atravessam o trecho em obras, em cada intervalo de liberação de filas?','Difícil','Cinemática','1ª Série EM','E',4,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'105' AS texto
  UNION ALL SELECT @qid,'B','9'
  UNION ALL SELECT @qid,'C','23'
  UNION ALL SELECT @qid,'D','190'
  UNION ALL SELECT @qid,'E','35'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma cena icônica da série Friends envolve a tentativa fracassada dos personagens subirem um sofá pela escada. Com um pouco de conhecimento físico, uma roldana fixa e uma corda, os três amigos poderiam resolver o problema por meio do içamento do sofá pelo lado externo do prédio. Adotando g = 10 m/s², considerando que o sistema corda-roldana é ideal, sabendo que a massa do sofá é de 65 kg e supondo que ele é içado com aceleração constante e igual a 0,2 m/s², se cada amigo individualmente exerce uma força de igual intensidade sobre o extremo livre da corda, a intensidade dessa força individual é de','Difícil','Dinâmica - roldanas','1ª Série EM','D',4,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'715 N.' AS texto
  UNION ALL SELECT @qid,'B','650 N.'
  UNION ALL SELECT @qid,'C','130 N.'
  UNION ALL SELECT @qid,'D','221 N.'
  UNION ALL SELECT @qid,'E','438 N.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em 2024, em média, dois novos prédios foram construídos por dia na cidade de São Paulo, e a expansão vertical da cidade permanece. Por isso, é comum observar gruas, guindastes montados sobre uma torre metálica fixa ao solo, espalhadas pela cidade. Em um canteiro de obras, uma grua ergue simultaneamente 50 vigas de aço de 110 kg cada uma. As vigas são transportadas verticalmente com velocidade constante, por uma altura de 60 m, medida do chão da obra até o topo do prédio em construção. Sendo o valor da aceleração da gravidade igual a 10 m/s², ao longo desse deslocamento, o valor absoluto do trabalho realizado pelo peso das vigas é de','Médio','Trabalho e energia','1ª Série EM','B',4,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'3,0 x 10^5 J.' AS texto
  UNION ALL SELECT @qid,'B','3,3 x 10^6 J.'
  UNION ALL SELECT @qid,'C','5,5 x 10^4 J.'
  UNION ALL SELECT @qid,'D','6,6 x 10^4 J.'
  UNION ALL SELECT @qid,'E','6,0 x 10^5 J.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Às vezes, fazemos perguntas que parecem triviais, mas que se tornam interessantes graças à fonte das respostas. Se feitas a um físico, perguntas como: você se sente atraído por outra pessoa? ou você é atraente? serão respondidas afirmativamente. Graças à gravidade que atua entre as coisas e é universal, todo objeto que tem massa tem também a sua própria força gravitacional. Então, estamos todos atraindo e sendo atraídos o tempo todo. (https://www.bbc.com. Acesso em 03.08.2025. Adaptado) Conforme explica a reportagem, podemos usar a lei da gravidade de Newton para calcular a atração gravitacional entre quaisquer dois objetos, inclusive entre duas pessoas aqui na Terra. Apesar de a intensidade dessa força ser muito pequena, não há dúvidas de que ela será maior quanto','Médio','Gravitação universal','1ª Série EM','A',4,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'menor a distância entre as pessoas.' AS texto
  UNION ALL SELECT @qid,'B','mais próximas as pessoas estiverem da Terra.'
  UNION ALL SELECT @qid,'C','menor a massa das pessoas.'
  UNION ALL SELECT @qid,'D','mais distantes as pessoas estiverem da Terra.'
  UNION ALL SELECT @qid,'E','maior a distância entre as pessoas.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Construído em 1906, o aqueduto de Juazeiro, no norte da Bahia, é o único no Brasil ainda em funcionamento como originalmente concebido. A estrutura, em estilo barroco neoclássico, foi projetada para transportar água do rio São Francisco e abastecer o Departamento de Tecnologia e Ciências Sociais da Universidade do Estado da Bahia – Uneb, localizada na cidade. O aqueduto de Juazeiro está a 7 m de altura entre o local de retirada de água e o local de destino. Ele é composto por canais que conduzem a água sobre arcos e pilares construídos com uma leve inclinação que garante o fluxo contínuo e sem perdas. Considerando que a aceleração da gravidade é igual a 10 m/s² e que o sistema é conservativo, o ganho de energia cinética que uma massa de 300 kg de água terá ao ser transportada pelo aqueduto será de','Médio','Energia cinética','1ª Série EM','C',4,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'35 kJ.' AS texto
  UNION ALL SELECT @qid,'B','70 kJ.'
  UNION ALL SELECT @qid,'C','21 kJ.'
  UNION ALL SELECT @qid,'D','56 kJ.'
  UNION ALL SELECT @qid,'E','14 kJ.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o trecho de uma reportagem científica: "Pesquisadores da Universidade de Michigan, nos Estados Unidos, desenvolveram uma célula solar que combina alta eficiência, transparência e possibilidade de reciclagem. O novo dispositivo é feito com materiais que permitem sua separação em componentes reutilizáveis, por meio de um processo que utiliza vapor de água a 85 ºC. Embora ainda esteja em fase experimental, o avanço representa um passo promissor para tornar as tecnologias fotovoltaicas mais sustentáveis e de menor impacto ambiental." (https://revistapesquisa.fapesp.br/. Acesso em 15.09.2025) De acordo com o excerto, o desenvolvimento dessa nova célula solar está relacionado','Fácil','Tecnologia e sustentabilidade','1ª Série EM','A',4,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à nova tecnologia, que alia eficiência energética à sustentabilidade, com potencial de reaproveitamento de materiais.' AS texto
  UNION ALL SELECT @qid,'B','ao aumento significativo da produção de energia elétrica em larga escala, sem necessidade de radiação solar direta.'
  UNION ALL SELECT @qid,'C','à substituição total de painéis solares convencionais por novos materiais de baixo custo, já disponíveis no mercado.'
  UNION ALL SELECT @qid,'D','à aplicação imediata em sistemas comerciais e industriais devido à alta durabilidade e à resistência à água.'
  UNION ALL SELECT @qid,'E','à fabricação de células solares mais leves e versáteis, com uso restrito às propriedades industriais e rurais.'
) alts WHERE @ja_existe = 0;

-- ==========================================================
--  BLOCO D — Química
-- ==========================================================

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em junho de 2025, um vazamento de óleo diesel atingiu o rio Ribeira de Iguape, na divisa entre os estados de São Paulo e Paraná. A situação causou alerta em diversas cidades devido ao risco de contaminação da água e morte de peixes. Considere a tabela a seguir com algumas propriedades da água e do óleo diesel: Água — Densidade 1,0 g/mL, Polaridade polar. Óleo diesel — Densidade 0,85 g/mL, Polaridade não polar. Com base nessas informações, é correto afirmar que o vazamento de óleo prejudica o ambiente aquático porque o óleo','Fácil','Densidade e polaridade','1ª Série EM','A',5,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'flutua na superfície da água e dificulta a entrada de oxigênio no ecossistema.' AS texto
  UNION ALL SELECT @qid,'B','reage rapidamente com a água e forma produtos venenosos para os peixes.'
  UNION ALL SELECT @qid,'C','mistura-se com a água e dificulta a movimentação dos peixes.'
  UNION ALL SELECT @qid,'D','deposita-se no fundo do rio e afeta os nutrientes essenciais ao ecossistema.'
  UNION ALL SELECT @qid,'E','dissolve-se lentamente na água e reduz a quantidade de luz absorvida pelas algas.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O Brasil inspira o mundo nas estratégias de produção de alumínio metálico (Al) de forma sustentável e menos poluente. O alumínio é produzido a partir do seu minério, a bauxita, que contém alumina (Al2O3). A eletrólise da alumina com eletrodos de carbono (C), denominado coque, resulta no alumínio metálico e no gás dióxido de carbono (CO2). A equação dessa reação é representada a seguir: 2Al2O3 + 3C → 4Al + 3CO2. Na reação de obtenção do alumínio metálico, as substâncias simples são','Médio','Substâncias simples e compostas','1ª Série EM','B',5,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'carbono e dióxido de carbono.' AS texto
  UNION ALL SELECT @qid,'B','carbono e alumínio.'
  UNION ALL SELECT @qid,'C','alumina e alumínio.'
  UNION ALL SELECT @qid,'D','alumina e dióxido de carbono.'
  UNION ALL SELECT @qid,'E','carbono e alumina.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Megaoperação da Companhia Ambiental do Estado de São Paulo (Cetesb) fiscaliza mais de 34 mil veículos a diesel em SP. Ação contra poluição veicular resultou em mais de 400 autuações; operação Fumaça Preta segue até setembro, período em que a dispersão de poluentes na atmosfera é menor. (https://www.agenciasp.sp.gov.br/. Acesso em 09.08.2025. Adaptado) A fumaça escura emitida do escapamento dos veículos pesados movidos a diesel é resultado da combustão','Médio','Combustão','1ª Série EM','E',5,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'incompleta do combustível, que libera CO2 gasoso e vapor de água (H2O).' AS texto
  UNION ALL SELECT @qid,'B','completa do combustível, que libera CO2 gasoso, C sólido, CO gasoso e vapor de água (H2O).'
  UNION ALL SELECT @qid,'C','completa do combustível, que libera CO2 gasoso e vapor de água (H2O).'
  UNION ALL SELECT @qid,'D','completa do combustível, que libera C sólido e vapor de água (H2O).'
  UNION ALL SELECT @qid,'E','incompleta do combustível, que libera CO2 gasoso, C sólido, CO gasoso e vapor de água (H2O).'
) alts WHERE @ja_existe = 0;

-- ---------- Texto de apoio: cloreto de magnésio — Q36, Q37
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Cloreto de magnésio — produção e uso farmacêutico',
'O Brasil produz cloreto de magnésio a partir da água do mar, em tanques onde a solução aquosa desse composto é separada e o composto sólido é obtido. O cloreto de magnésio é empregado na indústria farmacêutica, de alimentos e de cosméticos. É formado pelos íons Mg2+ e Cl–. Na forma de medicamento, é vendido em sachês contendo 33 g do composto. O conteúdo do sachê deve ser dissolvido em água até o volume de 1 L. O paciente deve tomar 60 mL dessa solução por dia. (https://www.buschle.com.br/pt/bel-mag. Acesso em 09.08.2025)',
5, 2
WHERE @ja_existe = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O magnésio pertence ao grupo dos metais ______ na tabela periódica. Para formar o íon magnésio, o átomo de magnésio ______ 2 elétrons. A fórmula unitária do cloreto de magnésio é ______. As lacunas devem ser preenchidas, correta e respectivamente, por:','Médio','Ligações iônicas','1ª Série EM','D',5,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'alcalinoterrosos ... ganha ... Mg2Cl' AS texto
  UNION ALL SELECT @qid,'B','alcalinos ... ganha ... Mg2Cl'
  UNION ALL SELECT @qid,'C','alcalinoterrosos ... perde ... Mg2Cl'
  UNION ALL SELECT @qid,'D','alcalinoterrosos ... perde ... MgCl2'
  UNION ALL SELECT @qid,'E','alcalinos ... perde ... MgCl2'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considerando que 1 L contém 1000 mL, a massa de cloreto de magnésio contida na dose diária da solução de cloreto de magnésio, preparada seguindo a indicação do sachê de 33 g dissolvido em 1 L de água, com dose diária de 60 mL, é de aproximadamente','Difícil','Concentração de soluções','1ª Série EM','B',5,2,@tid,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'60 g.' AS texto
  UNION ALL SELECT @qid,'B','2 g.'
  UNION ALL SELECT @qid,'C','20 g.'
  UNION ALL SELECT @qid,'D','6 g.'
  UNION ALL SELECT @qid,'E','3 g.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Muitas árvores da Floresta Amazônica atingem cerca de 50 m de altura. A estabilidade mecânica e estrutural das árvores vem das interações entre as moléculas que compõem a celulose, uma macromolécula formada por moléculas de glicose. Essas macromoléculas se organizam de forma a conferir resistência e rigidez ao tronco e aos galhos. Presente na maior parte dos seres vivos, a glicose é formada pelos elementos carbono, hidrogênio e oxigênio (fórmula estrutural em cadeia aberta: CHO—H-C-OH—HO-C-H—H-C-OH—H-C-OH—CH2OH). A tabela a seguir apresenta os valores da eletronegatividade de Pauling para os átomos que compõem a glicose: Carbono (C) = 2,6; Hidrogênio (H) = 2,2; Oxigênio (O) = 3,4. Na celulose, a força intermolecular mais intensa é a','Médio','Forças intermoleculares','1ª Série EM','C',5,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'interação de dipolo momentâneo.' AS texto
  UNION ALL SELECT @qid,'B','interação de dipolo induzido.'
  UNION ALL SELECT @qid,'C','ligação de hidrogênio.'
  UNION ALL SELECT @qid,'D','interação íon-dipolo.'
  UNION ALL SELECT @qid,'E','ligação iônica.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O nitreto de silício (Si3N4) é uma cerâmica avançada com alta dureza, resistência térmica e estabilidade química. É amplamente usada em microeletrônica e rolamentos, sendo empregada em componentes dos motores de veículos elétricos. Uma das rotas de síntese do nitreto de silício é feita pela reação, sob condições específicas, do silício (Si) e amônia (NH3), representada na equação a seguir: 3Si (s) + 4NH3 (g) → Si3N4 (s) + 6H2 (g). Ao serem misturados, nas condições de reação, 12 mol de silício e 12 mol de amônia, a quantidade de nitreto de silício formada e a quantidade de reagente em excesso são, respectivamente,','Difícil','Estequiometria','1ª Série EM','E',5,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'12 mol de Si3N4 e 3 mol de Si.' AS texto
  UNION ALL SELECT @qid,'B','4 mol de Si3N4 e 3 mol de NH3.'
  UNION ALL SELECT @qid,'C','12 mol de Si3N4 e 4 mol de NH3.'
  UNION ALL SELECT @qid,'D','3 mol de Si3N4 e 4 mol de Si.'
  UNION ALL SELECT @qid,'E','3 mol de Si3N4 e 3 mol de Si.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Durante uma aula a respeito dos ciclos biogeoquímicos, os alunos discutiram a transformação de compostos nitrogenados realizada por bactérias presentes no solo. Uma das etapas envolve a formação de amônia (NH3), que se dissipa no solo e na água em ambientes ricos em matéria orgânica. Na presença de água, a amônia interage de acordo com a equação a seguir: NH3 (g) + H2O (l) → NH4(OH) (aq). A amônia formada no ciclo biogeoquímico do nitrogênio','Médio','Reações ácido-base','1ª Série EM','E',5,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'reage com a água, formando um óxido que se dissolve no solo e diminui o seu pH.' AS texto
  UNION ALL SELECT @qid,'B','comporta-se como um ácido fraco e reage com as bases fracas neutralizando o solo.'
  UNION ALL SELECT @qid,'C','comporta-se como ácido forte, contribuindo para a acidificação natural do solo.'
  UNION ALL SELECT @qid,'D','transforma-se em um sólido que se acumula como depósito mineral insolúvel.'
  UNION ALL SELECT @qid,'E','reage com a água, formando soluções de caráter básico que aumentam o pH do solo.'
) alts WHERE @ja_existe = 0;

-- ==========================================================
--  BLOCO E — Biologia
-- ==========================================================

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Pesquisas realizadas na Mata Atlântica e no Cerrado revelam que formigas desempenham um papel essencial na regeneração de áreas florestais degradadas. Os formigueiros, ricos em nutrientes, tornam-se locais ideais para o desenvolvimento das plantas. Além disso, as formigas contribuem para a dispersão direcionada de sementes (dispersão secundária: as formigas limpam os frutos caídos e transportam as sementes até o formigueiro), aumentando a diversidade e a chance de sobrevivência das plantas jovens ao longo do tempo, especialmente nos estágios iniciais da sucessão ecológica. (https://revistapesquisa.fapesp.br/. Acesso em 23.07.2025. Adaptado) O papel das formigas, numa sucessão ecológica, é','Médio','Sucessão ecológica','1ª Série EM','A',3,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'contribuir com o processo de colonização ao favorecer a germinação de sementes em ambientes já degradados.' AS texto
  UNION ALL SELECT @qid,'B','reduzir a velocidade de transformação desse processo, pois elas consomem sementes e impedem sua germinação.'
  UNION ALL SELECT @qid,'C','transportar as sementes em ambientes de rocha nua, onde não há solo e nem matéria orgânica.'
  UNION ALL SELECT @qid,'D','transportar as sementes que não conseguem germinar até os formigueiros que são locais secos e pobres.'
  UNION ALL SELECT @qid,'E','substituir de forma integral o papel do vento, aves e mamíferos na dispersão inicial de sementes.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a manchete de uma notícia: "Fenômeno raro deixa o mar de praia em Ubatuba \'brilhando no escuro\'" (https://nautica.com.br/. Acesso em 25.07.2025. Adaptado). Esse fenômeno é denominado de bioluminescência e ocorre porque alguns organismos unicelulares, como algas, convertem moléculas de ATP, obtidas a partir da glicose, em luz. Essa emissão luminosa é um exemplo de atividade metabólica celular que depende diretamente da liberação controlada de energia. A bioluminescência observada depende diretamente da','Médio','Bioluminescência e respiração celular','1ª Série EM','D',3,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'fotossíntese, que transforma luz solar em energia luminosa utilizada pelas células para produzir luz.' AS texto
  UNION ALL SELECT @qid,'B','fermentação, que ocorre na presença de oxigênio e libera grandes quantidades de energia.'
  UNION ALL SELECT @qid,'C','respiração celular, que consome gás carbônico e água para gerar moléculas de glicose.'
  UNION ALL SELECT @qid,'D','respiração celular, que converte a energia de moléculas orgânicas de glicose em energia química na forma de ATP.'
  UNION ALL SELECT @qid,'E','fermentação intracelular, responsável pela quebra de partículas sólidas fagocitadas que liberam luz e energia.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Doenças metabólicas são desordens associadas à forma como o organismo processa as proteínas, os carboidratos e as gorduras dos alimentos. No enfrentamento dessas doenças, surge uma nova classe de medicamentos que ganhou notoriedade no controle da obesidade: são análogos sintéticos do GLP-1, como liraglutida e semaglutida, que imitam os efeitos do peptídeo natural. O GLP-1 é produzido naturalmente no intestino e, em menor quantidade, no cérebro logo após as refeições. Ele estimula a secreção de insulina, retarda o esvaziamento gástrico e ativa centros de saciedade no cérebro. Os medicamentos análogos sintéticos do GLP-1 interagem diretamente com os sistemas','Médio','Sistemas do corpo humano','1ª Série EM','B',3,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'circulatório, digestório e excretor.' AS texto
  UNION ALL SELECT @qid,'B','endócrino, nervoso e digestório.'
  UNION ALL SELECT @qid,'C','endócrino, nervoso e muscular.'
  UNION ALL SELECT @qid,'D','digestório, nervoso e respiratório.'
  UNION ALL SELECT @qid,'E','endócrino, tegumentar e nervoso.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma fazenda aplicou, a cada ano, grandes quantidades de fertilizantes nitrogenados sintéticos para maximizar sua produtividade agrícola. A fim de enriquecer o solo, que é naturalmente pobre em nitrogênio, o proprietário também cultivou leguminosas entre as safras. Apesar da alta produtividade, essa prática causou impactos em um curso d''água próximo. Análises de água revelaram um aumento na proliferação de algas e queda nos níveis de oxigênio dissolvido. Além disso, os moradores locais relataram um odor forte das águas e morte de peixes. De acordo com o ciclo do nitrogênio,','Médio','Ciclo do nitrogênio','1ª Série EM','A',3,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a utilização de fertilizantes sintéticos aumenta o aporte de nitrogênio reativo no solo, que pode ser lixiviado até corpos d''água, resultando na eutrofização.' AS texto
  UNION ALL SELECT @qid,'B','as leguminosas plantadas entre as safras competem com as bactérias nitrificantes do solo, dificultando a ciclagem do nitrogênio.'
  UNION ALL SELECT @qid,'C','a morte dos peixes no curso d''água está relacionada à escassez de nitrogênio, que provoca a proliferação de algas nos corpos d''água.'
  UNION ALL SELECT @qid,'D','o uso excessivo de fertilizantes industriais elimina as bactérias fixadoras presentes nas raízes das leguminosas.'
  UNION ALL SELECT @qid,'E','as leguminosas possuem nas raízes bactérias capazes de transformar o nitrato em amônia que é carreada para o curso d''água pelas chuvas.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT '"Nada em biologia faz sentido exceto à luz da evolução." Essa ideia, popularizada pelo geneticista Theodosius Dobzhansky (1973), baseia-se na teoria da evolução por seleção natural, um pilar da ciência moderna. A evolução biológica não é uma hipótese, mas um fato científico sustentado por mais de 160 anos de evidências, como fósseis, genética e biologia molecular. Todos esses dados confirmam que as espécies compartilham uma ancestralidade comum e que a seleção natural age sobre as variações genéticas, moldando a vida no planeta. O referido geneticista forneceu bases para a Teoria Sintética da Evolução, a qual','Difícil','Teoria da evolução','1ª Série EM','C',3,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'preconiza que a variação genética não é aleatória, enquanto a seleção natural ocorre ao acaso, seguindo as leis da genética mendeliana.' AS texto
  UNION ALL SELECT @qid,'B','propõe que mudanças ambientais, como o surgimento de barreiras geográficas, induzem a mutações genéticas específicas as quais moldam características úteis, transmitidas posteriormente diretamente à prole.'
  UNION ALL SELECT @qid,'C','integra as leis de hereditariedade de Mendel ao modelo darwiniano para explicar de forma abrangente a origem de novas características e sua propagação nas populações.'
  UNION ALL SELECT @qid,'D','demonstra que a variação genética é essencial para a evolução adaptativa e que as origens de estruturas anatômicas corroboram a ideia de herança de caracteres adquiridos.'
  UNION ALL SELECT @qid,'E','sustenta que a seleção natural é responsável por induzir novas mutações favoráveis ao longo das gerações, através do isolamento reprodutivo e da reprodução sexuada.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Cientistas brasileiros do Centro de Pesquisa para Inovação em Gases de Efeito Estufa estão desenvolvendo tecnologias para transformar o dióxido de carbono (CO2) capturado da atmosfera e de usinas de etanol em combustíveis renováveis, como o metanol. Esse avanço tecnológico tem como objetivo reduzir a quantidade de gases do efeito estufa na atmosfera, mitigando os impactos das mudanças climáticas. (https://revistapesquisa.fapesp.br/. Acesso em 30.08.2025. Adaptado) O processo descrito possui um paralelo com um processo biológico fundamental para a vida no planeta, que converte um composto inorgânico em matéria orgânica. Esse processo é similar','Médio','Fotossíntese e quimiossíntese','1ª Série EM','A',3,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à fotossíntese, pois é o processo de conversão de dióxido de carbono e água em glicose, utilizando uma fonte de energia externa.' AS texto
  UNION ALL SELECT @qid,'B','ao catabolismo, pois se refere à quebra de moléculas complexas para a obtenção de energia.'
  UNION ALL SELECT @qid,'C','à quimiossíntese, pois é a produção de matéria orgânica a partir da oxidação de substâncias orgânicas como dióxido de carbono.'
  UNION ALL SELECT @qid,'D','à respiração celular, pois é o processo de liberação de CO2 para a obtenção de energia.'
  UNION ALL SELECT @qid,'E','à fermentação, pois é um processo de obtenção de energia na ausência de oxigênio.'
) alts WHERE @ja_existe = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise a descrição a seguir sobre órgãos respiratórios de vertebrados. O ar, quando entra no organismo, atinge os bronquíolos e chega aos alvéolos pulmonares, unidades que realizam as trocas gasosas por difusão simples. Para ocorrer a ventilação pulmonar, o músculo diafragma e os músculos intercostais precisam entrar em atividade, contraindo e relaxando, permitindo a entrada ou a saída do ar nos pulmões. A descrição apresentada refere-se à fisiologia respiratória que ocorre nos','Fácil','Fisiologia respiratória','1ª Série EM','E',3,2,NULL,TRUE
WHERE @ja_existe = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'peixes pulmonados.' AS texto
  UNION ALL SELECT @qid,'B','anfíbios.'
  UNION ALL SELECT @qid,'C','répteis.'
  UNION ALL SELECT @qid,'D','aves.'
  UNION ALL SELECT @qid,'E','mamíferos.'
) alts WHERE @ja_existe = 0;
