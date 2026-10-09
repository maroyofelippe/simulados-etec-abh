-- ==========================================================
--  Migração de conteúdo: Banco de questões SARESP 2023 — 1ª Série EM
--  Caderno 010-MT-CH (Matemática + Ciências Humanas), Cad01,
--  aplicado como Provão Paulista Seriado 2023 (04.12.2023) — Versão 1.
--  Fonte: caderno de questões + gabarito oficial (Fundação Vunesp) fornecidos pela coordenação.
--  ----------------------------------------------------------
--  Origem das questões: SARESP (coluna questoes.origem, criada pela
--  migração 2026-10_origem_questoes.sql — por isso este arquivo vem depois dela).
--
--  Escopo: as 42 questões do caderno foram importadas. Nas questões 1, 7, 9, 12,
--  15, 18, 24, 39 e 40, a figura/gráfico/tirinha foi descrito em texto no
--  enunciado (ou os valores lidos foram transcritos).
--
--  Cria também as disciplinas "Filosofia" e "Sociologia" (Ciências Humanas),
--  usadas pelas questões 35-40.
--
--  Gabarito: Versão 1 do gabarito oficial (Cad01).
--
--  Idempotente: variável de sessão travada no início (@ja_existe_23c), sem
--  DELIMITER/stored procedures (incompatível com a execução via db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-10_origem_questoes_saresp2023_1serie_mt_ch.sql)
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
SET @ja_existe_23c := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'A representação a seguir é da reta dos números reais%'
);


-- Q01
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A representação a seguir é da reta dos números reais, apresentando alguns números inteiros (0, 2, 4, 6 e 8, marcados sobre a reta) e as posições identificadas por A, B, C, D, E e F: A fica antes do 0, B entre 0 e 2, C entre 2 e 4, D entre 4 e 6, E entre 6 e 8 e F depois do 8.

O número √27, quando representado na reta numérica, está localizado entre','Médio','Números reais - reta numérica e raiz quadrada','1ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'C e 4.' AS texto
  UNION ALL SELECT @qid,'B','4 e 6.'
  UNION ALL SELECT @qid,'C','A e B.'
  UNION ALL SELECT @qid,'D','B e C.'
  UNION ALL SELECT @qid,'E','6 e 8.'
) alts WHERE @ja_existe_23c = 0;

-- Q02
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A razão entre a altura de um poste de iluminação e a altura de um edifício é de 2/7. Sabendo que esse poste tem 8 m de altura, qual é a altura do edifício?','Fácil','Razão e proporção','1ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'2,3 m.' AS texto
  UNION ALL SELECT @qid,'B','17,0 m.'
  UNION ALL SELECT @qid,'C','28,0 m.'
  UNION ALL SELECT @qid,'D','8,3 m.'
  UNION ALL SELECT @qid,'E','13,0 m.'
) alts WHERE @ja_existe_23c = 0;

-- Q03
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A distância entre Marte e Netuno é de, aproximadamente, 4 bilhões e 300 milhões de quilômetros. Mantida a unidade de medida, essa distância pode ser expressa em notação científica da seguinte forma:','Fácil','Notação científica','1ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'4 300 · 10⁶ km.' AS texto
  UNION ALL SELECT @qid,'B','4 300 · 10⁹ km.'
  UNION ALL SELECT @qid,'C','0,43 · 10¹⁰ km.'
  UNION ALL SELECT @qid,'D','4,3 · 10⁹ km.'
  UNION ALL SELECT @qid,'E','4,3 · 10⁴ km.'
) alts WHERE @ja_existe_23c = 0;

-- Q04
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em dez envelopes, foram colocados valores, em reais, de modo que esses valores formam uma progressão aritmética. Ordenados os envelopes, de modo que o primeiro tenha o menor valor e o último tenha o maior, tem-se que no segundo envelope está contido o valor de R$ 120,00 e no quinto envelope, o valor de R$ 210,00.

Qual o valor que está contido no décimo envelope?','Médio','Progressão aritmética','1ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'R$ 390,00.' AS texto
  UNION ALL SELECT @qid,'B','R$ 330,00.'
  UNION ALL SELECT @qid,'C','R$ 360,00.'
  UNION ALL SELECT @qid,'D','R$ 420,00.'
  UNION ALL SELECT @qid,'E','R$ 270,00.'
) alts WHERE @ja_existe_23c = 0;

-- Q05
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em uma loja, o preço de determinado produto para o pagamento à vista é de R$ 1.400,00. Caso o comprador queira, ele pode pagar o produto em duas vezes: uma parcela de R$ 900,00, no ato da compra, e financiar o restante, pagando uma segunda parcela de R$ 560,00, após 30 dias da data da compra.

Se uma pessoa optar pelo pagamento em duas vezes, qual a porcentagem de juros que ela estará pagando no financiamento?','Médio','Matemática financeira - juros','1ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'24%' AS texto
  UNION ALL SELECT @qid,'B','12%'
  UNION ALL SELECT @qid,'C','4%'
  UNION ALL SELECT @qid,'D','40%'
  UNION ALL SELECT @qid,'E','60%'
) alts WHERE @ja_existe_23c = 0;

-- Q06
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A densidade demográfica é a razão entre o número total de habitantes e a área ocupada por eles. De acordo com o Instituto Brasileiro de Geografia e Estatística (IBGE), a densidade demográfica do município de Iporanga, em 2022, era de 3,5 habitantes por km². Sabendo que a área territorial daquele município, no mesmo ano, era de, aproximadamente, 1 150 km², o número total de habitantes no município, em 2022, de acordo com o IBGE, é um número entre','Fácil','Razão - densidade demográfica','1ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'300 e 400 pessoas.' AS texto
  UNION ALL SELECT @qid,'B','400 e 500 pessoas.'
  UNION ALL SELECT @qid,'C','3 200 e 3 300 pessoas.'
  UNION ALL SELECT @qid,'D','40 200 e 40 300 pessoas.'
  UNION ALL SELECT @qid,'E','4 000 e 4 100 pessoas.'
) alts WHERE @ja_existe_23c = 0;

-- Q07
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere a seguinte tabela, que relaciona os números da coluna y com os números da coluna x:
x: 0, 1, 2, 3, 4, 5, 6, 7, 8
y: 1, 2, 3, 4, 5, 5, 5, 5, 5

Sabendo que a tabela é a de uma função f: [0, 8] → ℝ, assinale a alternativa que contém uma representação algébrica para a função f.','Médio','Funções - representação algébrica','1ª Série EM','SARESP','A',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'y = f(x) = x + 1, se 0 ≤ x < 4; e y = f(x) = 5, se 4 ≤ x ≤ 8.' AS texto
  UNION ALL SELECT @qid,'B','y = f(x) = x + 1'
  UNION ALL SELECT @qid,'C','y = f(x) = x + 1, se 0 ≤ x ≤ 3; e y = f(x) = 5, se 4 ≤ x ≤ 8.'
  UNION ALL SELECT @qid,'D','y = f(x) = x − 3'
  UNION ALL SELECT @qid,'E','y = f(x) = 5'
) alts WHERE @ja_existe_23c = 0;

-- Q08
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Três salões têm os seus pisos em formato de polígonos. Um deles tem o formato de quadrado de lados medindo 8 m; o outro tem o formato de triângulo retângulo, com catetos medindo 9 m e 12 m, e hipotenusa medindo 15 m; e o terceiro tem o formato de retângulo com comprimento de 12 m e largura de 5 m.

Se Q é a área do salão com piso no formato quadrado, T é a área do salão com piso no formato de triângulo retângulo, e R é a área do salão com piso no formato de retângulo, então é verdade que','Fácil','Geometria plana - áreas','1ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'T é a menor área e R é a maior.' AS texto
  UNION ALL SELECT @qid,'B','Q é a menor área e R é a maior.'
  UNION ALL SELECT @qid,'C','Q é a menor área e T é a maior.'
  UNION ALL SELECT @qid,'D','T é a menor área e Q é a maior.'
  UNION ALL SELECT @qid,'E','R é a menor área e T é a maior.'
) alts WHERE @ja_existe_23c = 0;

-- Q09
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere a reta r representada no gráfico a seguir: uma reta crescente que passa pelo ponto (1, 1) e pelo ponto (3, 5).

A equação da reta representada na figura é','Médio','Geometria analítica - equação da reta','1ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'y = (3/5)x − 1' AS texto
  UNION ALL SELECT @qid,'B','y = (1/2)x − 1'
  UNION ALL SELECT @qid,'C','y = 2x + 1'
  UNION ALL SELECT @qid,'D','y = 2x − 1'
  UNION ALL SELECT @qid,'E','y = x'
) alts WHERE @ja_existe_23c = 0;

-- Q10
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um quadrilátero tem os vértices nos pontos com as seguintes coordenadas: (3,3), (3,5), (5,5) e (5,3). Qual é a forma e o perímetro (soma das medidas dos lados) desse quadrilátero?','Fácil','Geometria analítica - perímetro','1ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'quadrado; 32 unidades de comprimento.' AS texto
  UNION ALL SELECT @qid,'B','quadrado; 64 unidades de comprimento.'
  UNION ALL SELECT @qid,'C','quadrado; 8 unidades de comprimento.'
  UNION ALL SELECT @qid,'D','retângulo; 32 unidades de comprimento.'
  UNION ALL SELECT @qid,'E','retângulo; 64 unidades de comprimento.'
) alts WHERE @ja_existe_23c = 0;

-- Q11
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Foi feito um levantamento do número de funcionários de onze pequenas empresas recém-instaladas em um polo industrial. Os números obtidos foram os seguintes:

15, 16, 16, 17, 17, 18, 22, 22, 22, 26, 28

Com o objetivo de obter dados para um estudo estatístico, foram calculadas a média, a moda e a mediana do número de funcionários dessas empresas. Quais foram os resultados obtidos?','Fácil','Estatística - média, moda e mediana','1ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Média: 20 funcionários; Moda: 29 funcionários; Mediana: 18 funcionários.' AS texto
  UNION ALL SELECT @qid,'B','Média: 20 funcionários; Moda: 22 funcionários; Mediana: 18 funcionários.'
  UNION ALL SELECT @qid,'C','Média: 20 funcionários; Moda: 18 funcionários; Mediana: 22 funcionários.'
  UNION ALL SELECT @qid,'D','Média: 110 funcionários; Moda: 18 funcionários; Mediana: 29 funcionários.'
  UNION ALL SELECT @qid,'E','Média: 110 funcionários; Moda: 22 funcionários; Mediana: 18 funcionários.'
) alts WHERE @ja_existe_23c = 0;

-- Q12
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O gráfico de barras representa o número de alunos matriculados no Ensino Médio, em certa escola (valores lidos no gráfico):
- 1º Ano: Diurno 275; Noturno 200.
- 2º Ano: Diurno 325; Noturno 250.
- 3º Ano: Diurno 250; Noturno 275.

Assinale a alternativa que contém uma tabela que melhor se adequa às informações apresentadas no gráfico (cada alternativa lista Diurno/Noturno para o 1º, 2º e 3º anos):','Fácil','Estatística - leitura de gráfico de barras','1ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'1º Ano: 200/275; 2º Ano: 250/325; 3º Ano: 275/250.' AS texto
  UNION ALL SELECT @qid,'B','1º Ano: 290/200; 2º Ano: 340/250; 3º Ano: 250/290.'
  UNION ALL SELECT @qid,'C','1º Ano: 250/275; 2º Ano: 325/250; 3º Ano: 275/200.'
  UNION ALL SELECT @qid,'D','1º Ano: 260/200; 2º Ano: 310/250; 3º Ano: 250/260.'
  UNION ALL SELECT @qid,'E','1º Ano: 275/200; 2º Ano: 325/250; 3º Ano: 250/275.'
) alts WHERE @ja_existe_23c = 0;

-- Q13
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Tereza, que gosta de colecionar objetos, tinha certa quantidade de canetas que, adicionada à sua quarta parte, totalizava 320 canetas. Sabendo que ela pretende reduzir pela metade a quantidade de canetas colecionadas, com quantas canetas ela pretende ficar?','Médio','Equações do 1º grau - problemas','1ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'120.' AS texto
  UNION ALL SELECT @qid,'B','286.'
  UNION ALL SELECT @qid,'C','250.'
  UNION ALL SELECT @qid,'D','128.'
  UNION ALL SELECT @qid,'E','40.'
) alts WHERE @ja_existe_23c = 0;

-- Q14
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em países como a Inglaterra, utiliza-se a polegada como unidade de medida de comprimento. Sabendo-se que 1 polegada corresponde a 2,54 cm, um quarteirão que tem 2 500 polegadas de comprimento tem como correspondente uma medida','Fácil','Unidades de medida - conversão','1ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'entre 100 metros e 150 metros.' AS texto
  UNION ALL SELECT @qid,'B','entre 150 metros e 200 metros.'
  UNION ALL SELECT @qid,'C','entre 50 metros e 100 metros.'
  UNION ALL SELECT @qid,'D','maior do que 200 metros.'
  UNION ALL SELECT @qid,'E','menor do que 50 metros.'
) alts WHERE @ja_existe_23c = 0;

-- Q15
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um marceneiro precisa montar, em madeira, duas peças que serão encaixadas uma na outra. A figura (fora de escala) representa um triângulo cujo lado esquerdo mede 30 cm + 70 cm = 100 cm; o lado oposto ao vértice superior (lado direito inferior) mede 50 cm; e um segmento de x cm, traçado a 30 cm do vértice superior, é paralelo ao lado de 50 cm.

Sabendo que os lados representados com as medidas 50 cm e x cm são paralelos, o valor de x deve ser igual a','Médio','Semelhança de triângulos','1ª Série EM','SARESP','A',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'15 cm.' AS texto
  UNION ALL SELECT @qid,'B','40 cm.'
  UNION ALL SELECT @qid,'C','25 cm.'
  UNION ALL SELECT @qid,'D','10 cm.'
  UNION ALL SELECT @qid,'E','21 cm.'
) alts WHERE @ja_existe_23c = 0;

-- Q16
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Daniel tinha um terreno em formato de retângulo, com 50 m de comprimento e 30 m de largura. Recentemente, ele adquiriu parte de propriedades vizinhas, ampliando seu terreno, que passou a ter 2 400 m² de área, mantendo-o no formato retangular.

Agora, Daniel irá cercar sua propriedade e, para fins de orçamento, precisa informar as medidas do seu novo terreno. Considerando que a ampliação aumentou x metros o comprimento e x metros a largura do terreno original, qual o novo comprimento do terreno de Daniel?','Difícil','Equação do 2º grau - área do retângulo','1ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'80 m.' AS texto
  UNION ALL SELECT @qid,'B','30 m.'
  UNION ALL SELECT @qid,'C','60 m.'
  UNION ALL SELECT @qid,'D','40 m.'
  UNION ALL SELECT @qid,'E','50 m.'
) alts WHERE @ja_existe_23c = 0;

-- Q17
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Rogério se interessa muito pelo desempenho dos aviões, tanto que coleciona aviões em miniatura e comprou um avião motorizado de brinquedo para observar suas manobras, conhecer a altura máxima que o avião poderia atingir e a distância a que ele poderia chegar.

Sabe-se que a trajetória y (em metros de altura) do avião comprado por Rogério é definida pela parábola de expressão algébrica y = –x² + 5x, em que x é a distância (em metros), em linha reta no solo, do ponto em que o avião levanta voo até o ponto em que ele pousa.

Fazendo-se x = 0 a abscissa do ponto exato em que o avião levanta voo, qual a altura máxima que esse avião atinge e a distância no solo, medida do ponto em que o avião levanta voo até o ponto em que ele pousa?','Médio','Função quadrática - vértice e raízes','1ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Altura de 6 m e distância igual a 2,5 m.' AS texto
  UNION ALL SELECT @qid,'B','Altura de 2,5 m e distância igual a 6,25 m.'
  UNION ALL SELECT @qid,'C','Altura de 6 m e distância igual a 5 m.'
  UNION ALL SELECT @qid,'D','Altura de 6,25 m e distância igual a 5 m.'
  UNION ALL SELECT @qid,'E','Altura de 6,25 m e distância igual a 2,5 m.'
) alts WHERE @ja_existe_23c = 0;

-- Q18
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'São apresentadas a figura 1 e a figura 2, ambas representando quadrados: a figura 1 é um quadrado ABCD com os lados na horizontal e na vertical; a figura 2 é um quadrado A''B''C''D'' com os vértices voltados para cima, para a direita, para baixo e para a esquerda (isto é, o quadrado girado em 45º), posicionado em outro lugar do plano.

Sabendo que a figura 2 foi obtida a partir de duas transformações isométricas da figura 1, assinale a alternativa que contém as possíveis transformações que foram utilizadas.','Médio','Transformações isométricas','1ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Rotação em relação ao centro do quadrado e reflexão em relação a um dos lados do quadrado.' AS texto
  UNION ALL SELECT @qid,'B','Reflexão em relação a uma das diagonais do quadrado e rotação em relação a um dos vértices do quadrado.'
  UNION ALL SELECT @qid,'C','Translação e reflexão em relação a uma reta paralela a um dos lados do quadrado.'
  UNION ALL SELECT @qid,'D','Reflexão em relação a uma reta paralela a um dos lados do quadrado e rotação em relação a um dos vértices do quadrado.'
  UNION ALL SELECT @qid,'E','Rotação em relação ao centro do quadrado e translação.'
) alts WHERE @ja_existe_23c = 0;

-- Q19
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'João precisava de um empréstimo de R$ 10.000,00. Seu irmão, sabendo que João iria solicitar um empréstimo bancário, fez a seguinte proposta, que foi aceita por João: em vez de João pagar juros bancários, ele emprestaria todo o valor a João, com base na relação M = 10 000 + 100x, sendo M correspondente ao montante a ser devolvido, de uma só vez, e x corresponde ao número de meses do período do empréstimo. Sabendo que João pagou o empréstimo ao final do período de 5 meses, qual foi o montante pago?','Fácil','Funções - modelo de montante','1ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'R$ 10.050,00.' AS texto
  UNION ALL SELECT @qid,'B','R$ 10.500,00.'
  UNION ALL SELECT @qid,'C','R$ 50.500,00.'
  UNION ALL SELECT @qid,'D','R$ 10.400,00.'
  UNION ALL SELECT @qid,'E','R$ 10.100,00.'
) alts WHERE @ja_existe_23c = 0;

-- Q20
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma parede precisa ser revestida com azulejos em formato de polígonos regulares. Para tanto, será escolhido um tipo de azulejo, de modo a se obter um ladrilhamento. Das alternativas a seguir, qual é a forma de azulejo ideal para revestir essa parede?','Médio','Geometria plana - ladrilhamento','1ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Um heptágono (7 lados).' AS texto
  UNION ALL SELECT @qid,'B','Um pentágono (5 lados).'
  UNION ALL SELECT @qid,'C','Um octógono (8 lados).'
  UNION ALL SELECT @qid,'D','Um decágono (10 lados).'
  UNION ALL SELECT @qid,'E','Um hexágono (6 lados).'
) alts WHERE @ja_existe_23c = 0;

-- Q21
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O aquecimento global acontece quando aumenta a concentração de vapor d''água e de determinados gases na atmosfera terrestre, como, por exemplo, o dióxido de carbono, metano, óxido nitroso dentre outros de menor expressão. Esse conjunto de gases são responsáveis','Fácil','Meio ambiente - efeito estufa','1ª Série EM','SARESP','A',7,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'pelo efeito estufa.' AS texto
  UNION ALL SELECT @qid,'B','pela redução da camada de ozônio.'
  UNION ALL SELECT @qid,'C','pelo aumento da cobertura de gelo nos polos.'
  UNION ALL SELECT @qid,'D','pela ocorrência de inversões térmicas.'
  UNION ALL SELECT @qid,'E','pela chuva alcalina.'
) alts WHERE @ja_existe_23c = 0;

-- Q22
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma atividade esportiva terá seu início às 15h em uma localidade situada na longitude de 45º a leste do meridiano de Greenwich. Estando o expectador em Brasília com longitude de 45º a oeste do meridiano de Greenwich, o horário simultâneo desta atividade será às','Médio','Cartografia - fusos horários','1ª Série EM','SARESP','C',7,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'19h.' AS texto
  UNION ALL SELECT @qid,'B','21h.'
  UNION ALL SELECT @qid,'C','09h.'
  UNION ALL SELECT @qid,'D','23h.'
  UNION ALL SELECT @qid,'E','12h.'
) alts WHERE @ja_existe_23c = 0;

-- Q23
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O trecho a seguir é parte do Decreto Federal nº 6.040 de 2007:

São grupos culturalmente diferenciados e que se reconhecem como tais, que possuem formas próprias de organização social, que ocupam e usam territórios e recursos naturais como condição para sua reprodução cultural, social, religiosa, ancestral e econômica, utilizando conhecimentos, inovações e práticas gerados e transmitidos pela tradição.

Esse trecho apresenta o conceito de','Fácil','Sociedade - povos e comunidades tradicionais','1ª Série EM','SARESP','E',7,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'colonizadores e seus descendentes.' AS texto
  UNION ALL SELECT @qid,'B','população flutuante.'
  UNION ALL SELECT @qid,'C','coletores de recicláveis.'
  UNION ALL SELECT @qid,'D','migrantes.'
  UNION ALL SELECT @qid,'E','povos e comunidades tradicionais.'
) alts WHERE @ja_existe_23c = 0;

-- Q24
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Observe a figura que representa o consumo de água (retirada em m³/s) entre os anos 2000 e 2020, com projeção para 2040 para alguns setores da economia (gráfico de linhas):
- Irrigação: 639 (2000); 964 (2020); 1552 (2040).
- Abastecimento Urbano: 380 (2000); 482 (2020); 537 (2040).
- Indústria: 107 (2000); 184 (2020); 251 (2040).
(Agência Nacional de Águas, 2021)

No cenário nacional, de acordo com os dados apresentados, tem-se que, ao longo do período exibido,','Médio','Recursos hídricos - interpretação de gráfico','1ª Série EM','SARESP','B',7,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'em termos de volume de consumo, o setor da indústria é o maior deles, seguido de abastecimento urbano e irrigação.' AS texto
  UNION ALL SELECT @qid,'B','os três setores apresentam aumento, sendo o setor de irrigação aquele com o acréscimo mais expressivo.'
  UNION ALL SELECT @qid,'C','o setor de irrigação apresenta redução no consumo de água, enquanto abastecimento urbano e industrial apresentam elevação no consumo.'
  UNION ALL SELECT @qid,'D','os três setores apresentam estagnação no consumo da água.'
  UNION ALL SELECT @qid,'E','os três setores apresentam aumento até 2020 e redução para a projeção de 2040.'
) alts WHERE @ja_existe_23c = 0;

-- Q25
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O fenômeno atmosférico da ilha de calor é comum em áreas urbanizadas em função da grande concentração de asfalto e concreto tornando a temperatura do ar mais elevada que o entorno próximo menos urbanizado.

Como medida para reduzir seus impactos na população, pode-se adotar','Fácil','Clima urbano - ilha de calor','1ª Série EM','SARESP','D',7,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o reuso da água.' AS texto
  UNION ALL SELECT @qid,'B','a limpeza das calçadas.'
  UNION ALL SELECT @qid,'C','manutenção dos bueiros limpos.'
  UNION ALL SELECT @qid,'D','o plantio de árvores.'
  UNION ALL SELECT @qid,'E','a irrigação das praças.'
) alts WHERE @ja_existe_23c = 0;

-- Q26
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O início da década de 1990 marcou o começo da chamada Nova Ordem Mundial, em que os fluxos de mercadorias, serviços e capitais se tornaram ainda mais intensos com a integração dos países que eram socialistas ao mercado internacional.

O processo de aprofundamento da integração econômica, social e cultural e da comunicação entre os países é chamado de globalização. Esse processo teve como marco histórico','Fácil','Globalização - marco histórico','1ª Série EM','SARESP','C',6,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a assinatura do Pacto de Varsóvia.' AS texto
  UNION ALL SELECT @qid,'B','a retificação do Protocolo de Kyoto.'
  UNION ALL SELECT @qid,'C','o fim da Guerra Fria.'
  UNION ALL SELECT @qid,'D','a imposição de sanções econômicas a Cuba.'
  UNION ALL SELECT @qid,'E','os conflitos no Atlântico Norte.'
) alts WHERE @ja_existe_23c = 0;

-- Q27
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Conceito que expressa uma medida matemática, ou seja, uma fração que indica a relação entre as medidas do real (terreno) e aquelas da representação em um mapa. Esse conceito se refere','Fácil','Cartografia - escala','1ª Série EM','SARESP','A',7,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à escala cartográfica.' AS texto
  UNION ALL SELECT @qid,'B','às medidas verticais de um mapa.'
  UNION ALL SELECT @qid,'C','ao norte geográfico ou norte da quadrícula.'
  UNION ALL SELECT @qid,'D','à presença de legenda do mapa.'
  UNION ALL SELECT @qid,'E','à escala temporal de análise.'
) alts WHERE @ja_existe_23c = 0;

-- Q28
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para responder à questão, considere o texto a seguir.

"Parece-me gente de tal inocência que, se homem os entendesse e eles a nós, seriam logo cristãos, porque eles, segundo parece, não têm, nem entendem nenhuma crença. Eles não lavam, nem criam. Não há aqui boi, nem vaca, nem cabra, nem ovelha, nem galinha... Nem comem senão desse inhame, que aqui há muito, e dessa semente e frutos, que a terra e as árvores de si lançam. E com isto andam tais e tão rijos que o não somos nós tanto, com quanto trigo e legumes comemos. Neste dia, enquanto ali andaram, dançaram e bailaram sempre com os nossos, ao som dum tamboril dos nossos, de maneira que são muito mais nossos amigos, que nós seus."
(Pero Vaz de CAMINHA. Carta de Pero Vaz de Caminha a El-Rei d. Manuel sobre o Achamento do Brasil. Sintra: Europa-América, s/d. p.90-1. Adaptado)

Esse excerto da carta de Pero Vaz de Caminha faz menção ao seguinte fato:','Médio','História do Brasil - Carta de Pero Vaz de Caminha','1ª Série EM','SARESP','E',6,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a ausência de animais na terra recém-descoberta.' AS texto
  UNION ALL SELECT @qid,'B','os portugueses estavam bastante preocupados com a forma de alimentação que poderia haver na terra recém-descoberta.'
  UNION ALL SELECT @qid,'C','a indicação aos portugueses, pelo autor da carta, para que exterminassem os indígenas para ocupar a terra deles.'
  UNION ALL SELECT @qid,'D','os portugueses compreendiam a si próprios como amigos dos indígenas.'
  UNION ALL SELECT @qid,'E','os indígenas foram parte de um projeto civilizatório dos portugueses que abarcava a catequização dos primeiros.'
) alts WHERE @ja_existe_23c = 0;

-- Q29
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto a seguir.

"A importância da concepção monástica do trabalho – o trabalho como penitência redentora – favorece, desse modo, a extraordinária ''invenção do tempo'' que marca o Ocidente medieval. O tempo cotidiano se mede daí em diante de maneira abstrata, em primeiro lugar com o emprego do tempo das horas monásticas marcado pelos relógios, invenção dos séculos VI e VII, depois, no quadro urbano, com o relógio mecânico indicador das horas iguais e mensuráveis, surgido no final do século XII. Mudou a natureza do tempo, transformado em espaço horário que se dispõe e se organiza."
(Jacques Le Goff. Uma longa Idade Média. 2ª ed. Rio de Janeiro: Civilização Brasileira, 2010. p.78. Adaptado)

Esse comentário do historiador Jacques Le Goff revela que','Médio','Idade Média - concepção de tempo e trabalho','1ª Série EM','SARESP','D',6,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o relógio mecânico foi inventado como um instrumento necessário à vida no campo.' AS texto
  UNION ALL SELECT @qid,'B','a concepção monástica do trabalho constrói, pela primeira vez, uma maneira social de se lidar com o tempo.'
  UNION ALL SELECT @qid,'C','a ideia de trabalho na Antiguidade aproxima-se da ideia de penitência.'
  UNION ALL SELECT @qid,'D','a natureza do tempo é alguma coisa que se transforma historicamente.'
  UNION ALL SELECT @qid,'E','o relógio mecânico é uma invenção dos séculos VI e VII.'
) alts WHERE @ja_existe_23c = 0;

-- Q30
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto a seguir.

"A teoria política grega pode ser considerada uma abstração. A teoria política dos gregos era, basicamente, a reflexão a propósito da natureza da polis, dirigida como empreendimento intelectual autoconsciente, diverso – e em nível mais geral – do debate sobre matérias políticas específicas. A teoria política era, portanto, uma atividade secundária, a respeito do nível em que era tratado seu assunto."
(M. I. Finley, O legado da Grécia: uma nova avaliação. Brasília: Editora Universidade de Brasília, 1998. p.49. Adaptado)

A partir do excerto sobre a teoria política grega, pode-se afirmar que','Médio','Antiguidade clássica - teoria política grega','1ª Série EM','SARESP','B',6,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a teoria política grega era fortemente influenciada pelos romanos.' AS texto
  UNION ALL SELECT @qid,'B','o pensamento político versava sobre o funcionamento político das cidades.'
  UNION ALL SELECT @qid,'C','a reflexão sobre a vida na polis inexistia para os gregos.'
  UNION ALL SELECT @qid,'D','a teoria política grega não faz sentido para a posteridade.'
  UNION ALL SELECT @qid,'E','a vida política entre os gregos era tratada como uma atividade secundária.'
) alts WHERE @ja_existe_23c = 0;

-- Q31
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto a seguir.

"Duas gerações após o êxito final de Esparta, a derrota de Atenas na Guerra do Peloponeso, Esparta estava reduzida a uma cidade-Estado relativamente secundária. Os recursos territoriais e demográficos eram excessivamente escassos. Roma foi singular de um modo diferente porque era um implacável Estado de conquista desde o começo de sua história documentada. A combinação de, por um lado, aquisição territorial e contínua fixação de camponeses (cidadãos) nas terras confiscadas com, por outro lado, retenção de uma estrutura de cidade-estado e uma certa medida de participação popular no governo proporcionou um cunho peculiarmente romano a todos os aspectos de sua história, sociedade e política."
(M. I. FInley. A política no mundo antigo. Rio de Janeiro: Zahar, 1983. p. 80. Adaptado)

De acordo com o excerto,','Médio','Antiguidade clássica - Esparta e Roma','1ª Série EM','SARESP','C',6,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Atenas e Esparta eram cidades-Estados que compartilhavam língua, costumes e valores.' AS texto
  UNION ALL SELECT @qid,'B','Roma foi vencida por Esparta na Guerra do Peloponeso.'
  UNION ALL SELECT @qid,'C','Roma combinava a força da conquista a mecanismos de persuasão, que favoreciam a permanência dos povos conquistados no Império Romano.'
  UNION ALL SELECT @qid,'D','Esparta, como Roma, foi um poderoso Estado de conquista após sua vitória na Guerra do Peloponeso.'
  UNION ALL SELECT @qid,'E','Os romanos deram continuidade à política grega em todos os seus aspectos.'
) alts WHERE @ja_existe_23c = 0;

-- Q32
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto a seguir.

"Vários autores escreveram sobre a temática, no sentido de interrogar a ideia de América e a de América Latina. Tal temática pode ser pensada sob duas perspectivas: a da modernidade eurocêntrica e a da colonialidade. Na primeira, o quarto continente é interpretado como expansão do continente europeu; sua existência só se tornou possível com a chegada dos europeus, com o ''descobrimento''. Desse modo, povos como os kuhikugo, tuxanas, aruaques, tupis, guaranis, os habitantes dos impérios Inca, Asteca e Maia e tantos outros grupamentos humanos que habitavam essas terras, incluindo os povos africanos transportados, foram tomados como povos sem história. Já a perspectiva da colonialidade denuncia o colonialismo e permite interrogar sobre o apagamento da existência de outras dinâmicas de sociedade para dar lugar à imposição do modelo eurocêntrico, o que, consequentemente, fundamentou a produção dos argumentos de hierarquia racial e inferioridade dos povos colonizados."
(Cynthia Greive Veiga. Subalternidade e opressão sociorracial. São Paulo: Unesp, 2022. p.18. Adaptado)

Considerando as ideias expostas no texto, é correto afirmar que','Médio','América Latina - eurocentrismo e colonialidade','1ª Série EM','SARESP','E',6,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'os povos indígenas das Américas lutavam uns contra os outros, o que causou um apagamento de sua existência.' AS texto
  UNION ALL SELECT @qid,'B','os Incas, Astecas e Maias estavam espalhados por todo continente americano, incluindo o Brasil.'
  UNION ALL SELECT @qid,'C','os povos da América só devem ser considerados historicamente a partir da descoberta do continente pelos europeus.'
  UNION ALL SELECT @qid,'D','o Brasil, ao contrário dos demais povos da América Latina, não contou com visões de mundo que possam ser identificadas como racistas.'
  UNION ALL SELECT @qid,'E','a perspectiva de América como continuidade da Europa é uma construção narrativa, que traduz o intuito do colonialismo europeu.'
) alts WHERE @ja_existe_23c = 0;

-- Q33
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto a seguir.

"O Concílio de Trento, convocado pelo papa Paulo III, reunido pela primeira vez em 1545, não tinha a intenção de chegar à reconciliação com os protestantes. O principal objetivo do Concílio era fortalecer o catolicismo em áreas onde o protestantismo ainda não se estabelecera com firmeza, como a Itália. Seu propósito doutrinal era óbvio: esclarecer os ensinamentos da Igreja sobre a justificação, e manifestar-se sobre outros assuntos em que os protestantes haviam se afastado da ortodoxia católica. Com efeito, a pauta dos debates limitava-se às crenças postas em dúvida pelos protestantes."
(N. S. Davidson, A Contra-Reforma. São Paulo: Martins Fontes, 1991. p.10. Adaptado)

De acordo com o excerto, a chamada Contrarreforma foi um movimento que','Fácil','Idade Moderna - Contrarreforma','1ª Série EM','SARESP','A',6,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'procurou fortalecer o cristianismo tradicional católico, fortalecendo os aspectos considerados centrais da sua doutrina.' AS texto
  UNION ALL SELECT @qid,'B','procurou fundamentalmente afastar-se da ortodoxia católica.'
  UNION ALL SELECT @qid,'C','não se preocupava com o protestantismo, dado que este não se estabelecera em muitas áreas, como, por exemplo, a Itália.'
  UNION ALL SELECT @qid,'D','teve o Concílio de Trento como seu opositor.'
  UNION ALL SELECT @qid,'E','pretendia uma reconciliação com os protestantes.'
) alts WHERE @ja_existe_23c = 0;

-- Q34
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para responder à questão, considere o texto a seguir.

"Na sociedade feudal, o homem não ''desempenhava um papel''; era aquilo para que nascera. A divisão capitalista do trabalho e a abertura da hierarquia social tornaram possível, no entanto, que uma mesma pessoa ocupasse diferentes degraus da escada social; podia ser ativo em ramos completamente diferentes da divisão do trabalho, ser barbeiro num dia e escritor no dia seguinte e condottiere no terceiro, adotando formas de comportamento diferentes umas a seguir às outras e continuando, apesar disso, a ser o mesmo homem. Dado que cada lugar particular na estrutura social e cada ocupação particular produzia diferentes comportamentos e um conjunto diferente de direitos e obrigações, um mesmo homem podia identificar-se com diferentes comportamentos, diferentes conjuntos de direitos e obrigações e diferentes normas concretas, continuando, no entanto, a ser ''ele'' e não ''eles''. Como é óbvio, não foi apenas a extensão da divisão social do trabalho que provocou o aparecimento destes comportamentos em função do papel social. Para tal, o capitalismo nascente foi obrigado a dissolver todas as comunidades, de tal modo que o homem só pudesse afirmar-se com a mediação da posição por ele ocupada na divisão social do trabalho, de tal modo que o estatuto econômico (e não a humanidade como comunidade) pudesse tornar-se a norma universal."
(Agnes Heller. O homem do Renascimento. Lisboa: Presença, 1982.p.170. Adaptado)

De acordo com a perspectiva de Agnes Heller manifestada no excerto,','Difícil','Idade Moderna - Renascimento e capitalismo','1ª Série EM','SARESP','D',6,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'cada pessoa na Idade Moderna teria o rol de comportamentos, de atitudes e de valores que escolhesse enquanto indivíduo.' AS texto
  UNION ALL SELECT @qid,'B','o capitalismo nascente fortaleceu os elos comunitários.'
  UNION ALL SELECT @qid,'C','não há relação entre o Renascimento e a divisão social do trabalho.'
  UNION ALL SELECT @qid,'D','o homem do Renascimento pode ser compreendido a partir das mudanças econômicas e sociais daquela época.'
  UNION ALL SELECT @qid,'E','não há nenhuma dimensão econômica que se coloque como obstáculo às estratégias de ascensão social.'
) alts WHERE @ja_existe_23c = 0;

-- Q35
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A filosofia nascente rejeitava as interpretações míticas que, baseadas no sobrenatural, aceitavam a interferência de agentes divinos nos fenômenos da natureza. Ao buscarem a racionalidade do universo, os filósofos dessacralizam a natureza, isto é, retiram dela a dimensão do sagrado. A filosofia surge, então, como um pensamento reflexivo que busca a definição rigorosa dos conceitos, a coerência interna do discurso, a fim de possibilitar o debate e a discussão.
(Maria Lúcia de Arruda Aranha. Filosofia da Educação, 2003)

Analisando o excerto, dessacralizar a natureza significa','Médio','Filosofia - origem do pensamento filosófico','1ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'implementar a razão como explicação da natureza, sendo o mito a segurança para o avanço do pensamento filosófico.' AS texto
  UNION ALL SELECT @qid,'B','implantar um novo método de interpretação da natureza, com forte presença das crenças mitológicas.'
  UNION ALL SELECT @qid,'C','desmistificar o mundo com a presença da razão, fortalecendo os agentes divinos na explicação dos fenômenos.'
  UNION ALL SELECT @qid,'D','superar a explicação mitológica da natureza, reforçando a presença do sobrenatural na interpretação dos fenômenos.'
  UNION ALL SELECT @qid,'E','afastar os deuses da natureza, superando a explicação mitológica para os fenômenos da natureza.'
) alts WHERE @ja_existe_23c = 0;

-- Q36
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O senso comum é fragmentário, difuso e, num primeiro momento, não questionado, pois é um conhecimento ametódico e assistemático. […] Embora rigoroso e eficaz, o conhecimento científico é apenas uma das formas de conhecimento da realidade e, como tal, reduz a nossa experiência do mundo, que também se constitui de intuições, imaginação, crenças, emoções e afetividade.
(Maria Lúcia de Arruda Aranha. Filosofia da Educação, 2003)

A comparação entre o saber do senso comum e o conhecimento científico revela que','Médio','Filosofia - senso comum e conhecimento científico','1ª Série EM','SARESP','B',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o senso comum é uma intuição, enquanto a ciência é imaginativa e repleta de crenças.' AS texto
  UNION ALL SELECT @qid,'B','o senso comum é um saber passado de geração a geração, sendo a ciência um saber comprovado.'
  UNION ALL SELECT @qid,'C','o senso comum é um saber justificado racionalmente, enquanto o conhecimento científico é intuitivo.'
  UNION ALL SELECT @qid,'D','o senso comum é fragmentário, enquanto a ciência é assistemática.'
  UNION ALL SELECT @qid,'E','o senso comum é um saber comprovado, sendo a ciência um saber metódico e sistemático.'
) alts WHERE @ja_existe_23c = 0;

-- Q37
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT '[...] durante o tempo em que os homens vivem sem um poder comum capaz de os manter a todos em respeito, eles se encontram naquela condição a que se chama guerra; e uma guerra que é de todos os homens contra todos os homens.
(Thomas Hobbes. Leviatã, 1983)

O texto revela a condição do ser humano dentro do estado de natureza proposto por Hobbes. Segundo esse autor, essa condição revela','Médio','Filosofia política - Hobbes e o estado de natureza','1ª Série EM','SARESP','C',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'que os indivíduos nascem bons, mas a ambição os corrompe.' AS texto
  UNION ALL SELECT @qid,'B','a garantia da paz e a harmonia entre os seres humanos a partir da guerra de uns contra os outros.'
  UNION ALL SELECT @qid,'C','a fragilidade dos indivíduos sem a figura de um Estado que garanta a paz.'
  UNION ALL SELECT @qid,'D','a fragilidade da sociedade civil em vista do acordo entre os indivíduos.'
  UNION ALL SELECT @qid,'E','a subordinação de uns aos outros em harmonia garantido a paz.'
) alts WHERE @ja_existe_23c = 0;

-- Q38
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A questão é que a bioética desenvolve-se como um novo campo disciplinar, e é justamente impulsionada, pelo menos na perspectiva de Beauchamp e Childress, pela consideração de que a Ética tradicional, estando assentada em princípios muito abstratos, e por isso de difícil operacionalização, não poderia servir para fazer frente aos desafios de nossa sociedade científica-tecnológica. Impõe-se agora, esta a palavra de ordem, uma "ética aplicada". Parece, de fato, que os teóricos da bioética já não acreditam que a Ética filosófica clássica possa servir para orientar um comportamento moral na "civilização tecnológica". Eis uma primeira dificuldade a ser enfrentada.
(Solange Dejeannel. Os fundamentos da bioética e a teoria principialista. Thaumazein, 2011)

Acerca da comparação entre a bioética e a ética tradicional, pode-se afirmar que','Difícil','Filosofia - ética e bioética','1ª Série EM','SARESP','A',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a ética tradicional é desafiada por questões atuais que envolvem a vida, sendo necessário adaptar princípios que embasam decisões sobre o comportamento moral.' AS texto
  UNION ALL SELECT @qid,'B','a ética tradicional, fundamentada em seu saber abstrato, serve de base para a ampliação da bioética e sua formulação para novas aplicações no campo do comportamento moral.'
  UNION ALL SELECT @qid,'C','a bioética é um campo seguro do saber humano, caracterizada com fundamentos da ética tradicional, das principais correntes filosóficas, com regras claras que permitem tomadas de decisões.'
  UNION ALL SELECT @qid,'D','a ética tradicional está preparada para enfrentar as inovações no campo científico e tecnológico frente aos avanços da bioética e sua orientação voltada ao comportamento moral.'
  UNION ALL SELECT @qid,'E','a bioética é um campo abstrato e de difícil compreensão, sendo necessário uma ética aplicada com base nos fundamentos da ética tradicional, que pode garantir os avanços técnico-científicos.'
) alts WHERE @ja_existe_23c = 0;

-- Q39
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a tira "O Mundo de Tayó", de Mariana Lima. Nos quadrinhos, uma menina negra olha para um espelho e pensa: "EU GOSTO DE PENSAR QUE O ESPELHO É UMA PORTA ENCANTADA... AO ABRI-LA, SÓ UM POUQUINHO, EU PODEREI VER QUEM EU SOU; MAS, AO ABRI-LA UM TANTÃO!! EU PODEREI VER QUE ANTES DE MIM, OUTRAS COMO EU JÁ VIERAM!..." No último quadrinho, o espelho mostra, além dela, uma outra mulher negra, que a antecede.
(Mariana Lima. O Mundo de Tayó. Disponível em https://observatorio3setor.org.br/noticias/. Acesso em 04.08.2023)

Considerando a reflexão sobre a relação entre arte e cultura, a tirinha','Fácil','Cultura e identidade - ancestralidade','1ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'critica a capacidade da população negra em criar e recriar elementos culturais.' AS texto
  UNION ALL SELECT @qid,'B','evidencia uma visão preconceituosa sobre a cultura e a população afrodescendente.'
  UNION ALL SELECT @qid,'C','veicula uma mensagem de desesperança, ao opor a cultura ancestral e a jovem atual.'
  UNION ALL SELECT @qid,'D','expressa convicções religiosas preconceituosas ao retratar a cultura e a população negra.'
  UNION ALL SELECT @qid,'E','relata a valorização e autoestima da população negra a partir da sua ancestralidade.'
) alts WHERE @ja_existe_23c = 0;

-- Q40
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a tira "Manual do Minotauro", de Laerte (https://laerte.art.br/. Acesso em 10.08.2023). Em quatro quadrinhos, a mesma pessoa é mostrada em fases da vida, sempre deslizando por uma ladeira: primeiro, um bebê em uma cadeira alta; depois, uma criança estudando em uma carteira escolar; em seguida, um jovem diante de um computador; por fim, um adulto sentado em uma poltrona, segurando um aparelho eletrônico (celular ou controle remoto).

Ao representar o crescimento de uma pessoa do início do século XXI, a tira explicita','Médio','Sociedade contemporânea - tecnologia e cultura de massa','1ª Série EM','SARESP','B',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'uma atitude socialmente engajada, que busca confrontar os processos de educação e as fases da vida.' AS texto
  UNION ALL SELECT @qid,'B','um painel composto de imagens fragmentárias, que inclui menções ao progresso tecnológico, cultura de massa e a novos comportamentos sociais.'
  UNION ALL SELECT @qid,'C','um conjunto coeso de práticas de consumo, que alude ao acelerado desenvolvimento econômico do país.'
  UNION ALL SELECT @qid,'D','uma crítica à alienação da juventude, que despreza a formação educacional e a progresso tecnológico.'
  UNION ALL SELECT @qid,'E','uma análise crítica dos limites da modernização tecnológica, que havia sido interrompida após o salto ocorrido do século XX para o século XXI.'
) alts WHERE @ja_existe_23c = 0;

-- Q41
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

POR QUE O MUNDO TEME OS REFUGIADOS

Estas pessoas que estão vindo agora são refugiados que não são famintos, sem pão ou água. São pessoas que, ontem, tinham orgulho de seus lares, de suas posições na sociedade, que, frequentemente, tinham um alto grau de educação e assim por diante. Mas, agora eles são refugiados. E eles vêm para cá. Quem eles encontram aqui? O precariado. O precariado vive na ansiedade. No medo. Nós temos pesadelos. Tenho uma ótima posição social e quero mantê-la. "Precariado" vem da palavra francesa précarité que, em livre tradução, significa andar em areias movediças. Agora, surgem estas pessoas da Síria e da Líbia. Elas trazem esta ameaça de países distantes para nossas casas. De repente, eles aparecem ao nosso lado. Não conseguimos omitir suas presenças. Os refugiados simbolizam, personificam nossos medos. Ontem, eram pessoas poderosas em seus países. Felizes. Como nós somos aqui, hoje. Mas, veja o que aconteceu hoje. Eles perderam suas casas, perderam seus trabalhos. O choque está apenas começando. Não existem atalhos para o problema. Não existem soluções rápidas. Então, precisamos nos preparar para um tempo muito difícil que está chegando. Esta onda de imigração que aconteceu ano passado não foi a última. Há mais e mais pessoas esperando. Precisamos aceitar que esta é a situação. Vamos nos unir e encontrar uma solução.
(Zygmunt Bauman. Fronteiras, maio de 2018. Disponível em https://www.fronteiras.com/. Acesso em 14.05.2020. Adaptado)

No que diz respeito à questão dos refugiados na atualidade, assinale a alternativa correta.','Médio','Geopolítica - refugiados e migrações','1ª Série EM','SARESP','A',7,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'O fator mais influente nos fluxos migratórios é o econômico, ao forçar o deslocamento de pessoas à procura de trabalho e de boas condições de vida.' AS texto
  UNION ALL SELECT @qid,'B','Os fluxos migratórios revelam o desenvolvimento econômico dos países ocasionado pelo aumento de intercâmbio profissional entre nações.'
  UNION ALL SELECT @qid,'C','Os fluxos migratórios atualmente não são tratados como um problema, na verdade permitem combater o racismo estrutural.'
  UNION ALL SELECT @qid,'D','É uma política de Estado que possibilita às famílias de vários países buscar oportunidades de trabalho segundo suas preferências.'
  UNION ALL SELECT @qid,'E','Os fluxos migratórios são motivados por escolhas pessoais dos indivíduos, em busca de novas experiências de vida e aventuras.'
) alts WHERE @ja_existe_23c = 0;

-- Q42
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Globalização e estados nacionais

A insistência no uso de globalização traduz a intenção de apresentar a fase atual da economia mundial como aquela em que o mundo se apresenta sem fronteiras e as grandes empresas sem nacionalidades. Dessa forma, a globalização seria o estado "natural" da economia mundial quando as forças do mercado se encontram liberadas finalmente de seus entraves. Dada essa realidade, a única alternativa que restaria aos países que quisessem se integrar na "nova ordem" seria levar até as suas últimas consequências a liberalização e a desregulamentação, condição necessária para garantir competitividade. Para os trabalhadores tal inevitabilidade significa destruir os sistemas de proteção social e todas as formas que regulamentam o emprego e o salário. Afinal, no que consiste a globalização, ou, como dizem os franceses, com o rigor que lhes é próprio, a mundialização? Trata-se de um dado estágio de desenvolvimento do capitalismo, que se caracteriza por um aprofundamento da concentração do capital e de uma nova forma de organização das empresas, pela financeirização e pela fragmentação.
(Rosa Maria Marques. Globalização e Estados nacionais. Crítica Marxista, São Paulo, Brasiliense, v.1, n.3, 1996, p.136-139. Disponível em https://www.ifch.unicamp.br/. Acesso em 11.08.2023. Adaptado)

De acordo com o texto, é correto afirmar que','Difícil','Globalização e Estados nacionais','1ª Série EM','SARESP','D',7,2,NULL,TRUE
WHERE @ja_existe_23c = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'inexiste relação direta entre globalização e Estados Nacionais, pois estes últimos se preservam por meio de mecanismos de defesa originários e totalitários.' AS texto
  UNION ALL SELECT @qid,'B','em virtude da presença dos Estados Nacionais, a tendência de homogeneização própria à globalização deve ser relativizada.'
  UNION ALL SELECT @qid,'C','os Estados Nacionais possuem total autonomia quanto à globalização, por isso não sofrem reflexos deste processo.'
  UNION ALL SELECT @qid,'D','apesar da resistência dos Estados Nacionais, a globalização resulta em homogeneização severa em todos os países que atinge.'
  UNION ALL SELECT @qid,'E','a globalização é um processo que atinge e subverte todos os Estados Nacionais, que tendem ao desaparecimento com construção política moderna.'
) alts WHERE @ja_existe_23c = 0;
