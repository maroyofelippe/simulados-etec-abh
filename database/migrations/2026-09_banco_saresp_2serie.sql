-- ==========================================================
--  Migração de conteúdo: Banco de questões SARESP 2025 — 2ª Série EM
--  Caderno 201-LT-CNT (Linguagens/Inglês + Ciências da Natureza), aplicação 03.11.2025
--  Fonte: prova oficial + gabarito (Fundação Vunesp) fornecidos pela coordenação.
--  ----------------------------------------------------------
--  Escopo: das 48 questões do caderno, foram importadas as 40 plenamente
--  respondíveis a partir do texto do enunciado. Ficaram de fora (não
--  cadastradas): questões 1, 2 (tira "Calvin", depende da sequência de
--  quadrinhos), 27, 28 (gráfico p×V do ciclo do compressor), 29 (posições
--  num grid do espelho plano), 35 (foto do fenômeno de floculação), 36
--  (alternativas são gráficos [H+]×tempo) e 47 (gráfico de barras de
--  organelas) — todas dependem de uma imagem/gráfico que este sistema
--  ainda não armazena por questão.
--
--  Reaproveita a disciplina "Língua Inglesa" já criada pela migração
--  2026-09_banco_saresp_1serie.sql. Usa textos_apoio para os textos-base
--  compartilhados por mais de uma questão (RF07a).
--
--  Idempotente: mesma técnica da migração da 1ª série — variável de sessão
--  travada no início (@ja_existe_2s), sem DELIMITER/stored procedures
--  (incompatível com a execução via db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-09_banco_saresp_2serie.sql)
-- ==========================================================
SET @db := DATABASE();

-- Garante que a disciplina "Língua Inglesa" existe (idempotente; normalmente já
-- foi criada pela migração da 1ª série, mas este arquivo pode rodar sozinho)
INSERT INTO disciplinas (nome, area)
SELECT 'Língua Inglesa', 'Linguagens'
WHERE NOT EXISTS (SELECT 1 FROM disciplinas WHERE nome = 'Língua Inglesa');

-- Guarda travada: já aplicamos este lote antes?
SET @ja_existe_2s := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'Na organização das informações textuais%'
);

-- ==========================================================
--  BLOCO A — Língua Portuguesa
-- ==========================================================

-- ---------- Texto de apoio: Dia Mundial do Oceano — Q03, Q04, Q05
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Dia Mundial do Oceano',
'Ele cobre cerca de 70% da superfície terrestre, abriga mais de 200 mil espécies conhecidas e milhões ainda não identificadas, produz pelo menos metade do oxigênio que respiramos, absorve grande parte do gás carbônico, regula o clima do planeta, emprega direta ou indiretamente milhões de pessoas, contribui para a economia global sendo rota de comércio da maioria dos produtos. Quem faz essas importantes tarefas é o oceano.

Por esses e tantos outros motivos, convencionou-se celebrar o Dia Mundial do Oceano em 8 de junho, instituído pela Organização das Nações Unidas (ONU), em 1992. A data nos convida a celebrar a importância desse ambiente em nossas vidas, mas também a promover a conscientização sobre a saúde dos ecossistemas marinhos, que sofrem múltiplas interferências, como os milhões de toneladas de plásticos que os atingem anualmente e o declínio de diversas espécies marinhas. A data propõe, então, reflexão e ação.
(https://cienciahoje.org.br, 01.06.2025. Acesso em 28.08.2025. Adaptado)',
1, 2
WHERE @ja_existe_2s = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na organização das informações textuais, uma das funções do pronome é antecipar uma informação que será explicitada depois, como ocorre com o pronome destacado em:','Médio','Coesão pronominal','2ª Série EM','A',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"Ele cobre cerca de 70% da superfície terrestre." (1º parágrafo)' AS texto
  UNION ALL SELECT @qid,'B','"Por esses e tantos outros motivos". (2º parágrafo)'
  UNION ALL SELECT @qid,'C','"A data nos convida a celebrar". (2º parágrafo)'
  UNION ALL SELECT @qid,'D','"a importância desse ambiente em nossas vidas". (2º parágrafo)'
  UNION ALL SELECT @qid,'E','"os milhões de toneladas de plásticos que os atingem". (2º parágrafo)'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na passagem do 2º parágrafo "A data nos convida a celebrar a importância desse ambiente em nossas vidas, mas também a promover a conscientização sobre a saúde dos ecossistemas marinhos", a expressão destacada tem a função de','Médio','Coesão textual','2ª Série EM','B',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'explicar a informação anterior.' AS texto
  UNION ALL SELECT @qid,'B','adicionar uma nova informação à anterior.'
  UNION ALL SELECT @qid,'C','concluir a informação anterior.'
  UNION ALL SELECT @qid,'D','contrapor uma informação à anterior.'
  UNION ALL SELECT @qid,'E','comparar uma informação nova com a anterior.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No primeiro parágrafo do texto, há um encadeamento de ideias formadas por verbos seguidos de seus complementos verbais. O trecho do parágrafo composto por um verbo e um objeto indireto é:','Médio','Regência verbal','2ª Série EM','B',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"produz pelo menos metade do oxigênio".' AS texto
  UNION ALL SELECT @qid,'B','"contribui para a economia global".'
  UNION ALL SELECT @qid,'C','"cobre cerca de 70% da superfície terrestre".'
  UNION ALL SELECT @qid,'D','"absorve grande parte do gás carbônico".'
  UNION ALL SELECT @qid,'E','"abriga mais de 200 mil espécies conhecidas".'
) alts WHERE @ja_existe_2s = 0;

-- ---------- Texto de apoio: Kalaf Epalanga, "Minha pátria é a língua pretuguesa" — Q06, Q07, Q08
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Kalaf Epalanga — "Minha pátria é a língua pretuguesa"',
'Foi em Lisboa — não me lembro quem nem onde terá sido —, mas alguém questionou-me sobre o motivo do meu interesse pela escrita, o motivo de escolher a escrita como profissão. A minha resposta: Quando aqui cheguei, na segunda metade dos anos 1990, o choque cultural não foi significativo. Trazia comigo a vantagem da língua e da similaridade de valores culturais e religiosos. Tirando uma ou outra característica comportamental, não havia muito a assinalar que pudesse alimentar um conflito cultural entre nós, africanos, e eles, os brancos, nativos. O único problema residia na pele: quanto mais escura, maiores as dificuldades de integração. A cor tornava palpável a pressão sociocultural sob a qual viviam os pretos, nas periferias dos grandes centros urbanos, entre dois mundos: a África umbilical, da saudade, do sonho e do orgulho de pertença, e Portugal, da adoção, da esperança, do desconhecido e da necessidade.
(Kalaf Epalanga. Minha pátria é a língua pretuguesa: Crônicas 2023. Adaptado)',
1, 2
WHERE @ja_existe_2s = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O termo destacado está empregado em sentido figurado na passagem:','Médio','Sentido figurado','2ª Série EM','D',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"nas periferias dos grandes centros urbanos".' AS texto
  UNION ALL SELECT @qid,'B','"Quando aqui cheguei, na segunda metade dos anos 1990".'
  UNION ALL SELECT @qid,'C','"o motivo de escolher a escrita como profissão".'
  UNION ALL SELECT @qid,'D','"A cor tornava palpável a pressão sociocultural".'
  UNION ALL SELECT @qid,'E','"Foi em Lisboa — não me lembro quem nem onde terá sido".'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O trecho "alguém questionou-me sobre o motivo do meu interesse pela escrita, o motivo de escolher a escrita como profissão." está reescrito conforme a norma-padrão, estabelecendo coesão adequada em:','Difícil','Norma-padrão e coesão','2ª Série EM','A',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'alguém me questionou sobre o motivo do meu interesse pela escrita, de escolhê-la como profissão.' AS texto
  UNION ALL SELECT @qid,'B','alguém questionou-me sobre o motivo do meu interesse pela escrita, de escolhê-lo como profissão.'
  UNION ALL SELECT @qid,'C','alguém me questionou sobre o motivo do meu interesse pela escrita, de escolher ela como profissão.'
  UNION ALL SELECT @qid,'D','alguém questionou-me sobre o motivo do meu interesse pela escrita, de a escolher como profissão.'
  UNION ALL SELECT @qid,'E','alguém me questionou sobre o motivo do meu interesse pela escrita, de o escolher como profissão.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Nas passagens "o choque cultural não foi significativo." e "entre nós, africanos, e eles, os brancos, nativos.", os termos destacados significam, correta e respectivamente:','Médio','Sinonímia','2ª Série EM','E',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'expressivo; aborígenes.' AS texto
  UNION ALL SELECT @qid,'B','contundente; indígenas.'
  UNION ALL SELECT @qid,'C','importante; selvagens.'
  UNION ALL SELECT @qid,'D','próprio; estrangeiros.'
  UNION ALL SELECT @qid,'E','relevante; naturais.'
) alts WHERE @ja_existe_2s = 0;

-- ---------- Texto de apoio: "Úrsula" (Maria Firmina dos Reis) — Q09, Q10
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Úrsula — Maria Firmina dos Reis',
'São vastos e belos os nossos campos; porque inundados pelas torrentes do inverno semelham o oceano em bonançosa calma – branco lençol de espuma, que não ergue marulhadas ondas, nem brame irado, ameaçando insano quebrar os limites, que lhe marcou a onipotente mão do rei da criação. Enrugada ligeiramente a superfície pelo manso correr da viração, frisadas as águas, aqui e ali, pelo volver rápido e fugitivo dos peixinhos, que mudamente se afagam, e que depois desaparecem para de novo voltarem — os campos são qual vasto deserto, majestoso e grande como o espaço, sublime como o infinito.

E a sua beleza é amena e doce, e o exíguo esquife, esquife, que vai cortando as suas águas hibernais mansas e quedas, e o homem, que sem custo o guia, e que sente vaga sensação de melancólico enlevo, desprende com mavioso acento um canto de harmoniosa saudade, despertado pela grandeza dessas águas, que sulca.
(Maria Firmina dos Reis. Úrsula. 2021)

Glossário: marulhadas = de águas agitadas; viração = brisa marinha; esquife = pequena embarcação; enlevo = deleite; mavioso = sensível; sulca = navega.',
1, 2
WHERE @ja_existe_2s = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O texto apresentado é predominantemente','Médio','Tipologia textual','2ª Série EM','C',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'narrativo, com ações desenvolvidas no oceano que encanta o narrador.' AS texto
  UNION ALL SELECT @qid,'B','descritivo, com uso de detalhes sutis indicativos do sofrimento do narrador.'
  UNION ALL SELECT @qid,'C','descritivo, com caracterização subjetiva do local sob os efeitos do inverno.'
  UNION ALL SELECT @qid,'D','narrativo, com fatos reveladores da violência que contrasta com o cenário.'
  UNION ALL SELECT @qid,'E','dissertativo, com reflexões sobre a beleza efêmera dos cenários naturais.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A concordância verbal e a concordância nominal estão em conformidade com a norma-padrão em:','Difícil','Concordância verbal e nominal','2ª Série EM','D',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Volta rápido e foge os peixinhos do oceano, que depois desaparecem para novamente voltarem.' AS texto
  UNION ALL SELECT @qid,'B','A amenidade e a doçura é típico das águas do oceano, que é majestoso e grande como o espaço.'
  UNION ALL SELECT @qid,'C','Quando ocorre as torrentes do inverno, é como se nossos campos ficassem igual ao oceano.'
  UNION ALL SELECT @qid,'D','Os nossos campos, que dispõem de vastidão e beleza, são inundados pelas torrentes do inverno.'
  UNION ALL SELECT @qid,'E','Não se ergue marulhadas ondas com o branco lençol de espuma, tomados em bonançosa calma.'
) alts WHERE @ja_existe_2s = 0;

-- ---------- Texto de apoio: "Rosa de Hiroshima" + postagem "A cebola" — Q11, Q12
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Texto 1 e Texto 2 — "Rosa de Hiroshima" e postagem "A cebola"',
'Texto 1 — "Rosa de Hiroshima" (Gerson Conrad e Vinícius de Moraes):
"Pensem nas crianças mudas, telepáticas
Pensem nas meninas cegas, inexatas
Pensem nas mulheres, rotas alteradas
Pensem nas feridas como rosas cálidas
Mas, ó, não se esqueçam da rosa, da rosa
Da rosa de Hiroshima, a rosa hereditária
A rosa radioativa, estúpida e inválida
A rosa com cirrose, a anti-rosa atômica
Sem cor, sem perfume, sem rosa, sem nada"
(https://www.letras.mus.br. Acesso em 12.08.2025)

Texto 2 — postagem na rede social "A cebola", de Jean Galvão (@jeangalvao), reproduzindo entre aspas dois versos da canção:
"Pensem nas meninas,
cegas, inexatas
Pensem nas mulheres,
rotas alteradas..."
(https://www.instagram.com/jeangalvao. Acesso em 12.08.2025)',
1, 2
WHERE @ja_existe_2s = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na letra da canção e na postagem da rede social, a forma verbal "Pensem" sugere aos interlocutores que','Médio','Interpretação de texto','2ª Série EM','A',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'se conscientizem do sofrimento vivido por muitas pessoas.' AS texto
  UNION ALL SELECT @qid,'B','se empenhem em livrar as pessoas de seus maiores sofrimentos.'
  UNION ALL SELECT @qid,'C','se responsabilizem pelo sofrimento vivido por muitas pessoas.'
  UNION ALL SELECT @qid,'D','se desculpem com as pessoas expostas aos problemas e tristezas.'
  UNION ALL SELECT @qid,'E','se distanciem paulatinamente das pessoas e de seus sofrimentos.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No texto 2, o emprego das aspas ocorre para marcar a intertextualidade por meio','Médio','Intertextualidade','2ª Série EM','B',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'da referência distorcida a alguns termos da canção.' AS texto
  UNION ALL SELECT @qid,'B','da citação fidedigna de dois versos da canção.'
  UNION ALL SELECT @qid,'C','da ironia que subverte o sentido expresso na canção.'
  UNION ALL SELECT @qid,'D','de uma paródia que satiriza o conteúdo da canção.'
  UNION ALL SELECT @qid,'E','da alusão que se faz a alguns conceitos da canção.'
) alts WHERE @ja_existe_2s = 0;

-- ---------- Texto de apoio: "O Guarani" (José de Alencar) — Q13, Q14, Q15
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'O Guarani — José de Alencar',
'Era Peri.
Altivo, nobre, radiante da coragem invencível e do sublime heroísmo de que já dera tantos exemplos, o índio se apresentava só em face de duzentos inimigos fortes e sequiosos de vingança.

Caindo do alto de uma árvore sobre eles, tinha abatido dois; e volvendo o seu montante como um raio em torno de sua cabeça abriu um círculo no meio dos selvagens.

Então encostou-se a uma lasca de pedra que descansava sobre uma ondulação do terreno, e preparou-se para o combate monstruoso de um só homem contra duzentos.

A posição em que se achava o favorecia, se isso é possível à vista de uma tal disparidade de número: apenas dois inimigos podiam atacá-lo de frente.

Passado o primeiro espanto, os selvagens bramindo atiraram-se todos como uma só mole, como uma tromba do oceano, contra o índio que ousava atacá-los a peito descoberto.
(José de Alencar. O Guarani, 1996)

Glossário: sequioso = desejoso; montante = grande espada antiga; bramindo = urrando; mole = imensa massa humana; tromba = grande volume de água.',
1, 2
WHERE @ja_existe_2s = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No texto, o narrador','Fácil','Interpretação de texto','2ª Série EM','E',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'descreve uma natureza exuberante.' AS texto
  UNION ALL SELECT @qid,'B','lamenta a morte de Peri.'
  UNION ALL SELECT @qid,'C','faz referência a mitos indígenas.'
  UNION ALL SELECT @qid,'D','analisa os sentimentos dos selvagens.'
  UNION ALL SELECT @qid,'E','exalta a bravura de Peri.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na passagem "os selvagens bramindo atiraram-se todos como uma só mole, como uma tromba do oceano" (6º parágrafo), a expressão destacada apresenta uma','Médio','Figuras de linguagem','2ª Série EM','C',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'hipérbole que enfatiza o pedido de ajuda dos selvagens.' AS texto
  UNION ALL SELECT @qid,'B','metáfora que indica a velocidade da fuga dos selvagens.'
  UNION ALL SELECT @qid,'C','comparação que expressa a violência do ataque dos selvagens.'
  UNION ALL SELECT @qid,'D','comparação que intensifica o sentimento de medo de Peri.'
  UNION ALL SELECT @qid,'E','metáfora que sugere a destreza de Peri no manejo da espada.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma característica da estética romântica brasileira presente no texto é a valorização','Médio','Romantismo','2ª Série EM','D',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'da persistência do conquistador, representada pelos selvagens.' AS texto
  UNION ALL SELECT @qid,'B','do amor à pátria, representado pelos portugueses.'
  UNION ALL SELECT @qid,'C','do exílio na natureza, representado pelas terras inabitadas.'
  UNION ALL SELECT @qid,'D','do elemento nacional, representado pelo indígena.'
  UNION ALL SELECT @qid,'E','da paisagem bucólica, representada pela vegetação abundante.'
) alts WHERE @ja_existe_2s = 0;

-- ---------- Questão isolada: poema de Sérgio Vaz (literatura periférica) — Q16
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o poema de Sérgio Vaz, pertencente à literatura periférica: "A fome sabe / onde o pobre mora, / e a felicidade não sabe andar / nos becos e vielas. / A Geografia da dor / registra no mapa / gente viva / com a barriga morta. / O arroz e o feijão / alegam não ter nada a ver com isso. / Quem se importa? / No vazio do garfo e da faca, / o tempero da revolta." (Sérgio Vaz. Flores da batalha, 2022) No poema, o eu lírico critica','Médio','Literatura periférica','2ª Série EM','A',1,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a indiferença diante da fome dos pobres, conforme se pode observar em "Quem se importa?".' AS texto
  UNION ALL SELECT @qid,'B','o desperdício de alimentos como causa da fome entre os mais pobres, conforme se observa em "No vazio do garfo e da faca".'
  UNION ALL SELECT @qid,'C','a falta de informações oficiais sobre as pessoas em situação de rua, conforme se pode observar em "gente viva".'
  UNION ALL SELECT @qid,'D','a ausência da fome nos espaços considerados nobres da cidade, conforme se observa em "nos becos e vielas".'
  UNION ALL SELECT @qid,'E','a aceitação da falta de alimentos como algo natural da existência, conforme se pode observar em "o tempero da revolta".'
) alts WHERE @ja_existe_2s = 0;

-- ---------- Texto de apoio: "O Primo Basílio" (Eça de Queirós) — Q17, Q18
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'O Primo Basílio — Eça de Queirós',
'Tinham dado onze horas no cuco da sala de jantar. Jorge fechou o volume de Luís Figuier que estivera folheando devagar, estirado na velha voltaire de marroquim escuro, espreguiçou-se, bocejou e disse:
— Tu não te vais vestir, Luísa?
— Logo.
Ficara sentada à mesa a ler o Diário de Notícias, no seu roupão de manhã de fazenda preta, bordado a sutache, com largos botões de madrepérola; o cabelo louro um pouco desmanchado, com um tom seco do calor do travesseiro, enrolava-se, torcido no alto da cabeça pequenina, de perfil bonito; a sua pele tinha a brancura tenra e láctea das louras; com o cotovelo encostado à mesa acariciava a orelha, e, no movimento lento e suave dos seus dedos, dois anéis de rubis miudinhos davam cintilações escarlates.
Tinham acabado de almoçar.
(Eça de Queirós. O Primo Basílio. http://www.dominiopublico.gov.br. Acesso em 05.08.2025)

Glossário: voltaire = tipo de poltrona; marroquim = couro curtido de bode ou cabra; sutache = pequena trança de algodão, lã ou seda, que enfeita peças de vestuário; escarlate = vermelho.',
1, 2
WHERE @ja_existe_2s = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma característica da estética realista presente no texto é','Médio','Realismo','2ª Série EM','B',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a opinião explícita do narrador sobre os personagens.' AS texto
  UNION ALL SELECT @qid,'B','a descrição detalhada e objetiva de um personagem.'
  UNION ALL SELECT @qid,'C','a crítica ao modo de vida fútil das camadas populares.'
  UNION ALL SELECT @qid,'D','a composição de um cenário predominantemente bucólico.'
  UNION ALL SELECT @qid,'E','a idealização da mulher e das relações amorosas.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O texto retrata uma cena na qual Luísa é apresentada em um momento de','Fácil','Interpretação de texto','2ª Série EM','A',1,2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'despreocupação.' AS texto
  UNION ALL SELECT @qid,'B','entusiasmo.'
  UNION ALL SELECT @qid,'C','frustação.'
  UNION ALL SELECT @qid,'D','inquietação.'
  UNION ALL SELECT @qid,'E','desilusão.'
) alts WHERE @ja_existe_2s = 0;

-- ==========================================================
--  BLOCO B — Língua Inglesa
-- ==========================================================

-- ---------- Texto de apoio: "Killing two birds with one stone" — Q19, Q20, Q21
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Killing two birds with one stone',
'This post will cover some common ways of talking about doing things successfully. Informally, it is very common to say that we "get something done". When something is completed successfully and often more easily than you expected, you might exclaim, "Job done!" More formally, we can say we "achieve" or "accomplish" something, especially when it takes a lot of effort. In informal English, when people achieved something extremely well, we can say they "smashed it". If someone succeeded easily in something difficult, such as an exam, the person "sailed through" it.

Finally, if you are lucky enough to achieve two things with the same action, you could use the expression "kill two birds with one stone". I hope this post has fulfilled its aim and that you have managed to learn some new words to help you sail through your exams!
(Liz Walter. https://dictionaryblog.cambridge.org. Acesso em 03.07.2025. Adaptado)',
(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'), 2
WHERE @ja_existe_2s = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O trecho que apresenta o objetivo do texto é:','Médio','Reading comprehension - objetivo do texto','2ª Série EM','E',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"Informally, it is very common to say that we ''get something done''".' AS texto
  UNION ALL SELECT @qid,'B','"In informal English, when people do something extremely well, we can say they ''smashed it''".'
  UNION ALL SELECT @qid,'C','"If someone succeeded easily in something difficult, such as an exam, the person ''sailed through'' it".'
  UNION ALL SELECT @qid,'D','"I hope this post has fulfilled its aim and that you have managed to learn some new words to help you sail through your exams!"'
  UNION ALL SELECT @qid,'E','"This post will cover some common ways of talking about doing things successfully".'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No texto, a expressão que é usada para dizer que uma tarefa difícil foi realizada com facilidade é','Fácil','Reading comprehension - expressões idiomáticas','2ª Série EM','E',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"achieve".' AS texto
  UNION ALL SELECT @qid,'B','"accomplish".'
  UNION ALL SELECT @qid,'C','"smashed it".'
  UNION ALL SELECT @qid,'D','"get something done".'
  UNION ALL SELECT @qid,'E','"sailed through".'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No trecho do segundo parágrafo — if you are lucky enough to achieve two things with the same action, you could use the expression "kill two birds with one stone" —, a expressão entre aspas equivale, em português, a','Médio','Expressões idiomáticas','2ª Série EM','C',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ter dois pesos e duas medidas.' AS texto
  UNION ALL SELECT @qid,'B','trocar seis por meia dúzia.'
  UNION ALL SELECT @qid,'C','acertar dois coelhos com uma só cajadada.'
  UNION ALL SELECT @qid,'D','mais vale um pássaro na mão do que dois voando.'
  UNION ALL SELECT @qid,'E','estar com a faca e o queijo na mão.'
) alts WHERE @ja_existe_2s = 0;

-- ---------- Texto de apoio: "Climate change is happening" — Q22, Q23, Q24
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Climate change is happening',
'Climate change is already affecting every region on Earth. Changes in rain cycles, rising sea levels, melting glaciers, a warming ocean, and more frequent and intense extreme weather events are now impacting millions of people.

Climate change can affect our health, ability to grow food, housing, safety and work. Some of us are more vulnerable to climate impacts, such as people living in small islands and in poorer countries. Because of sea-level rise, for example, whole communities have had to move to other places. In the future, the number of people displaced by climate change is expected to go up.

The changes in the climate are everywhere, rapid and intensifying, and some of the changes, such as sea-level rise or melting ice sheets, are irreversible over hundreds to thousands of years.
(www.un.org/en. Acesso em 30.07.2025. Adaptado)',
(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'), 2
WHERE @ja_existe_2s = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O título do texto — Climate change is happening — e a primeira frase — Climate change is already affecting every region on Earth — mostram, por meio do uso do tempo verbal, que a mudança climática','Médio','Reading comprehension - tempos verbais','2ª Série EM','D',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'deve manifestar-se futuramente.' AS texto
  UNION ALL SELECT @qid,'B','já ocorreu e se encerrou.'
  UNION ALL SELECT @qid,'C','talvez possa tornar-se real.'
  UNION ALL SELECT @qid,'D','está em curso no momento.'
  UNION ALL SELECT @qid,'E','está prestes a acontecer.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No trecho do segundo parágrafo — Some of us are more vulnerable to climate impacts, such as people living in small islands and in poorer countries. —, a expressão "such as" introduz','Fácil','Reading comprehension - conectivos','2ª Série EM','A',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'uma exemplificação.' AS texto
  UNION ALL SELECT @qid,'B','uma finalidade.'
  UNION ALL SELECT @qid,'C','um contraste.'
  UNION ALL SELECT @qid,'D','uma causa.'
  UNION ALL SELECT @qid,'E','uma alternativa.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'De acordo com o texto, um efeito da mudança climática considerado irreversível em um futuro diz respeito a','Médio','Reading comprehension - interpretação','2ª Série EM','B',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'the heat of the oceans.' AS texto
  UNION ALL SELECT @qid,'B','the rise of sea waters.'
  UNION ALL SELECT @qid,'C','changes in rain cycles.'
  UNION ALL SELECT @qid,'D','problems in food distribution.'
  UNION ALL SELECT @qid,'E','the protection of poorer populations.'
) alts WHERE @ja_existe_2s = 0;

-- ==========================================================
--  BLOCO C — Física
-- ==========================================================

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O Brasil possui a maior quantidade de nióbio do mundo, com 98% de todas as reservas conhecidas. Esse metal possui cada vez mais importância mundial por ser o material supercondutor mais comum. Sua alta temperatura crítica de 9,3 K (abaixo da qual o nióbio torna-se supercondutor), em comparação com outros materiais, torna-o essencial em setores tecnológicos que utilizam campos magnéticos fortes, como os aparelhos de ressonância magnética usados na medicina para diagnósticos de imagem. Considerando que o ponto de congelamento da água é de 273,0 K e que o ponto de ebulição da água é de 373,0 K, a temperatura crítica do nióbio, em graus Celsius, é igual a','Médio','Termometria','2ª Série EM','D',4,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'– 254,4 ºC.' AS texto
  UNION ALL SELECT @qid,'B','– 245,1 ºC.'
  UNION ALL SELECT @qid,'C','– 175,0 ºC.'
  UNION ALL SELECT @qid,'D','– 263,7 ºC.'
  UNION ALL SELECT @qid,'E','– 282,3 ºC.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O titânio tem se tornado cada vez mais importante na fabricação de componentes aeroespaciais onde o controle térmico e a resistência a altas temperaturas são cruciais. O baixo calor específico do titânio de 0,52 J/(g·ºC) desempenha um papel importante nesse aspecto. Uma amostra de 100 g de titânio, inicialmente a uma temperatura de 20 ºC, que receba uma quantidade de calor igual a 520 J, terá sua temperatura alterada para','Fácil','Calorimetria','2ª Série EM','A',4,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'30 ºC.' AS texto
  UNION ALL SELECT @qid,'B','22 ºC.'
  UNION ALL SELECT @qid,'C','24 ºC.'
  UNION ALL SELECT @qid,'D','26 ºC.'
  UNION ALL SELECT @qid,'E','28 ºC.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um observador O vê um lápis de 18 cm de altura imerso, verticalmente, em um aquário preenchido com uma coluna d''água de 16 cm. Considerando que o índice de refração do ar no local é igual a 1, o índice de refração da água no aquário é igual a 4/3, e o ângulo de observação com relação à reta normal à superfície da água é muito pequeno, a altura aparente do lápis, na visão do observador, é igual a','Difícil','Óptica - refração','2ª Série EM','C',4,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'16,5 cm.' AS texto
  UNION ALL SELECT @qid,'B','13,5 cm.'
  UNION ALL SELECT @qid,'C','14,0 cm.'
  UNION ALL SELECT @qid,'D','15,0 cm.'
  UNION ALL SELECT @qid,'E','12,0 cm.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Lasers possuem muitas aplicações em tratamentos médicos, desde procedimentos estéticos até equipamentos cirúrgicos. O tipo de laser utilizado depende de seu poder de penetração na pele humana. A tabela mostra o nível de penetração na pele humana para alguns tipos de lasers utilizados e seus comprimentos de onda λ: Excimer, λ = 190×10⁻⁹ m, penetra até o Estrato córneo da pele; KTP, λ = 530×10⁻⁹ m, até a Epiderme; PDL, λ = 600×10⁻⁹ m, até a Derme; Diodo, λ = 800×10⁻⁹ m, até os Vasos sanguíneos da pele; Nd:YAG, λ = 1060×10⁻⁹ m, até a Gordura subcutânea. Uma propriedade importante do laser é que o produto entre o seu comprimento de onda λ e a sua frequência f é constante e igual à velocidade da luz c = 3×10⁸ m/s. Se um feixe de laser é emitido com uma frequência igual a 5×10¹⁴ Hz, o nível de penetração dele na pele humana será até','Difícil','Ondas eletromagnéticas','2ª Série EM','A',4,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a derme.' AS texto
  UNION ALL SELECT @qid,'B','a epiderme.'
  UNION ALL SELECT @qid,'C','os vasos sanguíneos da pele.'
  UNION ALL SELECT @qid,'D','o estrato córneo da pele.'
  UNION ALL SELECT @qid,'E','a gordura subcutânea.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Ouvir música é uma ótima maneira de relaxar. Com o avanço da tecnologia, os fones de ouvido se tornaram uma parte essencial de nossas vidas. No entanto, ouvir músicas com fones de ouvido pode, em certos casos, levar à perda auditiva. Estudos demonstram que a exposição prolongada a sons acima de 85 decibéis (dB) pode causar perda auditiva permanente. (https://www.otone.com.br, 21.03.2023. Adaptado) O decibel é uma unidade de medida utilizada para medir a propriedade sonora denominada','Fácil','Acústica','2ª Série EM','E',4,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'altura.' AS texto
  UNION ALL SELECT @qid,'B','reverberação.'
  UNION ALL SELECT @qid,'C','timbre.'
  UNION ALL SELECT @qid,'D','eco.'
  UNION ALL SELECT @qid,'E','intensidade.'
) alts WHERE @ja_existe_2s = 0;

-- ==========================================================
--  BLOCO D — Química
-- ==========================================================

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Deseja-se aquecer óxido de cobre (II) até sua fusão, que ocorre a 1326 ºC. O laboratório dispõe de um forno que atinge até 1500 ºC e de recipientes dos materiais apresentados no quadro (temperatura de fusão): Alumínio 660 ºC; Cobre 1085 ºC; Estanho 232 ºC; Tungstênio 3422 ºC; Vidro borossilicato 820 ºC. Para realizar a fusão do óxido de cobre (II) no forno, sem risco de danificar o recipiente, esse procedimento deve ser realizado em um recipiente feito de','Médio','Ponto de fusão','2ª Série EM','D',5,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'cobre.' AS texto
  UNION ALL SELECT @qid,'B','estanho.'
  UNION ALL SELECT @qid,'C','alumínio.'
  UNION ALL SELECT @qid,'D','tungstênio.'
  UNION ALL SELECT @qid,'E','vidro borossilicato.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A presença de oxidantes como o peróxido de hidrogênio (H2O2) em alimentos pode ser determinada através de uma reação com íons iodeto (I–). A reação entre o iodeto e o peróxido de hidrogênio forma iodo molecular (I2), que produz uma cor amarelada na solução, evidenciando a presença do oxidante. A reação entre os íons iodeto e o peróxido de hidrogênio é representada pela equação: 2I– + H2O2 + 2H+ → I2 + 2H2O. Em uma análise de rotina para verificar a presença de peróxido de hidrogênio (M = 34 g/mol) no leite de vaca, uma amostra de 10 mL de leite consumiu 5×10⁻³ mol de íons iodeto. A concentração de peróxido de hidrogênio, em g/L, na amostra analisada, é igual a','Difícil','Estequiometria','2ª Série EM','A',5,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'8,5.' AS texto
  UNION ALL SELECT @qid,'B','17,3.'
  UNION ALL SELECT @qid,'C','12,0.'
  UNION ALL SELECT @qid,'D','22,5.'
  UNION ALL SELECT @qid,'E','4,3.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A tecnologia XTL consiste em transformar fontes de carbono de diferentes naturezas em hidrocarbonetos líquidos usados como combustível ou outros insumos químicos. O processo parte de matérias-primas (carvão, gás natural ou biomassa), que geram um gás de síntese (CO + H2), convertido em hidrocarbonetos líquidos — produtos finais como diesel, querosene de avião e insumos químicos. (Mota, C.J.A. e Monteiro, R.S., Quim. Nova, 36(10), 2013. Adaptado) Um exemplo de fonte de carbono para o processo XTL que fará a produção de hidrocarbonetos ser considerada renovável é','Médio','Fontes renováveis de carbono','2ª Série EM','C',5,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o etanol produzido pela hidrogenação do etileno.' AS texto
  UNION ALL SELECT @qid,'B','resíduos plásticos oriundos da reciclagem de derivados do petróleo.'
  UNION ALL SELECT @qid,'C','a fibra celulósica do bagaço de cana-de-açúcar.'
  UNION ALL SELECT @qid,'D','o carvão mineral formado por matéria orgânica fossilizada.'
  UNION ALL SELECT @qid,'E','o metano extraído do subsolo.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma das tendências modernas para a construção de pilhas e baterias é a chamada bateria de estado sólido, em que o eletrólito líquido é substituído por um material sólido que permite a troca iônica entre os compartimentos anódico e catódico. Na bateria de estado sólido recarregável ilustrada, o cátodo é composto por nanotubos de carbono e recebe o fluxo de O2; o ânodo é de lítio; entre eles há um separador polimérico que permite o transporte de íons. As reações químicas envolvidas são: Li → Li+ + e– (no ânodo) e O2 + 2Li+ + 2e– → Li2O2 (no cátodo). (microtexindia.com. Acesso em 10.08.2025. Adaptado) A partir dessas informações, é correto afirmar que, quando essa bateria sofre descarga, o lítio sofre ______ e seus íons migram pelo separador polimérico em direção ao ______ de nanotubo de carbono, onde reagem com o ar externo fazendo com que a massa da bateria ______. As lacunas do texto devem ser preenchidas, correta e respectivamente, por:','Difícil','Eletroquímica','2ª Série EM','E',5,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'oxidação ... ânodo ... permaneça constante' AS texto
  UNION ALL SELECT @qid,'B','redução ... cátodo ... aumente'
  UNION ALL SELECT @qid,'C','oxidação ... ânodo ... diminua'
  UNION ALL SELECT @qid,'D','redução ... ânodo ... diminua'
  UNION ALL SELECT @qid,'E','oxidação ... cátodo ... aumente'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O radioisótopo lutécio-177 (177Lu) é utilizado em tratamentos de tumores neuroendócrinos, podendo ser produzido por meio de dois processos distintos, conforme as equações a seguir: 176-71Lu + w → 177-71Lu ; 177-70Yb → x + 177-71Lu. As partículas representadas pelas letras w e x são, respectivamente,','Difícil','Radioatividade','2ª Série EM','C',5,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'próton e partícula beta.' AS texto
  UNION ALL SELECT @qid,'B','nêutron e partícula alfa.'
  UNION ALL SELECT @qid,'C','nêutron e partícula beta.'
  UNION ALL SELECT @qid,'D','partícula alfa e partícula beta.'
  UNION ALL SELECT @qid,'E','partícula beta e próton.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A menadiona, também conhecida como vitamina K3, é um composto sintético pertencente ao grupo das vitaminas K. Diferentemente das formas naturais (vitaminas K1 e K2), a vitamina K3 não é encontrada diretamente nos alimentos, mas pode ser convertida no organismo em compostos ativos que desempenham funções biológicas importantes. Sua fórmula estrutural corresponde à 2-metil-1,4-naftoquinona: dois anéis aromáticos fundidos (naftaleno), com dois grupos carbonila (C=O) no anel e um grupo metila (CH3) substituinte. A cadeia apresentada na molécula de menadiona e o grupo funcional característico são, respectivamente,','Médio','Funções orgânicas','2ª Série EM','D',5,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'alifática e cetona.' AS texto
  UNION ALL SELECT @qid,'B','aromática e éster.'
  UNION ALL SELECT @qid,'C','alifática e aldeído.'
  UNION ALL SELECT @qid,'D','aromática e cetona.'
  UNION ALL SELECT @qid,'E','alifática e éster.'
) alts WHERE @ja_existe_2s = 0;

-- ==========================================================
--  BLOCO E — Biologia
-- ==========================================================

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a tirinha do cartunista Jean Pico. No 1º quadrinho, um personagem pergunta: "Se o tratamento de esgoto é tão bom assim, como o lago ficou cheio de dejetos humanos?". No 2º quadrinho, o outro responde: "O problema é com o esgoto da chuva? Como é o nome mesmo?" e o primeiro emenda: "Isso, pluvial! Então o problema é o esgoto pluvial?". No 3º quadrinho, o segundo esclarece: "O esgoto pluvial é super importante, ele não traz sujeira para o lago!". No 4º quadrinho, ele se corrige: "Ah... Corrigindo: o esgoto pluvial não deveria trazer sujeira para o lago...". (https://www.jornalecao.com.br. Acesso em 01.08.2025) O problema ambiental abordado na tirinha pode ser causado pela','Médio','Saneamento e poluição hídrica','2ª Série EM','B',3,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'baixa disponibilidade de aterros sanitários municipais.' AS texto
  UNION ALL SELECT @qid,'B','ligação irregular do esgoto residencial à rede de águas pluviais.'
  UNION ALL SELECT @qid,'C','ampla impermeabilização do solo por asfalto e concreto.'
  UNION ALL SELECT @qid,'D','ausência de coleta do lixo reciclável nos bairros residenciais.'
  UNION ALL SELECT @qid,'E','liberação ilegal de lixo sólido nas margens dos rios e lagos.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os vapes ou cigarros eletrônicos conquistam cada vez mais usuários, sobretudo jovens. Esses dispositivos podem ter quantidades de nicotina ainda maiores do que o cigarro. É o caso dos modelos que levam os chamados sais de nicotina, uma combinação da substância com o ácido benzoico. A mistura faz com que a nicotina seja mais facilmente absorvida na corrente sanguínea, além de tornar o vapor mais "tragável", o que resulta em um produto ainda mais viciante. (https://revistagalileu.globo.com. Acesso em 28.07.2025. Adaptado) No sistema respiratório humano, a absorção da nicotina para corrente sanguínea ocorre','Fácil','Fisiologia respiratória','2ª Série EM','A',3,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'nos alvéolos.' AS texto
  UNION ALL SELECT @qid,'B','nos bronquíolos.'
  UNION ALL SELECT @qid,'C','na traqueia.'
  UNION ALL SELECT @qid,'D','nos brônquios.'
  UNION ALL SELECT @qid,'E','na laringe.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A pelagem nas extremidades do corpo dos coelhos himalaias pode assumir cores distintas conforme a temperatura do ambiente. Em um experimento, um coelho himalaia criado em temperatura igual ou menor que 20 ºC desenvolveu pelagem escura nas extremidades (orelhas, nariz, patas e cauda), enquanto outro coelho, geneticamente idêntico, criado em temperaturas acima de 30 ºC, desenvolveu pelagem inteiramente branca. (www.nature.com. Acesso em 29.07.2025. Adaptado) Em relação à cor da pelagem desses animais, o experimento demonstra que','Médio','Genética - interação gene-ambiente','2ª Série EM','A',3,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o mesmo genótipo de um coelho himalaia pode expressar fenótipos diferentes.' AS texto
  UNION ALL SELECT @qid,'B','o genótipo de um coelho himalaia é determinado pela temperatura do meio.'
  UNION ALL SELECT @qid,'C','o genótipo de um coelho himalaia pode ser alterado por variação de temperatura.'
  UNION ALL SELECT @qid,'D','as alterações de temperatura causam mutações gênicas em coelhos himalaias.'
  UNION ALL SELECT @qid,'E','as temperaturas mais baixas bloqueiam a expressão do fenótipo em coelhos himalaias.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No Brasil, a ingestão do açaí processado artesanalmente, sem tratamento térmico, tem sido relacionada a casos crescentes dessa doença, por contaminação dos frutos pelo protozoário encontrado no inseto conhecido como "barbeiro". Uma das etapas mais importantes das Boas Práticas de Fabricação do açaí é o choque térmico que deve ser realizado em água à temperatura entre 80 °C e 90 °C, durante dez segundos, e rapidamente resfriados em água à temperatura ambiente, fazendo com que haja a inativação do protozoário. (https://www.alice.cnptia.embrapa.br. Acesso em 03.08.2025. Adaptado) A etapa de Boas Práticas de Fabricação do açaí descrita no texto tem como objetivo eliminar o protozoário causador da','Fácil','Doenças parasitárias','2ª Série EM','E',3,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'malária.' AS texto
  UNION ALL SELECT @qid,'B','sífilis.'
  UNION ALL SELECT @qid,'C','febre amarela.'
  UNION ALL SELECT @qid,'D','tuberculose.'
  UNION ALL SELECT @qid,'E','doença de Chagas.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma mutação genética causou a troca de um aminoácido valina por um aminoácido glicina em uma proteína. A tabela mostra as trincas de bases nitrogenadas (códons) no RNA mensageiro que codificam os aminoácidos valina e glicina nessa proteína: Valina = GUG; Glicina = GGG. A mutação no gene (DNA) que codifica essa proteína resultou na substituição da base nitrogenada','Difícil','Genética molecular','2ª Série EM','C',3,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'guanina por timina.' AS texto
  UNION ALL SELECT @qid,'B','timina por adenina.'
  UNION ALL SELECT @qid,'C','adenina por citosina.'
  UNION ALL SELECT @qid,'D','citosina por guanina.'
  UNION ALL SELECT @qid,'E','guanina por adenina.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A água de lastro preenche os porões de grandes navios descarregados para equilibrar sua estrutura física, assegurando assim as condições de navegabilidade. O processo ocorre em cinco etapas: no porto de origem, o navio descarregado tem suas águas de lastro bombeadas para os tanques; durante a viagem para o porto de carregamento, os tanques de lastro permanecem cheios; no porto de destino, o navio é carregado e, em seguida, as águas de lastro dos tanques são descarregadas nesse novo porto. (https://olharoceanografico.com. Acesso em 31.07.2025. Adaptado) A utilização da água de lastro por navios cargueiros contribui com','Médio','Espécies invasoras','2ª Série EM','B',3,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a alteração da composição de sais minerais nas águas dos ecossistemas onde ocorre a descarga das águas de lastro dos tanques dos navios.' AS texto
  UNION ALL SELECT @qid,'B','a introdução de espécies exóticas invasoras nos ecossistemas em que ocorre a descarga das águas de lastro dos tanques dos navios.'
  UNION ALL SELECT @qid,'C','o aumento da quantidade de alimento disponível nos ecossistemas em que ocorre a descarga das águas de lastro dos tanques dos navios.'
  UNION ALL SELECT @qid,'D','a redução do número de espécies nativas que vivem nos ecossistemas onde ocorre o bombeamento das águas de lastro para os tanques dos navios.'
  UNION ALL SELECT @qid,'E','a extinção das espécies que morrem nos tanques de lastros dos navios durante as viagens de transporte de cargas entre os portos.'
) alts WHERE @ja_existe_2s = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Pesquisadores brasileiros desenvolveram um soro antiapílico para o tratamento contra o veneno de abelhas africanizadas. A produção consiste em injetar nos cavalos duas proteínas selecionadas do veneno das abelhas e extrair os anticorpos do plasma dos equinos para obter soro antiapílico. Entre os processos necessários para produção desse soro, está a posterior adição da enzima pepsina, utilizada para partir a fração dos anticorpos responsável por identificar que ele foi produzido pelos cavalos. (https://jornal.unesp.br. Acesso em 01.08.2025. Adaptado) A adição da enzima pepsina na produção do soro antiapílico impede que, na pessoa tratada, ocorra','Difícil','Imunologia','2ª Série EM','D',3,2,NULL,TRUE
WHERE @ja_existe_2s = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'fabricação de antígenos contra as proteínas do cavalo.' AS texto
  UNION ALL SELECT @qid,'B','produção de células de memória contra o veneno da abelha.'
  UNION ALL SELECT @qid,'C','inativação das células de memória pelas proteínas do cavalo.'
  UNION ALL SELECT @qid,'D','reação imunológica contra os anticorpos fabricados pelo cavalo.'
  UNION ALL SELECT @qid,'E','baixa produção de anticorpos contra o veneno da abelha.'
) alts WHERE @ja_existe_2s = 0;
