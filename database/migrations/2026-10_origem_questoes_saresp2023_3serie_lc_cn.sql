-- ==========================================================
--  Migração de conteúdo: Banco de questões SARESP 2023 — 3ª Série EM
--  Caderno 017-LC-CN (Linguagens/Inglês + Ciências da Natureza), Cad01,
--  aplicado como Provão Paulista Seriado 2023 (28.11.2023) — Versão 1.
--  Fonte: caderno de questões + gabarito oficial (Fundação Vunesp) fornecidos pela coordenação.
--  ----------------------------------------------------------
--  Origem das questões: SARESP (coluna questoes.origem, criada pela
--  migração 2026-10_origem_questoes.sql — por isso este arquivo vem depois dela).
--
--  Escopo: as 48 questões do caderno foram importadas. Nas questões 1, 7, 11, 12,
--  23, 29, 30, 32, 33, 34, 38, 39, 41, 42, 47 e 48, a figura/charge/tira/gráfico
--  foi descrita em texto no enunciado. Palavras destacadas (negrito/sublinhado)
--  no caderno aparecem entre _ _ (questões 4, 6, 9, 10, 15, 16, 18 e 19).
--
--  Gabarito: Versão 1 do gabarito oficial (Cad01).
--
--  Idempotente: variável de sessão travada no início (@ja_existe_23e), sem
--  DELIMITER/stored procedures (incompatível com a execução via db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-10_origem_questoes_saresp2023_3serie_lc_cn.sql)
-- ==========================================================
SET @db := DATABASE();

-- Garante que a disciplina "Língua Inglesa" existe (idempotente)
INSERT INTO disciplinas (nome, area)
SELECT 'Língua Inglesa', 'Linguagens'
WHERE NOT EXISTS (SELECT 1 FROM disciplinas WHERE nome = 'Língua Inglesa');

-- Guarda travada: já aplicamos este lote antes?
SET @ja_existe_23e := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'Leia a charge do chargista Lute%'
);


-- Q01
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a charge do chargista Lute (https://www.hojeemdia.com.br/opiniao/blog-do-lute/charge-do-lute-11-02-2023-1.947734. Acesso em 17.08.2023). Sob o título "Queda no desmatamento na Amazônia é de 61% em janeiro", vê-se uma área devastada, cheia de tocos de árvores cortadas, onde nasce um pequeno broto. Um pássaro, pousado em um toco, diz: "E... ...COM ELA... BROTA UM BOCADO DE ESPERANÇA AQUI NO MEU PEITO TAMBÉM!".

Analisando-se a relação entre os elementos verbais e não verbais, conclui-se corretamente que o autor evidencia','Fácil','Charge - relação verbo-visual','3ª Série EM','SARESP','D',1,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'um retrocesso quanto ao desmatamento da Amazônia, onde quase nada sobrou.' AS texto
  UNION ALL SELECT @qid,'B','uma chance remota de melhora da Amazônia, onde o desmatamento foi de 61%.'
  UNION ALL SELECT @qid,'C','um aumento descomunal do desmatamento na Amazônia, já sem vegetação.'
  UNION ALL SELECT @qid,'D','uma perspectiva de salvação para a Amazônia, apesar dos descuidos já vividos.'
  UNION ALL SELECT @qid,'E','uma esperança para a fauna e a flora da Amazônia, com o fim do desmatamento.'
) alts WHERE @ja_existe_23e = 0;

-- ---------- Texto de apoio: Pepetela — "De fato e gravata" — Q02, 03, 04, 05, 06
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Pepetela — "De fato e gravata"',
'Exemplo desses hábitos ou manias [que contribuem com o seu pequeno quinhão para a futura miséria do planeta] é o de se usar fato e gravata, por vezes colete mesmo, nos climas mais tórridos do mundo. Um calor de morrer, humidade no máximo, e lá andamos nós de pescoço apertado a escorrer suor, casacos mesmo que de verão, meias e sapatos apertados. Não aguentamos a temperatura, corremos a refugiar-nos nos gabinetes e salas refrescadas por aparelhos de ar-condicionado, ficamos ainda assim uma meia hora a arrefecer e sem pensar em mais nada senão nos nossos corpos pegajosos, até finalmente nos sentirmos mais confortáveis. Mas não abdicamos do fato e da gravata. Sem fato que seria do burocrata chefe de serviço? Nem parecia um chefe de serviço. E então, que dizer do responsável a nível mais elevado que aparecesse com uma simples camisa? Ninguém o respeitava, parecia um falhado.
Alguns países adotaram como traje oficial (ou pelo menos recomendado) roupas leves e largas, como é o caso de alguns da África Ocidental ou da América Latina. Para não falar já do célebre e elegante safari à Nyerere ou das camisas coloridas e sóbrias de Nelson Mandela. Eis homens que não fizeram concessões aos preconceitos ocidentais e se vestiram sempre de acordo com o clima, antecipando uma luta que hoje é de todos. Muitos africanos só usam fato e gravata para se parecerem com os europeus que os colonizaram. Nunca foram capazes de ultrapassar esse complexo de inferioridade e se sentem nus se não tiverem um casaco escuro, de preferência vindo de um estilista famoso de Londres ou Paris. Uma maneira de exibirem a importância que por vezes não têm.
(Pepetela. "De fato e gravata". Em: Crónicas Maldispostas, 2015. Adaptado)
* Fato: terno.',
1, 2
WHERE @ja_existe_23e = 0;
SET @tid = LAST_INSERT_ID();

-- Q02
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em sua análise sobre o uso de terno (fato) e gravata, o narrador pondera que esse costume','Médio','Interpretação de texto - crônica','3ª Série EM','SARESP','E',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'traz prejuízos ao meio ambiente, pelo uso exagerado de ar-condicionado, uma vez que as pessoas do continente o usam meia hora por dia.' AS texto
  UNION ALL SELECT @qid,'B','representa desconforto físico incontestável aos homens, sendo, todavia, necessário para as atividades profissionais reguladas pela formalidade de vestuário.'
  UNION ALL SELECT @qid,'C','caiu em desuso na África Ocidental e na América Latina, onde o clima mais ameno justificaria a manutenção desse vestuário cotidianamente.'
  UNION ALL SELECT @qid,'D','traduz a vontade da sociedade, que se vê cada mais independente de valores estrangeiros e, por isso, decidiu deflagar uma guerra cultural contra a Europa.'
  UNION ALL SELECT @qid,'E','vai de encontro às condições climáticas do continente, reportando a uma indesejável herança cultural que denuncia a influência do colonizador.'
) alts WHERE @ja_existe_23e = 0;

-- Q03
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na passagem do primeiro parágrafo – "Sem fato que seria do burocrata chefe de serviço? Nem parecia um chefe de serviço. E então, que dizer do responsável a nível mais elevado que aparecesse com uma simples camisa? Ninguém o respeitava, parecia um falhado." –, o autor exprime','Médio','Interpretação de texto - posicionamento do autor','3ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'desprezo quanto à popularização de formas informais de se vestir para trabalhos burocratas.' AS texto
  UNION ALL SELECT @qid,'B','indiferença às roupas como forma de alguém mostrar competência profissional.'
  UNION ALL SELECT @qid,'C','admiração por aqueles que alternam suas formas de se vestir, de acordo com as situações.'
  UNION ALL SELECT @qid,'D','apreço ao uso de terno para o trabalho, como expediente de confirmação de competência.'
  UNION ALL SELECT @qid,'E','apoio a quem opta por usar terno e gravata no trabalho, que é a roupa profissional adequada.'
) alts WHERE @ja_existe_23e = 0;

-- Q04
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na passagem do primeiro parágrafo – "Exemplo desses hábitos ou manias [...] é o de se usar fato e gravata, por vezes colete _mesmo_, nos climas mais tórridos do mundo. Um calor de morrer, humidade no máximo, e lá andamos nós de pescoço apertado a escorrer suor, casacos _mesmo que_ de verão, meias e sapatos apertados." –, as expressões destacadas (entre _ _) veiculam, correta e respectivamente, sentidos de','Médio','Valores semânticos de expressões','3ª Série EM','SARESP','D',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'afirmação e explicação.' AS texto
  UNION ALL SELECT @qid,'B','intensidade e conclusão.'
  UNION ALL SELECT @qid,'C','comparação e causa.'
  UNION ALL SELECT @qid,'D','inclusão e concessão.'
  UNION ALL SELECT @qid,'E','finalidade e condição.'
) alts WHERE @ja_existe_23e = 0;

-- Q05
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A reescrita de informações textuais está em conformidade com a norma-padrão de regência em:','Médio','Regência verbal e nominal','3ª Série EM','SARESP','E',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Com a temperatura muito alta, ansiamos dos nossos gabinetes e salas refrescadas por aparelhos de ar-condicionado, para nos sentirmos mais confortáveis com as roupas.' AS texto
  UNION ALL SELECT @qid,'B','Não renunciamos do fato e da gravata, mesmo não aguentando a temperatura e desejando os gabinetes e salas, sob a refrigeração dos aparelhos de ar-condicionado.'
  UNION ALL SELECT @qid,'C','Alguns países optaram às roupas leves e largas como traje oficial, mais compatíveis aos climas quentes, como é o caso de alguns da África Ocidental ou da América Latina.'
  UNION ALL SELECT @qid,'D','Os africanos são adeptos pela cultura europeia, pois preferem as roupas de estilistas famosos de Londres ou Paris do que aquelas leves e largas adequadas ao seu clima.'
  UNION ALL SELECT @qid,'E','O responsável, cujo nível é mais elevado, caso aparecesse com uma simples camisa, certamente nenhum subalterno lhe obedeceria, e ele pareceria um falhado.'
) alts WHERE @ja_existe_23e = 0;

-- Q06
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A palavra do texto cuja escrita é diferente da usualmente utilizada no português do Brasil está destacada (entre _ _) em:','Fácil','Variação linguística - português de Portugal','3ª Série EM','SARESP','C',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'… camisas coloridas e _sóbrias_ de Nelson Mandela.' AS texto
  UNION ALL SELECT @qid,'B','Mas não _abdicamos_ do fato e da gravata.'
  UNION ALL SELECT @qid,'C','Um calor de morrer, _humidade_ no máximo…'
  UNION ALL SELECT @qid,'D','… usar fato e gravata, por vezes _colete_ mesmo…'
  UNION ALL SELECT @qid,'E','… se não tiverem um _casaco_ escuro…'
) alts WHERE @ja_existe_23e = 0;

-- Q07
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a charge de Bob Thaves, "Frank & Ernest" (https://www.estadao.com.br/cultura/quadrinhos, 16.08.2023). Em um consultório médico, o médico bate com um martelinho no joelho do paciente, que está sentado e de bermuda, e este pergunta: "AGORA QUE JÁ ME CUTUCOU, BASTANTE, DIGA: ESTOU MADURO?".

Analisando o contexto do diálogo, conclui-se que a fala do paciente expressa','Fácil','Charge - registro linguístico','3ª Série EM','SARESP','A',1,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'informalidade.' AS texto
  UNION ALL SELECT @qid,'B','erudição.'
  UNION ALL SELECT @qid,'C','desrespeito.'
  UNION ALL SELECT @qid,'D','reverência.'
  UNION ALL SELECT @qid,'E','mau humor.'
) alts WHERE @ja_existe_23e = 0;

-- ---------- Texto de apoio: Daniel Munduruku — "Por que o sol anda tão devagar?" — Q08, 09, 10
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Daniel Munduruku — "Por que o sol anda tão devagar?"',
'Contam os velhos sábios Karajá que, no início dos tempos, a Terra era um lugar muito escuro, muito frio. Isso acontecia porque não havia sol, lua ou estrelas para trazer claridade. Por causa disso, os Karajá precisavam manter um pequeno braseiro aceso dentro de casa. Mas isso era muito trabalhoso, pois exigia que os homens saíssem para a mata atrás de lenha. Como tudo era escuro e frio, todo mundo sentia uma grande indisposição para ir até lá. Aliada à preguiça que sentiam, havia também o fato de sentirem muito medo de permanecerem fora de sua hetó, pois os perigos eram muitos e grandes.
Nesta época, dizem os velhos, a preguiça tomava conta de todo mundo, mesmo de um grande herói do povo Karajá. Este herói, de nome Cananxiuê, morava na casa do pai de sua esposa, como é o costume desse povo. Por isso, sempre ouvia o velho homem lhe dizer:
— Oh, meu genro. Você precisa arranjar luz para todos nós. Você é um herói e como herói você tem que resolver este problema que fará muito bem para os Karajá.
— Tá bom meu sogro, um dia eu vou!
Mas o herói não queria nem saber de levantar-se de sua rede. Como todos os homens do lugar, preferia ficar ali a enfrentar a noite escura e fria da mata. Nem lenha ele queria ir buscar, deixando a tarefa para sua esposa.
(Daniel Munduruku, "Por que o sol anda tão devagar?". Em: Contos Indígenas Brasileiros, 2021)',
1, 2
WHERE @ja_existe_23e = 0;
SET @tid = LAST_INSERT_ID();

-- Q08
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Sobre a herança cultural indígena, o texto de Daniel Mundukuru ressalta','Médio','Interpretação de texto - herança cultural indígena','3ª Série EM','SARESP','D',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a superstição exagerada, desmotivando a vida coletiva, sugestionada no primeiro parágrafo: "o fato de sentirem muito medo" e "os perigos eram muitos e grandes".' AS texto
  UNION ALL SELECT @qid,'B','o dinamismo do herói para cuidar de todos, constatado no primeiro e quinto parágrafos: "os Karajá precisavam manter um pequeno braseiro aceso" e "preferia ficar ali".'
  UNION ALL SELECT @qid,'C','a insubordinação dos mais jovens em relação aos mais velhos, flagrada no segundo e quarto parágrafo: "sempre ouvia o velho homem lhe dizer" e "um dia eu vou".'
  UNION ALL SELECT @qid,'D','o forte apelo à tradição oral, reiterado pelas formas que iniciam o primeiro e o segundo parágrafo: "Contam os velhos sábios Karajá" e "Nesta época, dizem os velhos".'
  UNION ALL SELECT @qid,'E','o empoderamento feminino, com a mulher decidindo tudo, evidenciado no segundo e último parágrafo: "morava na casa do pai de sua esposa" e "deixando a tarefa para sua esposa".'
) alts WHERE @ja_existe_23e = 0;

-- Q09
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Nas passagens – "Como tudo era escuro e frio, todo mundo sentia uma grande indisposição para ir até _lá_." (1º parágrafo) – e – "_Nesta época_, dizem os velhos, a preguiça tomava conta de todo mundo..." (2º parágrafo) –, as expressões destacadas (entre _ _) referem-se, correta e respectivamente:','Médio','Coesão referencial - advérbio e expressão temporal','3ª Série EM','SARESP','D',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à casa; ao tempo de preguiça.' AS texto
  UNION ALL SELECT @qid,'B','à Terra; à aldeia dos Karajá.'
  UNION ALL SELECT @qid,'C','à casa do herói; à noite escura.'
  UNION ALL SELECT @qid,'D','à mata; ao início dos tempos.'
  UNION ALL SELECT @qid,'E','à claridade; ao escuro e ao frio.'
) alts WHERE @ja_existe_23e = 0;

-- Q10
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na passagem – "Mas isso era muito trabalhoso, pois _exigia_ que os homens saíssem para a mata atrás de lenha." –, a forma verbal destacada (entre _ _) indica','Médio','Tempos verbais - pretérito imperfeito','3ª Série EM','SARESP','E',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ação futura em relação ao tempo passado.' AS texto
  UNION ALL SELECT @qid,'B','ação anterior a outra no tempo passado.'
  UNION ALL SELECT @qid,'C','ação concluída no tempo passado.'
  UNION ALL SELECT @qid,'D','ação hipotética no tempo passado.'
  UNION ALL SELECT @qid,'E','ação contínua no tempo passado.'
) alts WHERE @ja_existe_23e = 0;

-- Q11
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a tira de Bill Watterson (https://www.estadao.com.br/cultura/quadrinhos/, 31.07.2023), em que os personagens Calvin e Haroldo conduzem a reunião de um clube.

Quadrinho 1: "DECLARO ABERTA A SESSÃO DO CLUBE DOS HERÓIS QUE ODEIAM MENINAS ENJOADAS! O PRIMEIRO-TIGRE, HAROLDO, LERÁ A ATA DA REUNIÃO PASSADA."
Quadrinho 2: "OBRIGADO. "9:30 - QUESTÃO DE ORDEM. O DITADOR-VITALÍCIO, CALVIN, PROPÕE UMA MOÇÃO CONDENANDO A EXISTÊNCIA DAS MENINAS.""
Quadrinho 3: ""9:35 - O PRIMEIRO-TIGRE SE ABSTÉM DO VOTO. A MOÇÃO É DERROTADA. 9:36 - QUESTIONADO O PATRIOTISMO DO PRIMEIRO-TIGRE. 9:37 - DISCUSSÃO FILOSÓFICA. 10:15 - APLICAÇÃO DE CURATIVOS. O DITADOR-VITALÍCIO, CALVIN, É ADVERTIDO POR MORDER.""
Quadrinho 4: "ENTÃO, ESTE CLUBE É, OU NÃO É BACANA?" ""10:16 - FOI ESQUECIDA A RAZÃO DO DEBATE. MEDALHAS DE BRAVURA SÃO CONCEDIDAS AOS MEMBROS.""

O texto verbal da tira possui elementos que caracterizam','Médio','Tira - linguagem e gênero textual','3ª Série EM','SARESP','B',1,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'uma apropriação de texto oral, pois seleciona termos próprios dessa modalidade de discurso.' AS texto
  UNION ALL SELECT @qid,'B','um diálogo intertextual com o texto de uma ata, por imitação de sua linguagem e elementos constituintes.'
  UNION ALL SELECT @qid,'C','uma crítica implícita à linguagem das tirinhas, cuja simplicidade afasta vocabulário de prestígio.'
  UNION ALL SELECT @qid,'D','uma representação de escolhas linguísticas típicas do formalismo dos diálogos de personagens de quadrinhos.'
  UNION ALL SELECT @qid,'E','um diálogo formatado como paráfrase explicativa de textos jornalísticos de humor, caso das tirinhas.'
) alts WHERE @ja_existe_23e = 0;

-- Q12
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere a tira "Clube dos Heróis que Odeiam Meninas Enjoadas" (Bill Watterson), cujo terceiro quadrinho registra a ata: "9:35 - O PRIMEIRO-TIGRE SE ABSTÉM DO VOTO. A MOÇÃO É DERROTADA. 9:36 - QUESTIONADO O PATRIOTISMO DO PRIMEIRO-TIGRE. 9:37 - DISCUSSÃO FILOSÓFICA. 10:15 - APLICAÇÃO DE CURATIVOS. O DITADOR-VITALÍCIO, CALVIN, É ADVERTIDO POR MORDER.", e cujo último quadrinho traz: "10:16 - FOI ESQUECIDA A RAZÃO DO DEBATE. MEDALHAS DE BRAVURA SÃO CONCEDIDAS AOS MEMBROS."

No terceiro quadrinho da tira, está indicada a sequência cronológica em que se deram as discussões durante a reunião do clube. Observando-se a relação entre o item "Discussão filosófica" e o item seguinte, deduz-se que','Médio','Tira - inferência','3ª Série EM','SARESP','C',1,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'está implícita a ideia de que as discussões tomaram muito tempo e levaram a gestos de conciliação.' AS texto
  UNION ALL SELECT @qid,'B','está implícita a ideia de que temas filosóficos desencadearam animosidade, mas ao final houve consenso.'
  UNION ALL SELECT @qid,'C','está implícita a ideia de que houve longa discussão acalorada e quebra de protocolo, seguida de sanção.'
  UNION ALL SELECT @qid,'D','está explícita a ideia de que o tema das discussões não cabia no contexto do clube HOMEN.'
  UNION ALL SELECT @qid,'E','está explícita a ideia de que a harmonização de pontos de vista demandava mais tempo de discussão.'
) alts WHERE @ja_existe_23e = 0;

-- Q13
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto.

A sociedade

Salvatore Melli alinhou algarismos torcendo a bigodeira. Falou como homem de negócios que enxerga longe. Demonstrou cabalmente as vantagens econômicas de sua proposta.
– O doutor...
– Eu não sou doutor, Senhor Melli.
– Parlo assim para facilitar. Non é para ofender. Primo o doutor pense bem. E poi me dê a sua resposta. Ma pense bem!
Renovou a proposta e repetiu os argumentos pró. O Conselheiro José Bonifácio de Matos e Arruda possuía uns terrenos em São Caetano. Cousas de herança. Não lhe davam renda alguma. Melli tinha a sua fábrica ao lado. 1.200 teares. 36.000 fusos. Constituíam uma sociedade. O conselheiro entrava com os terrenos. Melli com o capital. Arruavam os trinta alqueires e vendiam logo grande parte para os operários da fábrica. Lucro certo, mais que certo, garantidíssimo.
– É. Eu já pensei nisso. Mas sem capital o senhor compreende é impossível...
– Per Bacco, doutor! Mas io tenho o capital. O capital sono io. O senhor entra com o terreno e mais nada. E o lucro se divide no meio.
O capital acendeu um charuto. O conselheiro coçou os joelhos disfarçando a emoção.
– Dopo o doutor me dá a resposta. Io só digo isto: Pense bem.
(António de Alcântara Machado. Novelas paulistanas. 1976. Adaptado)

Nesse texto do período modernista, Alcântara Machado aborda a mescla de línguas decorrente da imigração no Brasil, no final do século XIX, e o processo de integração entre os aristocratas paulistanos e os imigrantes, no caso, os italianos. Designando a personagem Salvatore Melli com a expressão "O capital" ("O capital acendeu um charuto..."), o enunciador se vale de um recurso estilístico cujo efeito de sentido é,','Difícil','Modernismo - metonímia','3ª Série EM','SARESP','A',1,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'por meio de uma metonímia, ressaltar como se caracteriza a situação envolvendo as personagens no âmbito social, numa negociação que revela novas relações de poder, nas quais o dinheiro se sobrepõe ao prestígio.' AS texto
  UNION ALL SELECT @qid,'B','por meio de um eufemismo, relativizar a recepção hostil a Salvatore Melli pelo Conselheiro, visto que se sugere que este perdeu seu poder aquisitivo e passou a fazer negociações com o milionário estrangeiro.'
  UNION ALL SELECT @qid,'C','por meio de uma metáfora, expor a ruptura de convenções sociais arraigadas na cultura brasileira, questionando valores e pondo em xeque possibilidades de ascensão social pelo dinheiro.'
  UNION ALL SELECT @qid,'D','por meio de uma antítese, caracterizar a distância de comunicação que separa as personagens, evidenciada na atribuição de traços contrastantes da linguagem e da postura reticente de uma delas na negociação.'
  UNION ALL SELECT @qid,'E','por meio de um paradoxo, escancarar as contradições que marcaram a abordagem de Salvatore Melli ao Conselheiro, contradições essas relacionadas à tentativa de impor ao Conselheiro um negócio suspeito.'
) alts WHERE @ja_existe_23e = 0;

-- ---------- Texto de apoio: Evaristo de Miranda — incêndios no Canadá — Q14, 15, 16
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Evaristo de Miranda — incêndios no Canadá',
'Sobre a crise ambiental canadense, apesar de seus impactos hemisféricos cada vez maiores, segue o apagão midiático, de artistas, ONGS e políticos. Como se ninguém tivesse nada a dizer. Imagine se fosse no Brasil.
Em dois meses, o Canadá calcinou e reduziu a cinzas uma área florestal superior às áreas desmatadas da Amazônia nos últimos dez anos, para se ter uma ideia da dimensão territorial do desastre. É como queimar em 60 dias uma área superior à totalidade dos Estados do Rio de Janeiro e Espírito Santo ou um Portugal ou mais de duas Suíças. E a situação se agrava sob um silêncio midiático quase absoluto.
Entre os comentários enfumarados, alguns explicaram a dificuldade do Canadá com incêndios por ser uma situação nova: "o Canadá tem mais dificuldades do que nós em apagar incêndios porque nunca tiveram que fazer isso [sic]" ou "nunca as florestas do Canadá incendiaram antes". Na realidade, há séculos as florestas canadenses sofrem incêndios. Nos último 40 anos (de 1983 a 2022), a média anual de incêndios foi de 7.102.
Para outro especialista, "isso está acontecendo porque estamos atingindo o ponto de não retorno do aquecimento planetário". Aliás, nos raros artigos sobre o tema, os incêndios canadenses servem apenas para comprovar os efeitos das mudanças climáticas.
Outro especialista vaticinou: "Indiretamente, o desmatamento da Amazônia é responsável pelo que está acontecendo no Canadá". Como analisar o alcance na física da atmosfera e na metafísica da noosfera desse "indiretamente"? É surrealista afirmar sobre uma troca inter-hemisférica "indireta" de calor e umidade entre o sul da Amazônia e o Canadá. O fator humano local, não o distante amazônico, é apontado pelos canadenses como principal causa de incêndios primaveris.
(Evaristo de Miranda: Comentariolus sobre incêndios no Canadá e fumaças no Brasil. https://revistaoeste.com. Adaptado)',
1, 2
WHERE @ja_existe_23e = 0;
SET @tid = LAST_INSERT_ID();

-- Q14
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No texto, a abordagem da crise ambiental no Canadá provocada pelos incêndios, na primavera de 2023, tem foco','Difícil','Interpretação de texto - foco da abordagem','3ª Série EM','SARESP','D',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'na consistência das manifestações que explicam essa crise, já que elas recorrem a raciocínios baseados em causalidade para interpretação dos fatos e apresentação das conclusões, evitando se deixar influenciar por opiniões externas.' AS texto
  UNION ALL SELECT @qid,'B','na constatação de que a análise da questão é bastante complexa, razão pela qual se justifica a divergência de opiniões dos veículos de comunicação, cujo ponto de contato é a preocupação com expor a verdade.'
  UNION ALL SELECT @qid,'C','nas incoerências que podem ser constatadas nos argumentos apresentados pelos especialistas que se manifestaram sobre o assunto, sendo a principal delas a atribuição da responsabilidade pelos incêndios ao fator humano local.'
  UNION ALL SELECT @qid,'D','no cotejo de abordagens acerca do assunto, com exposição da fragilidade dos argumentos nelas apresentados, nos quais se identificam pontos de vista desvinculados das evidências de fatos e dados.'
  UNION ALL SELECT @qid,'E','no contexto social em que se deram os fatos, o que explicaria a hesitação da mídia em fazer declarações assertivas sobre razões e consequências dos incêndios, já que inexistem dados históricos que sustentem opiniões.'
) alts WHERE @ja_existe_23e = 0;

-- Q15
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Observe o trecho destacado (entre _ _) no texto.

"Sobre a crise ambiental canadense, _apesar de seus impactos hemisféricos cada vez maiores_, segue o apagão midiático, de artistas, ONGS e políticos. Como se ninguém tivesse nada a dizer. Imagine se fosse no Brasil."

O trecho destacado se coloca no contexto como','Difícil','Articulação de ideias - função de trecho no contexto','3ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'manifestação de uma circunstância que se toma como premissa para uma intervenção efetivada no âmbito de interesses restritos.' AS texto
  UNION ALL SELECT @qid,'B','expressão de um argumento que consistiria em fato suficiente para desencadear uma ação, mas que é representado como irrelevante para certos grupos.'
  UNION ALL SELECT @qid,'C','ratificação de ideias veiculadas por grupos formadores de opinião, destacando a relevância do assunto para tomada de decisões urgentes.'
  UNION ALL SELECT @qid,'D','condição indispensável para que sua difusão por grupos formadores de opinião seja refutada, à vista da parcialidade da mídia.'
  UNION ALL SELECT @qid,'E','exposição de um contraponto à tese segundo a qual grupos específicos se omitiram de opinar, em razão da desimportância do fato apontado.'
) alts WHERE @ja_existe_23e = 0;

-- Q16
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o fragmento, em que os trechos destacados estão entre _ _.

"_Um certo especialista vaticinou_: "Indiretamente, o desmatamento da Amazônia é responsável pelo que está acontecendo no Canadá". Como analisar o alcance na física da atmosfera e na metafísica da noosfera desse "indiretamente"? _É surrealista_ afirmar que há uma troca inter-hemisférica "indireta" de calor e umidade entre o sul da Amazônia e o Canadá."

Observando-se a sintaxe desse fragmento, constata-se que a relação entre os trechos destacados e suas respectivas sequências se caracteriza','Difícil','Sintaxe - coordenação e subordinação','3ª Série EM','SARESP','E',1,2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'pelo processo de subordinação, apesar de as sequências terem sentido próprio, o que afasta a dependência de outras partes do fragmento.' AS texto
  UNION ALL SELECT @qid,'B','pelo processo de coordenação, considerando-se que existe dependência semântica, mas não há vínculo sintático com os trechos destacados.'
  UNION ALL SELECT @qid,'C','pelo processo de subordinação, pois ambas as sequências vinculam-se pelo sentido aos trechos destacados, mas não dependem sintaticamente deles.'
  UNION ALL SELECT @qid,'D','pelos processos de coordenação e subordinação: a sequência, na primeira passagem, tem sentido independente; na segunda, dependente.'
  UNION ALL SELECT @qid,'E','pelo processo de subordinação, pois as sequências integram o conjunto sintático-semântico, dando completude aos enunciados.'
) alts WHERE @ja_existe_23e = 0;

-- Q17
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto.

Se na década de 40 amadureceu a tradição literária nacionalista, nos anos que se lhe seguiram, a poesia brasileira percorrerá os meandros do extremo subjetivismo. Alguns poetas adolescentes, mortos antes de tocarem a plena juventude, darão exemplo de toda uma temática emotiva de amor e morte, dúvida e ironia, entusiasmo e tédio.
(Alfredo Bosi. História concisa da literatura brasileira. 2008)

As considerações do crítico são referência para a identificação de textos característicos (I) da década de 40 e (II) dos anos seguintes, na alternativa:','Difícil','Literatura brasileira - Romantismo x poesia de 1940-50','3ª Série EM','SARESP','A',1,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'(I) No meio das tabas de amenos verdores, / Cercado de troncos – cobertos e flores, / Alteiam-se os tetos d''altiva nação. (II) Adeus, meus sonhos, eu pranteio e morro! / Não levo da existência uma saudade! / E a tanta vida que meu peito enchia / Morreu na minha triste mocidade!' AS texto
  UNION ALL SELECT @qid,'B','(I) Mas que vejo eu aí... Que quadro d''amarguras! / É canto funeral! ... Que tétricas figuras! ... / Que cena infame e vil... Meu Deus! Meu Deus! Que horror! (II) Quem são esses desgraçados / Que não encontram em vós / Mais que o rir calmo da turba / Que excita a fúria do algoz?'
  UNION ALL SELECT @qid,'C','(I) Pálida, à luz da lâmpada sombria / Sobre o leito de flores reclinada, / Como a lua por noite embalsamada, / Entre as nuvens do amor ela dormia! (II) Deus! ó Deus! onde estás que não respondes? / Em que mundo, em que estrelas tu te escondes / Embuçado nos céus?'
  UNION ALL SELECT @qid,'D','(I) Que me resta, meu Deus? Aos meus suspiros / Nem geme a viração. / E dentro – no deserto do meu peito / Não dorme o coração! (II) Valente na guerra / Quem há, como eu sou? / Quem vibra o tacape / Com mais valentia?'
  UNION ALL SELECT @qid,'E','(I) Encontre a bela, caprichosa sempre, / Nos ternos hinos d''infantil frescor / Entrelaçados na grinalda amiga / Doces perfumes e celeste amor. (II) Não mais te embalarei sobre os joelhos / Nem de teus olhos no cerúleo brilho / Acharei um consolo a meus tormentos.'
) alts WHERE @ja_existe_23e = 0;

-- Q18
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o fragmento do conto "São Marcos".

Sim, que, à parte o sentido prisco, valia o ileso gume do vocábulo pouco visto e menos ainda ouvido, raramente usado, melhor fora se jamais usado. Porque, diante de um gravatá, selva molhada em jarro jônico, dizer-se apenas _drimirim_ ou _amormeuzinho_ é justo; e, ao descobrir, no meio da mata, um angelim que atira para cima cinquenta metros de tronco e fronde, quem não terá o ímpeto de criar um vocativo absurdo e bradá-lo – Ó _colossalidade_! – na direção da altura?
(João Guimarães Rosa. Sagarana, 2001)

Nesse fragmento, o narrador explora o potencial da língua para expressar sentimentos, no caso, a admiração diante da natureza que se contempla. Esse potencial é caracterizado, nos trechos em destaque (entre _ _), pela','Médio','Formação de palavras e tipos de frase','3ª Série EM','SARESP','D',1,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'criação de palavras por meio de prefixos e pelo emprego de frase declarativa.' AS texto
  UNION ALL SELECT @qid,'B','retomada de palavras em desuso e pelo emprego de frase exclamativa.'
  UNION ALL SELECT @qid,'C','retomada de palavras da botânica e pelo emprego de frase imperativa.'
  UNION ALL SELECT @qid,'D','criação de palavras por meio de sufixos e pelo emprego de frase exclamativa.'
  UNION ALL SELECT @qid,'E','criação de palavras de radicais diferentes e pelo emprego de frase declarativa.'
) alts WHERE @ja_existe_23e = 0;

-- Q19
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto.

O canário e o morcego

Em uma gaiola suspensa a uma viga, havia um canário que cantava durante a noite. Um morcego ouviu de longe a sua voz e, aproximando-se, _perguntou por que durante o dia ele se calava e cantava à noite. "Não é por mero capricho" – respondeu o canário, pois fora capturado de dia, por causa do seu canto._ Por isso, desde então se tornara prudente. O morcego disse então: "Tuas precauções já não servem, são inúteis, mas devias ter tido cuidado antes de seres capturado".
Moral: A fábula mostra que, depois do infortúnio, é inútil mudar de comportamento.
(Esopo. Fábulas. 2006)

O trecho destacado (entre _ _) está reescrito com coerência e citação de discurso adequada em:','Médio','Discurso direto e indireto','3ª Série EM','SARESP','C',1,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'… perguntou: Durante o dia, porque você cantava e você se cala à noite? O canário respondeu que fora capturado, mas não é por mero capricho, é por causa de seu canto, pois cantava de dia.' AS texto
  UNION ALL SELECT @qid,'B','perguntou por que durante o dia você se cala e à noite você canta? O canário respondeu que não cantara por mero capricho, que era porque cantava de dia e por isso fora capturado.'
  UNION ALL SELECT @qid,'C','… perguntou: Por que durante o dia você se cala e à noite você canta? O canário respondeu que não cantava por mero capricho, e sim porque tinha sido capturado durante o dia, por causa de seu canto.'
  UNION ALL SELECT @qid,'D','… perguntou: Por que durante o dia você se calava e à noite você cantava? O canário respondeu que não cantava por mero capricho e sim porque tinha sido capturado durante o dia, por causa de seu canto.'
  UNION ALL SELECT @qid,'E','… perguntou porque durante o dia você se cala e à noite você canta? O canário respondeu que: tinha sido capturado então não cantava por capricho porque tinha cantado de dia.'
) alts WHERE @ja_existe_23e = 0;

-- Q20
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto.

15 de novembro

Escrevo esta no dia seguinte ao do aniversário da proclamação da República. Não fui à cidade e deixei-me ficar pelos arredores da casa em que moro, num subúrbio distante. Não ouvi nem sequer as salvas da pragmática; e, hoje, nem sequer li a notícia das festas comemorativas que se realizaram. Entretanto, li com tristeza a notícia da morte da princesa Isabel. Embora eu não a julgue com o entusiasmo de panegírico dos jornais, não posso deixar de confessar que simpatizo com essa eminente senhora.
Veio, entretanto, vontade de lembrar-me o estado atual do Brasil, depois de trinta e dois anos de República.
(Lima Barreto. Crônicas escolhidas.1995)

O trecho adaptado do original que apresenta concordância e regência de acordo com a norma-padrão é:','Médio','Concordância e regência - norma-padrão','3ª Série EM','SARESP','C',1,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Escreve-se esta no dia seguinte ao do aniversário da proclamação da República. Preferi ficar pelos arredores da casa em que moro do que ir à cidade.' AS texto
  UNION ALL SELECT @qid,'B','As notícias lidas da morte da princesa Isabel me causou tristeza e, mesmo sem o entusiasmo de panegírico dos jornais, não me omito de dizer que lhe tenho simpatia.'
  UNION ALL SELECT @qid,'C','Não se ouviram nem sequer as salvas da pragmática; e, hoje, sequer tive acesso à notícia das festas comemorativas realizadas.'
  UNION ALL SELECT @qid,'D','Embora eu não a dedique o entusiasmo de panegírico de jornais, confesso que essa eminente senhora é uma das que mais respeito.'
  UNION ALL SELECT @qid,'E','Deixei de ir na cidade e fiquei nos arredores da casa aonde moro, num subúrbio distante. Ali nem sequer as salvas da pragmática pode ser ouvida.'
) alts WHERE @ja_existe_23e = 0;

-- ---------- Texto de apoio: Supertramp — "The Logical Song" (trecho) — Q21, 22
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Supertramp — "The Logical Song" (trecho)',
'"When I was young, it seemed that life was so wonderful
A miracle, oh, it was beautiful, magical
And all the birds in the trees, well they''d be singing so happily
Oh, joyfully, oh, playfully watching me
But then they sent me away to teach me how to be sensible
Logical, oh, responsible, practical
Then they showed me a world where I could be so dependable
Oh, clinical, oh, intellectual, cynical"
(Supertramp. The Logical Song. Disponível em <https://www.lyricfind.com/>. Acesso em 05.08.2023)',
(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'), 2
WHERE @ja_existe_23e = 0;
SET @tid = LAST_INSERT_ID();

-- Q21
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A música "The Logical Song" foi um sucesso da banda Supertramp na década de 1970. Neste trecho, é possível observar certa tristeza e nostalgia devido','Médio','Reading comprehension - tom da canção','3ª Série EM','SARESP','A',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à necessidade de maior racionalidade com a chegada da vida adulta.' AS texto
  UNION ALL SELECT @qid,'B','à perda de uma vivência adolescente mais naturalista e agradável.'
  UNION ALL SELECT @qid,'C','ao desvio da juventude diante do consumismo e da perda de valores.'
  UNION ALL SELECT @qid,'D','ao aumento das responsabilidades ainda na infância.'
  UNION ALL SELECT @qid,'E','à imposição de um ambiente mais lógico e intelectualizado.'
) alts WHERE @ja_existe_23e = 0;

-- Q22
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os últimos quatro versos apresentam diversos adjetivos que indicam que o eu lírico deve assumir uma postura','Fácil','Vocabulary - adjetivos','3ª Série EM','SARESP','B',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,@tid,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'agradável.' AS texto
  UNION ALL SELECT @qid,'B','sensata.'
  UNION ALL SELECT @qid,'C','autêntica.'
  UNION ALL SELECT @qid,'D','severa.'
  UNION ALL SELECT @qid,'E','despojada.'
) alts WHERE @ja_existe_23e = 0;

-- Q23
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a charge (<https://br.pinterest.com/pin/482448178826515417/>. Acesso em 09.08.2023). Um senhor idoso e uma senhora estão sentados em um balanço de varanda, à noite, sob a lua. Ele diz: "IN THE MOONLIGHT YOUR TEETH LOOK JUST LIKE PEARLS." (Ao luar, seus dentes parecem pérolas). Ela responde, irritada: "WHO''S PEARL, AND WHAT WERE YOU DOING IN THE MOONLIGHT WITH HER?!"

O diálogo ilustra um mal-entendido que se deve','Fácil','Reading comprehension - charge e humor','3ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à estranha comparação feita pelo idoso.' AS texto
  UNION ALL SELECT @qid,'B','à compreensão de um elogio como se fosse crítica.'
  UNION ALL SELECT @qid,'C','a um erro de pronúncia na fala do idoso.'
  UNION ALL SELECT @qid,'D','à desatenção do interlocutor ao interpretar a mensagem.'
  UNION ALL SELECT @qid,'E','à sonoridade de "pearls", que é a mesma de "Pearl''s".'
) alts WHERE @ja_existe_23e = 0;

-- Q24
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Are you smarter than a scammer? Play this game.
Take this quiz to find out if you can spot what''s real and what''s fake

No matter how cautious and untrusting you are, you could still end up falling for a scam. One reason is that scammers change their tactics constantly.
In 2022, 2.4 million Americans reported to the Federal Trade Commission that they were victims of a scam, losing nearly $8.8 billion, a 30 percent increase from 2021. Most reported scam attempts come via email, followed by phone calls and text messages, and the most popular types of scams are people pretending to work in businesses or government agencies.
Learn more about how to keep yourself safe by testing your instincts below and guessing whether each instance is a scam, using real-life examples.
(Heather Kelly. www.washingtonpost.com, 09.08.2023. Adaptado)
Scam – fraud.
Scammer – a person who commits a fraud.

A leitura do texto permite compreender que','Médio','Reading comprehension - informações do texto','3ª Série EM','SARESP','D',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'mais de 8 bilhões de americanos foram vítimas de golpes virtuais nos anos de 2021 e 2022.' AS texto
  UNION ALL SELECT @qid,'B','a Comissão Federal de Comércio dos EUA tem um papel no levantamento de golpes e fake news.'
  UNION ALL SELECT @qid,'C','o quiz proposto pela jornalista reduziu o número de vítimas de golpes ocasionados por fake news.'
  UNION ALL SELECT @qid,'D','os principais veículos de golpes são os e-mails, seguidos de ligações telefônicas e mensagens de texto.'
  UNION ALL SELECT @qid,'E','a propagação de fake news e golpes existentes nos EUA é viabilizada por telemarketing.'
) alts WHERE @ja_existe_23e = 0;

-- Q25
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere o seguinte trecho de uma notícia:

O Brasil lançou recentemente o plano nacional para eliminação da malária, cujo objetivo é diminuir o número de casos autóctones para menos de 68 mil até 2025, reduzindo a quantidade de óbitos para zero até 2030 e eliminando a doença no território brasileiro até 2035.
(https://www.paho.org/pt/noticias/. Acesso em: 16.08.2023)

A principal forma pela qual o ser humano adquire a malária é pela picada de fêmeas de mosquitos do gênero Anopheles infectadas pelo Plasmodium, agente etiológico da doença.

Sobre esse agente etiológico e seu ciclo de vida, é correto afirmar que se trata de um','Médio','Parasitologia - malária','3ª Série EM','SARESP','E',3,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'protozoário, pluricelular, que pode infectar as plaquetas, onde se dá parte do seu ciclo de vida. O mosquito é considerado hospedeiro intermediário e o ser humano hospedeiro definitivo do parasita.' AS texto
  UNION ALL SELECT @qid,'B','metazoário, unicelular, que pode infectar os leucócitos, onde se dá parte de seu ciclo de vida. O mosquito é considerado hospedeiro intermediário e o ser humano hospedeiro definitivo do parasita.'
  UNION ALL SELECT @qid,'C','metazoário, pluricelular, que pode infectar os linfócitos, onde se dá parte de seu ciclo de vida. O mosquito é considerado hospedeiro definitivo e o ser humano hospedeiro intermediário do parasita.'
  UNION ALL SELECT @qid,'D','metazoário, pluricelular, que pode infectar as plaquetas, onde se dá parte do seu ciclo de vida. O mosquito é considerado hospedeiro definitivo e o ser humano hospedeiro intermediário do parasita.'
  UNION ALL SELECT @qid,'E','protozoário, unicelular, que pode infectar as hemácias, onde se dá parte de seu ciclo de vida. O mosquito é considerado hospedeiro definitivo e o ser humano hospedeiro intermediário do parasita.'
) alts WHERE @ja_existe_23e = 0;

-- Q26
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os ácidos nucleicos constituem uma importante categoria de biomoléculas orgânicas. Os principais exemplos encontrados nos seres vivos são o DNA e o RNA. Eles apresentam características específicas que os definem, como serem constituídos por nucleotídeos, mas há também características que os diferenciam entre si.

Dentre as características que tornam o RNA diferente do DNA, pode ser citado o fato de apenas o RNA apresentar, em sua composição, moléculas de','Fácil','Citologia - ácidos nucleicos','3ª Série EM','SARESP','C',3,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'adenina.' AS texto
  UNION ALL SELECT @qid,'B','timina.'
  UNION ALL SELECT @qid,'C','uracila.'
  UNION ALL SELECT @qid,'D','fosfato.'
  UNION ALL SELECT @qid,'E','desoxirribose.'
) alts WHERE @ja_existe_23e = 0;

-- Q27
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A sistemática é a área da Biologia que teoriza sobre a classificação das espécies, prática que favorece o estudo comparativo dos organismos vivos, bem como a análise de suas relações filogenéticas. Uma das formas de classificação mais conhecidas das espécies vegetais agrupa as plantas em quatro grandes grupos: briófitas, pteridófitas, gimnospermas e angiospermas. Esses grupos podem ser classificados de forma mais ampla de acordo com as suas características morfológicas e fisiológicas: criptógamas, fanerógamas, traqueófitas e espermatófitas.

Em relação à classificação das plantas nos quatro grupos supracitados, é correto afirmar que','Médio','Botânica - classificação das plantas','3ª Série EM','SARESP','B',3,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'pteridófitas são fanerógamas e apresentam um sistema vascular composto por xilema e floema, responsáveis por conduzir seiva bruta e seiva elaborada.' AS texto
  UNION ALL SELECT @qid,'B','pteridófitas são traqueófitas e apresentam um sistema vascular composto por xilema e floema, responsáveis por conduzir seiva bruta e seiva elaborada.'
  UNION ALL SELECT @qid,'C','gimnospermas são fanerógamas e possuem flores e frutos, sendo que são nestes últimos que as sementes são abrigadas até sua completa maturação.'
  UNION ALL SELECT @qid,'D','angiospermas são criptógamas e apresentam um sistema vascular composto por xilema e floema, responsáveis por conduzir seiva bruta e seiva elaborada.'
  UNION ALL SELECT @qid,'E','briófitas são criptógamas e possuem flores e frutos, sendo que é nas flores que as sementes são abrigadas até sua completa maturação.'
) alts WHERE @ja_existe_23e = 0;

-- Q28
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os ecossistemas terrestres que se desenvolvem em ambientes com características similares – como umidade, temperatura e latitude – e que apresentam cobertura vegetal com características e adaptações semelhantes são agrupados em um mesmo Bioma.

Sobre as características e as coberturas vegetais dos biomas terrestres, é correto afirmar que','Médio','Ecologia - biomas','3ª Série EM','SARESP','C',3,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a Floresta Temperada ocorre em regiões de alta latitude da América do Sul, sendo o bioma com maior diversidade, além de ser composto por espécies sempre-verdes.' AS texto
  UNION ALL SELECT @qid,'B','a Floresta Tropical é encontrada na zona intertropical, onde o clima é quente e seco, e é caracterizada pelo predomínio de vegetação adaptada a longos períodos de estiagem.'
  UNION ALL SELECT @qid,'C','o Campo ocorre em regiões temperadas, onde há clima seco e com temperaturas intermediárias, e é caracterizado pela predominância de espécies herbáceas e arbustivas.'
  UNION ALL SELECT @qid,'D','a Tundra ocorre em altas latitudes, onde o clima é frio e úmido, e é caracterizada pela presença de espécies arbóreas decíduas.'
  UNION ALL SELECT @qid,'E','a Taiga ocorre em latitudes superiores à Tundra, onde o clima é frio e seco, sendo caracterizada pela presença de vegetais rasteiros resistentes a períodos de gelo.'
) alts WHERE @ja_existe_23e = 0;

-- Q29
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O cladograma a seguir relaciona filogeneticamente 4 grupos de vertebrados: Anfíbios, Mamíferos, Répteis e Aves. Nele, o ramo dos anfíbios sai primeiro; o ponto de ramificação 1 está na base do grupo formado por Mamíferos, Répteis e Aves; e o ponto 2 está na base do grupo formado apenas por Répteis e Aves.

A análise do cladograma permite que se possa afirmar, corretamente, que a característica','Médio','Zoologia - filogenia dos vertebrados','3ª Série EM','SARESP','A',3,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'1 corresponde à presença de âmnio.' AS texto
  UNION ALL SELECT @qid,'B','2 corresponde à presença de dentes.'
  UNION ALL SELECT @qid,'C','2 corresponde à circulação dupla e incompleta.'
  UNION ALL SELECT @qid,'D','2 corresponde à epiderme queratinizada.'
  UNION ALL SELECT @qid,'E','1 corresponde à presença de quatro membros.'
) alts WHERE @ja_existe_23e = 0;

-- Q30
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A figura a seguir ilustra a comunicação entre um vaso sanguíneo e um néfron. Os néfrons são estruturas que existem aos milhões nos rins e que têm papel fundamental na produção da urina. Na figura, uma arteríola aferente leva sangue ao glomérulo; a seta 1 indica a passagem de substâncias do sangue para a cápsula do néfron; a seta 2 indica a passagem de substâncias do túbulo de volta para os capilares; e a seta 3 indica a passagem de substâncias dos capilares para o túbulo, em direção à urina.
(Gerard J. Tortora e Bryan Derrickson, Princípios de anatomia e fisiologia. 2019. Adaptado)

Os processos numerados de 1 a 3 correspondem, respectivamente a:','Médio','Fisiologia - néfron e formação da urina','3ª Série EM','SARESP','D',3,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'secreção capsular, absorção tubular e secreção tubular.' AS texto
  UNION ALL SELECT @qid,'B','secreção capsular, reabsorção tubular e excreção tubular.'
  UNION ALL SELECT @qid,'C','secreção capsular, absorção tubular e excreção tubular.'
  UNION ALL SELECT @qid,'D','filtração glomerular, reabsorção tubular e secreção tubular.'
  UNION ALL SELECT @qid,'E','filtração glomerular, absorção tubular e excreção tubular.'
) alts WHERE @ja_existe_23e = 0;

-- Q31
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As ideias de Charles Darwin foram fundamentais para a compreensão do processo de evolução das espécies ao longo do tempo, porém foram absorvendo conceitos e conhecimentos de novas áreas da Biologia conforme os anos foram passando. A teoria de Darwin atualizada ganha o nome de neodarwinismo e conta com noções de biologia molecular, paleontologia, ecologia e genética, além de ter todo um apoio argumentativo com bases estatísticas e probabilísticas.

O neodarwinismo defende que','Médio','Evolução - neodarwinismo','3ª Série EM','SARESP','B',3,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o ambiente exerce papel fundamental na mudança de hábitos, de comportamentos e até de estruturas de indivíduos para melhor adaptá-los ao meio ambiente.' AS texto
  UNION ALL SELECT @qid,'B','o sucesso evolutivo de uma determinada característica pode ser mensurado a partir do acompanhamento da sua frequência na população ao longo do tempo.'
  UNION ALL SELECT @qid,'C','sobrevive e se reproduz o indivíduo que for mais forte, o que justifica a transformação das espécies tal qual se observa nos registros fósseis.'
  UNION ALL SELECT @qid,'D','ao longo do tempo, os indivíduos de uma população se mantêm inalterados, o que garante a manutenção da forma e da fisiologia das espécies com o passar do tempo.'
  UNION ALL SELECT @qid,'E','indivíduos evoluem ao longo de suas vidas de acordo com o sucesso que obtiverem ao conviverem com as pressões seletivas do meio.'
) alts WHERE @ja_existe_23e = 0;

-- Q32
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O heredograma a seguir descreve a herança de uma característica autossômica recessiva, marcada em preto, em uma família. Geração I: o indivíduo I-1 (homem) e o I-2 (mulher) são afetados e têm uma filha, II-1, também afetada; o indivíduo I-3 (homem) é afetado e o I-4 (mulher) não é afetada, e têm um filho, II-2, não afetado. O indivíduo II-1 encontra-se gestante, resultado de seu relacionamento com o indivíduo II-2, mas o sexo e as características do descendente ainda são desconhecidos.

Considerando as características presentes no heredograma e no enunciado, é correto afirmar que a probabilidade de o descendente de II-1 e II-2 apresentar tal característica recessiva é de','Médio','Genética - heredograma','3ª Série EM','SARESP','E',3,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'25%.' AS texto
  UNION ALL SELECT @qid,'B','0%.'
  UNION ALL SELECT @qid,'C','100%.'
  UNION ALL SELECT @qid,'D','75%.'
  UNION ALL SELECT @qid,'E','50%.'
) alts WHERE @ja_existe_23e = 0;

-- Q33
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O ar atmosférico mantém-se em constante movimentação desencadeada pelas diferenças de temperatura que ocorrem no planeta. Uma dessas movimentações é conhecida como frente fria, em que o ar frio, que é predominante e mais denso, empurra o ar quente para cima ao mesmo tempo que avança, provocando queda de temperatura e potenciais tempestades, como mostra a figura (esquema de uma frente fria: o ar frio avança sob o ar quente, que é empurrado para cima, formando nuvens e chuva).
(https://www.infoescola.com/geografia/chuva-frontal/)

Suponha que uma cidade esteja alinhada com o caminho seguido por uma frente fria que se desloca a 80 km/h. Se a distância entre essa frente fria até o centro dessa cidade é de 280 km, é possível prever que a chegada dessa frente fria nesse local ocorrerá em','Fácil','Cinemática - velocidade média','3ª Série EM','SARESP','A',4,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'3 horas e 30 minutos.' AS texto
  UNION ALL SELECT @qid,'B','2 horas e 50 minutos.'
  UNION ALL SELECT @qid,'C','2 horas e 30 minutos.'
  UNION ALL SELECT @qid,'D','3 horas e 10 minutos.'
  UNION ALL SELECT @qid,'E','3 horas e 50 minutos.'
) alts WHERE @ja_existe_23e = 0;

-- Q34
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O sistema de corpos mostrado na figura a seguir pode ser considerado ideal: o corpo B está apoiado sobre uma mesa horizontal, sem atrito, ligado por um fio que passa por uma polia fixa na borda da mesa ao corpo A, que pende verticalmente.

Sabendo que as massas dos corpos A e B são, respectivamente, 8 kg e 12 kg, considerando 10 m/s² o valor da aceleração da gravidade, o movimento do sistema se dará com aceleração igual a','Médio','Dinâmica - leis de Newton (sistema de corpos)','3ª Série EM','SARESP','C',4,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'8 m/s².' AS texto
  UNION ALL SELECT @qid,'B','6 m/s².'
  UNION ALL SELECT @qid,'C','4 m/s².'
  UNION ALL SELECT @qid,'D','2 m/s².'
  UNION ALL SELECT @qid,'E','5 m/s².'
) alts WHERE @ja_existe_23e = 0;

-- Q35
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em um parque de diversões, um carrinho e seus ocupantes, somando uma massa de 250 kg, é elevado até o ponto mais alto de um trilho a 6 m acima do nível da água contida em um canal, lá permanecendo em repouso, até que um mecanismo de liberação permita o início de seu movimento. Na rampa, os trilhos estão mergulhados em um lençol de água corrente, que tem a finalidade de diminuir a velocidade do carrinho, que chega ao canal com água a 2 m/s.

Sendo 10 m/s² a aceleração da gravidade, o valor absoluto da energia mecânica dissipada pela água durante a descida desse carrinho é de','Médio','Energia - conservação e dissipação','3ª Série EM','SARESP','E',4,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'15,0 kJ.' AS texto
  UNION ALL SELECT @qid,'B','18,0 kJ.'
  UNION ALL SELECT @qid,'C','16,5 kJ.'
  UNION ALL SELECT @qid,'D','22,5 kJ.'
  UNION ALL SELECT @qid,'E','14,5 kJ.'
) alts WHERE @ja_existe_23e = 0;

-- Q36
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Ao cozinhar frango para ser desfiado, um chefe de cozinha guarda no congelador o caldo que seria descartado, em porções de 1500 g. Quando quiser preparar alguma receita que conte com o sabor de frango, em vez de usar produtos industrializados, utiliza seu caldo congelado. Para usá-lo, deve desenformar o caldo congelado diretamente em uma panela. Rapidamente, a temperatura do caldo congelado chega a 0 ºC. A partir daí, imaginando que o caldo se comporte termicamente de modo semelhante à água, entendendo que o calor latente de fusão é igual a 80 cal/g, que a temperatura de fusão é 0 ºC e que, quando líquido, o calor específico seja igual a 1 cal/(g × ºC), a quantidade de calor que essa quantidade de 1500 g de caldo tem que receber para que chegue à temperatura de 100 ºC é de','Médio','Calorimetria - calor latente e sensível','3ª Série EM','SARESP','C',4,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'120 kcal.' AS texto
  UNION ALL SELECT @qid,'B','230 kcal.'
  UNION ALL SELECT @qid,'C','270 kcal.'
  UNION ALL SELECT @qid,'D','100 kcal.'
  UNION ALL SELECT @qid,'E','150 kcal.'
) alts WHERE @ja_existe_23e = 0;

-- Q37
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um objeto real é posicionado à frente de uma lente esférica biconvexa, a 60 cm do centro dela e sobre o seu eixo principal. Lembrando que o inverso da distância focal de uma lente é igual à soma do inverso da distância do objeto ao centro da lente com o inverso da distância da imagem ao centro da lente, se a distância focal dessa lente é igual a 40 cm, a imagem obtida será de tamanho','Médio','Óptica - equação de Gauss (lentes)','3ª Série EM','SARESP','D',4,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'maior que o objeto, virtual e direita, estando a 120 cm do centro da lente.' AS texto
  UNION ALL SELECT @qid,'B','menor que o objeto, virtual e direita, estando a 60 cm do centro da lente.'
  UNION ALL SELECT @qid,'C','maior que o objeto, virtual e invertida, estando a 120 cm do centro da lente.'
  UNION ALL SELECT @qid,'D','maior que o objeto, real e invertida, estando a 120 cm do centro da lente.'
  UNION ALL SELECT @qid,'E','menor que o objeto, real e direita, estando a 60 cm do centro da lente.'
) alts WHERE @ja_existe_23e = 0;

-- Q38
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Nos dois extremos de uma corda esticada, são gerados, ao mesmo instante, dois abalos com o mesmo comprimento e que avançam um em direção ao outro, como mostra a figura: o primeiro, que avança da esquerda para a direita, é um pulso triangular para cima, de amplitude 1 (rampa subindo e queda vertical no final); o segundo, que avança da direita para a esquerda, é um pulso retangular para baixo, de amplitude 1.

No momento em que esses dois abalos estiverem completamente sobrepostos, a corda mostrará a aparência desenhada em (descrição das figuras, na mesma largura dos pulsos): ','Médio','Ondulatória - superposição de pulsos','3ª Série EM','SARESP','E',4,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'(A) um pulso para baixo que desce em rampa até a amplitude −2 e sobe verticalmente de volta à posição de equilíbrio.' AS texto
  UNION ALL SELECT @qid,'B','(B) um pulso para cima que sobe em rampa até a amplitude +2 e cai verticalmente à posição de equilíbrio.'
  UNION ALL SELECT @qid,'C','(C) um pulso triangular para cima, de amplitude 1, que sobe em rampa e cai verticalmente.'
  UNION ALL SELECT @qid,'D','(D) um pulso triangular para cima, de amplitude 1, que sobe verticalmente e desce em rampa.'
  UNION ALL SELECT @qid,'E','(E) um pulso triangular para baixo, de amplitude 1, que desce verticalmente e sobe em rampa até a posição de equilíbrio.'
) alts WHERE @ja_existe_23e = 0;

-- Q39
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No circuito da figura a seguir, que foi construído com elementos ideais, quando a chave ch está aberta, o amperímetro indica a passagem de uma corrente elétrica de intensidade igual a 0,5 A. No circuito, a fonte E está ligada entre os pontos A e C; entre A e C há dois ramos em paralelo: um com o resistor R₁ em série com a chave ch, e outro com R₂, o amperímetro e R₃ em série.

Fechando-se a chave ch, sendo E = 20 V, R₁ = 40 Ω, R₂ = 30 Ω, a nova leitura do amperímetro será de','Médio','Eletrodinâmica - circuito com chave','3ª Série EM','SARESP','B',4,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'1,0 A.' AS texto
  UNION ALL SELECT @qid,'B','0,5 A.'
  UNION ALL SELECT @qid,'C','1,5 A.'
  UNION ALL SELECT @qid,'D','2,0 A.'
  UNION ALL SELECT @qid,'E','4,5 A.'
) alts WHERE @ja_existe_23e = 0;

-- Q40
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Por questão de tempo e comodidade, uma pessoa optou por adquirir uma esteira elétrica para fazer exercícios físicos diários em sua própria casa. O motor da esteira comprada tem potência de 2,5 HP e o tempo diário estimado para o uso da esteira é de 40 minutos. Considerando que a potência dissipada pela esteira pode ser igualada à potência dissipada por seu motor, admitindo que 1 HP = 750 W, a conta de energia que essa pessoa deverá pagar no decorrer de um mês de 30 dias apresentará um aumento no consumo exclusivamente devido ao uso da esteira de, aproximadamente,','Médio','Energia elétrica - potência e consumo','3ª Série EM','SARESP','B',4,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'33 kWh.' AS texto
  UNION ALL SELECT @qid,'B','38 kWh.'
  UNION ALL SELECT @qid,'C','46 kWh.'
  UNION ALL SELECT @qid,'D','24 kWh.'
  UNION ALL SELECT @qid,'E','28 kWh.'
) alts WHERE @ja_existe_23e = 0;

-- Q41
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O óleo essencial de rosas é uma mistura que contém dois componentes majoritários: o citronelol (C₁₀H₂₀O) e o geraniol (C₁₀H₁₈O). Essas substâncias possuem fórmulas estruturais muito parecidas, conforme representadas nas imagens de suas estruturas. Considere as esferas escuras como os átomos de carbono, as esferas claras como átomos de hidrogênio e as esferas vermelhas como átomos de oxigênio. Na imagem, a representação da estrutura da molécula de citronelol se encontra dividida em cinco regiões numeradas de 1 a 5, da esquerda para a direita: a região 1 é o grupo de dois metilas na extremidade esquerda, a 2 é o trecho da ligação dupla/CH, a 3 e a 4 são trechos da cadeia (a 4 contém a ramificação metila) e a 5 é o grupo terminal com o oxigênio (álcool). O geraniol é representado logo abaixo, com duas ligações duplas.

Considerando os átomos ligados aos átomos de carbono, a principal diferença estrutural entre as moléculas está contida na região marcada com o número','Fácil','Química orgânica - estrutura molecular','3ª Série EM','SARESP','A',5,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'4.' AS texto
  UNION ALL SELECT @qid,'B','3.'
  UNION ALL SELECT @qid,'C','2.'
  UNION ALL SELECT @qid,'D','1.'
  UNION ALL SELECT @qid,'E','5.'
) alts WHERE @ja_existe_23e = 0;

-- Q42
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A beterraba é um vegetal nutritivo que apresenta um determinado pigmento, cuja coloração vermelha intensa depende do pH.

Para que um bolo de beterraba mantenha a cor vermelha do vegetal, muitas receitas sugerem a adição de suco de limão, cuja acidez compensa o efeito do bicarbonato de sódio (NaHCO₃) presente no fermento. Caso contrário, o bolo não mantém a cor característica da beterraba. A reação do bicarbonato com o ácido é mostrada a seguir:
HCO₃⁻ (aq) + H⁺ (aq) → CO₂ (g) + H₂O (l)

Para melhor compreender esse fenômeno, um grupo de estudantes ferveu uma beterraba em água pura para extrair o pigmento. Na sequência, retirou duas partes da solução e ferveu uma com limão, dando origem à amostra (A), e outra com bicarbonato de sódio, dando origem à amostra (B). As amostras foram fervidas pelo mesmo tempo e a foto registrada na sequência mostra a amostra A com coloração vermelha intensa e a amostra B amarelada, quase sem cor vermelha.

A conclusão do grupo foi a de que o bicarbonato de sódio conferiu à solução um caráter (I) ______, condição na qual o pigmento (II) ______ sua coloração vermelha, e a adição de limão ajuda a (III) ______ o pH, (IV) ______ a coloração vermelha.

As lacunas I, II, III e IV são preenchidas, respectivamente, por','Médio','Ácidos e bases - pH e indicadores','3ª Série EM','SARESP','C',5,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'neutro … perde … estabilizar … mantendo' AS texto
  UNION ALL SELECT @qid,'B','alcalino … mantém … elevar … perdendo'
  UNION ALL SELECT @qid,'C','alcalino … perde … reduzir … mantendo'
  UNION ALL SELECT @qid,'D','ácido … mantém … elevar … perdendo'
  UNION ALL SELECT @qid,'E','ácido … perde … reduzir … perdendo'
) alts WHERE @ja_existe_23e = 0;

-- Q43
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para responder à questão, considere o texto a seguir.

"Um projeto de energia sustentável pioneiro no mundo que prevê a produção de hidrogênio (H₂) a partir da reforma a vapor do etanol.
No processo de reforma a vapor desenvolvido, o etanol é submetido a temperaturas e pressões específicas e reage com a vapor de água dentro de um reator. Como resultado, a molécula de etanol (C₂H₆O) é quebrada, deixando disponível o hidrogênio contido nela.
O hidrogênio é apontado por especialistas do setor energético como o combustível do futuro. Ao ser transformado em energia, ele não emite gases de efeito estufa (GEE). O resíduo liberado na atmosfera é o vapor d''água resultante da ligação do hidrogênio com o oxigênio na reação química que produz a energia."
(https://revistapesquisa.fapesp.br. Adaptado)

Assinale a alternativa que mostra equações químicas balanceadas e compatíveis com as duas reações descritas no texto.','Médio','Reações químicas - balanceamento e energia','3ª Série EM','SARESP','E',5,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'2CO(g) + 4H₂(g) → C₂H₆O(g) + H₂O(g); 2H₂O(g) → O₂(g) + 2H₂(g)' AS texto
  UNION ALL SELECT @qid,'B','C₂H₆O(g) + 1/2 O₂(g) → 2CO₂(g) + 3H₂(g); 2H₂(g) + O₂(g) → H₂O(g)'
  UNION ALL SELECT @qid,'C','CO₂(g) + C(s) + 3H₂O(g) → C₂H₆O(g) + 2O₂(g); H₂(g) + O₂(g) → H₂O₂(g)'
  UNION ALL SELECT @qid,'D','2H₂O(g) + C₂H₆O(g) → 2CO(g) + 5H₂(g); 2H₂O₂(g) → O₂(g) + H₂(g)'
  UNION ALL SELECT @qid,'E','C₂H₆O(g) + 3H₂O(g) → 2CO₂(g) + 6H₂(g); H₂(g) + 1/2 O₂(g) → H₂O(g)'
) alts WHERE @ja_existe_23e = 0;

-- Q44
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em um experimento, foram adicionadas em um reator determinadas quantidades de eteno (C₂H₄) e 1,3-butadieno (C₄H₆) sob pressão adequada e aquecimento até 200 ºC.
Após certo tempo, ocorreu a formação de cicloexeno (C₆H₁₀) e 4-vinilcicloexeno (C₈H₁₂). Algumas quantidades dos reagentes permaneceram sem reagir na mistura reacional produzida no interior do reator. Na sequencia, o reator foi esfriado até atingir pressão e temperatura ambiente.

Os dados de ponto de ebulição e de fusão das substâncias contidas na mistura reacional são apresentados na tabela a seguir (ponto de fusão / ponto de ebulição, em ºC):
Eteno (C₂H₄): −170 / −104
1,3-Butadieno (C₄H₆): −109 / −4
Cicloexeno (C₆H₁₀): −103 / 83
4-vinilcicloexeno (C₈H₁₂): −109 / 129

A mistura contida no interior do reator foi destilada em pressão ambiente em temperatura entre 80 ºC e 90 ºC. A fração coletada na saída do destilador, após a destilação dessa mistura, era constituída majoritariamente','Difícil','Separação de misturas - destilação','3ª Série EM','SARESP','D',5,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'por quantidades iguais de uma fase líquida correspondente ao cicloexeno e uma fase constituída por 1,3-butadieno, que solidificou ao atingir a temperatura ambiente.' AS texto
  UNION ALL SELECT @qid,'B','por quantidades semelhantes de cicloexeno e 4-vinilcicloexeno, uma vez que os reagentes em excesso, com ponto de fusão alto, não serão destilados.'
  UNION ALL SELECT @qid,'C','por 4-vinilcicloexeno, pois os demais compostos não foram destilados, por terem temperatura de ebulição baixa.'
  UNION ALL SELECT @qid,'D','por cicloexeno, pois os reagentes em excesso na mistura reacional foram eliminados na forma gasosa e o 4-vinilcicloexeno não foi destilado.'
  UNION ALL SELECT @qid,'E','por reagentes líquidos remanescentes sem reagir na mistura reacional.'
) alts WHERE @ja_existe_23e = 0;

-- Q45
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O hipoclorito de sódio (NaClO) é um potente agente bactericida usado na desinfecção de ambientes e alimentos. Ele pode ser encontrado na forma de solução aquosa, com densidade igual a 1,0 g/mL, em produtos fornecidos por diversos fabricantes. A tabela a seguir apresenta algumas características de dois desses produtos (volume da embalagem / preço / concentração de NaClO em massa):
Água sanitária: 1,0 L / R$ 5,00 / 2,5 %
Desinfetante para hortifrutícolas: 50,0 mL / R$ 12,00 / 2,5 %

Comparando-se o preço de 1 g de hipoclorito de sódio em cada um dos produtos, constata-se que, na água sanitária, o valor é cerca de','Médio','Soluções - concentração e custo','3ª Série EM','SARESP','B',5,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'15 vezes menor.' AS texto
  UNION ALL SELECT @qid,'B','50 vezes menor.'
  UNION ALL SELECT @qid,'C','70 vezes maior.'
  UNION ALL SELECT @qid,'D','5 vezes maior.'
  UNION ALL SELECT @qid,'E','80 vezes menor.'
) alts WHERE @ja_existe_23e = 0;

-- Q46
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A Aflatoxina B1 (AFB1) é uma toxina produzida por fungos que é prejudicial à saúde e pode estar presente em alguns produtos alimentícios armazenados inadequadamente. Uma vez absorvida no nosso organismo, essa toxina pode ser destruída por reação de hidrólise. Um estudo científico comparou em laboratório a rapidez da reação de hidrólise da toxina AFB1 em diversas condições. Os dados desse estudo estão na tabela (experimento / condição de hidrólise / rapidez da reação a 25 ºC, em µmol·L⁻¹·s⁻¹):
1 / sem mediação de enzima / 0,64
2 / com 10 µM de enzima de rato / 0,72
3 / com 19 µM de enzima de rato / 0,78
4 / com 14 µM de enzima de humano / 0,64

Com base nessas informações, uma conclusão coerente com esses resultados seria a de que a enzima purificada de rato (I) ______ a rapidez da reação de hidrólise da toxina se comparada à reação de hidrólise da toxina sem a presença de enzima, (II) ______ resultado obtido na presença de enzima purificada de humanos.

As lacunas I e II são preenchidas adequadamente com os termos:','Médio','Cinética química - catálise enzimática','3ª Série EM','SARESP','B',5,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'I – não mudou … II – ao contrário do' AS texto
  UNION ALL SELECT @qid,'B','I – aumentou … II – diferentemente do'
  UNION ALL SELECT @qid,'C','I – não mudou … II – assim como o'
  UNION ALL SELECT @qid,'D','I – diminuiu … II – de forma oposta ao'
  UNION ALL SELECT @qid,'E','I – diminuiu … II – igual ao'
) alts WHERE @ja_existe_23e = 0;

-- Q47
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Smog fotoquímico é o nome dado para a poluição de ar causada por reações mediadas pela luz solar, que são marcantes em grandes cidades. Um dos mecanismos envolvidos na formação de smog fotoquímico ao longo do dia, que resulta na produção de ozônio (O₃) e dos compostos gasosos NO e NO₂ é descrito a seguir:

"Hidrocarbonetos presentes na atmosfera reagem com moléculas de oxigênio do ar (O₂) e produzem radicais peróxido, que por sua vez oxidam o gás NO, acumulado na atmosfera durante a noite, transformando-o em gás NO₂.
Após grande parte do gás NO se transformar em gás NO₂, a decomposição fotoquímica de NO₂ forma NO e oxigênio elementar (O), que, por ser instável, combina-se rapidamente com O₂ e gera O₃."
(Colin Baird. Química Ambiental, 2002. Adaptado)

O gráfico a seguir representa a variação da concentração (em ppm) dos três gases resultantes do mecanismo de formação do smog fotoquímico ao longo das horas do dia (das 4h às 18h). A curva I (tracejada) tem um máximo (cerca de 0,15 ppm) por volta das 6-7h da manhã e cai a quase zero perto das 9-10h; a curva II tem um máximo (cerca de 0,2 ppm) por volta das 8h e cai ao longo da manhã; a curva III começa a subir por volta das 8h, atinge o máximo (cerca de 0,2 ppm) perto do meio-dia e cai lentamente ao longo da tarde.

As curvas marcadas com I, II e III correspondem, respectivamente, a:','Difícil','Química ambiental - smog fotoquímico','3ª Série EM','SARESP','C',5,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'O₃; NO; NO₂.' AS texto
  UNION ALL SELECT @qid,'B','NO₂; O₃; NO.'
  UNION ALL SELECT @qid,'C','NO; NO₂; O₃.'
  UNION ALL SELECT @qid,'D','NO; O₃; NO₂.'
  UNION ALL SELECT @qid,'E','O₃; NO₂; NO.'
) alts WHERE @ja_existe_23e = 0;

-- Q48
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto a seguir, a respeito da toxicidade do arsênio:

"O Arsênio é um metaloide e pode se apresentar em diversos estados de oxidação. A toxicidade das diversas espécies de arsênio decresce na seguinte ordem: compostos de As(III) inorgânicos, compostos de As(V) inorgânico, composto de As(III) ligados a grupos orgânico, Composto de As(V) ligados a grupos orgânicos."
(Andrade, D.F.; Rocha, M.S. Revista Acadêmica, 3 (10), 2016. Adaptado)

Considere os 3 compostos de arsênio representados a seguir:
- Ácido dimetilarsínico: As(V) ligado a dois grupos metila (H₃C e CH₃), uma ligação dupla com oxigênio (As=O) e um grupo OH.
- Ácido arsênico (arsênio, na figura): As(V) com uma ligação dupla com oxigênio e três grupos OH, HO–As(=O)(OH)–OH.
- Ácido arsenioso: As(III) com três grupos OH, HO–As(OH)–OH.

A ordem de toxidade desses compostos, conforme descrito no texto, considerando do mais tóxico para o menos tóxico, será:','Médio','Química inorgânica - toxicidade do arsênio','3ª Série EM','SARESP','D',5,2,NULL,TRUE
WHERE @ja_existe_23e = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ácido arsênico > ácido dimetilarsínico > ácido arsenioso.' AS texto
  UNION ALL SELECT @qid,'B','ácido dimetilarsínico > ácido arsênico > ácido arsenioso.'
  UNION ALL SELECT @qid,'C','ácido arsenioso > ácido dimetilarsínico > ácido arsênico.'
  UNION ALL SELECT @qid,'D','ácido arsenioso > ácido arsênico > ácido dimetilarsínico.'
  UNION ALL SELECT @qid,'E','ácido dimetilarsínico > ácido arsenioso > ácido arsênico.'
) alts WHERE @ja_existe_23e = 0;
