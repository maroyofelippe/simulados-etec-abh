-- ==========================================================
--  Migração de conteúdo: Banco de questões SARESP 2023 — 2ª Série EM
--  Caderno 013-LC-CN (Linguagens/Inglês + Ciências da Natureza), Cad02,
--  aplicado como Provão Paulista Seriado 2023 (01.12.2023) — Versão 2.
--  Fonte: caderno de questões + gabarito oficial (Fundação Vunesp) fornecidos pela coordenação.
--  ----------------------------------------------------------
--  Origem das questões: SARESP (coluna questoes.origem, criada pela
--  migração 2026-10_origem_questoes.sql — por isso este arquivo vem depois dela).
--
--  Escopo: das 48 questões do caderno, foram importadas as 46 plenamente
--  respondíveis a partir do texto. Ficaram de fora (não cadastradas):
--  questão 43 (a pergunta pede o gráfico das curvas de ebulição, e as
--  alternativas são gráficos) e questão 47 (as alternativas são gráficos de
--  DBO × OD ao longo do rio) — dependem de imagem que este sistema ainda não
--  armazena por questão. Nas questões 5, 21, 22, 27, 30, 44, 45, 46 e 48, a
--  figura/esquema foi descrito em texto no enunciado.
--
--  Gabarito: Versão 2 do gabarito oficial (Cad02).
--
--  Idempotente: variável de sessão travada no início (@ja_existe_23), sem
--  DELIMITER/stored procedures (incompatível com a execução via db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-10_origem_questoes_saresp2023_2serie.sql)
-- ==========================================================
SET @db := DATABASE();

-- Garante que a disciplina "Língua Inglesa" existe (idempotente)
INSERT INTO disciplinas (nome, area)
SELECT 'Língua Inglesa', 'Linguagens'
WHERE NOT EXISTS (SELECT 1 FROM disciplinas WHERE nome = 'Língua Inglesa');

-- Guarda travada: já aplicamos este lote antes?
SET @ja_existe_23 := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'No texto, o uso da palavra "entretanto"%'
);


-- ---------- Texto de apoio: Jeferson Tenório — gramática antirracista — Q01, 02
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Jeferson Tenório — gramática antirracista',
'A conquista de uma gramática antirracista, ou seja, de um vocabulário antirracista e que trouxe expressões e palavras como "branquitude", "lugar de fala", "privilégio branco", "racismo estrutural", ganhou mais espaço no meio social. Entretanto, esta mesma gramática ainda não penetrou de fato no Judiciário, que segue encarcerando pessoas negras com uma lógica baseada no perfilamento racial. Diante desses dados, não há como negar que a prisão de pessoas negras e periféricas, que são a maioria nos presídios, faz parte de um sistema injusto e racista.
(Jeferson Tenório. Prisão de jovens negros com pouca quantidade de drogas é estratégia racista. UOL, 18.07.2023. Disponível em: https://noticias.uol.com.br/colunas/jeferson-tenorio/)',
1, 2
WHERE @ja_existe_23 = 0;
SET @tid = LAST_INSERT_ID();

-- Q01
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No texto, o uso da palavra "entretanto" contribui para','Médio','Conectivos - valor semântico','2ª Série EM','SARESP','D',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'reafirmar que, mesmo promovendo um sistema injusto e racista, o Judiciário demonstra ser sensível à gramática antirracista.' AS texto
  UNION ALL SELECT @qid,'B','mostrar que, se o Judiciário aderisse a uma gramática antirracista, a prisão de pessoas negras e periféricas deixaria de acontecer.'
  UNION ALL SELECT @qid,'C','confirmar que, por representar um avanço social, palavras e expressões indicativas de uma gramática antirracista se difundiram no Judiciário.'
  UNION ALL SELECT @qid,'D','destacar que, apesar de representar um avanço social, a gramática antirracista ainda não se reflete na postura do Judiciário.'
  UNION ALL SELECT @qid,'E','negar que, embora ainda haja preconceito racial, a prisão de pessoas negras e periféricas resulte de uma atitude do Judiciário contra a gramática antirracista.'
) alts WHERE @ja_existe_23 = 0;

-- Q02
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No texto, a palavra "entretanto" poderia ser substituída por qualquer uma das seguintes palavras ou locuções:','Fácil','Conectivos - substituição','2ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'por isso, portanto, porém.' AS texto
  UNION ALL SELECT @qid,'B','no entanto, contudo, todavia.'
  UNION ALL SELECT @qid,'C','mas, no entanto, por isso.'
  UNION ALL SELECT @qid,'D','portanto, no entanto, consequentemente.'
  UNION ALL SELECT @qid,'E','embora, contudo, porém.'
) alts WHERE @ja_existe_23 = 0;

-- ---------- Texto de apoio: Campanha contra a violência doméstica — Q03, 04
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Campanha contra a violência doméstica',
'VIOLÊNCIA DOMÉSTICA CONTRA A MULHER. NÃO SE CALE. SILÊNCIO MATA. FALAR, NÃO!

VOCÊ NÃO ESTÁ SOZINHA. PROCURE UMA DELEGACIA OU UM CENTRO ESPECIALIZADO DE ATENDIMENTO À MULHER.

JUNTAS SOMOS MAIS FORTES.
(O Globo, 04.08.2023, p. 10)',
1, 2
WHERE @ja_existe_23 = 0;
SET @tid = LAST_INSERT_ID();

-- Q03
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O texto dessa peça publicitária apresenta o uso de','Fácil','Gêneros textuais - peça publicitária','2ª Série EM','SARESP','C',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'frase exclamativa para criar um suspense sobre o conteúdo da campanha.' AS texto
  UNION ALL SELECT @qid,'B','frase verbal afirmativa para reforçar a polêmica da campanha.'
  UNION ALL SELECT @qid,'C','frase nominal para introduzir o tema da campanha.'
  UNION ALL SELECT @qid,'D','frase verbal imperativa para obrigar uma adesão à campanha.'
  UNION ALL SELECT @qid,'E','frase interrogativa para lançar dúvidas sobre a campanha.'
) alts WHERE @ja_existe_23 = 0;

-- Q04
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Três períodos da peça publicitária se encontram corretamente articulados num único período composto em:','Médio','Período composto - articulação de orações','2ª Série EM','SARESP','E',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Caso não se cale, silêncio mata, porém falar, não!' AS texto
  UNION ALL SELECT @qid,'B','Não se cale, porque silêncio mata, ainda que falar, não!'
  UNION ALL SELECT @qid,'C','Não se cale, mas silêncio mata, e falar, não!'
  UNION ALL SELECT @qid,'D','Mesmo que não se cale, silêncio mata, embora falar, não!'
  UNION ALL SELECT @qid,'E','Não se cale, pois silêncio mata, mas falar, não!'
) alts WHERE @ja_existe_23 = 0;

-- Q05
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os quadrinhos a seguir foram publicados em uma tira da cartunista Laerte (Piratas do Tietê. Folha de S.Paulo, 06.11.2021, p. C5). Nos três primeiros quadrinhos, uma placa com a palavra "PROIBIDO" aparece em uma paisagem que vai sendo ocupada por casas e prédios. No último quadrinho, uma placa menor, acima da placa maior, diz "VOCÊ ESTÁ ENTRANDO EM", e a placa maior continua dizendo "PROIBIDO", como se fosse o nome de uma cidade.

Do exame dessa tira, depreendemos que','Médio','Classes de palavras - tira','2ª Série EM','SARESP','B',1,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o emprego de "proibido" como advérbio nos três primeiros quadrinhos se contrapõe ao seu emprego como adjetivo no último quadrinho.' AS texto
  UNION ALL SELECT @qid,'B','o emprego de "proibido" como adjetivo nos três primeiros quadrinhos cria uma expectativa que é quebrada pelo seu emprego como substantivo no último quadrinho.'
  UNION ALL SELECT @qid,'C','o emprego de "proibido" ora como substantivo ora como adjetivo nos três primeiros quadrinhos produz uma situação de incerteza no último quadrinho.'
  UNION ALL SELECT @qid,'D','o emprego de "proibido" como substantivo nos três primeiros quadrinhos gera uma ambiguidade que é desfeita pelo seu emprego como adjetivo no último quadrinho.'
  UNION ALL SELECT @qid,'E','o emprego de "proibido" como substantivo nos três primeiros quadrinhos produz um sentido negativo, que se torna positivo pelo seu uso como advérbio no último quadrinho.'
) alts WHERE @ja_existe_23 = 0;

-- Q06
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto a seguir, transcrição de um anúncio comercial publicado na Gazeta de Campinas, em 23 de junho de 1870.

Hotel Universal em Campinas
Rua do Commercio número 43

Este estabelecimento acha-se hoje montado com todo necessario. Os senhores viajantes ahi encontrarão sempre bons commodos, salão e quartos mobiliados. Um excellente cosinheiro e muito bons empregados servirão com a maior promptidão e aceio. Tem constantemente um completo sortimento de bebidas e refrescos e um sortimento de doces de todas as qualidades. Aprompta qualquer petisco sem demora. Recebe pensionistas internos e externos e manda comida para fóra por muito diminutos preços. Garante bem servir os freguezes para o que não poupa nem trabalho nem despeza. Tem cocheira para animaes onde são tratados perfeitamente com abundancia de capim e milho, e mandando-se laval-os e escoval-os. Estão a chegar ao mesmo hotel bons bilhares, jogos de bagatella, xadrez, damas, dominó, etc.
(Adaptado de: Guedes, Marymarcia & Berlinck, Rosane (orgs). (2000) E os preços eram commodos… Anúncios de jornais brasileiros – século XIX. São Paulo: Humanitas – FFLCH/USP. p. 280)

A partir da análise desse anúncio, é correto afirmar que','Médio','Variação linguística - ortografia histórica','2ª Série EM','SARESP','D',1,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a palavra "aceio", escrita atualmente com "ss", sugere que houve uma mudança na forma de representar os fonemas representados pela letra "c".' AS texto
  UNION ALL SELECT @qid,'B','a ocorrência de "laval-os" e "escoval-os" mostra que os verbos eram conjugados de forma diferente, com o sufixo número-pessoal "os" sendo flexionado fora da raiz verbal.'
  UNION ALL SELECT @qid,'C','a pronúncia das palavras "excelente" e "cômodos" era diferente da pronúncia atual, por isso eram escritas com consoantes dobradas ("excellente" e "commodos").'
  UNION ALL SELECT @qid,'D','a ocorrência de palavras como "cosinheiro" e "freguezes" indica que as letras "s" e "z" eram usadas para representar um mesmo fonema, tal como no sistema ortográfico atual.'
  UNION ALL SELECT @qid,'E','seu autor tinha baixo nível de escolarização, o que o levou a escrever várias palavras em desacordo com a norma ortográfica, como "animaes", "ahi" e "promptidão".'
) alts WHERE @ja_existe_23 = 0;

-- ---------- Texto de apoio: Superinteressante — a palavra "forró" — Q07, 08
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Superinteressante — a palavra "forró"',
'A palavra "forró" surgiu mesmo de "for all"?

NÃO. Essa é uma lenda linguística, que, de tão repetida, acabou ganhando um verniz histórico. Segundo ela, militares americanos estabelecidos no Rio Grande do Norte, à época da Segunda Guerra, teriam organizado uma festa dançante. Então, para que todo mundo se sentisse convidado, fixaram uma placa na entrada com a inscrição "For All" ("para todos") – que os brasileiros acabariam adaptando, por semelhança fonética, para "forró". Mas o termo "forró" ("baile popular em que casais dançam ao som de ritmos nordestinos") já constava em dicionário desde 1913 – três décadas antes. A origem mais plausível seria uma redução de "forrobodó", que também significa "baile popular". O termo foi dicionarizado em 1899.
Em uma coluna de 2020 na Veja, o escritor e especialista em língua portuguesa Sérgio Rodrigues explica que "forrobodó" já era título de uma opereta de Chiquinha Gonzaga que estreou em 1911. E vai além, lembrando que, de acordo com o gramático Evanildo Bechara, a palavra vem do galego forbodó (também "baile popular").
(Oráculo. Superinteressante. Edição 450. Abril 2023. p. 61)',
1, 2
WHERE @ja_existe_23 = 0;
SET @tid = LAST_INSERT_ID();

-- Q07
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No texto, a ideia de semelhança fonética está associada','Médio','Interpretação de texto - semelhança fonética','2ª Série EM','SARESP','A',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à proximidade na forma como a expressão "for all", do inglês, e a palavra "forró", do português, são pronunciadas.' AS texto
  UNION ALL SELECT @qid,'B','ao sentido da expressão "for all" em inglês, que é próximo ao significado da palavra "forró" em português.'
  UNION ALL SELECT @qid,'C','à origem duvidosa da palavra "forró", que mostra uma proximidade sonora tanto com o inglês "for all" quanto com o galego "forbodó".'
  UNION ALL SELECT @qid,'D','à identidade sonora entre "forró" e as duas primeiras sílabas de "forrobodó", que se assemelham à expressão "for all" do inglês.'
  UNION ALL SELECT @qid,'E','à adaptação de "for all" à sonoridade do português, dando origem a "forró", que conserva o sentido da expressão estrangeira.'
) alts WHERE @ja_existe_23 = 0;

-- Q08
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O processo de formação de palavra que, de acordo com o texto, caracteriza a origem provável da palavra "forró" também está presente em','Médio','Formação de palavras - redução','2ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"choro", a partir de "chorar".' AS texto
  UNION ALL SELECT @qid,'B','"refri", a partir de "refrigerante".'
  UNION ALL SELECT @qid,'C','"ONU", a partir de "Organização das Nações Unidas".'
  UNION ALL SELECT @qid,'D','"futebol", a partir de "football".'
  UNION ALL SELECT @qid,'E','"cachorro-quente", a partir de "hot dog".'
) alts WHERE @ja_existe_23 = 0;

-- Q09
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'De acordo com a Nova Gramática do Português Contemporâneo, "hipérbato é termo genérico para designar toda inversão na ordem normal das palavras na oração, ou da ordem das orações no período, com finalidade expressiva" (Celso Cunha & Lindley Cintra. Rio de Janeiro: Editora Moderna, 1985, p. 610).

Em qual dos ditados populares apresentados a seguir temos um hipérbato?','Médio','Figuras de linguagem - hipérbato','2ª Série EM','SARESP','E',1,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"Quem não tem cão caça com gato."' AS texto
  UNION ALL SELECT @qid,'B','"Quem vê cara não vê coração."'
  UNION ALL SELECT @qid,'C','"Quem ri por último ri melhor."'
  UNION ALL SELECT @qid,'D','"Quem cala consente."'
  UNION ALL SELECT @qid,'E','"Quem se mistura com porcos farelo come."'
) alts WHERE @ja_existe_23 = 0;

-- Q10
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto, publicado no jornal O Globo, em 2018, do jornalista carioca Gilberto Porcidonio.

As gírias ''daora'' invadiram a nossa praia

Os "mano e as mina", no trampo ou na balada, acham tudo "daora" ou "sussa", ou só "ficam pistola" se tiver "treta". Não deu para entender? Então, isso é sinal (ou seria semáforo) de que as gírias paulistanas desembarcaram no Rio para confundir. Mas a gente pode explicar, assim como qualquer carioca que aderiu ao "paulistanês".
É o caso da estudante Aline Lopes, moradora de Bento Ribeiro. Ela usa corriqueiramente expressões típicas da Terra da Garoa, novas e antigas.
– Falo "que fita", "fazer um corre" e "breja" – enumera Aline, para lamentar em seguida: Mas "padoca" e "feijuca" eu não consigo.
O tatuador Thiago Luz, que foi alvo de deboche quando chegou ao Rio, há 18 anos, lembra que falar palavras como "mano" era a senha para virar motivo de piada.
– Eu não podia falar "mano", "meu", "rolezinho" e "daora" que alguém sempre caía em cima. Parecia que eu estava em outro planeta.
Mas a história de amor com São Paulo não encanta todos os cariocas. O engenheiro Maurilio Mesquita, que mora na Tijuca, não disfarça o incômodo. Ele costuma dizer que o monopólio da língua é disputado entre Rio e São Paulo, numa espécie de "bipolarização do português".
– Está na hora de o Iphan (Instituto do Patrimônio Histórico e Artístico Nacional) tombar o português falado na antiga capital do Império – provoca Maurilio.
(Adaptado de: PORCIDONIO, Gilberto. As gírias ''daora'' invadiram a nossa praia. O Globo, 22.04.18, p. 16)

A matéria de Gilberto Porcidonio sugere que','Médio','Interpretação de texto - gírias regionais','2ª Série EM','SARESP','D',1,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'cariocas estão travando uma disputa com paulistanos pelo domínio do português, levando à rejeição de palavras como "padoca" e "mano" no Rio de Janeiro.' AS texto
  UNION ALL SELECT @qid,'B','cariocas deixaram de usar palavras típicas do Rio de Janeiro, como "cerveja", e passaram a usar palavras que são empregadas por paulistanos, como "breja".'
  UNION ALL SELECT @qid,'C','palavras como "sussa", "daora" e "rolezinho" são usadas por paulistanos para indicar situações que são desconhecidas por quem vive no Rio de Janeiro.'
  UNION ALL SELECT @qid,'D','gírias usadas por paulistanos, como "ficam pistola" e "sussa", vêm se tornando conhecidas no Rio de Janeiro, mas nem sempre são compreendidas ou bem aceitas por cariocas.'
  UNION ALL SELECT @qid,'E','paulistanos falam de forma confusa, mas isso não tem impedido o uso de palavras comuns em São Paulo, como "treta" e "feijuca", por moradores do Rio de Janeiro.'
) alts WHERE @ja_existe_23 = 0;

-- ---------- Texto de apoio: Renato Russo / Legião Urbana — "Pais e Filhos" — Q11, 12, 13
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Renato Russo / Legião Urbana — "Pais e Filhos"',
'Pais e Filhos

Estátuas, e cofres, e paredes pintadas
Ninguém sabe o que aconteceu
Hum, ela se jogou da janela do quinto andar
Nada é fácil de entender

Dorme agora
Hum, hum
É só o vento lá fora

Quero colo
Vou fugir de casa
Posso dormir aqui com vocês?
Estou com medo
Tive um pesadelo
Só vou voltar depois das três

Meu filho vai ter nome de santo
Quero o nome mais bonito

É preciso amar
As pessoas como se não houvesse amanhã
Porque se você parar pra pensar
Na verdade, não há

Me diz por que que o céu é azul
Explica a grande fúria do mundo

São meus filhos que tomam conta de mim
Eu moro com a minha mãe, mas meu pai vem me visitar
Eu moro na rua, não tenho ninguém
Eu moro em qualquer lugar
Já morei em tanta casa que nem me lembro mais
Eu moro com meus pais

É preciso amar
As pessoas como se não houvesse amanhã
Porque se você parar pra pensar
Na verdade, não há

Sou uma gota d''água
Sou um grão de areia
Você me diz que seus pais não o entendem
Mas você não entende seus pais

Você culpa seus pais por tudo
Isso é um absurdo
São crianças como você
O que você vai ser
Quando você crescer?
(Renato/Legião Urbana. Pais e Filhos. In: RUSSO, As quatro Estações. Rio de Janeiro: EMI, 1989)',
1, 2
WHERE @ja_existe_23 = 0;
SET @tid = LAST_INSERT_ID();

-- Q11
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na terceira estrofe da canção "Pais e Filhos" ("Quero colo... só vou voltar depois das três"), os versos aparentemente independentes uns dos outros significam que','Médio','Texto literário - canção','2ª Série EM','SARESP','C',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a rebeldia dos jovens é assunto de canções do universo do Pop-Rock.' AS texto
  UNION ALL SELECT @qid,'B','a linguagem literária, por ser imaginativa, dispensa a coerência textual.'
  UNION ALL SELECT @qid,'C','se cria o eco de múltiplas vozes, presentificando-se demandas de filhos aos pais.'
  UNION ALL SELECT @qid,'D','os pais demandam os filhos em diferentes fases de seu desenvolvimento físico e emocional.'
  UNION ALL SELECT @qid,'E','a poesia não utiliza recursos coesivos para a construção dos sentidos do texto.'
) alts WHERE @ja_existe_23 = 0;

-- Q12
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Depreende-se de sua letra que a canção','Médio','Texto literário - canção','2ª Série EM','SARESP','A',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'parte de um tema sensível, o suicídio de uma jovem, e chega a uma mensagem sobre empatia nos relacionamentos interpessoais.' AS texto
  UNION ALL SELECT @qid,'B','parte de um tema sensível, o suicídio de uma jovem, e induz os pais a reverem seus posicionamentos autoritários.'
  UNION ALL SELECT @qid,'C','parte de um tema sensível, o suicídio de uma jovem, e induz os filhos a reverem seus posicionamentos rebeldes.'
  UNION ALL SELECT @qid,'D','parte de um tema sensível, a rebeldia de uma jovem, e questiona os sentimentos desencontrados dos pais.'
  UNION ALL SELECT @qid,'E','parte de um tema sensível, a rebeldia de uma jovem, e generaliza a atitude dela para todos os jovens.'
) alts WHERE @ja_existe_23 = 0;

-- Q13
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considerando o texto e o que se sabe a respeito do texto literário, pode-se afirmar que a canção','Fácil','Texto literário - canção','2ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'valoriza os problemas urbanos contemporâneos.' AS texto
  UNION ALL SELECT @qid,'B','é representativa de uma força da música brasileira, que associa poesia e canto.'
  UNION ALL SELECT @qid,'C','está em desacordo com o gênero lírico por pressupor diálogos.'
  UNION ALL SELECT @qid,'D','abusa de figuras como a sinestesia e de elementos místicos.'
  UNION ALL SELECT @qid,'E','fala de problemas objetivos do narrador do poema.'
) alts WHERE @ja_existe_23 = 0;

-- Q14
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia os textos a seguir.

TEXTO I
"Uma mulher, de 86 anos, foi resgatada depois de trabalhar para uma mesma família há 74 anos. Nascida em Vassouras, no Centro-Sul do estado do Rio de Janeiro, a senhora trabalhou para a mesma família desde os 12 anos de idade, por três gerações.
Ela prestou serviço todos os dias, sem oportunidade de estudo, férias ou salário. Atualmente, com a idade avançada, continuava exercendo as funções domésticas como limpar, passar roupa, fazer comida e cuidar da dona casa."
(Portal CNN, 13 de maio de 2022. Disponível em https://www.cnnbrasil.com.br. Acesso em 15.08.2023. Adaptado)

TEXTO II
"O que é o trabalho escravo contemporâneo?
Na legislação brasileira, o artigo 149 do Código Penal prevê os elementos que caracterizam a redução de um ser humano à condição análoga à de escravo. São eles: a submissão a trabalhos forçados ou a jornadas exaustivas, a sujeição a condições degradantes de trabalho e a restrição de locomoção do trabalhador.
O conceito de trabalho escravo contemporâneo trazido pelo ordenamento brasileiro representa grande avanço no combate a essa dura realidade, pois evidencia que, nos tempos atuais, sua configuração vai muito além da privação de liberdade, ocorrendo nas mais amplas situações de ofensa à dignidade do ser humano, como em hipóteses de submissão a condições degradantes de trabalho, jornadas exaustivas ou forçadas por dívidas impostas aos trabalhadores."
(https://www.cnmp.mp.br. Acesso em 15.08.2023. Adaptado)

Relacionando-se os textos 1 e 2, é correto concluir que a senhora que prestava serviços domésticos','Médio','Relação entre textos - trabalho escravo contemporâneo','2ª Série EM','SARESP','D',1,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'foi empregada doméstica de uma mesma família por três gerações.' AS texto
  UNION ALL SELECT @qid,'B','não foi mantida em situação análoga à de escravidão, pois desfrutava de relativa liberdade.'
  UNION ALL SELECT @qid,'C','foi mantida em situação análoga à de escravidão a partir do momento em que poderia ter se aposentado.'
  UNION ALL SELECT @qid,'D','foi mantida em situação análoga à de escravidão por três gerações de uma família.'
  UNION ALL SELECT @qid,'E','não foi mantida em situação análoga à de escravidão, pois vivia integrada em uma família.'
) alts WHERE @ja_existe_23 = 0;

-- ---------- Texto de apoio: Machado de Assis — "Pai contra mãe" — Q15, 16
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Machado de Assis — "Pai contra mãe"',
'A escravidão levou consigo ofícios e aparelhos, como terá sucedido a outras instituições sociais. Não cito alguns aparelhos senão por se ligarem a certo ofício. Um deles era o ferro ao pescoço, outro o ferro ao pé; havia também a máscara de folha de flandres. A máscara fazia perder o vício da embriaguez aos escravos, por lhes tapar a boca. Tinha só três buracos, dous para ver, um para respirar, e era fechada atrás da cabeça por um cadeado. Com o vício de beber, perdiam a tentação de furtar, porque geralmente era dos vinténs do senhor que eles tiravam com que matar a sede, e aí ficavam dous pecados extintos, e a sobriedade e a honestidade, certas. Era grotesca tal máscara, mas a ordem social e humana nem sempre se alcança sem o grotesco, e alguma vez o cruel. Os funileiros as tinham penduradas, à venda, na porta das lojas. Mas não cuidemos de máscaras.
O ferro ao pescoço era aplicado aos escravos fujões. Imaginai uma coleira grossa, com a haste grossa também, à direita ou à esquerda, até ao alto da cabeça e fechada atrás com chave. Pesava, naturalmente, mas era menos castigo que sinal. Escravo que fugia assim, onde quer que andasse, mostrava um reincidente, e com pouco era pegado.
(Machado de Assis. Pai contra mãe. In: Relíquias de Casa Velha, Obra completa em três volumes. 6ª impressão ilustrada. Rio de Janeiro: Editora Nova Aguilar, 1986, vol. II, p. 659)',
1, 2
WHERE @ja_existe_23 = 0;
SET @tid = LAST_INSERT_ID();

-- Q15
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No primeiro parágrafo do texto, pode-se afirmar que o narrador:','Difícil','Texto literário - Machado de Assis','2ª Série EM','SARESP','A',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'constrói uma breve lista de aparelhos com os quais se torturavam os escravizados, com o objetivo de relembrar os dias terríveis da escravidão brasileira.' AS texto
  UNION ALL SELECT @qid,'B','utiliza uma atenuação ao concluir o primeiro parágrafo com "Mas não cuidemos de máscaras", já que um dos assuntos do trecho é a violência dos aparelhos de tortura aos escravizados.'
  UNION ALL SELECT @qid,'C','utiliza-se a hipérbole (exagero) ao mencionar, no mesmo trecho, o "ferro ao pescoço", o "ferro ao pé" e descrever a "máscara de folha de flandres".'
  UNION ALL SELECT @qid,'D','elide (oculta) a função de alguns aparelhos de tortura aos escravizados para jamais reproduzir os dias terríveis da escravidão brasileira.'
  UNION ALL SELECT @qid,'E','menciona de forma leve o assunto da escravização brasileira, ao dizer que "não cito aparelhos senão por se ligarem a certo ofício".'
) alts WHERE @ja_existe_23 = 0;

-- Q16
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No trecho "era grotesca tal máscara mas a ordem humana nem sempre se alcança sem o grotesco", estamos diante do estilo irônico de Machado de Assis','Difícil','Texto literário - ironia','2ª Série EM','SARESP','C',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'que repete as palavras "grotesca" e "grotesco" na mesma oração.' AS texto
  UNION ALL SELECT @qid,'B','que repete as palavras grotesca/grotesco como forma de evidenciar a condição feminina e masculina da ordem humana.'
  UNION ALL SELECT @qid,'C','que repete as palavras "grotesca" e "grotesco" como forma de evidenciar o paradoxo entre e ordem humana e bizarro.'
  UNION ALL SELECT @qid,'D','cujas frases são titubeantes porque repetem as palavras "grotesca" e "grotesco".'
  UNION ALL SELECT @qid,'E','pelo qual se afirma que as máscaras são necessárias à ordem humana.'
) alts WHERE @ja_existe_23 = 0;

-- ---------- Texto de apoio: Luís de Camões — soneto "Amor, que o gesto humano n'alma escreve" — Q17, 19, 20
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Luís de Camões — soneto "Amor, que o gesto humano n''alma escreve"',
'Amor, que o gesto humano n''alma escreve,
vivas faíscas me mostrou um dia,
donde um puro cristal se derretia
por entre vivas rosas e alva neve.

A vista, que em si mesma não se atreve,
por se certificar do que ali via,
foi convertida em fonte, que fazia
a dor ao sofrimento doce e leve.

Jura Amor que brandura de vontade
causa o primeiro efeito; o pensamento
endoudece, se cuida que é verdade.

Olhai como Amor gera num momento,
de lágrimas de honesta piedade,
lágrimas de imortal contentamento!
(CAMÕES, Luís Vaz de. Obra completa, 2003)',
1, 2
WHERE @ja_existe_23 = 0;
SET @tid = LAST_INSERT_ID();

-- Q17
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A chamada rima rica é aquela que ocorre entre palavras de classes gramaticais diferentes, a exemplo do que se verifica','Difícil','Texto literário - rima rica','2ª Série EM','SARESP','A',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'na primeira e na segunda estrofes.' AS texto
  UNION ALL SELECT @qid,'B','na segunda estrofe, apenas.'
  UNION ALL SELECT @qid,'C','na primeira estrofe, apenas.'
  UNION ALL SELECT @qid,'D','na primeira e na terceira estrofes.'
  UNION ALL SELECT @qid,'E','na segunda e na quarta estrofes.'
) alts WHERE @ja_existe_23 = 0;

-- Q18
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o trecho do ensaio "A vida ao rés-do-chão", do crítico Antonio Candido.

A crônica não é um "gênero maior". Não se imagina uma literatura feita de grandes cronistas, que lhe dessem o brilho universal dos grandes romancistas, dramaturgos e poetas. Portanto, parece mesmo que a crônica é um gênero "menor". Por meio dos assuntos, da composição solta, do ar de coisa sem necessidade que costuma assumir, ela se ajusta à sensibilidade de todo o dia. O fato de ficar perto do dia a dia age como quebra do monumental e da ênfase.
(Antonio Candido. Recortes, 1993. Adaptado)

Depreende-se do ensaio de Antonio Candido que','Médio','Interpretação de texto - gênero crônica','2ª Série EM','SARESP','E',1,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a crônica, por se debruçar sobre a matéria do cotidiano, é um gênero que produz a impressão de elevação.' AS texto
  UNION ALL SELECT @qid,'B','a crônica, por se debruçar sobre a matéria do cotidiano, é um gênero que não focaliza assuntos relevantes.'
  UNION ALL SELECT @qid,'C','a crônica possui valor literário inferior à poesia, por não explorar o lirismo que se oculta no cotidiano.'
  UNION ALL SELECT @qid,'D','a crônica possui valor literário inferior ao romance, por não dar ênfase aos assuntos graves do cotidiano.'
  UNION ALL SELECT @qid,'E','a crônica, por se debruçar sobre a matéria do cotidiano, é um gênero que abre mão do monumental.'
) alts WHERE @ja_existe_23 = 0;

-- Q19
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O soneto é construído a partir do recurso reiterado','Médio','Texto literário - antítese','2ª Série EM','SARESP','B',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ao eufemismo, com a intenção de expor a ausência de lógica do sentimento amoroso.' AS texto
  UNION ALL SELECT @qid,'B','à antítese, com a intenção de expor as contradições decorrentes do sentimento amoroso.'
  UNION ALL SELECT @qid,'C','ao pleonasmo, com a intenção de se expor a banalidade do sentimento amoroso.'
  UNION ALL SELECT @qid,'D','ao eufemismo, com a intenção de expor os prazeres decorrentes do sentimento amoroso.'
  UNION ALL SELECT @qid,'E','à antítese, com a intenção de expor o enfraquecimento paulatino do sentimento amoroso.'
) alts WHERE @ja_existe_23 = 0;

-- Q20
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No soneto, o eu lírico dirige-se diretamente a seus leitores no seguinte verso:','Fácil','Texto literário - vocativo e interlocução','2ª Série EM','SARESP','D',1,2,@tid,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"A vista, que em si mesma não se atreve," (2ª estrofe)' AS texto
  UNION ALL SELECT @qid,'B','"Jura Amor que brandura de vontade" (3ª estrofe)'
  UNION ALL SELECT @qid,'C','"Amor, que o gesto humano na alma escreve," (1ª estrofe)'
  UNION ALL SELECT @qid,'D','"Olhai como Amor gera, num momento," (4ª estrofe)'
  UNION ALL SELECT @qid,'E','"Lágrimas de imortal contentamento!" (4ª estrofe)'
) alts WHERE @ja_existe_23 = 0;

-- Q21
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O infográfico a seguir refere-se a uma pesquisa feita na Inglaterra e Irlanda, a respeito de embalagens reutilizáveis de alimentos e bebidas.

What will help get people on board?
41% – Using it for no extra cost
38% – Earning rewards or discounts (10% off)
38% – Knowing that it''s better for the environment

What might put people off?
38% – It might not be clean or hygienic
31% – It might cost more money
27% – Having to carry or store it until I can return it
(Disponível em: https://www.hubbub.org.uk/reuse-systems-unpacked. Acesso em 30.07.2023. Adaptado)

Entre os aspectos favoráveis ao esquema de embalagem reutilizável, inclui-se','Fácil','Reading comprehension - infográfico','2ª Série EM','SARESP','C',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o engajamento das prefeituras de regiões periféricas.' AS texto
  UNION ALL SELECT @qid,'B','investimento financeiro na produção de invólucros.'
  UNION ALL SELECT @qid,'C','o recebimento de bônus ou descontos.'
  UNION ALL SELECT @qid,'D','o retorno dos recipientes ao local de origem.'
  UNION ALL SELECT @qid,'E','a verificação contínua de condições de higiene.'
) alts WHERE @ja_existe_23 = 0;

-- Q22
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a charge a seguir, em que duas mulheres conversam diante de produtos de maquiagem. Na fala da primeira: "SORRY I BLAMED YOU FOR USING MY MAKEUP." Na fala da segunda: "LET''S NOT FIGHT. LET''S MAKE UP."
(http://englishteachermargarita.blogspot.com. Acesso em: 28.07.2023)

Na figura, as ocorrências de "makeup" e "make up" significam, respectivamente,','Fácil','Vocabulary - phrasal verbs','2ª Série EM','SARESP','A',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'maquiagem e reconciliação.' AS texto
  UNION ALL SELECT @qid,'B','base e discussão.'
  UNION ALL SELECT @qid,'C','limpeza e confidência.'
  UNION ALL SELECT @qid,'D','decisão e expectativa.'
  UNION ALL SELECT @qid,'E','creme e inveja.'
) alts WHERE @ja_existe_23 = 0;

-- Q23
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Do you think of cats as nocturnal animals, asleep most of the day and awake at night?
Are cats nocturnal? Unlike bats, for example, cats are not technically nocturnal. Instead, ''cats are crepuscular,'' explains Michelle Lugones, a veterinarian at Best Friends Animal Society. ''This means that they are wired to be most active at dusk and dawn.''
''Many people think that cats are nocturnal because most people who have a cat will attest to the fact that their cat wakes them up in the middle of the night regularly,'' Dr. Lugones says. ''But that overnight activity usually correlates to their crepuscular tendencies.''
Even though they''re not actually nocturnal, cats certainly do a lot of snoozing during the day. But while they sleep 12 and 15 hours a day, they''re not lazy, or even very deep sleepers! Cats are always ''on the alert'' – even in their sleep. This means that if there''s a loud sound, they may wake up and instantly be bright and alert. It''s a protective mechanism designed to keep wild animals safe from predators and able to catch prey if the opportunity arises.
(Meghan Jones. Are Cats Nocturnal? Your Cat''s Overnight Activity, Explained. https://www.rd.com/article/are-cats-nocturnal/. 02.05.2023. Acesso em 08.08.2023. Adaptado)

Considerado o contexto, o segmento "But that overnight activity usually correlates to their crepuscular tendencies.", em relação aos gatos, refere-se','Médio','Reading comprehension - inferência','2ª Série EM','SARESP','A',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'às atividades em períodos com pouca luz.' AS texto
  UNION ALL SELECT @qid,'B','à capacidade de socialização com seus tutores.'
  UNION ALL SELECT @qid,'C','ao comportamento preguiçoso e relaxado.'
  UNION ALL SELECT @qid,'D','às formas de simulação de camuflagem.'
  UNION ALL SELECT @qid,'E','à rapidez de reação em situações de perigo.'
) alts WHERE @ja_existe_23 = 0;

-- Q24
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Choice is our ability to make decisions when presented with two or more options. The psychology of choice explores why we subconsciously make the decisions we do, what motivates those decisions, and what needs these decisions are meant to satisfy.
I don''t know about you, but I get stressed when someone asks me what I want for lunch. Food delivery apps give us hundreds of restaurants willing to bring our meals right to our door. Entertainment apps give us thousands of movie titles to choose from on a Friday night.
We live in an unprecedented age of options. And that can make choice difficult.
Choice is the purest expression of free will – the freedom to choose allows us to shape our lives exactly how we wish (provided we have the resources to do so).
But choice is difficult because it also represents sacrifice. Choosing something inherently means giving up something else – something we might want tomorrow, or next week – and that won''t be available to us if we don''t grab it today.
All choices are made to satisfy five basic needs: survival, love and belonging, power, freedom, and fun.
(Leslie Ye. The Psychology of Choice: How to Make Easier Decisions. https://blog.hubspot.com/sales/the-psychology-of-choice. 25.07. 2019. Acesso em 02.08.2023. Adaptado)

De acordo com o texto, o gesto de fazer escolhas na vida envolve','Médio','Reading comprehension - ideia central','2ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Língua Inglesa'),2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ter paciência para aguardar o momento de agir.' AS texto
  UNION ALL SELECT @qid,'B','delegar a alguém próximo parte das decisões inadiáveis.'
  UNION ALL SELECT @qid,'C','observar tendência a optar pelo conhecido.'
  UNION ALL SELECT @qid,'D','fazer julgamentos apressados e inconsequentes.'
  UNION ALL SELECT @qid,'E','ter de renunciar a alternativas possíveis.'
) alts WHERE @ja_existe_23 = 0;

-- Q25
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os dados a seguir referem-se à contaminação por bifenilas policloradas (PCBs), uma forma de poluente orgânico, em uma cadeia trófica aquática (dados em mg/L ou em mg/kg de gordura):
Água marinha: 0,0001 – 0,02
Sedimento: 0,005 – 0,16
Fitoplâncton: 8,0
Zooplâncton: 10,0
Invertebrados: 5,0 – 11,0
Peixes: 1,0 – 37,0
Aves marinhas: 110,0
Mamíferos marinhos: 160,0
(https://worldoceanreview.com/. Acesso em 05.08.2023. Adaptado)

Considerando o efeito tóxico deste poluente, espera-se que ocorra redução populacional imediata dos','Médio','Ecologia - bioacumulação','2ª Série EM','SARESP','D',3,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'organismos do zooplâncton.' AS texto
  UNION ALL SELECT @qid,'B','cardumes de peixes.'
  UNION ALL SELECT @qid,'C','produtores planctônicos.'
  UNION ALL SELECT @qid,'D','predadores de topo de cadeia.'
  UNION ALL SELECT @qid,'E','invertebrados.'
) alts WHERE @ja_existe_23 = 0;

-- Q26
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Em julho de 2023, o Japão foi autorizado a começar a bombear para o mar mais de um milhão de toneladas – quase o mesmo volume de 500 piscinas olímpicas – de água tratada que foi usada para resfriar os reatores derretidos da usina nuclear de Fukushima desde 2011, já que a capacidade de armazenamento está se esgotando. O diretor-geral da Agência Internacional de Energia Atômica (AIEA), Rafael Grossi, afirmou que a água tratada terá "impacto radiológico insignificante para as pessoas e para o meio ambiente". A vizinha Coreia do Sul também emitiu parecer similar, embora mantenha sua proibição de importação de alguns alimentos japoneses. E a China e Hong Kong anunciaram proibições similares.
(Shaimaa Khalil. Tarachine: as mulheres de Fukushima que controlam a radioatividade nos alimentos e ainda temem o ''inimigo sensível''. BBC News Brasil, 22.07.2023)

Estas proibições se devem ao temor de que o consumo destes produtos resulte em','Médio','Radiação e saúde','2ª Série EM','SARESP','B',3,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'alterações fisiológicas no sistema nervoso.' AS texto
  UNION ALL SELECT @qid,'B','mutações genéticas com efeitos cancerígenos no organismo.'
  UNION ALL SELECT @qid,'C','queimaduras e necrose de tecidos.'
  UNION ALL SELECT @qid,'D','amplificação da reprodução de micro-organismos patogênicos.'
  UNION ALL SELECT @qid,'E','inativação das enzimas que atuam no metabolismo energético.'
) alts WHERE @ja_existe_23 = 0;

-- Q27
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O esquema a seguir resume as principais etapas do metabolismo energético:
- GLICÓLISE: glicose (6 carbonos) é convertida em piruvato (3 carbonos), com produção de 2 NADH e 2 ATP.
- FERMENTAÇÃO: a partir do piruvato, forma 2 lactato (3 carbonos) ou 2 etanol (2 carbonos) + 2 CO2.
- OXIDAÇÃO DO PIRUVATO: produz 2 NADH e 2 CO2 e forma 2 grupos acetil como acetil CoA (2 carbonos).
- CICLO DO ÁCIDO CÍTRICO: produz 6 NADH, 2 FADH2, 4 CO2 e 2 ATP.
- CADEIA DE TRANSPORTE DE ELÉTRONS: recebe os NADH e FADH2, consome 6 O2, produz 6 H2O e 28 ATP.
Resumo de reagentes e produtos: C6H12O6 + 6 O2 → 6 CO2 + 6 H2O + 32 ATP.
(David Sadava e colaboradores. Vida: a Ciência da Biologia. 2009)

Com base no esquema, a produção de ATP em larga escala é dependente, sobretudo, da','Médio','Metabolismo energético - respiração celular','2ª Série EM','SARESP','C',3,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'oxidação do piruvato.' AS texto
  UNION ALL SELECT @qid,'B','ocorrência do ciclo do ácido cítrico.'
  UNION ALL SELECT @qid,'C','presença de gás oxigênio.'
  UNION ALL SELECT @qid,'D','realização da fermentação.'
  UNION ALL SELECT @qid,'E','inativação da glicólise.'
) alts WHERE @ja_existe_23 = 0;

-- Q28
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Em 2015, o Ministério da Saúde instituiu a campanha Junho Vermelho, de incentivo para novos doadores a fim de manter os estoques dos hemocentros pelo Brasil. Neste ano, porém, o enfoque é no estado de São Paulo, onde a situação é de alerta, com estoques da Fundação Pró-sangue operando em nível crítico, com menos de 40% da sua capacidade e os sangues do tipo O–, O+ e B–, com menos de 10% da capacidade ideal, de acordo com dados da Secretaria de Saúde paulista.
(Simone Blanes. Doação de Sangue: Como doar? Quem pode? Quem não pode? Veja, 14.06.2023. Adaptado)

Um homem deseja ajudar a atender a esta demanda, mas não sabe o seu grupo sanguíneo, apenas que sua mãe é do tipo A+, seu pai é B- e um irmão, filho dos mesmos pais, é O–.

A chance de este homem possuir qualquer dos tipos sanguíneos abaixo da capacidade ideal é de','Difícil','Genética - sistema ABO e Rh','2ª Série EM','SARESP','A',3,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'37,5%.' AS texto
  UNION ALL SELECT @qid,'B','12,5%.'
  UNION ALL SELECT @qid,'C','25%.'
  UNION ALL SELECT @qid,'D','50%.'
  UNION ALL SELECT @qid,'E','6,25%.'
) alts WHERE @ja_existe_23 = 0;

-- Q29
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere o excerto a seguir.

Na Amazônia, o acumulado de alertas de desmatamento no período de agosto de 2022 a julho de 2023 foi de 7.952 km². Esse é o menor valor em quatro anos. Quando comparado com a temporada de 2021/2022, o atual período registrou queda de mais de 7% no acumulado de alertas, redução que equivale a uma área de 638 km².
(Roberto Peixoto, Júlia Putini e Lorena Fraga. Alertas de desmatamento batem recorde no Cerrado e na Amazônia taxa é a menor em 4 anos. G1 – Meio Ambiente. 03.08.2023. Adaptado)

Uma importante consequência desta tendência é','Fácil','Ecologia - desmatamento','2ª Série EM','SARESP','B',3,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a modificação das relações tróficas.' AS texto
  UNION ALL SELECT @qid,'B','a conservação da biodiversidade.'
  UNION ALL SELECT @qid,'C','a limitação dos nichos ecológicos.'
  UNION ALL SELECT @qid,'D','a supressão dos organismos decompositores.'
  UNION ALL SELECT @qid,'E','a ampliação das variações microclimáticas.'
) alts WHERE @ja_existe_23 = 0;

-- Q30
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere a filogenia a seguir, realizada a partir de um mesmo sítio nucleotídico da cadeia de DNA. Nela, observa-se que as bases nitrogenadas presentes podem ser adenina (A) ou citosina (C).
Descrição da árvore: o ancestral S1 {A, C} origina S2 {A, C} e S3 {C}. S2 origina S4 {C} e S5 {A}. S3 origina S6 {C} e S7 {C}.
(Antonio Solé-Cava, Edson Pereira da Silva e Gisele Lôbo-Hadju. Evolução, 2010)

Em um estudo da evolução deste grupo, constatou-se que a espécie ancestral S1 apresentava polimorfia, isto é, certos indivíduos possuíam adenina e outros, citosina. Porém, as espécies atuais – S4 a S7 – apresentam apenas uma das duas possibilidades, citosina em S4, S6 e S7 e adenina em S5.

Esta filogenia indica que a presença de citosina nas espécies atuais é resultado de','Difícil','Evolução - filogenia','2ª Série EM','SARESP','D',3,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'manutenção das frequências gênicas.' AS texto
  UNION ALL SELECT @qid,'B','alterações fenotípicas em relação ao ancestral comum.'
  UNION ALL SELECT @qid,'C','mutação genética nova.'
  UNION ALL SELECT @qid,'D','fixação independente em clados diferentes.'
  UNION ALL SELECT @qid,'E','seleção natural aleatória.'
) alts WHERE @ja_existe_23 = 0;

-- Q31
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere o excerto a seguir.

Em 1945, J. Robert Oppenheimer, um físico americano, supervisionou o Projeto Manhattan, que desenvolveu a bomba atômica. Após o bombardeio de Hiroshima e Nagasaki, Oppenheimer disse: "Vi a besta abrir a boca."
As palavras de Oppenheimer são um lembrete do poder e da responsabilidade da ciência. A biotecnologia é uma área de pesquisa emergente que tem o potencial de curar doenças e melhorar a vida das pessoas. No entanto, também tem o potencial de ser usada para criar armas biológicas ou para manipular a genética humana.
(Katie Jennings. Oppenheimer e as lições sobre poder e responsabilidade para a biotecnologia. Forbes. 28.07.2023)

O texto recomenda cautela, pois a área científica em questão desenvolve','Médio','Biotecnologia - ética e ciência','2ª Série EM','SARESP','E',3,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'imunizantes de RNA que possuem maior eficácia contra agentes patogênicos.' AS texto
  UNION ALL SELECT @qid,'B','metodologias biológicas de combate a poluentes orgânicos persistentes.'
  UNION ALL SELECT @qid,'C','vetores virais e não virais que dirimem doenças gênicas.'
  UNION ALL SELECT @qid,'D','produtos farmacêuticos que minimizam rejeição por incompatibilidade tecidual.'
  UNION ALL SELECT @qid,'E','variedades de organismos que alteram as relações tróficas.'
) alts WHERE @ja_existe_23 = 0;

-- Q32
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

O que é um coração artificial?
São bombas que ajudam um ou todos os lados do coração. Elas podem tanto funcionar externamente, com mangueiras conectadas às veias e às artérias, ou internamente. Cada bomba cuida de uma função: há a que puxa o sangue venoso e existe a que distribui o oxigenado para o corpo. Como um coração, as bombas precisam trabalhar sem descanso.
(Coração artificial: entenda em 4 pontos como a técnica funciona. G1. 23.08.2023)

O uso da bomba cardíaca artificial não é capaz de cumprir estas duas funções simultaneamente, pois resultaria em','Médio','Fisiologia - sistema cardiovascular','2ª Série EM','SARESP','C',3,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'fluxo sanguíneo com direções opostas.' AS texto
  UNION ALL SELECT @qid,'B','alteração significativa do retorno venoso.'
  UNION ALL SELECT @qid,'C','redução do índice de oxigênio transportado.'
  UNION ALL SELECT @qid,'D','interrupção do processo de hematose.'
  UNION ALL SELECT @qid,'E','derrame pulmonar nos alvéolos.'
) alts WHERE @ja_existe_23 = 0;

-- Q33
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Sabendo que o coração de um beija-flor bate com uma frequência máxima de 20 Hz, ou seja, 20 batimentos a cada segundo, qual seria o número de batimentos que o coração poderia dar durante uma hora, assumindo que ele trabalhasse sempre no maior ritmo possível?','Fácil','Ondulatória - frequência','2ª Série EM','SARESP','E',4,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'720.' AS texto
  UNION ALL SELECT @qid,'B','7 200.'
  UNION ALL SELECT @qid,'C','720 000.'
  UNION ALL SELECT @qid,'D','72.'
  UNION ALL SELECT @qid,'E','72 000.'
) alts WHERE @ja_existe_23 = 0;

-- Q34
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Felix Baumgartner é um atleta austríaco que ganhou fama mundial em 2012, ao ser a primeira pessoa a superar a velocidade do som em um salto de paraquedas a partir de um balão estratosférico, à 39 km de altitude. Ele atingiu a velocidade máxima aproximada de 1 350 km/h, o equivalente a 1,25 vez a velocidade do som.
(https://www.redbull.com/. Acesso em 13.09.2023. Adaptado)

Utilizando os conceitos sobre forças de atrito e assumindo que a força de atrito que o ar exerce sobre os corpos em movimento é dada por R = k · d · v², com k sendo uma constante que depende da área e da forma do corpo, d sendo a densidade do ar e v a velocidade do corpo, assinale a alternativa que explica corretamente a necessidade de esse salto ter acontecido de uma altitude tão grande para permitir atingir essa velocidade.','Difícil','Dinâmica - força de atrito com o ar','2ª Série EM','SARESP','B',4,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Devido à grande distância percorrida pelo paraquedista na queda, o paraquedista pode acumular aceleração da gravidade, atingindo assim maiores velocidades terminais.' AS texto
  UNION ALL SELECT @qid,'B','Em grandes altitudes, a densidade do ar é mais baixa, diminuindo assim o atrito do ar e permitindo que a velocidade terminal do paraquedista seja maior.'
  UNION ALL SELECT @qid,'C','A velocidade terminal do paraquedista será maior quanto maior for o peso do paraquedista, e o peso é mais alto em grandes altitudes, devido à variação na constante g.'
  UNION ALL SELECT @qid,'D','Trata-se simplesmente de uma questão de tempo de queda – de quanto mais alto a pessoa saltar, maior será a velocidade terminal atingida.'
  UNION ALL SELECT @qid,'E','Na estratosfera, o ar é muito mais frio do que na troposfera, o que o torna mais viscoso, diminuindo assim o atrito e aumentando a velocidade terminal do paraquedista.'
) alts WHERE @ja_existe_23 = 0;

-- Q35
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere hipoteticamente que o foguete que irá trazer as futuras amostras coletadas pela sonda Perseverance em Marte tenha uma massa total de 500 kg, contando carga e combustível. A aceleração de um foguete é dada por a = E/m − g, com E sendo o empuxo do foguete, dado em N, m sua massa, dada em kg, e g a aceleração da gravidade no local, dada em m/s². Assumindo que o empuxo do foguete em questão é constante de 10 kN, que a aceleração da gravidade em Marte é g = 3,7 m/s² e desprezando o atrito com a atmosfera, a aceleração inicial do foguete, no momento da decolagem, será de','Médio','Dinâmica - aceleração de foguete','2ª Série EM','SARESP','D',4,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'29,8 m/s²' AS texto
  UNION ALL SELECT @qid,'B','23,7 m/s²'
  UNION ALL SELECT @qid,'C','11,2 m/s²'
  UNION ALL SELECT @qid,'D','16,3 m/s²'
  UNION ALL SELECT @qid,'E','20,0 m/s²'
) alts WHERE @ja_existe_23 = 0;

-- Q36
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A velocidade de cozimento dos alimentos em frituras a óleo é maior do que nos forninhos de convecção a ar, do tipo air fryer. Esse fenômeno acontece porque','Médio','Termologia - transferência de calor','2ª Série EM','SARESP','A',4,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'estando o óleo no estado líquido, a transferência de calor pelo óleo é mais eficiente do que pelo ar, aquecendo mais rapidamente os alimentos.' AS texto
  UNION ALL SELECT @qid,'B','a densidade do óleo é baixa, o que permite que o calor seja transferido de forma mais rápida até o alimento, fazendo o processo de cocção ser mais rápido.'
  UNION ALL SELECT @qid,'C','a alta densidade do óleo em relação ao ar faz com que o óleo atinja temperaturas maiores do que o ar, cozinhando os alimentos mais rapidamente.'
  UNION ALL SELECT @qid,'D','a temperatura do ar é mais baixa do que a do óleo, fazendo com que o cozimento a ar seja mais lento.'
  UNION ALL SELECT @qid,'E','o aumento da temperatura do ar faz com que sua densidade aumente, o que impede a transmissão de calor para o alimento de forma eficiente.'
) alts WHERE @ja_existe_23 = 0;

-- Q37
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O telescópio Hubble é um equipamento em operação desde 1990 que permite sondar objetos muito distantes da Terra e possui um espelho côncavo único de 2,4 m de diâmetro. O espelho do telescópio Hubble conjuga uma imagem','Fácil','Óptica - espelhos esféricos','2ª Série EM','SARESP','D',4,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'imprópria.' AS texto
  UNION ALL SELECT @qid,'B','virtual e invertida.'
  UNION ALL SELECT @qid,'C','virtual e direita.'
  UNION ALL SELECT @qid,'D','real e invertida.'
  UNION ALL SELECT @qid,'E','real e direita.'
) alts WHERE @ja_existe_23 = 0;

-- Q38
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Ondas baixas são ondas eletromagnéticas emitidas por fios de transmissão de alta tensão e possuem frequência típica de 10² Hz. Assumindo que a velocidade de propagação de uma onda eletromagnética é de 3 × 10⁸ m/s, o comprimento de onda típico das ondas baixas é igual a','Fácil','Ondulatória - comprimento de onda','2ª Série EM','SARESP','B',4,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'3 × 10⁴ m.' AS texto
  UNION ALL SELECT @qid,'B','3 × 10⁶ m.'
  UNION ALL SELECT @qid,'C','3 × 10² m.'
  UNION ALL SELECT @qid,'D','3 × 10¹ m.'
  UNION ALL SELECT @qid,'E','3 × 10⁸ m.'
) alts WHERE @ja_existe_23 = 0;

-- Q39
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O carro elétrico Tesla modelo Y possui um banco de baterias com capacidade de cerca de 75 kWh e, em sua versão feita para percorrer longas distâncias, tem uma potência total máxima de 250 kW. Assumindo que o carro esteja com as baterias totalmente carregadas e seja dirigido de forma que o motor desenvolva sua potência máxima em todo o trajeto, quanto tempo duraria, aproximadamente, sua bateria?','Médio','Eletricidade - potência e energia','2ª Série EM','SARESP','C',4,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'125 minutos.' AS texto
  UNION ALL SELECT @qid,'B','232 minutos.'
  UNION ALL SELECT @qid,'C','18 minutos.'
  UNION ALL SELECT @qid,'D','48 minutos.'
  UNION ALL SELECT @qid,'E','5 minutos.'
) alts WHERE @ja_existe_23 = 0;

-- Q40
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Segundo o modelo de Rutherford para o átomo, os elétrons seriam partículas carregadas negativamente que orbitariam o núcleo, onde estaria concentrada a carga positiva. No entanto, esse modelo tinha uma falha, pois uma partícula descrevendo movimento circular estaria sujeita a acelerações, e, segundo as equações de Maxwell para o eletromagnetismo, toda partícula carregada sujeita a acelerações emitiria radiação, perdendo energia e levando ao colapso dos elétrons sobre o núcleo. Bohr viria resolver esse problema usando a hipótese','Médio','Física moderna - modelo atômico de Bohr','2ª Série EM','SARESP','E',4,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'do princípio da conservação da energia, que propunha que a energia dos elétrons não poderia diminuir de intensidade.' AS texto
  UNION ALL SELECT @qid,'B','da dualidade partícula-onda, que impediria os elétrons de oscilarem para próximo do núcleo atômico.'
  UNION ALL SELECT @qid,'C','do efeito fotoelétrico, que transformariam os elétrons em luz assim que eles se aproximassem do núcleo atômico.'
  UNION ALL SELECT @qid,'D','do princípio da conservação da quantidade de movimento linear, que propunha que o produto massa e velocidade dos elétrons deveria se manter constante sempre.'
  UNION ALL SELECT @qid,'E','do princípio de quantização dos orbitais, segundo o qual existiriam órbitas específicas onde a energia dos elétrons se manteria constante.'
) alts WHERE @ja_existe_23 = 0;

-- Q41
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Pela primeira vez, em dezembro de 2022, um experimento de fusão nuclear com deutério (²₁H) e trítio (³₁H), os mesmos átomos que sofrem fusão no Sol, conseguiu produzir mais energia do que foi consumida. Os átomos de deutério e trítio','Fácil','Estrutura atômica - isótopos','2ª Série EM','SARESP','A',5,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'são isótopos.' AS texto
  UNION ALL SELECT @qid,'B','têm a mesma diferença entre prótons e nêutrons.'
  UNION ALL SELECT @qid,'C','possuem diferentes números de elétrons.'
  UNION ALL SELECT @qid,'D','são isóbaros.'
  UNION ALL SELECT @qid,'E','possuem propriedades químicas diferentes.'
) alts WHERE @ja_existe_23 = 0;

-- Q42
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No tratamento de efluentes, é utilizado o cloreto de ferro (III), que necessita ser monitorado para não ultrapassar a concentração máxima dos íons ferro ao final do tratamento, que é de 2,7 × 10⁻⁴ mol/L. A análise de 200 mL de uma solução de FeCl₃ mostrou a presença de 2,4 × 10⁻³ mol de íons Cl⁻. A concentração de íons Fe³⁺ na solução analisada é igual a','Médio','Soluções - concentração em mol/L','2ª Série EM','SARESP','B',5,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'4,0 × 10⁻⁴ mol/L e atende ao limite de concentração permitido.' AS texto
  UNION ALL SELECT @qid,'B','4,0 × 10⁻³ mol/L e não atende ao limite de concentração permitido.'
  UNION ALL SELECT @qid,'C','2,4 × 10⁻³ mol/L e não atende ao limite de concentração permitido.'
  UNION ALL SELECT @qid,'D','1,2 × 10⁻² mol/L e não atende ao limite de concentração permitido.'
  UNION ALL SELECT @qid,'E','1,2 × 10⁻⁴ mol/L e atende ao limite de concentração permitido.'
) alts WHERE @ja_existe_23 = 0;

-- Q44
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A combustão do etanol (C2H6O) é uma reação muito utilizada para fornecer energia em diversas situações. O diagrama de energia apresenta a variação de entalpia envolvida na combustão de 1 mol de etanol: os reagentes (C2H6O + 3 O2) estão em um nível de energia X; os produtos (2 CO2 + 3 H2O) estão no nível de energia −1646 kJ; e ΔH = −1350 kJ.

Considere que 0,1 mol de etanol foi queimado para aquecer certa massa de água em 50 ºC em um calorímetro ideal. Considerando o calor específico da água igual a 4,2 J · g⁻¹ · ºC⁻¹, a entalpia padrão de formação do etanol e a massa de água aquecida na combustão de 0,1 mol de etanol são iguais, respectivamente, a','Difícil','Termoquímica - entalpia e calorimetria','2ª Série EM','SARESP','C',5,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'–296 kJ e 64,29 g.' AS texto
  UNION ALL SELECT @qid,'B','+296 kJ e 64,29 g.'
  UNION ALL SELECT @qid,'C','–296 kJ e 642,9 g.'
  UNION ALL SELECT @qid,'D','+296 kJ e 642,9 g.'
  UNION ALL SELECT @qid,'E','–296 kJ e 6,429 g.'
) alts WHERE @ja_existe_23 = 0;

-- Q45
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O ácido chiquímico é uma substância extraída de vegetais e utilizada na indústria farmacêutica. Uma vantagem ambiental reside no fato de que sua extração envolve a dissolução em água, não dependendo de solventes orgânicos. A estrutura do ácido chiquímico é um anel de seis carbonos com uma dupla ligação, um grupo carboxila (–COOH) e três grupos hidroxila (–OH).

A boa solubilidade do ácido chiquímico em água deve-se ao fato de que essa substância, assim como a água, estabelece interações intermoleculares do tipo','Médio','Interações intermoleculares - solubilidade','2ª Série EM','SARESP','A',5,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ligação de hidrogênio.' AS texto
  UNION ALL SELECT @qid,'B','dispersão de London.'
  UNION ALL SELECT @qid,'C','dipolo permanente-dipolo permanente.'
  UNION ALL SELECT @qid,'D','íon-dipolo permanente.'
  UNION ALL SELECT @qid,'E','covalente.'
) alts WHERE @ja_existe_23 = 0;

-- Q46
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em um experimento caseiro para a construção de uma pilha, pregos de zinco e cobre foram inseridos em um limão, e a esses pregos foram conectados fios elétricos, os quais também foram conectados a uma lâmpada de LED, fechando o circuito.

Após algum tempo de funcionamento da pilha, os pregos foram retirados do limão e analisados. Considerando-se que o potencial de redução do cobre é maior que o potencial de redução do zinco, espera-se verificar','Médio','Eletroquímica - pilhas','2ª Série EM','SARESP','C',5,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'corrosão apenas do prego de cobre.' AS texto
  UNION ALL SELECT @qid,'B','um depósito de cobre metálico sobre a superfície do prego de cobre.'
  UNION ALL SELECT @qid,'C','corrosão apenas do prego de zinco.'
  UNION ALL SELECT @qid,'D','um depósito de zinco metálico sobre a superfície do prego de cobre.'
  UNION ALL SELECT @qid,'E','um depósito de cobre metálico sobre a superfície do prego de zinco.'
) alts WHERE @ja_existe_23 = 0;

-- Q48
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os corais são animais marinhos que possuem um esqueleto de carbonato de cálcio (CaCO3). Esse esqueleto tem sua formação a partir da dissolução de dióxido do carbono gasoso (CO2) em água, conforme representada nos equilíbrios químicos:
CO2 + H2O ⇌ HCO3⁻ + H⁺
H⁺ + CO3²⁻ ⇌ HCO3⁻
CaCO3 (coral) ⇌ Ca²⁺ + CO3²⁻
(jovemexplorador.iag.usp.br. Adaptado)

Considerando o efeito da temperatura sobre a solubilidade de gases em água, um aumento da temperatura das águas oceânicas deve provocar','Difícil','Equilíbrio químico - CO2 e corais','2ª Série EM','SARESP','D',5,2,NULL,TRUE
WHERE @ja_existe_23 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'diminuição da concentração de CO2 dissolvido e, consequentemente, aumento do pH e favorecimento da formação de novos corais.' AS texto
  UNION ALL SELECT @qid,'B','diminuição da concentração de CO2 dissolvido e, consequentemente, diminuição do pH e favorecimento da formação de novos corais.'
  UNION ALL SELECT @qid,'C','aumento da concentração de CO2 dissolvido e, consequentemente, aumento do pH e dissolução dos corais existentes.'
  UNION ALL SELECT @qid,'D','diminuição da concentração de CO2 dissolvido e, consequentemente, aumento do pH e dissolução dos corais existentes.'
  UNION ALL SELECT @qid,'E','aumento da concentração de CO2 dissolvido e, consequentemente, diminuição do pH e favorecimento da formação de novos corais.'
) alts WHERE @ja_existe_23 = 0;
