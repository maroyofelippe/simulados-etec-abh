-- ==========================================================
--  Migração de conteúdo: Banco de questões SARESP 2023 — 2ª Série EM
--  Caderno 014-MT-CH (Matemática + Ciências Humanas), Cad02,
--  aplicado como Provão Paulista Seriado 2023 (04.12.2023) — Versão 2.
--  Fonte: caderno de questões + gabarito oficial (Fundação Vunesp) fornecidos pela coordenação.
--  ----------------------------------------------------------
--  Origem das questões: SARESP (coluna questoes.origem, criada pela
--  migração 2026-10_origem_questoes.sql — por isso este arquivo vem depois dela).
--
--  Escopo: as 42 questões do caderno foram importadas. Nas questões 4, 6, 7, 15,
--  22, 23, 25, 27, 29 e 31, a figura/mapa/gráfico/cartaz foi descrito em texto
--  no enunciado (nas questões 9 e 10, as funções e a relação entre os cones já
--  estão no enunciado).
--
--  Usa as disciplinas "Filosofia" e "Sociologia" (Ciências Humanas), criadas
--  também pela migração do caderno 010-MT-CH (1ª série); o INSERT abaixo as garante.
--
--  Gabarito: Versão 2 do gabarito oficial (Cad02).
--
--  Idempotente: variável de sessão travada no início (@ja_existe_23d), sem
--  DELIMITER/stored procedures (incompatível com a execução via db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-10_origem_questoes_saresp2023_2serie_mt_ch.sql)
-- ==========================================================
SET @db := DATABASE();

-- Garante que as disciplinas "Filosofia" e "Sociologia" existem (idempotente)
INSERT INTO disciplinas (nome, area)
SELECT 'Filosofia', 'Ciências Humanas'
WHERE NOT EXISTS (SELECT 1 FROM disciplinas WHERE nome = 'Filosofia');
INSERT INTO disciplinas (nome, area)
SELECT 'Sociologia', 'Ciências Humanas'
WHERE NOT EXISTS (SELECT 1 FROM disciplinas WHERE nome = 'Sociologia');

-- Guarda travada: já aplicamos este lote antes?
SET @ja_existe_23d := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'Duas empreendedoras vendem bombons%'
);


-- Q01
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Duas empreendedoras vendem bombons a R$ 2,50 por unidade. A empreendedora 1 tem custo fixo mensal de R$ 1.000,00 e custo de produção de R$ 1,50 por bombom, enquanto a empreendedora 2 tem custo fixo mensal de R$ 200,00 e custo de produção de R$ 2,00 por bombom. O lucro é o valor obtido nas vendas menos os custos fixos de produção.

Em um certo mês, essas empreendedoras tiveram o mesmo lucro. Se a empreendedora 1 vendeu 2 000 bombons, a empreendedora 2 vendeu','Médio','Função afim - custo e lucro','2ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'4 000 bombons.' AS texto
  UNION ALL SELECT @qid,'B','3 000 bombons.'
  UNION ALL SELECT @qid,'C','2 000 bombons.'
  UNION ALL SELECT @qid,'D','2 400 bombons.'
  UNION ALL SELECT @qid,'E','1 600 bombons.'
) alts WHERE @ja_existe_23d = 0;

-- Q02
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um objeto é lançado para cima, perpendicularmente ao chão, a partir da altura de 1 m e com velocidade de 5 m/s. Desprezando a resistência do ar e assumindo que a aceleração da gravidade é igual a 10 m/s², a altura h do objeto, em metros, é descrita como h = 1 + 5t − 5t², em que t é o tempo transcorrido, em segundos, desde o lançamento.

Segundo a expressão apresentada, esse objeto atinge sua altura máxima em','Médio','Função quadrática - altura máxima','2ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'1,0 s.' AS texto
  UNION ALL SELECT @qid,'B','2,0 s.'
  UNION ALL SELECT @qid,'C','10,0 s.'
  UNION ALL SELECT @qid,'D','5,0 s.'
  UNION ALL SELECT @qid,'E','0,5 s.'
) alts WHERE @ja_existe_23d = 0;

-- Q03
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No início deste ano, Alberto abriu uma conta em uma rede social tendo Bernardo como único amigo, e Bernardo fez o mesmo, no mesmo dia, tendo Alberto como único amigo. Alberto planeja agregar 100 amigos por ano à sua rede, enquanto Bernardo planeja dobrar seu número de amigos a cada ano.

Se tudo correr como o planejado, a primeira vez em que Bernardo terá mais seguidores do que Alberto será em','Difícil','Progressões - aritmética x geométrica','2ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'40 anos.' AS texto
  UNION ALL SELECT @qid,'B','50 anos.'
  UNION ALL SELECT @qid,'C','30 anos.'
  UNION ALL SELECT @qid,'D','20 anos.'
  UNION ALL SELECT @qid,'E','10 anos.'
) alts WHERE @ja_existe_23d = 0;

-- Q04
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A linha superior da rede de voleibol feminino tem 2,24 m e o fundo da quadra adversária está a 9 m de distância. Uma jogadora pula para cima, com seus olhos a 90 cm de distância horizontal da rede. (Figura: uma linha reta parte da linha de fundo, no chão, passa pelo topo da rede, que está a 9 m da linha de fundo, e chega aos olhos da jogadora, que estão a 90 cm da rede, do outro lado.)
(https://www.ambiance-sticker.com. Acesso em 05/10/2023. Adaptado)

A menor altura que seus olhos devem atingir para que ela veja a linha de fundo da quadra por cima da rede é de, aproximadamente,','Médio','Semelhança de triângulos - rede de voleibol','2ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'2,33 m.' AS texto
  UNION ALL SELECT @qid,'B','2,46 m.'
  UNION ALL SELECT @qid,'C','2,54 m.'
  UNION ALL SELECT @qid,'D','3,14 m.'
  UNION ALL SELECT @qid,'E','2,90 m.'
) alts WHERE @ja_existe_23d = 0;

-- Q05
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um triângulo retângulo tem hipotenusa medindo 10 cm e catetos medindo x e 2x.

Conclui-se que x, em centímetros, é igual a','Fácil','Teorema de Pitágoras','2ª Série EM','SARESP','A',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'2√5' AS texto
  UNION ALL SELECT @qid,'B','√2'
  UNION ALL SELECT @qid,'C','√(10/3)'
  UNION ALL SELECT @qid,'D','10√3 / 3'
  UNION ALL SELECT @qid,'E','√5'
) alts WHERE @ja_existe_23d = 0;

-- Q06
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Utilizando apenas pentágonos regulares, não é possível obter-se um ladrilhado do plano euclidiano sem sobreposições nem lacunas. No entanto, se aos pentágonos se juntarem losangos de um certo tipo, isso é possível, como mostra a figura (pentágonos regulares dispostos em fileiras, com losangos alongados preenchendo os espaços entre eles).

Dado que cada ângulo interno do pentágono regular mede 108º, o menor ângulo interno em cada losango da figura mede','Médio','Geometria plana - ladrilhamento com pentágonos','2ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'20°.' AS texto
  UNION ALL SELECT @qid,'B','30°.'
  UNION ALL SELECT @qid,'C','36°.'
  UNION ALL SELECT @qid,'D','15°.'
  UNION ALL SELECT @qid,'E','24°.'
) alts WHERE @ja_existe_23d = 0;

-- Q07
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A figura mostra uma imagem de satélite de uma região do Estado de São Paulo, com coordenadas de longitude (na horizontal: 50,50ºO, 50,40ºO, 50,30ºO e 50,20ºO) e latitude (na vertical: 22,60ºS, 22,70ºS e 22,80ºS). O ponto A está em, aproximadamente, 50,25ºO e 22,80ºS; o ponto B está em, aproximadamente, 50,40ºO e 22,60ºS.
(https://www.google.com.br/earth/index.html. Acesso em 10.09.2023. Adaptado)

Depois da vírgula, os números indicam décimos e centésimos de grau. Em regiões pequenas como essas, podemos admitir que a Terra é aproximadamente plana e considerar que essas linhas são retas e perpendiculares entre si.

Se o ponto B é o ponto médio entre o ponto A e um ponto C, que não aparece no mapa, as coordenadas de C são','Médio','Geometria analítica - ponto médio e coordenadas','2ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'50,25ºO e 22,80ºS.' AS texto
  UNION ALL SELECT @qid,'B','50,10ºO e 23,00ºS.'
  UNION ALL SELECT @qid,'C','50,40ºO e 22,60ºS.'
  UNION ALL SELECT @qid,'D','50,55ºO e 22,40ºS.'
  UNION ALL SELECT @qid,'E','50,35ºO e 22,70ºS.'
) alts WHERE @ja_existe_23d = 0;

-- Q08
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em geometria plana, costuma-se chamar de estádio a figura formada por um retângulo unido com dois semicírculos em lados opostos.

Se os lados do retângulo que compõe o estádio medem 314 m e 200 m, e os semicírculos estão unidos pelos lados menores, a fração que a área somada dos semicírculos representa em relação à área total do estádio é, aproximadamente,','Médio','Geometria plana - áreas (estádio)','2ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'1/4' AS texto
  UNION ALL SELECT @qid,'B','1/2'
  UNION ALL SELECT @qid,'C','1/3'
  UNION ALL SELECT @qid,'D','2/3'
  UNION ALL SELECT @qid,'E','1/5'
) alts WHERE @ja_existe_23d = 0;

-- Q09
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A figura mostra o gráfico de três funções polinomiais de primeiro grau: p₁(x) = 2 + 2x, p₂(x) = x e p₃(x) = 3/4 − x/2.

O intervalo em que p₂(x) < p₃(x) < p₁(x) é','Médio','Funções afins - inequações','2ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'−2 < x < −1/2' AS texto
  UNION ALL SELECT @qid,'B','−2 < x < 3/2'
  UNION ALL SELECT @qid,'C','−1/2 < x'
  UNION ALL SELECT @qid,'D','−1/2 < x < 1/2'
  UNION ALL SELECT @qid,'E','x < 1/2'
) alts WHERE @ja_existe_23d = 0;

-- Q10
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na figura, o cone 1, de altura h₁, tem como base o círculo circunscrito a um quadrado de lado a, e o cone 2, de altura h₂, tem como base o círculo inscrito em um quadrado também de lado a.

Se os volumes dos cones são iguais entre si, conclui-se que a razão h₂/h₁ é','Difícil','Geometria espacial - volume de cones','2ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'√2' AS texto
  UNION ALL SELECT @qid,'B','2'
  UNION ALL SELECT @qid,'C','1/3'
  UNION ALL SELECT @qid,'D','1'
  UNION ALL SELECT @qid,'E','3'
) alts WHERE @ja_existe_23d = 0;

-- Q11
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em um grupo escolar, há 3 crianças que não tomaram nenhuma dose de vacina contra Meningite tipo B, outras 3 crianças que tomaram apenas uma dose dessa vacina e 9 crianças que tomaram as duas doses da vacina.

Se essas crianças forem fazer uma atividade juntas, em duplas, a probabilidade de que a primeira dupla formada seja composta por duas crianças que não tomaram o mesmo número de doses da vacina contra Meningite tipo B é','Médio','Probabilidade - combinações','2ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'1/2' AS texto
  UNION ALL SELECT @qid,'B','2/5'
  UNION ALL SELECT @qid,'C','3/10'
  UNION ALL SELECT @qid,'D','1/5'
  UNION ALL SELECT @qid,'E','3/5'
) alts WHERE @ja_existe_23d = 0;

-- Q12
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma caixa de papelão tem divisórias que formam doze compartimentos para armazenar bolas de Natal. Em cada compartimento cabe apenas uma bola. Ana numerou os compartimentos e guardou 12 bolas idênticas entre si a menos da cor. Das 12 bolas guardadas por Ana, 6 são vermelhas, 4 douradas e 2 azuis. O número de maneiras distintas que Ana pode ter guardado as bolas é igual a','Médio','Análise combinatória - permutação com repetição','2ª Série EM','SARESP','A',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'12! / (6! · 4! · 2!)' AS texto
  UNION ALL SELECT @qid,'B','12!'
  UNION ALL SELECT @qid,'C','12! / (8! · 4! · 2!)'
  UNION ALL SELECT @qid,'D','(12! / (8! · 4!)) · (12! / (6! · 6!))'
  UNION ALL SELECT @qid,'E','12! / (6! · 4!)'
) alts WHERE @ja_existe_23d = 0;

-- Q13
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A quantidade de números inteiros que estão entre 15 − √35 e 15 + √35 é','Médio','Números reais - raízes e intervalos','2ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'12.' AS texto
  UNION ALL SELECT @qid,'B','10.'
  UNION ALL SELECT @qid,'C','11.'
  UNION ALL SELECT @qid,'D','9.'
  UNION ALL SELECT @qid,'E','13.'
) alts WHERE @ja_existe_23d = 0;

-- Q14
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere 9 números cuja soma é 540. Ao ordenar esses números do menor para o maior, o número N ocupa a 5ª posição. Sabendo-se que a soma dos 5 menores é 180 e a soma dos 5 maiores é 405, o valor de N é','Médio','Estatística - soma e ordenação','2ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'21.' AS texto
  UNION ALL SELECT @qid,'B','45.'
  UNION ALL SELECT @qid,'C','65.'
  UNION ALL SELECT @qid,'D','81.'
  UNION ALL SELECT @qid,'E','60.'
) alts WHERE @ja_existe_23d = 0;

-- Q15
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Cada quadradinho do quadriculado 4x4 deve ser preenchido com números inteiros obedecendo as seguintes regras:
I. A soma de quaisquer três números colocados em quadradinhos consecutivos em uma linha deve ser 12.
II. A soma de quaisquer três números colocados em quadradinhos consecutivos em uma coluna deve ser 12.

Os números 2 e 6 já foram colocados no quadriculado: o 6 está na 1ª linha, 2ª coluna, e o 2 está na 4ª linha, 1ª coluna.

Após o correto preenchimento, a soma dos 16 números colocados no quadriculado é','Difícil','Raciocínio lógico - quadriculado','2ª Série EM','SARESP','A',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'62.' AS texto
  UNION ALL SELECT @qid,'B','64.'
  UNION ALL SELECT @qid,'C','66.'
  UNION ALL SELECT @qid,'D','68.'
  UNION ALL SELECT @qid,'E','60.'
) alts WHERE @ja_existe_23d = 0;

-- Q16
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em um parque ecológico, há três trilhas para caminhadas chamadas Trilha da Cachoeira, Trilha do Lago e Trilha do Rei. Em uma semana, Ana deu duas voltas na Trilha da Cachoeira, três voltas na Trilha do Lago e uma volta na Trilha do Rei totalizando 5 720 metros; Beto deu uma volta na Trilha da Cachoeira, duas voltas na Trilha do Lago e duas voltas na Trilha do Rei totalizando 5 280 metros; por fim, Carlos deu quatro voltas na Trilha da Cachoeira e duas voltas na Trilha do Rei totalizando 7 600 metros. Se Daniel der uma volta em cada uma das trilhas, ele fará uma caminhada de','Médio','Sistemas lineares','2ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'2 040 metros.' AS texto
  UNION ALL SELECT @qid,'B','2 600 metros.'
  UNION ALL SELECT @qid,'C','3 400 metros.'
  UNION ALL SELECT @qid,'D','3 240 metros.'
  UNION ALL SELECT @qid,'E','2 320 metros.'
) alts WHERE @ja_existe_23d = 0;

-- Q17
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A escola de inglês QuickSpeak teve o mesmo número de matriculados em 2021, 2022 e 2023 nas turmas iniciais. Em 2022 a escola criou duas turmas iniciais a mais do que tinha em 2021 e, com isso, o número médio de alunos por turma inicial diminuiu em 14. Novamente, em 2023, mais duas turmas iniciais foram criadas e o número médio de alunos por turma diminuiu em 6 em relação à 2022.

Qual o número de turmas iniciais que a QuickSpeak tinha em 2021?','Difícil','Equações - média de alunos por turma','2ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'4' AS texto
  UNION ALL SELECT @qid,'B','3'
  UNION ALL SELECT @qid,'C','2'
  UNION ALL SELECT @qid,'D','6'
  UNION ALL SELECT @qid,'E','5'
) alts WHERE @ja_existe_23d = 0;

-- Q18
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere a sequência a₁, a₂, … em que a₁ = 3, a₂ = 8 e, para n > 2: aₙ = aₙ₋₁ − aₙ₋₂, se n é ímpar; e aₙ = aₙ₋₁ + aₙ₋₂, se n é par.

Ao obter os 10 primeiros termos dessa sequência, tem-se que','Médio','Sequências - lei de recorrência','2ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a₈ = a₉ + 2' AS texto
  UNION ALL SELECT @qid,'B','a₈ = a₇'
  UNION ALL SELECT @qid,'C','a₉ = a₈ + a₇'
  UNION ALL SELECT @qid,'D','a₁₀ = a₉ + 5'
  UNION ALL SELECT @qid,'E','a₉ = a₆'
) alts WHERE @ja_existe_23d = 0;

-- Q19
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'André precisa criar uma senha com três dígitos distintos que devem ser escolhidos do conjunto {0, 1, 2, 3, 4, 5}. Ele decide que o dígito central deve ser a média de seus vizinhos. O número de senhas distintas que André pode criar é','Médio','Análise combinatória - contagem','2ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'6.' AS texto
  UNION ALL SELECT @qid,'B','14.'
  UNION ALL SELECT @qid,'C','12.'
  UNION ALL SELECT @qid,'D','8.'
  UNION ALL SELECT @qid,'E','10.'
) alts WHERE @ja_existe_23d = 0;

-- Q20
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um ingresso para uma peça de teatro será sorteado entre os estudantes de uma turma. Há quatro rapazes a mais do que moças nessa turma. Se a probabilidade de um rapaz ser sorteado é 5/9, o número total de estudantes dessa turma é','Médio','Probabilidade - problemas','2ª Série EM','SARESP','A',2,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'36.' AS texto
  UNION ALL SELECT @qid,'B','9.'
  UNION ALL SELECT @qid,'C','20.'
  UNION ALL SELECT @qid,'D','18.'
  UNION ALL SELECT @qid,'E','16.'
) alts WHERE @ja_existe_23d = 0;

-- Q21
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A respeito da segregação socioespacial e da mobilidade das classes sociais no espaço urbano das grandes cidades, é correto afirmar que a população de maior renda','Médio','Geografia urbana - segregação socioespacial','2ª Série EM','SARESP','C',7,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'permaneceu na área central onde existem mais equipamentos urbanos, enquanto a população de baixa renda se deslocou para áreas mais próximas ao centro onde estão os postos de trabalho.' AS texto
  UNION ALL SELECT @qid,'B','se deslocou para os condomínios fechados na periferia, enquanto a população de menor renda passou a morar no centro onde há presença de equipamentos públicos e postos de trabalho mais qualificados.'
  UNION ALL SELECT @qid,'C','abandonou a área central em direção ao subúrbio para morar em condomínios fechados, enquanto a população de menor renda foi empurrada para as áreas ainda mais periféricas onde a terra é mais barata.'
  UNION ALL SELECT @qid,'D','permaneceu no centro, deslocando-se para os edifícios inteligentes com sistemas de segurança, e a população de menor renda se manteve na periferia com acesso à moradia popular em grandes conjuntos habitacionais.'
  UNION ALL SELECT @qid,'E','abandonou os seus antigos casarões no centro, sendo eles preservados e transformados em locais de moradia popular a partir de programas governamentais de habitação para a população de baixa renda.'
) alts WHERE @ja_existe_23d = 0;

-- Q22
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Observe a figura, em escala numérica 1:50.000, de uma reserva natural hipotética denominada Parque Natural Paraíso. De acordo com a imagem, verifica-se que a distância, em linha reta, entre a portaria, na entrada do parque, e o Morro do Bugio é de 8 centímetros (cm) e entre este morro e a Toca da Onça é de 6 centímetros (cm).

Qual a distância real total, em quilômetros, entre a Portaria e a Toca da Onça, passando pelo Morro do Bugio?','Fácil','Cartografia - escala numérica','2ª Série EM','SARESP','D',7,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'70 km.' AS texto
  UNION ALL SELECT @qid,'B','14 km.'
  UNION ALL SELECT @qid,'C','40 km.'
  UNION ALL SELECT @qid,'D','7 km.'
  UNION ALL SELECT @qid,'E','140 km.'
) alts WHERE @ja_existe_23d = 0;

-- Q23
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A elevada taxa de precipitação acumulada no estado do Rio Grande do Sul no mês de setembro de 2023, conforme demonstra a figura (mapa do Brasil de precipitação acumulada até 23/09/2023, em que o Rio Grande do Sul aparece com os maiores valores acumulados, em contraste com a maior parte do país), costuma ser resultado da combinação de diversos fatores atmosféricos. (Clima Monitoramento Brasil - CPTEC/INPE. https://clima1.cptec.inpe.br. Acesso em 26.09.2023)

Os quatro fatores que influenciaram as chuvas torrenciais no referido estado são:','Difícil','Climatologia - fatores das chuvas no Sul','2ª Série EM','SARESP','A',7,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Presença de ciclones extratropicais, sistemas frontais, baixa pressão atmosférica e influência do fenômeno El Niño.' AS texto
  UNION ALL SELECT @qid,'B','Presença de ciclones tropicais, sistemas frontais, alta pressão atmosférica e influência do fenômeno La Niña.'
  UNION ALL SELECT @qid,'C','Presença de anticiclones tropicais, baixa pressão atmosférica, frentes frias e influência do fenômeno El Niño.'
  UNION ALL SELECT @qid,'D','Presença de ciclones extratropicais, frentes quentes, alta pressão atmosférica e influência do fenômeno La Niña.'
  UNION ALL SELECT @qid,'E','Presença de anticiclones extratropicais e tropicais, sistemas frontais, frentes frias e influência do fenômeno La Niña.'
) alts WHERE @ja_existe_23d = 0;

-- Q24
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um lugar de importante destaque na produção de jeans brasileiro é Toritama, cidade que se transformou na terra do jeans. A produção chega a 18% do montante consumido no Brasil. O rio Capibaribe, principal manancial de água de Toritama, recebe os efluentes industriais das lavanderias de jeans e fica tingido com ''a cor da moda'', contribuindo para a má qualidade das águas. Essa poluição impossibilita a vida de peixes e outras espécies de animais, causa irritações na pele, olhos e mucosas dos humanos e pode provocar doenças na população local. Os impactos ambientais e sociais causados pela produção do tecido na cidade são reflexos da configuração produtiva que foi instalada no local. É uma economia com alto índice de informalidade, com trabalho domiciliar e familiar, em que predomina a pequena empresa e relações trabalhistas estabelecidas a partir da lógica da terceirização e subcontratação. Tais características invisibilizam as condições e favorecem a violação de direitos, a ocorrência de trabalho precário e a degradação ambiental.
(Os impactos da indústria têxtil brasileira: do algodão ao jeans de Toritama – Fashion Revolution – Carta Capital. Acesso em 19.08.2023. Adaptado)

Dentre os impactos socioambientais da cadeia produtiva de jeans em Toritama, no estado de Pernambuco, estão','Médio','Impactos socioambientais - indústria têxtil','2ª Série EM','SARESP','E',7,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a expansão do cultivo de peixes e a ampliação das leis trabalhistas.' AS texto
  UNION ALL SELECT @qid,'B','o enriquecimento da biodiversidade e a retração do setor têxtil.'
  UNION ALL SELECT @qid,'C','a intensificação da desertificação e a consolidação do setor sindical.'
  UNION ALL SELECT @qid,'D','os deslizamentos de terra e a comercialização de mercadorias falsificadas.'
  UNION ALL SELECT @qid,'E','a contaminação da bacia hidrográfica e a precarização das relações de trabalho.'
) alts WHERE @ja_existe_23d = 0;

-- Q25
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A imagem (uma casa destruída por deslizamento de terra, com uma pessoa entre os escombros, em uma encosta) retrata a recente tragédia socioambiental ocorrida no Litoral Norte do Estado de São Paulo, em fevereiro de 2023, quando as chuvas atingiram os municípios de Caraguatatuba, São Sebastião, Ubatuba, Guarujá e Bertioga, provocando intensos movimentos de massa, enxurradas e deslizamentos de terra. (https://www.unicamp.br)

As possíveis causas naturais e antrópicas associadas à tragédia socioambiental citada são','Fácil','Desastres socioambientais - Litoral Norte de SP','2ª Série EM','SARESP','B',7,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a inversão térmica acelerada e a densidade demográfica.' AS texto
  UNION ALL SELECT @qid,'B','os elevados níveis de precipitação e a ocupação precária de áreas de risco.'
  UNION ALL SELECT @qid,'C','as mudanças climáticas extremas e a verticalização do espaço urbano.'
  UNION ALL SELECT @qid,'D','a precipitação concentrada no inverno e a especulação imobiliária.'
  UNION ALL SELECT @qid,'E','a estiagem prolongada e a emissão de gases poluentes na atmosfera.'
) alts WHERE @ja_existe_23d = 0;

-- Q26
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A África Ocidental é uma região que reúne países que, embora possuam diversidades étnico-culturais, políticas, econômicas e naturais, participam da Comunidade Econômica dos Estados da África Ocidental (CEDEAO), composta por quinze países membros, a partir da qual partilham interesses geopolíticos, culturais e econômicos comuns.

A respeito dessa região africana, assinale a alternativa que apresenta a afirmação correta.','Médio','Geografia da África - África Ocidental','2ª Série EM','SARESP','C',7,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Possuem áreas no deserto do Saara e no grande lago Vitória, são percorridos pelo rio Nilo, tornando-se importante fonte de riquezas para a agricultura, sendo países exportadores de petróleo e gás natural.' AS texto
  UNION ALL SELECT @qid,'B','Possuem áreas no deserto do Kalahari e no bioma das savanas, detendo parques industriais importantes, sendo países exportadores de recursos minerais (diamante e ouro) e combustíveis fósseis (petróleo).'
  UNION ALL SELECT @qid,'C','Possuem áreas no deserto do Saara e na zona úmida do golfo da Guiné, sendo países exportadores de recursos minerais (como ferro e ouro), fósseis (petróleo) e produtos agrícolas (cacau e algodão).'
  UNION ALL SELECT @qid,'D','Possuem áreas na zona equatorial e nas florestas tropicais do Pacífico, detendo importantes parques naturais que impulsionam o turismo nacional e, além disso, são países exportadores de petróleo e marfim.'
  UNION ALL SELECT @qid,'E','Possuem áreas na zona equatorial e nas florestas úmidas do Atlântico sul, detendo monumentos históricos que favorecem a atividade turística, sendo importantes países exportadores de petróleo e frutas.'
) alts WHERE @ja_existe_23d = 0;

-- Q27
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise o gráfico sobre a transição demográfica no Brasil entre os anos de 1800 a 2100 (população brasileira, em milhões de habitantes, dividida em quatro fases). Pontos indicados no gráfico: 1800 = 3,4 milhões; 1900 = 17,4 milhões; 2042 = 228 milhões (máximo); 2100 = 182 milhões. A fase 1 vai até cerca de 1900, com crescimento muito lento; a fase 2 vai de 1900 até cerca de 2030, com crescimento acelerado; a fase 3 corresponde ao período em que a curva se aproxima do máximo (por volta de 2030-2042); e a fase 4 é a que vem depois do máximo, com a população em queda.
(ALVES, José Eustáquio Diniz Alves. População e transição demográfica no Brasil: 1800-2100. https://www.ihu.unisinos.br. 2021. Adaptado)

Assinale a alternativa em que aparece corretamente a relação da influência dos indicadores demográficos em cada fase da dinâmica demográfica da população brasileira.','Difícil','Demografia - transição demográfica no Brasil','2ª Série EM','SARESP','D',7,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'(1) baixas taxas de natalidade e de mortalidade e elevado crescimento vegetativo; (2) elevadas taxas de mortalidade e aumento do crescimento vegetativo; (3) explosão demográfica; (4) elevação demográfica e alto crescimento vegetativo.' AS texto
  UNION ALL SELECT @qid,'B','(1) elevadas taxas de mortalidade e baixas taxas de natalidade; (2) redução nas taxas de natalidade e do crescimento vegetativo; (3) estabilização demográfica; (4) redução demográfica e alto crescimento vegetativo.'
  UNION ALL SELECT @qid,'C','(1) baixas taxas de natalidade e elevadas taxas de mortalidade; (2) redução nas taxas de natalidade e estagnação demográfica; (3) altas taxas de natalidade e elevação do crescimento populacional; (4) explosão demográfica.'
  UNION ALL SELECT @qid,'D','(1) elevadas taxas de mortalidade e de natalidade e baixo crescimento vegetativo; (2) redução nas taxas de mortalidade e elevação do crescimento vegetativo; (3) estabilização demográfica; (4) redução demográfica e baixo crescimento vegetativo.'
  UNION ALL SELECT @qid,'E','(1) estabilização demográfica; (2) elevadas taxas de mortalidade e aumento do crescimento vegetativo; (3) elevação nas taxas de natalidade e de mortalidade; (4) explosão demográfica e envelhecimento populacional.'
) alts WHERE @ja_existe_23d = 0;

-- Q28
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Embora a escravidão já existisse na África Ocidental antes da chegada dos europeus, ela assumiu outro significado. Doravante, o cativo tornou-se uma "peça", termo que evoca por si mesmo sua condição de mercadoria, cujo valor podia oscilar de acordo com a lei da oferta e da procura. Essa escravidão em massa, por sua vez, inundou a Europa, e depois toda a América, com uma categoria social completamente privada de direitos que passava a constituir a base de toda a exploração econômica [...].
(José Rivair Macedo. História da África, 2015)

Sobre a escravização dos africanos durante a Idade Moderna, o autor afirma que','Médio','História da África - escravização na Idade Moderna','2ª Série EM','SARESP','A',6,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'as características da escravidão já existente no oeste da África se diferenciavam das impostas aos africanos pelas sociedades europeias.' AS texto
  UNION ALL SELECT @qid,'B','a mão de obra de escravizados africanos era inexistente no continente europeu, onde predominava o uso do trabalho livre e assalariado.'
  UNION ALL SELECT @qid,'C','a valorização do preço dos escravizados no leste da África inviabilizava a utilização desse tipo de mão de obra no continente americano.'
  UNION ALL SELECT @qid,'D','a negociação entre africanos escravizados e traficantes para garantir um mínimo de direitos aos primeiros ocorria de forma constante.'
  UNION ALL SELECT @qid,'E','as nações europeias estabeleceram o comércio de escravizados africanos baseado em princípios liberais, como a livre concorrência entre os traficantes.'
) alts WHERE @ja_existe_23d = 0;

-- Q29
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise a charge, na qual está escrito: grab-bag alemão, britânico e russo. Grab-bag significa "saco de surpresas" ou "caixa de mistérios". É um recipiente que contém uma mistura de objetos muitas vezes retirados de um lugar sem serem vistos. Na charge (www.thinglink.com), três homens — um alemão, um britânico e um russo — cada um com um saco de "grab-bag" (German, British e Russian), puxam e repartem entre si um globo terrestre, no qual aparecem a Europa, a África e a Ásia.

No contexto histórico do século XIX, a charge retrata, na África e na Ásia,','Médio','Imperialismo e neocolonialismo - charge','2ª Série EM','SARESP','E',6,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a ação militar das potências europeias para evitar a guerra civil entre os nativos.' AS texto
  UNION ALL SELECT @qid,'B','a exploração de especiarias e produtos de luxo pelos europeus.'
  UNION ALL SELECT @qid,'C','a substituição das tradições milenares dos nativos por valores culturais europeus.'
  UNION ALL SELECT @qid,'D','a introdução do colonialismo mercantilista europeu.'
  UNION ALL SELECT @qid,'E','a expansão imperialista e neocolonial europeia.'
) alts WHERE @ja_existe_23d = 0;

-- Q30
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Durante a Primeira República brasileira, o "voto de cabresto" era quase uma prática político-cultural – um ato de lealdade do votante ao chefe local. O "curral eleitoral" aludia ao barracão onde os votantes eram mantidos em vigilância e ganhavam uma boa refeição, dali só saindo na hora de depositar o voto – que recebiam num envelope fechado – diretamente na urna.
(Lilia M. Schwarcz e Heloisa M. Starling. Brasil: uma biografia, 2015. Adaptado)

No contexto da Primeira República brasileira, o excerto apresenta características da prática política do período associadas','Médio','Primeira República - voto de cabresto','2ª Série EM','SARESP','C',6,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à regulação forçada do voto secreto.' AS texto
  UNION ALL SELECT @qid,'B','ao cerceamento policial da propaganda eleitoral.'
  UNION ALL SELECT @qid,'C','à captação ilícita de sufrágio.'
  UNION ALL SELECT @qid,'D','ao cumprimento das normas legais dos pleitos legislativos.'
  UNION ALL SELECT @qid,'E','ao controle do voto dos homens analfabetos.'
) alts WHERE @ja_existe_23d = 0;

-- Q31
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Examine o cartaz "Juventude Fascista" (Gioventù Fascista), produzido na Itália, em setembro de 1931, durante o regime fascista (1922-1943). No cartaz, um jovem de lenço no pescoço toca um tambor, diante de bandeiras negras tremulando, e lê-se: "O FASCISMO NÃO LHE PROMETE HONRAS OU CARGOS OU GANHOS, MAS DEVER E COMBATE. MUSSOLINI".
(https://propadv.com. Acesso em 04.09.2023. Adaptado)

O cartaz expressa o ideal fascista de','Médio','Fascismo - propaganda','2ª Série EM','SARESP','D',6,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'controle policial sobre os trabalhadores.' AS texto
  UNION ALL SELECT @qid,'B','superioridade da raça ariana.'
  UNION ALL SELECT @qid,'C','um sistema de governo comunista.'
  UNION ALL SELECT @qid,'D','uma sociedade militarizada.'
  UNION ALL SELECT @qid,'E','valorização da paz entre as nações.'
) alts WHERE @ja_existe_23d = 0;

-- Q32
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A época da transição para uma economia industrial no Brasil pode ser simbolizada pela política de massas, como padrão de organização política e sustentação do novo estilo de poder populista.
(Octavio Ianni. O colapso do populismo no Brasil, 1988. Adaptado)

Essa política de massas, presente no Brasil de 1930 a 1964, caracterizou-se','Médio','Brasil República - populismo (1930-1964)','2ª Série EM','SARESP','B',6,2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'pelo debate democrático, especialmente durante o Estado Novo, sobre as políticas econômicas de desenvolvimento do país.' AS texto
  UNION ALL SELECT @qid,'B','pelo uso da propaganda política para mobilizar os trabalhadores em torno dos projetos do governo.'
  UNION ALL SELECT @qid,'C','pela grande mobilização de sindicatos dos trabalhadores independentes do controle estatal.'
  UNION ALL SELECT @qid,'D','pela alteração da Consolidação das Leis do Trabalho (CLT) com a criação do trabalho intermitente.'
  UNION ALL SELECT @qid,'E','pela adoção de políticas públicas, como a reforma agrária, para melhorar as condições de vida da população.'
) alts WHERE @ja_existe_23d = 0;

-- Q33
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise os seguintes artigos da Declaração Universal dos Direitos Humanos (1948) e da Constituição Federal do Brasil (1988).

Artigo 2
Todo ser humano tem capacidade para gozar os direitos e as liberdades estabelecidos nesta Declaração, sem distinção de qualquer espécie, seja de raça, cor, sexo, língua, religião, opinião política ou de outra natureza, origem nacional ou social, riqueza, nascimento, ou qualquer outra condição. [...]
Artigo 3
Todo ser humano tem direito à vida, à liberdade e à segurança pessoal.
(Declaração Universal dos Direitos Humanos de 1948. https://www.unicef.org.)

Artigo 5º Todos são iguais perante a lei, sem distinção de qualquer natureza, garantindo-se aos brasileiros e aos estrangeiros residentes no País a inviolabilidade do direito à vida, à liberdade, à igualdade, à segurança e à propriedade [...].
(Constituição da República Federativa do Brasil de 1988. https://www.planalto.gov.br)

Com base nos trechos, um dos princípios comuns aos dois documentos é','Médio','Direitos humanos - Declaração Universal e Constituição','2ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a proteção da liberdade política independentemente de restrições legais.' AS texto
  UNION ALL SELECT @qid,'B','o direito das pessoas de prover individualmente a sua segurança pessoal.'
  UNION ALL SELECT @qid,'C','a garantia da igualdade social e econômica entre homens e mulheres.'
  UNION ALL SELECT @qid,'D','a defesa da função social da propriedade estatal para a garantia da dignidade humana.'
  UNION ALL SELECT @qid,'E','a condenação a qualquer tipo de discriminação atentatória dos direitos fundamentais.'
) alts WHERE @ja_existe_23d = 0;

-- Q34
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No passado, as máquinas competiram com humanos principalmente em habilidades físicas, enquanto os humanos se mantiveram à frente das máquinas em capacidade cognitiva. Por isso, quando trabalhos manuais na agricultura e na indústria foram automatizados, surgiram novos trabalhos no setor de serviços que requeriam o tipo de habilidade cognitiva que só os humanos possuíam: aprender, analisar, comunicar e acima de tudo compreender as emoções humanas. No entanto, a Inteligência Artificial (IA) está começando agora a superar os humanos em um número cada vez maior dessas habilidades, inclusive a de compreender as emoções humanas.
(Yuval Noah Harari. 21 lições para o século 21, 2018. Adaptado)

A abordagem do autor sobre as relações entre o desenvolvimento tecnológico e o mundo do trabalho, nas sociedades do século XXI, aponta para a','Médio','Trabalho e tecnologia - Inteligência Artificial','2ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'progressiva autonomia do trabalhador industrial.' AS texto
  UNION ALL SELECT @qid,'B','exploração do trabalho repetitivo em larga escala.'
  UNION ALL SELECT @qid,'C','expansão do número de empregados no setor terciário da economia.'
  UNION ALL SELECT @qid,'D','intensificação da divisão do trabalho.'
  UNION ALL SELECT @qid,'E','mudança significativa do mercado de trabalho.'
) alts WHERE @ja_existe_23d = 0;

-- Q35
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Conforme indica Ivonne Lampert (2019), existiriam três tipos de interrogações ou problemas filosóficos, quais sejam: (1) os que pedem uma explicação ou definição; (2) aqueles que indagam sob quais condições os indivíduos ganham experiência; (3) os que focalizam a maneira como se pensa os fenômenos e se fala sobre eles.

Uma característica central das interrogações e problemas filosóficos é','Fácil','Filosofia - problemas filosóficos','2ª Série EM','SARESP','A',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'terem diferentes propostas de solução.' AS texto
  UNION ALL SELECT @qid,'B','terem sido respondidos na atualidade.'
  UNION ALL SELECT @qid,'C','serem facilmente solucionáveis.'
  UNION ALL SELECT @qid,'D','serem irrelevantes para a vida cotidiana.'
  UNION ALL SELECT @qid,'E','serem formulados de modo confuso.'
) alts WHERE @ja_existe_23d = 0;

-- Q36
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O estudo e sistematização das formas de argumentação é uma das principais contribuições epistemológicas da Lógica Clássica. Graças à aplicação de princípios lógicos e regras de inferência na análise de um argumento é possível','Médio','Filosofia - lógica e argumentação','2ª Série EM','SARESP','D',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'justificar racionalmente quaisquer conclusões.' AS texto
  UNION ALL SELECT @qid,'B','persuadir por meio de alegações emocionais.'
  UNION ALL SELECT @qid,'C','demonstrar logicamente premissas dogmáticas.'
  UNION ALL SELECT @qid,'D','reconhecer sofismas e problematizar opiniões.'
  UNION ALL SELECT @qid,'E','formular falácias para convencer uma audiência.'
) alts WHERE @ja_existe_23d = 0;

-- Q37
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na tradição ocidental foram postuladas diferentes concepções filosóficas sobre Ética, isto é, sobre diferentes princípios e condições que permitiriam considerar uma ação correta ou incorreta, eticamente significativa e virtuosa ou não.

Em especial, a Ética das virtudes se caracteriza por','Médio','Filosofia - ética das virtudes','2ª Série EM','SARESP','C',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'promover o primado da felicidade individual.' AS texto
  UNION ALL SELECT @qid,'B','propor o princípio da não-maleficência.'
  UNION ALL SELECT @qid,'C','recomendar formas comedidas de conduta.'
  UNION ALL SELECT @qid,'D','formular imperativos morais categóricos.'
  UNION ALL SELECT @qid,'E','adotar como regra o princípio da empatia.'
) alts WHERE @ja_existe_23d = 0;

-- Q38
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A concepção liberal de Estado teve um papel filosófico relevante na história do pensamento europeu como construto teórico crítico do absolutismo. Na Europa, a progressiva implementação de princípios liberais foi concomitante ao desenvolvimento do capitalismo, à perda de relevância econômica e política das classes aristocráticas e à implementação gradual de mecanismos jurídico-sociais de proteção às classes populares. No entanto, mesmo em estados liberais contemporâneos, permanecem operando mecanismos denunciados por Karl Marx porque','Médio','Filosofia política - liberalismo e crítica marxista','2ª Série EM','SARESP','B',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a aristocracia industrial continua a explorar mão de obra camponesa.' AS texto
  UNION ALL SELECT @qid,'B','a lógica capitalista depende da implementação da mais valia.'
  UNION ALL SELECT @qid,'C','o liberalismo atual defende o princípio da luta de classes.'
  UNION ALL SELECT @qid,'D','o capitalismo financeiro combate práticas especulativas.'
  UNION ALL SELECT @qid,'E','a meritocracia liberal promove processos de inclusão social.'
) alts WHERE @ja_existe_23d = 0;

-- Q39
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Atualmente, estudos sociológicos sobre os direitos humanos, como o realizado pela Comissão Interamericana de Direitos Humanos intitulado Situação dos Direitos Humanos no Brasil (2021), têm discutido o papel e a influência de preconceitos (racial, de gênero, de classe, entre outros) em práticas pessoais e políticas institucionais.

Tais estudos são especialmente importantes para','Fácil','Sociologia - preconceito e direitos humanos','2ª Série EM','SARESP','D',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'preservar a cordialidade típica da cultura brasileira nas relações sociais.' AS texto
  UNION ALL SELECT @qid,'B','incentivar a miscigenação para evitar a instauração do racismo no Brasil.'
  UNION ALL SELECT @qid,'C','impossibilitar o surgimento no Brasil de preconceito por classe social.'
  UNION ALL SELECT @qid,'D','traçar políticas públicas que preservem e promovam a dignidade humana.'
  UNION ALL SELECT @qid,'E','propor medidas que evitem o ressurgimento de preconceitos de gênero.'
) alts WHERE @ja_existe_23d = 0;

-- Q40
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As novas tecnologias da informação e automação alteraram significativamente o mercado de trabalho, em especial nos últimos anos. Por exemplo, processos de automação cada vez mais sofisticados substituem progressivamente a mão de obra humana em processos produtivos e de prestação de serviços.

Considerando essa situação, é correto afirmar que','Médio','Sociologia do trabalho - automação','2ª Série EM','SARESP','D',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a utilização generalizada de tecnologias de automação visa implementar processos inclusivos.' AS texto
  UNION ALL SELECT @qid,'B','os sistemas automatizados de recomendação ampliam os postos de trabalho em lojas virtuais.'
  UNION ALL SELECT @qid,'C','a automação na produção industrial favorece trabalhadores com menor grau de instrução.'
  UNION ALL SELECT @qid,'D','a automação progressiva dos processos produtivos tende a elevar a desigualdade social.'
  UNION ALL SELECT @qid,'E','o aumento da produtividade e da margem de lucro de empresas beneficia toda a sociedade.'
) alts WHERE @ja_existe_23d = 0;

-- Q41
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O ambiente virtual parece carecer de instrumentos eficazes de regulação e controle, como é possível constatar pela quantidade de notícias falsas que se multiplicam pelas mídias digitais. Os fenômenos sociais da internet são posteriores à análise do papel das mídias na indústria cultural feita pelos sociólogos da Escola de Frankfurt. No entanto, análises críticas feitas em relação às mídias tradicionais ainda podem elucidar aspectos importantes das novas mídias.

Dentre tais análises, encontra-se a constatação de que','Médio','Sociologia - indústria cultural e novas mídias','2ª Série EM','SARESP','C',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'as novas mídias promovem massivamente a educação crítica de seus usuários.' AS texto
  UNION ALL SELECT @qid,'B','a lógica da indústria cultural digital privilegia a qualidade do produto.'
  UNION ALL SELECT @qid,'C','os limites entre informação e consumo ficaram difusos e imprecisos.'
  UNION ALL SELECT @qid,'D','a influência da busca por lucro constitui um fator secundário nas novas mídias.'
  UNION ALL SELECT @qid,'E','as novas mídias auxiliam a amenizar a polarização política na sociedade civil.'
) alts WHERE @ja_existe_23d = 0;

-- Q42
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No Brasil atual, a violência ainda impera no campo por causa de uma série de fatores de natureza social, política, econômica e cultural. Dentre os fatores que permitem que a violência perdure no campo, é relevante mencionar','Médio','Sociologia rural - violência no campo','2ª Série EM','SARESP','A',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23d = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a expansão da fronteira agrícola por meio da falsificação de títulos de propriedade.' AS texto
  UNION ALL SELECT @qid,'B','o empenho de instituições privadas para combater o aumento de práticas de grilagem.'
  UNION ALL SELECT @qid,'C','o esforço de latifundiários em prol do princípio constitucional de função social da terra.'
  UNION ALL SELECT @qid,'D','a ajuda de entidades ligadas ao agronegócio para a demarcação de terras indígenas.'
  UNION ALL SELECT @qid,'E','o desmatamento sistemático praticado por indígenas e quilombolas em suas terras.'
) alts WHERE @ja_existe_23d = 0;
