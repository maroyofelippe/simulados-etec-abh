-- ==========================================================
--  Migração de conteúdo: Banco de questões SARESP 2024 — 2ª Série EM
--  Caderno 201-LT-CNT (Linguagens/Inglês + Ciências da Natureza), aplicação 11.11.2024
--  Fonte: prova oficial + gabarito (Fundação Vunesp) fornecidos pela coordenação.
--  ----------------------------------------------------------
--  Escopo: das 48 questões do caderno, foram importadas as 46 plenamente
--  respondíveis a partir do texto do enunciado. Ficaram de fora (não
--  cadastradas): questão 11 (compara a composição verbal/não verbal de
--  uma campanha e de uma charge — depende da leitura visual da charge) e
--  questão 27 (leitura de valores num gráfico tensão×tempo) — dependem de
--  uma imagem/gráfico que este sistema ainda não armazena por questão.
--
--  Reaproveita a disciplina "Língua Inglesa" já criada pela migração
--  2026-09_banco_saresp_1serie.sql. Usa textos_apoio para os textos-base
--  compartilhados por mais de uma questão (RF07a).
--
--  Idempotente: mesma técnica das migrações anteriores — variável de
--  sessão travada no início (@ja_existe_24), sem DELIMITER/stored
--  procedures (incompatível com a execução via db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-09_banco_saresp2024_2serie.sql)
-- ==========================================================
SET @db := DATABASE();

-- Garante que a disciplina "Língua Inglesa" existe (idempotente)
INSERT INTO disciplinas (nome, area)
SELECT 'Língua Inglesa', 'Linguagens'
WHERE NOT EXISTS (SELECT 1 FROM disciplinas WHERE nome = 'Língua Inglesa');

-- Guarda travada: já aplicamos este lote antes?
SET @ja_existe_24 := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'No texto, as palavras%'
);

-- ==========================================================
--  BLOCO A — Língua Portuguesa
-- ==========================================================

-- ---------- Texto de apoio: Djamila Ribeiro, "Pequeno manual antirracista" — Q01, Q02, Q03
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Djamila Ribeiro — "Pequeno manual antirracista"',
'Quando criança, fui ensinada que a população negra havia sido escrava e ponto, como se não tivesse existido uma vida anterior nas regiões de onde essas pessoas foram tiradas à força. Disseram-me que a população negra era passiva e que "aceitou" a escravidão sem resistência. Também me contaram que a princesa Isabel havia sido sua grande redentora. No entanto, essa era a história contada do ponto de vista dos vencedores, como diz Walter Benjamin. O que não me contaram é que o Quilombo dos Palmares, na Serra da Barriga, em Alagoas, perdurou por mais de um século, e que se organizaram vários levantes como forma de resistência à escravidão, como a Revolta dos Malês e a Revolta da Chibata. Com o tempo, aprendi que a população negra havia sido escravizada, e não era escrava – palavra que denota que essa seria uma condição natural, ocultando que esse grupo foi colocado ali pela ação de outrem.
(Djamila Ribeiro. Pequeno manual antirracista. São Paulo: Companhia das Letras, 2019. Adaptado)',
1, 2
WHERE @ja_existe_24 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No texto, as palavras "escrava" e "escravizada" foram usadas para','Médio','Semântica lexical','2ª Série EM','B',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'relacionar atitudes: a população negra se mostrou passiva diante da escravidão por se recusar a lutar pela liberdade.' AS texto
  UNION ALL SELECT @qid,'B','contrapor pontos de vista: a escravidão não era inerente à população negra, mas uma condição que lhe foi imposta.'
  UNION ALL SELECT @qid,'C','contrastar situações: a população negra era livre na África, e se conformou à escravidão no Brasil contra a sua vontade.'
  UNION ALL SELECT @qid,'D','justificar uma revisão histórica: nunca houve escravidão de fato no Brasil, o que exige repensar a história da população negra.'
  UNION ALL SELECT @qid,'E','destacar uma contradição: a população negra não aceitou a escravidão, embora não tenha oferecido resistências contra ela.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A expressão "O que", destacada no texto, faz referência a um conjunto de informações históricas que, de acordo com sua autora,','Médio','Coesão referencial','2ª Série EM','E',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'seguirá escondido por contrariar a narrativa dos vencedores.' AS texto
  UNION ALL SELECT @qid,'B','deveria ser divulgado para impor uma derrota aos vencedores.'
  UNION ALL SELECT @qid,'C','foi ensinado a partir da perspectiva dos vencedores.'
  UNION ALL SELECT @qid,'D','passou a ser contado para minimizar a força dos vencedores.'
  UNION ALL SELECT @qid,'E','foi ocultado para fazer prevalecer a visão dos vencedores.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'É correto afirmar que, no texto,','Difícil','Morfologia - verbo e adjetivo','2ª Série EM','A',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"escrava" é um adjetivo que sugere passividade, enquanto "escravizada" é um verbo no particípio que denota um efeito de imposição.' AS texto
  UNION ALL SELECT @qid,'B','tanto "escrava" quando "escravizada" são verbos no particípio que apresentam significados distintos, mas relacionados.'
  UNION ALL SELECT @qid,'C','"escrava" é um verbo que indica uma condição natural, ao passo que "escravizada", da mesma classe, denota submissão.'
  UNION ALL SELECT @qid,'D','"escrava" e "escravizada" podem ser tanto verbo quanto adjetivo, a depender do papel histórico que se atribua à população negra.'
  UNION ALL SELECT @qid,'E','"escrava" e "escravizada" são adjetivos que podem ser tratados como sinônimos, em oposição a "vencedores".'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Texto de apoio: Martha Medeiros, "Com h, y e sem acento" — Q04, Q05
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Martha Medeiros — "Com h, y e sem acento"',
'Fila de autógrafos. Qual o seu nome? Stephany. É como eu escreveria, mas pode ser Stefane, Stefany, Esttephani, assim como Tatiane pode ser Tathyane, Tatheani, Tathianne e Nícolas pode ser Nichollas, Níquolas, Nikollas. Fazer o quê? Chutar? Não é a solução mais simpática, melhor pedir gentilmente para que o leitor soletre. Está aí a explicação para as sessões de autógrafos se arrastarem por horas quando não há o papelzinho com o nome do leitor dentro do livro. E você achando que era por causa da popularidade do autor.
[...]
O nome é parte fundamental da nossa identidade, a primeira informação que recebemos sobre nós mesmos e a primeira que fornecemos a estranhos, a fim de sermos introduzidos ao fabuloso mundo da socialização. Hoje somos oito bilhões no planeta e não há nomes exclusivos para todos, somos obrigados a compartilhar nossa marca pessoal com outros tantos. Por isso, entendo que papi e mami nos registrem com algum detalhe "charmoso" para nos diferenciar – o diabo é que só complicam. Poucas pessoas conseguem dizer seu nome sem adicionar a observação: Elizza com dois z. Thalles com h e dois l. Walkyrya com w, k e dois y. Não é preciosismo, são os detalhes tão pequenos de nós todos. No meu caso, "Martha com th" virou praticamente nome composto.
(Martha Medeiros. Com h, y e sem acento. Conversa na sala. Porto Alegre: L&PM, 2023. Adaptado)',
1, 2
WHERE @ja_existe_24 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O ponto central da crônica tem a ver com o fato de que nomes próprios podem apresentar','Médio','Interpretação de texto','2ª Série EM','C',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'combinações distintas de letras para produzir variações na pronúncia.' AS texto
  UNION ALL SELECT @qid,'B','combinações de letras e pronúncias que não seguem a norma ortográfica.'
  UNION ALL SELECT @qid,'C','uma mesma pronúncia a partir de diferentes combinações de letras.'
  UNION ALL SELECT @qid,'D','pronúncias diferentes para uma mesma combinação de letras.'
  UNION ALL SELECT @qid,'E','pronúncias estranhas às possibilidades de combinação de letras do português.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Podemos afirmar que a crônica apresenta','Médio','Interpretação de texto','2ª Série EM','D',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'uma perspectiva irônica sobre o incômodo vivenciado por escritores que, diante da variação observada na pronúncia de nomes próprios, precisam solicitar aos seus leitores que soletrem os seus nomes.' AS texto
  UNION ALL SELECT @qid,'B','uma atitude sarcástica sobre a diversidade ortográfica dos nomes próprios e a dificuldade em escrevê-los, introduzindo um questionamento sobre o seu papel como um elemento identitário.'
  UNION ALL SELECT @qid,'C','uma visão crítica a respeito da variação na pronúncia e na ortografia de certos nomes, o que pode complicar o cotidiano das pessoas em situações nas quais precisam soletrar o seu nome.'
  UNION ALL SELECT @qid,'D','uma postura bem-humorada a respeito do modo como alguns nomes próprios podem ser escritos, destacando a importância dos nomes em geral como uma marca de identidade no processo de socialização.'
  UNION ALL SELECT @qid,'E','um manifesto de incentivo à socialização por meio de variações na escrita de nomes próprios, apesar das eventuais complicações que resultam das diferentes formas de escrever um mesmo nome.'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Questão isolada: manual de nheengatu (flexão verbal) — Q06
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As frases a seguir foram apresentadas em um manual de nheengatu, língua indígena amazônica, ao lado da sua tradução para o português brasileiro: Ixé amunhã pirakaya — "Eu faço piracaia"; Indé remunhã pirakaya — "Você faz piracaia"; Aé umunhã pirakaya — "Ele/Ela faz piracaia."; Yandé yamunhã pirakaya — "Nós fazemos piracaia."; Penhé pemunhã pirakaya — "Vocês fazem piracaia"; Tá umunhã pirakaya — "Eles/elas fazem piracaia" (piracaia = peixe assado). (Florêncio Almeida Vaz Filho; Antônio Fernandes Góes Neto (eds). Nheengatu Tapajowara. Santarém: SELO Gráfica Editora, 2016) Na conjugação verbal apresentada nesses exemplos específicos das duas línguas, observa-se que','Difícil','Morfologia verbal comparada','2ª Série EM','A',1,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a flexão verbal é prefixal no nheengatu e sufixal no português.' AS texto
  UNION ALL SELECT @qid,'B','a raiz verbal é regular tanto no nheengatu quanto no português.'
  UNION ALL SELECT @qid,'C','a flexão não se junta à raiz verbal no nheengatu, ao contrário do português.'
  UNION ALL SELECT @qid,'D','as marcas de primeira pessoa são idênticas às de terceira nas duas línguas.'
  UNION ALL SELECT @qid,'E','na terceira pessoa, nenhuma das línguas faz distinção entre singular e plural.'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Texto de apoio: Caetano Galindo, "Latim em pó" — Q07, Q08
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Caetano Galindo — "Latim em pó"',
'Somos um feixe variado de normas divergentes, e não apenas em termos de sotaque, elemento mais costumeiramente evocado para tratar da diversidade de normas regionais. Um bom exemplo: embora quase todo o país empregue o pronome você (já passou da hora de a gente assumir que é um pronome), ainda há grandes bolsões de uso de tu, com ou sem flexão do verbo na segunda pessoa. Dizemos você fez, tu fez, tu fizeste (e também tu fizesse, como no litoral catarinense). [...]

O que dizer do fato de que a minha norma, por exemplo, diferencia graus de formalidade entre construções como "Você me trouxe o seu livro" (engravatada) e "Você me trouxe o teu livro" (de pijama)? [...] A minha geração de curitibanos lida não com um "erro" de concordância, mas com uma delicada regra de aplicação variável e determinação contextual. E isso, cara leitora, caro leitor, também é gramática.
(Caetano Galindo. Latim em pó. Um passeio pela formação do nosso português. São Paulo: Companhia das Letras, 2022, pp. 202-203)',
1, 2
WHERE @ja_existe_24 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No texto, a palavra "erro" foi apresentada entre aspas porque, na perspectiva do seu autor,','Médio','Norma culta e variação linguística','2ª Série EM','B',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'as regras gramaticais não são definidas por nenhuma norma, o que vale tanto para o emprego de "teu" quanto de "seu".' AS texto
  UNION ALL SELECT @qid,'B','variações como as observadas entre os exemplos citados não se devem a um erro, pois fazem parte de uma determinada norma.'
  UNION ALL SELECT @qid,'C','embora o emprego de "você" em lugar de "tu" consista em um erro gramatical, o seu uso frequente justifica tratá-lo como um pronome.'
  UNION ALL SELECT @qid,'D','a decisão sobre o que é certo ou errado nas marcas de concordância deve seguir a norma padrão, respeitando-se as diferenças entre os sotaques.'
  UNION ALL SELECT @qid,'E','os exemplos mencionados são corretos em qualquer norma do português, independentemente das diferenças regionais.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considerando o ponto de vista defendido no texto, assinale a alternativa em que o par de sentenças pode ser tomado como um exemplo da variação entre norma "engravatada" e norma "de pijama", respectivamente.','Difícil','Registro de linguagem','2ª Série EM','E',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Podemos viajar nas férias. / Nós podemos viajar nas férias.' AS texto
  UNION ALL SELECT @qid,'B','Me abrace. / Me dê um abraço.'
  UNION ALL SELECT @qid,'C','Ontem jantamos cedo. / Jantamos cedo ontem.'
  UNION ALL SELECT @qid,'D','As crianças adoram biscoito. / As crianças amam bolacha.'
  UNION ALL SELECT @qid,'E','Irei ao cinema amanhã. / Vou ir no cinema amanhã.'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Texto de apoio: Sérgio Rodrigues, "'Posto que é chama': Vinicius bebeu?" — Q09, Q10
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Sérgio Rodrigues — "Posto que é chama": Vinicius bebeu?',
'"Que não seja imortal, posto que é chama / Mas que seja eterno enquanto dure." É provável que o poeta Vinicius de Moraes tivesse, sim, tomado algumas doses de "cachorro engarrafado" – isto é, de uísque, que ele chamava de "o melhor amigo do homem" – quando escreveu sua obra-prima "Soneto de fidelidade", que termina com os versos acima.

[...] Vinicius contrariou frontalmente a gramática tradicional com seu uso de posto que como conjunção explicativa (ou causal, dependendo do autor). O sentido dos versos é claro: o amor não é imortal, visto que é chama, isto é, por ser chama, mas o poeta deseja que, enquanto durar, tenha brilho infinito.

Só que Vinicius optou por não usar o visto que, que, além de caber na métrica, agradaria aos conservadores da língua. Foi mesmo de posto que, uma locução conjuntiva controversa.

Os gramáticos tradicionais atribuem a posto que valor exclusivamente concessivo, o mesmo de embora, como na seguinte frase: "Gosto dele, posto que seja meio antipático". Para eles, qualquer uso diferente é erro e pronto.

O português brasileiro ignora há muitas décadas essa análise e insiste em empregar posto que com papel explicativo. Isso não se dá por ignorância, ou não só por ignorância: encontra acolhida entre falantes cultos e parece se basear numa análise alternativa da expressão. Regras mudam.

Deliberadamente ou não, Vinicius de Moraes, um dos mestres do português brasileiro, tomou o partido da língua viva – o que no caso dele faz o maior sentido – e deu ao pessoal da linha dura uma dor de cabeça infinita (enquanto durar) [...].
(Sérgio Rodrigues. "Posto que é chama": Vinicius bebeu? Viva a língua brasileira. São Paulo: Companhia das Letras, 2016. p.148-149)',
1, 2
WHERE @ja_existe_24 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Assinale a alternativa que apresenta corretamente as ideias do texto.','Médio','Interpretação de texto','2ª Série EM','A',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'O uso de "posto que" com valor explicativo ou causal é comum entre falantes com alto nível de escolarização, embora esse uso não esteja previsto nos manuais de gramática mais conservadores.' AS texto
  UNION ALL SELECT @qid,'B','O valor explicativo de "posto que" deveria ser levado em conta pelas gramáticas tradicionais, que se limitam a apresentar essa locução conjuntiva como tendo um valor causativo ou concessivo.'
  UNION ALL SELECT @qid,'C','Assim como muitos falantes da língua, Vinicius de Moraes empregou o "posto que" da forma como vemos essa locução ser usada na fala informal e espontânea, que não dispõe de conjunções com valor concessivo.'
  UNION ALL SELECT @qid,'D','Devemos evitar o uso de "posto que" com um valor que não seja o definido nas gramáticas tradicionais, a não ser que seja para criar uma imagem poética, como vemos no Soneto da Fidelidade.'
  UNION ALL SELECT @qid,'E','A atribuição de um valor explicativo ou causal para "posto que" revela que mesmo os falantes mais cultos do português ignoram como as locuções conjuntivas da língua devem ser usadas.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Assinale a alternativa na qual, de acordo com o texto, o uso de "posto que" segue o que está previsto nas gramáticas tradicionais.','Difícil','Conjunções - valor concessivo','2ª Série EM','C',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'O mundo seria melhor, posto que as pessoas fossem mais generosas.' AS texto
  UNION ALL SELECT @qid,'B','O meu time jogou tão mal, posto que perdeu para o time adversário.'
  UNION ALL SELECT @qid,'C','Fui aprovado no concurso, posto que tivesse estudado muito pouco.'
  UNION ALL SELECT @qid,'D','Pratiquei atividades físicas o dia inteiro, posto que fiquei cansado.'
  UNION ALL SELECT @qid,'E','As ruas da cidade ficaram alagadas, posto que choveu demais.'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Questão isolada: campanha "Trabalho Infantil" (TST) — Q12
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Observe a campanha contra o trabalho infantil do TST: "TRABALHO INFANTIL — VOCÊ NÃO VÊ, MAS EXISTE. JOSÉ, 9 ANOS, TRABALHA EM UMA CARVOARIA. Cerca de 550 mil crianças entre 5 e 13 anos de idade encontram-se em situação ilegal de trabalho infantil." (https://tst.jus.br/web/combatetrabalhoinfantil/. Acesso em 09.08.2024) Assinale a alternativa que apresenta corretamente uma possibilidade de expressar o sentido da relação estabelecida entre as orações com "ver" e "existir" na campanha.','Médio','Orações - relação concessiva','2ª Série EM','B',1,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Ainda que existisse trabalho infantil, talvez você não o veria.' AS texto
  UNION ALL SELECT @qid,'B','Existe trabalho infantil, embora você não o veja.'
  UNION ALL SELECT @qid,'C','Se existe trabalho infantil é porque você não o vê.'
  UNION ALL SELECT @qid,'D','Existe trabalho infantil, então você não o vê.'
  UNION ALL SELECT @qid,'E','Quando existe trabalho infantil, você não o vê.'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Questão isolada: trabalho infantil no Brasil (IBGE/OIT) — Q13
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "O Brasil tem 1,9 milhões de crianças e adolescentes em situação de trabalho infantil, o equivalente a 4,9% do total de jovens entre 5 e 17 anos no país. Pesquisa [do IBGE] apontou que, em 2022, 756 mil crianças e adolescentes exerciam atividades da Lista TIP, do governo federal, que elenca as piores formas de trabalho infantil no país. No geral, são serviços que envolvem risco de acidentes ou são prejudiciais à saúde. A Organização Internacional do Trabalho (OIT) define trabalho infantil como aquele que é perigoso e prejudicial para a criança/adolescente e que interfere na sua escolarização." (Julia Nunes. Quase 5% das crianças e adolescentes do país estão em situação de trabalho infantil... G1. https://g1.globo.com/. Acesso em 01.08.2024. Adaptado) De acordo com o texto, o qual apresenta definições e estatísticas preocupantes sobre o que é considerado trabalho infantil, é correto afirmar:','Difícil','Interpretação de texto e dados estatísticos','2ª Série EM','E',1,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'4,9% de todas as crianças brasileiras estão em situação de trabalho infantil e exercem as piores formas de trabalho.' AS texto
  UNION ALL SELECT @qid,'B','a Organização Internacional do Trabalho garante a segurança das crianças brasileiras que exercem as piores formas de trabalho.'
  UNION ALL SELECT @qid,'C','4,9% do total de jovens entre 5 e 17 anos no país estão em situação de trabalho infantil e exercem as piores formas de trabalho.'
  UNION ALL SELECT @qid,'D','a definição de trabalho infantil dada pela OIT nada tem a ver com o que o governo federal brasileiro considera trabalho infantil.'
  UNION ALL SELECT @qid,'E','uma parte das crianças brasileiras em situação de trabalho infantil, segundo o IBGE, exerce as piores formas de trabalho.'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Texto de apoio: poema "Meninos carvoeiros" (Manuel Bandeira) + Lista TIP — Q14, Q15
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Manuel Bandeira, "Meninos carvoeiros" + Lista das Piores Formas de Trabalho Infantil',
'MENINOS CARVOEIROS
Os meninos carvoeiros
Passam a caminho da cidade.
— Eh, carvoero!
E vão tocando os animais com um relho enorme.
Os burros são magrinhos e velhos.
Cada um leva seis sacos de carvão de lenha.
A aniagem é toda remendada.
Os carvões caem.
(Pela boca da noite vem uma velhinha que os recolhe, dobrando-se com um gemido.)
— Eh, carvoero!
Só mesmo estas crianças raquíticas
Vão bem com estes burrinhos descadeirados.
A madrugada ingênua parece feita para eles…
Pequenina, ingênua miséria!
Adoráveis carvoeirinhos que trabalhais como se brincásseis!
— Eh, carvoero!
Quando voltam, vêm mordendo num pão encarvoado,
Encarapitados nas alimárias,
Apostando corrida,
Dançando, bamboleando nas cangalhas como espantalhos desamparados.
(Petrópolis, 1921)
(Manuel Bandeira. O ritmo dissoluto. In: Estrela da Vida Inteira. Rio de Janeiro: José Olympio)

Glossário: aniagem = tecido rústico de juta, fibra vegetal, entre outros materiais; encarapitado = colocado em local mais elevado; alimária = animal quadrúpede ou de carga; cangalha = apetrecho de madeira ou ferro, encaixado no lombo dos animais para pendurar carga de ambos os lados.

Lista das Piores Formas de Trabalho Infantil (Lista TIP) — Descrição dos Trabalhos (trechos): direção e operação de tratores, máquinas agrícolas e esmeris; processo produtivo do fumo, algodão, sisal, cana-de-açúcar e abacaxi; colheita de cítricos, pimenta malagueta e semelhantes; beneficiamento do fumo, sisal, castanha de caju e cana-de-açúcar; pulverização, manuseio e aplicação de agrotóxicos; locais de armazenamento com livre desprendimento de poeiras; estábulos, cavalariças, currais, estrebarias ou pocilgas sem condições adequadas de higienização; silos de estocagem com atmosferas tóxicas ou deficiência de oxigênio; sinalização na aplicação aérea de defensivos agrícolas; extração e corte de madeira; manguezais e lamaçais.
(Presidência da República. DECRETO Nº 6.481, DE 12 DE JUNHO DE 2008. Adaptado)',
1, 2
WHERE @ja_existe_24 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considerando-se a linguagem dos poemas enquanto gênero literário, é correto afirmar que o texto do modernista Manuel Bandeira','Médio','Linguagem poética','2ª Série EM','D',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'é compatível com a linguagem poética, pois o narrador, por meio de sua visão sobre os meninos carvoeiros, revela a sua compaixão e espanto diante do sofrimento inocente e contraditoriamente alegre das crianças.' AS texto
  UNION ALL SELECT @qid,'B','contradiz a linguagem poética, pois o eu lírico, apesar de estruturar o texto em estrofes, compõe os versos de forma excessivamente longa, o que desfaz o equilíbrio da estrofe.'
  UNION ALL SELECT @qid,'C','tem traços de linguagem poética, pois o eu-lírico narra e descreve em linguagem direta acontecimentos do cotidiano: a triste realidade de crianças trabalhadoras e de uma senhora abaixo da linha da pobreza.'
  UNION ALL SELECT @qid,'D','é marcado pela linguagem poética, pois o eu lírico, por meio de sua visão sobre os meninos carvoeiros da Petrópolis de 1921, revela a sua compaixão e espanto diante do sofrimento inocente e contraditoriamente alegre das crianças.'
  UNION ALL SELECT @qid,'E','é incompatível com a linguagem poética, pois o eu lírico, embora se utilize da estrutura de estrofes e versos, opta pelos "versos brancos", sem rima, e pelos versos sem métrica fixa.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Aproximando o poema do modernista Manuel Bandeira, escrito em 1921, e a Lista das Piores Formas de Trabalho Infantil, legislação de 2008, pode-se concluir que','Difícil','Intertextualidade e crítica social','2ª Série EM','A',1,2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'os meninos carvoeiros, hoje em dia, seriam considerados crianças que exercem uma atividade TIP, pois trabalham em condições precárias, são raquíticos e parecem, aos olhos do eu lírico, desamparados.' AS texto
  UNION ALL SELECT @qid,'B','a alegria e a brincadeira dos meninos carvoeiros, hoje em dia, os isentariam de integrar a lista TIP, na qual os trabalhos infantis elencados evidenciam que as crianças não podem ser felizes.'
  UNION ALL SELECT @qid,'C','a visão compadecida do eu lírico iguala os meninos carvoeiros e a velhinha que recolhe os carvões caídos ("dobrando-se com um gemido"), de modo que essas crianças nada teriam a ver com a lista TIP.'
  UNION ALL SELECT @qid,'D','os meninos carvoeiros, hoje em dia, estão em situação de conformidade com os direitos fundamentais crianças e adolescentes, já que eles trabalham, se divertem e têm pão para comer, portanto, longe da lista TIP.'
  UNION ALL SELECT @qid,'E','os meninos carvoeiros, hoje em dia, seriam considerados crianças que exercem uma atividade TIP, assim como os animais, que recebem maus-tratos (são tocados por um "relho", carregam peso, são magros e velhos).'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Questão isolada: poema "À Cidade da Bahia" (Gregório de Matos) — Q16
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o poema: "À CIDADE DA BAHIA. A cada canto um grande conselheiro / Que nos quer governar cabana e vinha; / Não sabem governar sua cozinha / E podem governar o mundo inteiro. / Em cada porta um bem frequente olheiro / Que a vida do vizinho e da vizinha / Pesquisa, escuta, espreita e esquadrinha / Para o levar à praça e ao terreiro. / Muitos mulatos desavergonhados, / Trazidos sob os pés os homens nobres, / Posta nas palmas toda a picardia, / Estupendas usuras nos mercados, / Todos os que não furtam muito pobres: / E eis aqui a cidade da Bahia." (picardia = ação daquele que engana, logra; usura = ambição excessiva; Cidade da Bahia = Salvador (BA), capital do Brasil à época do poema) (Gregório de Matos. Seleção de Obras Poéticas. Domínio Público. Acesso em 02.08.2024. Adaptado) A leitura do poema de Gregório de Matos, do Barroco do século XVII baiano, permite concluir que o eu lírico','Médio','Poesia satírica barroca','2ª Série EM','B',1,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'endereça sua crítica aos mulatos, mercadores e fofoqueiros, poupando, neste poema satírico, os fidalgos portugueses.' AS texto
  UNION ALL SELECT @qid,'B','utiliza da convenção da sátira barroca em relação à cidade de Salvador, evocando sua gente como incompetente, desonesta, ambiciosa e bisbilhoteira.'
  UNION ALL SELECT @qid,'C','faz uma sátira em que ataca os vícios e os viciosos, incluindo-se nela, já que conhecia muito bem a cidade da Bahia, onde vivia.'
  UNION ALL SELECT @qid,'D','evoca o período colonial brasileiro e as crises moral e econômica da época, as quais nada têm a ver com o tempo em que o poema foi escrito.'
  UNION ALL SELECT @qid,'E','traz à cena personagens e valores da sociedade portuguesa antiga, que nada têm a ver com a colonização do Brasil.'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Questão isolada: Machado de Assis, "Ideias de Canário" — Q17
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "— Quem seria o dono execrável deste bichinho, que teve ânimo de se desfazer dele por alguns pares de níqueis? E o canário, quedando-se em cima do poleiro, trilou isto: — Quem quer que sejas tu, certamente não estás em teu juízo. Não tive dono execrável [...] — Que dono? Esse homem que aí está é meu criado, dá-me água e comida todos os dias, com tal regularidade que eu, se devesse pagar-lhe os serviços, não seria com pouco; mas os canários não pagam criados. Em verdade, se o mundo é propriedade dos canários, seria extravagante que eles pagassem o que está no mundo. Pasmado das respostas, não sabia que mais admirar, se a linguagem, se as ideias. [...] — Mas, perdão, que pensas deste mundo? Que cousa é o mundo? — O mundo — redarguiu o canário com certo ar de professor —, o mundo é uma loja de belchior, com uma pequena gaiola de taquara, quadrilonga, pendente de um prego; o canário é senhor da gaiola que habita e da loja que o cerca. Fora daí, tudo é ilusão e mentira. Nisto acordou o velho, e veio a mim arrastando os pés. Perguntou-me se queria comprar o canário — As navalhas estão em muito bom uso — concluiu ele. — Quero só o canário." (Machado de Assis. Ideias de Canario. In: Páginas recolhidas. Acesso em 08.08.2024. Adaptado) A alternativa que contém uma afirmação correta acerca do texto é:','Difícil','Interpretação de conto','2ª Série EM','E',1,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o texto se caracteriza como uma fábula, pois é de pequena extensão, tem como personagens animais que falam e quase sempre termina com um ensinamento moral aos leitores jovens.' AS texto
  UNION ALL SELECT @qid,'B','desde o início, o conto expressa conflitos, pois o canário permanece o tempo todo em uma luta verbal com o comprador, mostrando-se inflexível ao expor o seu conhecimento de mundo.'
  UNION ALL SELECT @qid,'C','nessa crônica, o único sentido possível para o mistério que é tema central do conto (o canário que tem ideias e as comunica) é a loucura de Macedo, o comprador, posto que somente ele ouve a ave.'
  UNION ALL SELECT @qid,'D','nesta crônica não existe uma situação inusitada. Por se tratar de texto de ficção, o autor pode escolher qualquer tipo de ideia para ser desenvolvida na história.'
  UNION ALL SELECT @qid,'E','já no início do conto, revela-se uma situação inusitada: além de falar, a ave se mostra um tipo arrogante, que só enxerga o mundo e os acontecimentos a partir de seu próprio ponto de vista.'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Questão isolada: soneto de Camões — Q18
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "Busque Amor novas artes, novo engenho, / para matar-me, e novas esquivanças; / que não pode tirar-me as esperanças, / que mal me tirará o que eu não tenho. / Olhai de que esperanças me mantenho! / Vede que perigosas seguranças! / Que não temo contrastes nem mudanças, / andando em bravo mar, perdido o lenho. / Mas, conquanto não pode haver desgosto / onde esperança falta, lá me esconde / Amor um mal, que mata e não se vê. / Que dias há que n''alma me tem posto / um não sei quê, que nasce não sei onde, / vem não sei como, e dói não sei porquê." (Luís Vaz de Camões. Edição de Dr. Álvaro Júlio da Costa Pimpão. Adaptado) É correto afirmar que o texto camoniano é um','Médio','Poesia lírico-amorosa clássica','2ª Série EM','C',1,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'exemplar da poesia épica, no qual se identifica o paradoxo em "não temo contrastes nem mudanças".' AS texto
  UNION ALL SELECT @qid,'B','soneto de temática heroica d''Os Lusíadas, no qual se identifica a metáfora "não pode tirar-me as esperanças".'
  UNION ALL SELECT @qid,'C','soneto de temática lírico-amorosa, no qual se identifica o paradoxo em "perigosa segurança".'
  UNION ALL SELECT @qid,'D','exemplar de canção trovadoresca, no qual se identifica a metáfora em "novas artes, novo engenho".'
  UNION ALL SELECT @qid,'E','poema de temática religiosa, no qual se identifica o paradoxo em "nasce não sei onde".'
) alts WHERE @ja_existe_24 = 0;

-- ==========================================================
--  BLOCO B — Língua Inglesa
-- ==========================================================

-- ---------- Texto de apoio: "Adolescent Health" — Q19, Q20, Q21
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Adolescent Health',
'Young people are a large age group, comprising approximately 30% of the population in Latin America and the Caribbean. Adolescents are generally considered to be a "healthy" segment of the population, and their health needs are often ignored. However, investing in health and education for young people and adjusting economic policies enable productivity and economic growth.

In addition, investment in young people''s health is essential to protect investments made in childhood (e.g. significant investments in vaccines and food programs) and secures the health of the future adult population. Most habits harmful to health are acquired during adolescence and youth and manifest themselves as health problems in adulthood (e.g. lung cancer caused by the consumption of tobacco), adding an avoidable financial load to the health systems.
(www.paho.org/en/. Acesso em 14.08.2024. Adaptado)',
(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'), 2
WHERE @ja_existe_24 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O assunto principal do texto é','Fácil','Reading comprehension - assunto principal','2ª Série EM','D',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o descaso da população adolescente com a própria saúde.' AS texto
  UNION ALL SELECT @qid,'B','o efeito tardio de maus hábitos de saúde adquiridos desde a infância.'
  UNION ALL SELECT @qid,'C','a relevância da vacinação e da merenda escolar nas escolas.'
  UNION ALL SELECT @qid,'D','a importância de políticas de investimento na saúde de jovens e adolescentes.'
  UNION ALL SELECT @qid,'E','o crescimento da população de jovens e adolescentes no mundo.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No trecho, Adolescents are generally considered to be a "healthy" segment of the population, o termo healthy está entre aspas para','Médio','Reading comprehension - uso das aspas','2ª Série EM','B',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'mostrar como uma crença pode se tornar uma verdade.' AS texto
  UNION ALL SELECT @qid,'B','questionar a crença quanto à boa saúde dos jovens.'
  UNION ALL SELECT @qid,'C','enfatizar que os adolescentes são de fato uma população saudável.'
  UNION ALL SELECT @qid,'D','destacar que o termo saudável é confuso até para os médicos.'
  UNION ALL SELECT @qid,'E','agregar sentido humorístico ao termo saudável.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'According to the text, an example of bad habit acquired during adolescent years is','Médio','Reading comprehension - detalhes do texto','2ª Série EM','B',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a sedentary lifestyle.' AS texto
  UNION ALL SELECT @qid,'B','smoking.'
  UNION ALL SELECT @qid,'C','lung cancer.'
  UNION ALL SELECT @qid,'D','inadequate eating.'
  UNION ALL SELECT @qid,'E','non-vaccination.'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Questão isolada: anúncio Lakeridge Health — Q22
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Read the ad: "WE DON''T CARE WHAT''S ON YOUR HEAD. WE CARE WHAT''S IN IT. We''re Lakeridge Health, a leading hospital in the Greater Toronto Area. Our focus is on safety and quality, and we''re looking for people like you to join our team of health professionals. Check us out: www.lakeridgehealth.on.ca" (https://hcldr.wordpress.com/. Acesso em 28.08.2024) The main purpose of the ad is to','Fácil','Reading comprehension - propósito do texto','2ª Série EM','E',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'announce free hospital assistance.' AS texto
  UNION ALL SELECT @qid,'B','promote Lakeridge Health Hospital.'
  UNION ALL SELECT @qid,'C','offer safety and quality hospital services'
  UNION ALL SELECT @qid,'D','fight against discrimination.'
  UNION ALL SELECT @qid,'E','offer a job in the health area.'
) alts WHERE @ja_existe_24 = 0;

-- ---------- Texto de apoio: "Global literacy today" — Q23, Q24
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Global literacy today',
'Of the world population older than 15 years, the majority are literate, that is to say, can read and write.

This map shows how literacy rates vary around the world. In many countries, more than 95% have basic literacy skills. Literacy skills of the majority of the population are a modern achievement. Globally, however, large inequalities continue. In some countries in sub-Saharan Africa, less than 1-in-3 adults (aged over 15 years) are able to both read and write.
(Mapa: Literacy rate, 2022 — share of adults aged 15 and older who can both read and write. Data source: World Bank (2023). Our World in Data.org/literacy)

Historical change in literacy
While the earliest forms of written communication date back to about 3,500–3,000 before the Christian era, for centuries literacy remained a very restricted technology closely associated with the exercise of power. It was only during the Middle Ages that book production started growing, and literacy among the general population slowly started becoming important in the Western World. However, it took centuries for universal literacy to happen. It was only in the 19th and 20th centuries that rates of literacy approached universality in early-industrialized countries.
(Max Roser e Esteban Ortiz-Ospina, 03.2023. https://ourworldindata.org/literacy. Acesso em 14.09.2024. Adaptado)',
(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'), 2
WHERE @ja_existe_24 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A comparação entre o texto e o mapa permite afirmar que','Médio','Reading comprehension - texto e dados','2ª Série EM','C',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'15 anos é a idade de corte por ser aquela em que a alfabetização tende a estar completa.' AS texto
  UNION ALL SELECT @qid,'B','o número de pessoas com alfabetização adequada vem crescendo no mundo todo.'
  UNION ALL SELECT @qid,'C','países africanos estão entre aqueles com menor índice de alfabetização no mundo.'
  UNION ALL SELECT @qid,'D','os países com maiores índices de alfabetização encontram-se todos no Ocidente.'
  UNION ALL SELECT @qid,'E','nenhum país do mundo já atingiu o nível de 95% de sua população alfabetizada.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'According to the last paragraph,','Difícil','Reading comprehension - detalhes do texto','2ª Série EM','A',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'the first manifestations of written language come from around five thousand years ago.' AS texto
  UNION ALL SELECT @qid,'B','literacy is more and more associated with technology and the exercise of power nowadays.'
  UNION ALL SELECT @qid,'C','knowing how to read and write has always been an important universal objective.'
  UNION ALL SELECT @qid,'D','literacy became universal immediately after large book production started.'
  UNION ALL SELECT @qid,'E','literacy was particularly widespread during the Middle Ages.'
) alts WHERE @ja_existe_24 = 0;

-- ==========================================================
--  BLOCO C — Física
-- ==========================================================

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Sistemas de isolamento térmico são amplamente utilizados, especialmente em um país tropical como o Brasil. Garrafas e copos térmicos para bebidas e recipientes isolantes para o transporte de vacinas são alguns sistemas muito comuns no dia a dia. Sobre a propagação de calor em materiais nesse tipo de sistema, assinale a alternativa correta.','Médio','Propagação de calor','2ª Série EM','D',4,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'No caso de fluídos, o principal modo de transferência de calor é a condução.' AS texto
  UNION ALL SELECT @qid,'B','A convecção é usada para limitar a troca de calor.'
  UNION ALL SELECT @qid,'C','O excelente contato térmico entre as partes da garrafa térmica diminui a troca de calor.'
  UNION ALL SELECT @qid,'D','Apesar de isolados, os sistemas ainda podem ter a sua temperatura alterada por irradiação.'
  UNION ALL SELECT @qid,'E','A garrafa térmica utiliza apenas a condução para minimizar a troca de calor.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Apesar da escala Celsius ter substituído a Fahrenheit em quase todo mundo, alguns poucos países, dentre eles os Estados Unidos, continuam a usá-la. Nessa escala, quais seriam os valores para a temperatura de congelamento e de ebulição de água pura ao nível do mar, respectivamente?','Fácil','Termometria','2ª Série EM','B',4,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'0 e 100°F.' AS texto
  UNION ALL SELECT @qid,'B','32 e 212°F.'
  UNION ALL SELECT @qid,'C','32 e 100°F.'
  UNION ALL SELECT @qid,'D','0 e 212°F.'
  UNION ALL SELECT @qid,'E','100 e 300°F.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O acelerador síncrotron Sirius, do Centro Nacional de Pesquisa em Energia e Materiais, em Campinas, trabalha com um feixe de elétrons de corrente média de 100 mA, em um modo pulsado, com essas partículas se movendo em velocidades relativísticas em seu anel de armazenamento. (https://cnpem.br. Acesso em: 10.09.2024) O período de revolução dos elétrons é de 1,7 μs e o valor da carga elementar e ≅ 1,6×10⁻¹⁹ C. Qual o número aproximado de elétrons em uma volta do Sirius?','Difícil','Eletricidade - carga elétrica','2ª Série EM','E',4,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'10^21' AS texto
  UNION ALL SELECT @qid,'B','10^15'
  UNION ALL SELECT @qid,'C','10^18'
  UNION ALL SELECT @qid,'D','10^9'
  UNION ALL SELECT @qid,'E','10^12'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em um experimento de calorimetria, misturou-se duas substâncias, A e B, em um recipiente isolado termicamente. A massa da substância A foi de 300 g e a massa da substância B foi de 200 g, e ambas possuíam o mesmo calor específico. O gráfico da variação das temperaturas em função do tempo mostra que a substância A partiu de 70 ºC e a substância B partiu de 30 ºC, convergindo assintoticamente para uma temperatura de equilíbrio comum conforme o tempo passa. Com base nesses dados, qual é a temperatura de equilíbrio térmico entre as substâncias A e B?','Difícil','Calorimetria','2ª Série EM','A',4,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'54 °C.' AS texto
  UNION ALL SELECT @qid,'B','50 °C.'
  UNION ALL SELECT @qid,'C','60 °C.'
  UNION ALL SELECT @qid,'D','55 °C.'
  UNION ALL SELECT @qid,'E','45 °C.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O problema do acúmulo de lixo espacial é preocupante, e diversas soluções vêm sendo propostas para desorbitar satélites desativados e evitar colisões perigosas com satélites ou até mesmo com naves ou estações espaciais tripuladas. Uma dessas soluções envolve usar a força eletromagnética gerada pelo campo geomagnético terrestre sobre um fio condutor sendo atravessado por uma corrente elétrica para realizar a manobra de desorbita. Usando essa ideia como inspiração, considere um fio condutor, retilíneo, de comprimento 50 cm, percorrido por uma corrente de 5,0 A. Esse fio está imerso em um campo magnético uniforme, de intensidade 0,2 T, perpendicular ao fio. Qual o módulo da força magnética que atua nesse condutor?','Médio','Eletromagnetismo','2ª Série EM','A',4,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'0,5 N.' AS texto
  UNION ALL SELECT @qid,'B','10,0 N.'
  UNION ALL SELECT @qid,'C','50,0 N.'
  UNION ALL SELECT @qid,'D','20,0 N.'
  UNION ALL SELECT @qid,'E','0,2 N.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Capacitores são amplamente usados em sistemas elétricos. Nos recentes carros elétricos, por exemplo, eles podem complementar a função da bateria, liberando energia rapidamente em momentos de picos de potência, como acelerações bruscas. Também são usados nos sistemas de freios regenerativos, que geram energia elétrica em momentos de frenagem. Comumente são usadas associações de capacitores para esses fins. Suponhamos que dois capacitores, um de 3 μF e outro de 6 μF, sejam associados em série e submetidos a uma diferença de potencial de 120 V. Qual seria a carga armazenada nessa associação?','Médio','Capacitores','2ª Série EM','D',4,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'60 μC.' AS texto
  UNION ALL SELECT @qid,'B','2160 μC.'
  UNION ALL SELECT @qid,'C','13 μC.'
  UNION ALL SELECT @qid,'D','240 μC.'
  UNION ALL SELECT @qid,'E','1080 μC.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Geradores elétricos são essenciais em diversas aplicações em que não pode faltar energia elétrica, como, por exemplo, em hospitais. Com a crise energética, eles estão se tornando cada vez mais comuns até mesmo para residências. Para uma dessas aplicações, um gerador de pequeno porte, com força eletromotriz de 12 V e resistência interna de 0,5 Ω está conectado a um circuito externo com resistência equivalente de 5,5 Ω. Qual a potência dissipada no circuito externo?','Médio','Circuitos elétricos','2ª Série EM','C',4,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'24 W.' AS texto
  UNION ALL SELECT @qid,'B','16 W.'
  UNION ALL SELECT @qid,'C','22 W.'
  UNION ALL SELECT @qid,'D','12 W.'
  UNION ALL SELECT @qid,'E','2 W.'
) alts WHERE @ja_existe_24 = 0;

-- ==========================================================
--  BLOCO D — Química
-- ==========================================================

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As substâncias CCl4 (apolar), H2O (polar) e C6H14 (apolar) são adicionadas a um recipiente, nessa ordem, produzindo o sistema I, no qual se observam três camadas distintas (de cima para baixo: C6H14, H2O e CCl4), já que os dois compostos apolares não se misturam com a água e se distribuem conforme sua densidade. Quando a ordem de adição é modificada, forma-se o sistema II, no qual as duas substâncias apolares (CCl4 e C6H14), por serem miscíveis entre si, se juntam em uma única fase (identificada como X ou Y), restando a água como a outra fase. Para que os componentes do sistema II sejam separados, deve-se realizar, na sequência, as operações','Difícil','Métodos de separação de misturas','2ª Série EM','B',5,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'filtração e destilação fracionada.' AS texto
  UNION ALL SELECT @qid,'B','decantação e destilação fracionada.'
  UNION ALL SELECT @qid,'C','filtração e decantação.'
  UNION ALL SELECT @qid,'D','decantação e filtração.'
  UNION ALL SELECT @qid,'E','destilação fracionada e decantação.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A adição de biodiesel ao óleo diesel proveniente do petróleo apresenta diversas vantagens, como a diminuição da necessidade de utilização de fontes não renováveis de energia. Como o biodiesel não contém enxofre em sua composição, a adição dele ao óleo diesel também promove a diminuição da','Médio','Poluição atmosférica','2ª Série EM','E',5,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'emissão de gases de efeito estufa.' AS texto
  UNION ALL SELECT @qid,'B','destruição da camada de ozônio.'
  UNION ALL SELECT @qid,'C','produção de ozônio troposférico.'
  UNION ALL SELECT @qid,'D','eutrofização de lagos e represas.'
  UNION ALL SELECT @qid,'E','ocorrência de chuvas ácidas.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A mistura de hidróxido de bário (Ba(OH)2) e cloreto de amônio (NH4Cl), à temperatura ambiente, produz uma reação em que a temperatura final pode atingir –20 ºC. A equação que representa a reação é: Ba(OH)2 + xNH4Cl → BaCl2 + 2H2O + xNH3. A partir dessas informações e com base na equação, o valor de x na equação e a classificação da reação em relação ao calor envolvido são, respectivamente,','Difícil','Termoquímica e balanceamento','2ª Série EM','A',5,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'2 e endotérmica.' AS texto
  UNION ALL SELECT @qid,'B','2 e exotérmica.'
  UNION ALL SELECT @qid,'C','1 e endotérmica.'
  UNION ALL SELECT @qid,'D','1 e exotérmica.'
  UNION ALL SELECT @qid,'E','3 e endotérmica.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Soluções de nitrato de prata (AgNO3) são utilizadas para identificar a presença de íons cloreto (Cl–) na água. O AgNO3 apresenta solubilidade igual a 240 g por 100 g de água, a 25 ºC. Se um técnico de laboratório adicionar 2500 g de AgNO3 a 600 g de água, a 25 ºC, e filtrar o sistema obtido, a massa de solução saturada de AgNO3 produzida será igual a','Difícil','Solubilidade','2ª Série EM','E',5,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'840 g.' AS texto
  UNION ALL SELECT @qid,'B','1440 g.'
  UNION ALL SELECT @qid,'C','2800 g.'
  UNION ALL SELECT @qid,'D','3100 g.'
  UNION ALL SELECT @qid,'E','2040 g.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um estudante adicionou solução de azul de bromotimol a 500 mL de uma solução de ácido clorídrico (HCl) de concentração 10⁻³ mol/L. Em seguida, adicionou raspas de zinco (M = 65 g/mol) em excesso à solução, verificando a formação de bolhas e uma mudança na cor da solução. A reação entre zinco metálico e ácido clorídrico é representada pela equação: Zn + 2HCl → ZnCl2 + H2. A tabela apresenta as cores do indicador azul de bromotimol em função do pH: pH < 6,0 = amarelo; pH entre 6,0 e 7,6 = verde; pH > 7,6 = azul. A cor da solução de HCl, antes da adição de zinco metálico, e a massa de zinco consumida na reação entre Zn e HCl são, respectivamente,','Difícil','Estequiometria e indicadores ácido-base','2ª Série EM','C',5,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'verde e 16,25 mg.' AS texto
  UNION ALL SELECT @qid,'B','verde e 32,5 mg.'
  UNION ALL SELECT @qid,'C','amarela e 16,25 mg.'
  UNION ALL SELECT @qid,'D','amarela e 32,5 mg.'
  UNION ALL SELECT @qid,'E','azul e 16,25 mg.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Quando um isótopo radioativo emite uma partícula alfa, seu número atômico diminui duas unidades e seu número de massa diminui quatro unidades, devido às partículas que são emitidas pelo núcleo. Assim, quando um isótopo radioativo sofre decaimento alfa, são emitidos','Médio','Radioatividade','2ª Série EM','D',5,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'dois prótons e quatro nêutrons.' AS texto
  UNION ALL SELECT @qid,'B','dois prótons e dois elétrons.'
  UNION ALL SELECT @qid,'C','dois elétrons e dois nêutrons.'
  UNION ALL SELECT @qid,'D','dois prótons e dois nêutrons.'
  UNION ALL SELECT @qid,'E','dois elétrons e quatro nêutrons.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Quando metais diferentes são colocados em contato e mergulhados em uma solução eletrolítica, ocorre a corrosão eletroquímica. Em um experimento, placas de cobre são unidas por rebites de ferro, e placas de ferro são unidas por rebites de cobre, sendo ambos os conjuntos mergulhados em uma solução eletrolítica; observa-se corrosão exatamente nos rebites de ferro. (corrosion-doctors.org. Acesso em: 04.08.2024. Adaptado) A corrosão ilustrada ocorre porque, dentre os metais envolvidos,','Médio','Eletroquímica - corrosão','2ª Série EM','B',5,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o ferro apresenta maior potencial de redução, doando elétrons para a solução.' AS texto
  UNION ALL SELECT @qid,'B','o ferro apresenta menor potencial de redução, doando elétrons para a solução.'
  UNION ALL SELECT @qid,'C','o ferro apresenta maior potencial de redução, recebendo elétrons da solução.'
  UNION ALL SELECT @qid,'D','o cobre apresenta maior potencial de redução, doando elétrons para a solução.'
  UNION ALL SELECT @qid,'E','o cobre apresenta menor potencial de redução, recebendo elétrons da solução.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Nas estações de tratamento de água, o início do processo de tratamento consiste na produção do floculante hidróxido de alumínio (Al(OH)3) a partir da dissolução, em água, de sulfato de alumínio (Al2(SO4)3), que sofre hidrólise de acordo com a equação: Al2(SO4)3 (aq) + 6H2O (l) ⇌ 2Al(OH)3 (s) + 3H2SO4 (aq). Para aumentar o rendimento da produção de hidróxido de alumínio, é adicionada à água uma substância que, ao sofrer dissociação, desloca o equilíbrio no sentido dos produtos. A fórmula da substância adicionada à água é','Difícil','Equilíbrio químico','2ª Série EM','A',5,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Ca(OH)2.' AS texto
  UNION ALL SELECT @qid,'B','HCl.'
  UNION ALL SELECT @qid,'C','Na2SO4.'
  UNION ALL SELECT @qid,'D','CaCl2.'
  UNION ALL SELECT @qid,'E','CH3COOH.'
) alts WHERE @ja_existe_24 = 0;

-- ==========================================================
--  BLOCO E — Biologia
-- ==========================================================

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Mitose no lugar de meiose. Uma pesquisa brasileira, do Instituto Max Planck de Pesquisa em Melhoramento de Plantas, desenvolveu um sistema inovador de criação de gametas clonais denominado MiMe (Mitosis instead of Meiosis). Tradicionalmente, a geração de gametas em plantas ocorre através da meiose, processo que mistura o material genético dos genitores promovendo variabilidade. O sistema MiMe, testado em tomateiros (plantas com 24 cromossomos), permite a produção de gametas clonais a partir de mitose que, assim, passam a carregar 100% da carga genética da planta-mãe. A fecundação entre dois gametas clonais produzidos por essa técnica resulta em plantas com o conjunto genético completo de ambos os genitores, apresentando um total de 48 cromossomos. Esse método assegura a transmissão das características favoráveis de ambas as linhagens parentais, consolidando-as em uma única planta. (https://revistacultivar.com.br. Acesso em: 10.08.2024. Adaptado) Os tomates obtidos a partir da fecundação entre gametas produzidos pela técnica descrita no texto podem ser classificados como','Difícil','Genética - reprodução e clonagem','2ª Série EM','E',3,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'indivíduos transgênicos, porém não podem ser classificados como organismos geneticamente modificados.' AS texto
  UNION ALL SELECT @qid,'B','clones de apenas uma de suas plantas genitoras, porém não podem ser classificados como clones de ambas as plantas genitoras.'
  UNION ALL SELECT @qid,'C','clones de ambas as plantas genitoras, porém não podem ser classificados como sendo da mesma espécie que elas.'
  UNION ALL SELECT @qid,'D','defensivos agrícolas, porém não podem ser classificados como tomates biologicamente viáveis.'
  UNION ALL SELECT @qid,'E','indivíduos geneticamente modificados, porém não podem ser classificados como organismos transgênicos.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Gel contraceptivo para homens pode estar mais próximo de virar realidade. Após décadas de estudos, cientistas apontam avanços no desenvolvimento de uma alternativa de contracepção de longa duração para homens. O produto experimental é um gel que os homens passam nos ombros uma vez por dia e, ao longo do tempo, bloqueia a produção de espermatozoides. Desde 2005 os pesquisadores vêm formulando e refinando a dosagem e a concentração do gel, que contém testosterona e uma versão sintética de progesterona. Em um teste recente, que contou com mais de 300 casais, 86% dos homens atingiram baixa contagem de espermatozoides após 15 semanas de uso do gel. Para alguns, o efeito foi ainda mais rápido, suprimindo a produção do gameta em quatro a oito semanas. Depois que os homens param de usar o gel, a contagem de espermatozoides voltou aos níveis normais em dois ou três meses. (https://www.cnnbrasil.com.br/. Acesso em: 10.08.2024. Adaptado) Sobre o método descrito, é correto afirmar que','Médio','Reprodução humana - contracepção','2ª Série EM','A',3,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'não pode ser considerado um substituto para o preservativo por não proteger contra infecções sexualmente transmissíveis.' AS texto
  UNION ALL SELECT @qid,'B','pode ser considerado mais saudável do que métodos utilizados por mulheres por não envolver a administração de hormônios.'
  UNION ALL SELECT @qid,'C','pode ser útil em casos de relação desprotegida ou falha dos métodos contraceptivos utilizados, substituindo a pílula do dia seguinte.'
  UNION ALL SELECT @qid,'D','deve ser utilizado com cuidado, uma vez que seus efeitos não são reversíveis e, assim, podem interferir em um possível planejamento familiar futuro.'
  UNION ALL SELECT @qid,'E','protege contra infecções sexualmente transmissíveis por impedir o contato dos gametas masculinos com o corpo feminino.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O uso de RNA mensageiro em tratamentos é um campo em expansão na ciência. O uso de RNA mensageiro na ciência representou um dos maiores sinais de esperança contra a covid-19, uma vez que a tecnologia foi utilizada na produção de vacinas. Apesar de já ser alvo de estudo há décadas, a aplicação dessa tecnologia só teve repercussão mundial no cenário pandêmico, mas sua função na ciência vai muito além disso devido à sua versatilidade. Na oncologia, por exemplo, há diversos estudos sobre o uso de RNA mensageiro para codificar moléculas específicas das células mutadas — como os antígenos associados ao tumor — e induzir células do sistema imunológico a reconhecer e atacar tais células cancerosas. Assim, a terapia com RNAm teria potencial de inibir o crescimento tumoral ou induzir a eliminação das células cancerosas pelas células imunes. (https://jornal.usp.br/. Acesso em: 11.08.2024. Adaptado) Sobre o uso de RNAm, abordado na reportagem, é correto afirmar que a','Médio','Biologia molecular - síntese proteica','2ª Série EM','D',3,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'tradução da informação contida no RNA mensageiro garante a produção de moléculas de DNA.' AS texto
  UNION ALL SELECT @qid,'B','transcrição da informação contida no RNA mensageiro garante a produção de moléculas de RNA transportador.'
  UNION ALL SELECT @qid,'C','transcrição da informação contida no RNA mensageiro garante a produção de proteínas.'
  UNION ALL SELECT @qid,'D','tradução da informação contida no RNA mensageiro garante a produção de proteínas.'
  UNION ALL SELECT @qid,'E','replicação da informação contida no RNA mensageiro garante a produção de moléculas de DNA.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Marta desconhece seu tipo sanguíneo. Buscando descobrir com ajuda de seus conhecimentos de genética, pesquisou os tipos sanguíneos de alguns de seus familiares. A tabela a seguir sintetiza as informações coletadas: Juliana (mãe de Marta) = O+; Lauro (pai de Marta) = AB+; Rita (irmã de Marta) = A-; Aldo (marido de Marta e pai de Paula) = A-; Paula (filha de Marta) = B+. A partir das informações presentes na tabela, considera-se que o provável tipo sanguíneo de Marta seja','Difícil','Genética - sistema ABO e Rh','2ª Série EM','B',3,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'O-' AS texto
  UNION ALL SELECT @qid,'B','B+'
  UNION ALL SELECT @qid,'C','AB+'
  UNION ALL SELECT @qid,'D','AB-'
  UNION ALL SELECT @qid,'E','A+'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "Anúncio de recuperação da camada de ozônio foi prematuro, diz estudo. A recuperação da camada de ozônio foi celebrada como uma das maiores conquistas ambientais do mundo. Contudo, um estudo publicado em novembro de 2023 afirma que ela pode não estar se recuperando e que o buraco pode estar, na verdade, se expandindo. O buraco, que cresce sobre a Antártica durante a primavera antes de diminuir novamente no verão, atingiu tamanhos recordes entre 2020 e 2022." (https://www.cnnbrasil.com.br/. Acesso em: 12.08.2024. Adaptado) Sobre a camada de ozônio, citada no texto, é correto afirmar que','Médio','Camada de ozônio e radiação','2ª Série EM','C',3,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o aumento do buraco na camada de ozônio pode ser associado à formação de novas geleiras na Antártida e a uma nova era glacial.' AS texto
  UNION ALL SELECT @qid,'B','a camada de ozônio protege a superfície terrestre e os seres vivos de partículas alfa (α) e beta (β) provenientes do espaço sideral.'
  UNION ALL SELECT @qid,'C','pessoas que vivem em regiões menos protegidas pela camada de ozônio devem aumentar a proteção de seus corpos contra radiação ultravioleta.'
  UNION ALL SELECT @qid,'D','o aumento no buraco da camada de ozônio pode ser associado a doenças respiratórias por conta da associação do ozônio com a hemoglobina.'
  UNION ALL SELECT @qid,'E','o ozônio, um dos gases do efeito estufa, é produzido principalmente no tubo digestório de ruminantes e outros mamíferos herbívoros.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os esquemas de cadeias alimentares correspondem a formas de representar relações alimentares entre diferentes espécies que coexistem em um mesmo ambiente. Em um determinado ecossistema, a seguinte cadeia alimentar pode ser observada: Espécie X → Espécie Z → Espécie W → Espécie K. Considerando que as espécies X, Z, W e K não participam de outra cadeia alimentar nesse ecossistema, a análise do esquema permite afirmar que a espécie','Médio','Ecologia - cadeias alimentares','2ª Série EM','E',3,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'X é decompositora.' AS texto
  UNION ALL SELECT @qid,'B','X é consumidora de primeira ordem.'
  UNION ALL SELECT @qid,'C','K é produtora.'
  UNION ALL SELECT @qid,'D','W é consumidora de primeira ordem.'
  UNION ALL SELECT @qid,'E','Z é herbívora.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Ao arrumar o laboratório de sua orientadora, uma estudante do curso de nutrição encontrou um fragmento de tabela de informação nutricional sem nenhuma identificação a respeito de qual alimento estava sendo descrito. Avaliando os registros que estavam próximos à tabela, a aluna verificou que as informações poderiam corresponder a peito de frango, farinha de trigo, leite integral, batata frita ou leite de amêndoas, todos em sua composição pura – sem adição de novos ingredientes. Informação nutricional - Porção de 200 mL: Valor energético 114 kcal; Carboidratos 9 g; Lactose 7 g; Proteínas 6 g; Gorduras Totais 6 g; Gorduras Saturadas 4 g; Gordura Trans 0 g; Colesterol 20 mg; Fibra alimentar 0 g. A análise das informações presentes na tabela permite que seja identificado o alimento que melhor corresponde às informações nutricionais. Esse alimento é','Médio','Nutrição - composição de alimentos','2ª Série EM','D',3,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o leite de amêndoas.' AS texto
  UNION ALL SELECT @qid,'B','a farinha de trigo.'
  UNION ALL SELECT @qid,'C','a batata frita.'
  UNION ALL SELECT @qid,'D','o leite integral.'
  UNION ALL SELECT @qid,'E','o peito de frango.'
) alts WHERE @ja_existe_24 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Brasil conta com alternativas mais eficientes que carros elétricos na redução de emissão de CO2. A professora Adriana Marotti de Melo, da Faculdade de Economia, Administração, Contabilidade e Atuária (FEA), da USP, explica que o Brasil conta com alternativas de redução de CO2 para além dos carros elétricos. "Usando a metodologia de avaliação do ciclo de vida do produto desde a fase da produção das baterias até o descarte do veículo, quando você usa um veículo à combustão interna de etanol, o ganho em termos de emissão de CO2 é similar ao de um veículo elétrico", afirma. "O Brasil já tem uma alternativa, o etanol, cuja tecnologia é usada há muitos anos e que pode ser aperfeiçoada. Já temos toda a logística de produção e distribuição desse combustível, então, em termos de política pública, é mais interessante", finaliza. (https://jornal.usp.br/radio-usp/. Acesso em: 13.08.2024. Adaptado) Sobre as temáticas abordadas na reportagem, é correto afirmar que','Difícil','Sustentabilidade e biocombustíveis','2ª Série EM','D',3,2,NULL,TRUE
WHERE @ja_existe_24 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a atividade do motor dos carros elétricos emite mais gás carbônico do que a atividade do motor dos carros à combustão movidos a álcool' AS texto
  UNION ALL SELECT @qid,'B','os carros elétricos podem ser considerados ainda mais sustentáveis se a fonte da energia utilizada por eles vier de termelétricas.'
  UNION ALL SELECT @qid,'C','veículos elétricos são considerados neutros ecologicamente por não dependerem de intervenções humanas na natureza para que tenham energia.'
  UNION ALL SELECT @qid,'D','a taxa de emissão de gás carbônico na combustão do etanol é em parte compensada pelo consumo de gás carbônico feito pela cana-de-açúcar.'
  UNION ALL SELECT @qid,'E','no Brasil a maior parte do etanol utilizado nos automóveis é retirada de derivados do petróleo que, anteriormente, eram considerados residuais.'
) alts WHERE @ja_existe_24 = 0;
