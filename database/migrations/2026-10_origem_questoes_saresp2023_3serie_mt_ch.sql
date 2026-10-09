-- ==========================================================
--  Migração de conteúdo: Banco de questões SARESP 2023 — 3ª Série EM
--  Caderno 018-MT-CH-Redação (Matemática + Ciências Humanas + Redação), Cad01,
--  aplicado como Provão Paulista Seriado 2023 (30.11.2023) — Versão 1.
--  Fonte: caderno de questões + gabarito oficial (Fundação Vunesp) fornecidos pela coordenação.
--  ----------------------------------------------------------
--  Origem das questões: SARESP (coluna questoes.origem, criada pela
--  migração 2026-10_origem_questoes.sql — por isso este arquivo vem depois dela).
--
--  Escopo: as 42 questões objetivas do caderno foram importadas. A proposta de
--  Redação (tema: "O combate à fome no Brasil: entre a responsabilidade do Estado
--  e a atuação da sociedade civil") não é questão objetiva e não foi cadastrada.
--  Nas questões 4, 6, 8, 9, 10, 11, 15, 16, 20, 22, 24, 26, 27 e 32, a figura/
--  gráfico/mapa/charge foi descrito em texto no enunciado.
--
--  Atenção: no caderno impresso, as alternativas (D) e (E) da questão 29 têm o
--  mesmo texto; foram mantidas como estão (gabarito oficial: B).
--
--  Usa as disciplinas "Filosofia" e "Sociologia" (Ciências Humanas); o INSERT
--  abaixo as garante caso ainda não existam.
--
--  Gabarito: Versão 1 do gabarito oficial (Cad01).
--
--  Idempotente: variável de sessão travada no início (@ja_existe_23f), sem
--  DELIMITER/stored procedures (incompatível com a execução via db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-10_origem_questoes_saresp2023_3serie_mt_ch.sql)
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
SET @ja_existe_23f := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'O preço da saca de feijão%'
);


-- Q01
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O preço da saca de feijão nos meses de julho, agosto, setembro e outubro foi de 200 reais, 220 reais, 270 reais e 250 reais, respectivamente. Qual foi o preço médio da saca de feijão nos meses de julho a outubro?','Fácil','Estatística - média aritmética','3ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'245 reais.' AS texto
  UNION ALL SELECT @qid,'B','230 reais.'
  UNION ALL SELECT @qid,'C','240 reais.'
  UNION ALL SELECT @qid,'D','225 reais.'
  UNION ALL SELECT @qid,'E','235 reais.'
) alts WHERE @ja_existe_23f = 0;

-- Q02
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Ana recebeu uma carta e quer guardá-la em uma caixinha que tem 7 cm de largura, 7 cm de comprimento e 2 cm de altura. Ela irá dobrar a carta sempre ao meio até conseguir um tamanho que caiba na caixinha.

Sabendo que a carta é uma folha de papel quadrada de lado 24 cm e espessura 1 mm, qual é a quantidade mínima de dobras que Ana deve fazer para conseguir colocar a carta na caixinha?','Médio','Potências de 2 - dobras de papel','3ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'6.' AS texto
  UNION ALL SELECT @qid,'B','4.'
  UNION ALL SELECT @qid,'C','2.'
  UNION ALL SELECT @qid,'D','3.'
  UNION ALL SELECT @qid,'E','5.'
) alts WHERE @ja_existe_23f = 0;

-- Q03
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O balancete do total de vendas de uma loja, em um determinado mês, está apresentado na tabela a seguir:
- Blusa: valor unitário R$ 45,00; quantidade vendida 100.
- Calça: valor unitário R$ 80,00; quantidade vendida 50.
- Vestido: valor unitário R$ 60,00; quantidade vendida 60.

De acordo com os dados, ao analisar a quantidade de produtos vendidos e o valor total arrecadado com a venda de cada produto, pode-se afirmar que','Fácil','Interpretação de tabela - valor total','3ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o valor total arrecadado com a venda de todos os itens foi de R$12.000,00.' AS texto
  UNION ALL SELECT @qid,'B','o valor obtido com a venda de vestidos foi maior que o valor obtido com a venda de blusas.'
  UNION ALL SELECT @qid,'C','o valor obtido com a venda das blusas representou menos da metade do total arrecadado.'
  UNION ALL SELECT @qid,'D','a quantidade total de itens vendidos foi de 185.'
  UNION ALL SELECT @qid,'E','o item que mais contribuiu para o valor total das vendas foi a calça.'
) alts WHERE @ja_existe_23f = 0;

-- Q04
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere o gráfico a seguir, que representa a parábola y = ax² + bx + c. A parábola tem concavidade para cima, corta o eixo x nos pontos de abscissas −5 e 2, e corta o eixo y no ponto de ordenada −5.

Qual é o valor de a + b + c?','Médio','Função quadrática - gráfico','3ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'2.' AS texto
  UNION ALL SELECT @qid,'B','5.'
  UNION ALL SELECT @qid,'C','−3.'
  UNION ALL SELECT @qid,'D','−8.'
  UNION ALL SELECT @qid,'E','−10.'
) alts WHERE @ja_existe_23f = 0;

-- Q05
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considere a sequência a₁, a₂, ..., aₙ, ... dada por: a₁ = 1, a₂ = 2 e, se n ≥ 3, aₙ = resto da divisão de n por 3.

Sabendo que a soma dos k primeiros termos da sequência é igual a 31, qual é o valor de k?','Médio','Sequências - resto da divisão','3ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'12.' AS texto
  UNION ALL SELECT @qid,'B','42.'
  UNION ALL SELECT @qid,'C','53.'
  UNION ALL SELECT @qid,'D','31.'
  UNION ALL SELECT @qid,'E','21.'
) alts WHERE @ja_existe_23f = 0;

-- Q06
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A figura a seguir apresenta um retângulo de dimensões 8 cm × 10 cm e dois triângulos iguais cuja altura mede x cm. Os dois triângulos ficam lado a lado, na base inferior do retângulo (de 8 cm), dividindo-a em duas partes iguais, cada uma sendo a base de um dos triângulos; a altura x de cada triângulo é medida a partir da base. A região hachurada é o retângulo sem os dois triângulos.

Sabendo que a área da região hachurada é 64 cm², pode-se concluir que o valor de x, em cm, é igual a','Médio','Geometria plana - áreas','3ª Série EM','SARESP','A',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'4.' AS texto
  UNION ALL SELECT @qid,'B','5.'
  UNION ALL SELECT @qid,'C','3.'
  UNION ALL SELECT @qid,'D','6.'
  UNION ALL SELECT @qid,'E','7.'
) alts WHERE @ja_existe_23f = 0;

-- Q07
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT '"A Amazônia surge como solução para o enfrentamento de crises que vão desde a mudança climática, desmatamento e poluição até a perda de ecossistemas. Com 75% da população vivendo em áreas urbanas na região, a missão de garantir um desenvolvimento com sustentabilidade se torna cada vez maior e surge a necessidade de promover ações estruturantes para uma transição econômica justa, considerando os efeitos da mudança do clima e a busca por soluções e estratégias para fortalecer a socio bioeconomia e as populações locais."
(https://www.unep.org. Acesso em: 28.09.2023. Adaptado)

Considerando que a população da Amazônia é formada por 28 milhões de habitantes, é correto afirmar que, segundo a reportagem, a quantidade de habitantes desta região que vive em área urbana é de','Fácil','Porcentagem','3ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'13 milhões.' AS texto
  UNION ALL SELECT @qid,'B','21 milhões.'
  UNION ALL SELECT @qid,'C','7 milhões.'
  UNION ALL SELECT @qid,'D','19 milhões.'
  UNION ALL SELECT @qid,'E','24 milhões.'
) alts WHERE @ja_existe_23f = 0;

-- Q08
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A figura a seguir representa o gráfico de uma reta, decrescente, que corta o eixo y no ponto de ordenada 2 e passa pelo ponto de coordenadas (1, −1).

A partir dos dados, pode-se afirmar que o valor da inclinação da reta é igual a','Fácil','Geometria analítica - coeficiente angular','3ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'−1.' AS texto
  UNION ALL SELECT @qid,'B','−2.'
  UNION ALL SELECT @qid,'C','2.'
  UNION ALL SELECT @qid,'D','−3.'
  UNION ALL SELECT @qid,'E','3.'
) alts WHERE @ja_existe_23f = 0;

-- Q09
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na figura, o triângulo ABC é retângulo, com ângulo reto no vértice B, possuindo área igual a 24 cm², e o quadrilátero DEFG é um retângulo de área igual a 12 cm², com E e D na hipotenusa AC, F no lado AB e G no lado BC. A região hachurada é formada pelos triângulos AEF e GDC.

Sabendo que AF = FB = x + 1 e BG = GC = x, a área hachurada é igual a','Difícil','Geometria plana - áreas e pontos médios','3ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'3 cm².' AS texto
  UNION ALL SELECT @qid,'B','4 cm².'
  UNION ALL SELECT @qid,'C','5 cm².'
  UNION ALL SELECT @qid,'D','2 cm².'
  UNION ALL SELECT @qid,'E','6 cm².'
) alts WHERE @ja_existe_23f = 0;

-- Q10
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Será construído um teleférico para ligar uma praça ao topo de um morro. No esquema, a praça é representada pelo ponto A e o topo do morro pelo ponto C (vértice da parábola, sobre o eixo y). O ponto B está situado sobre o eixo y, a 10 metros de distância de C. O ponto D representa o pé do morro (raiz positiva da parábola) e está situado a uma distância de 920 metros de A. O cabo do teleférico é o segmento de reta que liga os pontos A e B. O perfil do morro é descrito pela parábola y = −x²/160 + 490.

Qual o comprimento do cabo do teleférico?','Difícil','Função quadrática e Pitágoras - teleférico','3ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'1200 m.' AS texto
  UNION ALL SELECT @qid,'B','1300 m.'
  UNION ALL SELECT @qid,'C','1100 m.'
  UNION ALL SELECT @qid,'D','1000 m.'
  UNION ALL SELECT @qid,'E','1400 m.'
) alts WHERE @ja_existe_23f = 0;

-- Q11
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As figuras representam uma mesma bicicleta com rodas circulares de raio de 24 cm que se desloca sobre uma reta tangente às rodas. O ponto C representa o centro da roda e P um ponto fixo pertencente à roda. Os pontos A e B pertencem à reta e a distância entre eles é de 22π cm. Conforme a bicicleta anda, a roda dianteira toca o ponto A e depois o ponto B.

Sabendo que, ao passar pelo ponto A, o ângulo ACP é igual a 45º, qual será o ângulo BCP quando a roda dianteira passar pelo ponto B?','Difícil','Trigonometria - arco e ângulo','3ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'150º' AS texto
  UNION ALL SELECT @qid,'B','165º'
  UNION ALL SELECT @qid,'C','120º'
  UNION ALL SELECT @qid,'D','135º'
  UNION ALL SELECT @qid,'E','90º'
) alts WHERE @ja_existe_23f = 0;

-- Q12
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma sala de 20 alunos realizou uma prova de Matemática. A nota média da turma foi 6. Sabe-se que a média das cinco piores notas foi 3. Qual foi a média das notas do restante da turma?','Fácil','Estatística - média ponderada','3ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'6.' AS texto
  UNION ALL SELECT @qid,'B','7.'
  UNION ALL SELECT @qid,'C','4.'
  UNION ALL SELECT @qid,'D','5.'
  UNION ALL SELECT @qid,'E','8.'
) alts WHERE @ja_existe_23f = 0;

-- Q13
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um time de vôlei amador conta com 10 jogadores, sendo que todos se dispõem a jogar em qualquer posição. O time que inicia a partida é composto por 6 jogadores.

Tendo todos à disposição, de quantas maneiras distintas o técnico desse time pode escolher os jogadores para montar o time que iniciará uma partida?','Fácil','Análise combinatória - combinação','3ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'60.' AS texto
  UNION ALL SELECT @qid,'B','72.'
  UNION ALL SELECT @qid,'C','420.'
  UNION ALL SELECT @qid,'D','720.'
  UNION ALL SELECT @qid,'E','210.'
) alts WHERE @ja_existe_23f = 0;

-- Q14
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para quais valores de x e y vale que 18ˣ · 24ʸ = 6¹⁰?','Médio','Equações exponenciais','3ª Série EM','SARESP','A',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'x = 4, y = 2.' AS texto
  UNION ALL SELECT @qid,'B','x = 2, y = 4.'
  UNION ALL SELECT @qid,'C','x = 3, y = 6.'
  UNION ALL SELECT @qid,'D','x = 2, y = 3.'
  UNION ALL SELECT @qid,'E','x = 4, y = 3.'
) alts WHERE @ja_existe_23f = 0;

-- Q15
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A figura ilustra uma circunferência de raio 5 cm e centro O, com um triângulo ABC inscrito, em que o lado AC é um diâmetro da circunferência (passa pelo centro O). O comprimento do segmento que liga os pontos A e B é 8 cm.

Qual é o valor do comprimento do segmento que liga os pontos B e C?','Médio','Circunferência - triângulo inscrito','3ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'3 cm.' AS texto
  UNION ALL SELECT @qid,'B','5 cm.'
  UNION ALL SELECT @qid,'C','4 cm.'
  UNION ALL SELECT @qid,'D','6 cm.'
  UNION ALL SELECT @qid,'E','7 cm.'
) alts WHERE @ja_existe_23f = 0;

-- Q16
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O gráfico de barras representa o lucro mensal de uma empresa durante o ano de 2022 (valores lidos no gráfico, em reais): Jan 25.000; Fev 10.000; Mar 25.000; Abr 10.000; Mai 20.000; Jun 15.000; Jul 20.000; Ago 25.000; Set 25.000; Out 25.000; Nov 20.000; Dez 30.000.

O valor da mediana do lucro mensal dessa empresa é','Fácil','Estatística - mediana','3ª Série EM','SARESP','B',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'R$ 20.000,00.' AS texto
  UNION ALL SELECT @qid,'B','R$ 22.500,00.'
  UNION ALL SELECT @qid,'C','R$ 15.000,00.'
  UNION ALL SELECT @qid,'D','R$ 17.500,00.'
  UNION ALL SELECT @qid,'E','R$ 25.000,00.'
) alts WHERE @ja_existe_23f = 0;

-- Q17
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em qual dos intervalos a seguir é verdade que cos(2θ) > √3/2?','Médio','Trigonometria - inequação','3ª Série EM','SARESP','D',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'30º ≤ θ < 45º' AS texto
  UNION ALL SELECT @qid,'B','15º ≤ θ < 30º'
  UNION ALL SELECT @qid,'C','45º ≤ θ < 60º'
  UNION ALL SELECT @qid,'D','0º ≤ θ < 15º'
  UNION ALL SELECT @qid,'E','60º ≤ θ < 90º'
) alts WHERE @ja_existe_23f = 0;

-- Q18
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um jogo consiste em lançar um dado honesto de 6 faces, numeradas de 1 a 6, por três vezes seguidas. Cada três lançamentos equivalem a uma rodada. O jogador vence o jogo quando conseguir tirar o número 6 duas vezes consecutivas em uma rodada. Qual é a probabilidade de o jogador vencer o jogo na primeira rodada?','Médio','Probabilidade - lançamentos de dado','3ª Série EM','SARESP','C',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'13/216' AS texto
  UNION ALL SELECT @qid,'B','14/216'
  UNION ALL SELECT @qid,'C','11/216'
  UNION ALL SELECT @qid,'D','12/216'
  UNION ALL SELECT @qid,'E','10/216'
) alts WHERE @ja_existe_23f = 0;

-- Q19
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um poliedro convexo de 10 vértices é formado por 2 pentágonos e 10 triângulos. Com base na fórmula de Euler, V − A + F = 2, em que V é o número de vértices, F o de faces e A o de arestas, qual é a quantidade de arestas desse poliedro?','Médio','Geometria espacial - relação de Euler','3ª Série EM','SARESP','A',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'20.' AS texto
  UNION ALL SELECT @qid,'B','22.'
  UNION ALL SELECT @qid,'C','24.'
  UNION ALL SELECT @qid,'D','26.'
  UNION ALL SELECT @qid,'E','28.'
) alts WHERE @ja_existe_23f = 0;

-- Q20
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A aranha constrói sua teia fazendo primeiro os raios, em seguida preenche a teia com arestas ligando os raios, chamadas de amarrações. A figura representa uma teia com seis raios, formando amarrações em forma de hexágonos concêntricos.

Nesta teia, os ângulos entre os raios são iguais e as amarrações que ligam os mesmos dois raios são paralelas. Suponha que as seis primeiras amarrações são construídas a partir de um ponto no raio que está a uma distância de 2 mm do centro da teia e que as amarrações seguintes que ligam os mesmos raios são construídas a partir de pontos no raio que estão separados por 1 mm de distância.

Usando a aproximação √3 = 1,7, quantas amarrações a aranha deverá fazer para construir uma teia de 2,55 cm²?','Difícil','Progressão aritmética e áreas - teia de aranha','3ª Série EM','SARESP','E',2,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'60.' AS texto
  UNION ALL SELECT @qid,'B','70.'
  UNION ALL SELECT @qid,'C','45.'
  UNION ALL SELECT @qid,'D','84.'
  UNION ALL SELECT @qid,'E','54.'
) alts WHERE @ja_existe_23f = 0;

-- Q21
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Pesquisadores da Universidade de Washington, nos Estados Unidos, alertaram sobre o problema da ''FakeGeo'', que pode ser traduzida por ''geografia falsa''. Esse problema consiste na geração de imagens falsas de satélites por Inteligência Artificial, que alteram os elementos físicos e humanos que compõem uma determinada paisagem.
(https://canaltech.com.br, Acesso em 07/10/2023. Adaptado)

A preocupação com as ''FakeGeo'' se justifica porque','Fácil','Geografia - tecnologia e informação (FakeGeo)','3ª Série EM','SARESP','C',7,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'disseminam a geolocalização dos elementos naturais que são preservados pela ação antrópica.' AS texto
  UNION ALL SELECT @qid,'B','impulsionam a criatividade das sociedades para cartografar uma bacia hidrográfica de um país em um outro local.'
  UNION ALL SELECT @qid,'C','propagam dados falsos com modificações das formas do relevo, do curso do rio ou mesmo construções urbanas.'
  UNION ALL SELECT @qid,'D','instrumentalizam a liberdade dos usuários para que possam representar o espaço geográfico, segundo suas próprias opiniões.'
  UNION ALL SELECT @qid,'E','difundem informações imprecisas sobre os elementos da natureza para representar a homogeneidade dos lugares.'
) alts WHERE @ja_existe_23f = 0;

-- Q22
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Examine o gráfico que corresponde a evolução da cobertura vegetal do estado de São Paulo, em hectares (ha), no período de 1971 a 2020. A série 1 (linha pontilhada) vai de 1.082.640 ha (1971/73) para 285.555 (1990/92), 202.056 (2000), 217.557 (2010) e 239.312 (2020). A série 2 (linha contínua) vai de 3.311.010 ha (1971/73) para 3.045.189 (1990/92), 3.255.887 (2000), 4.122.923 (2010) e 5.431.220 (2020).
(https://revistapesquisa.fapesp.br, Acesso em 08.10.2023. Adaptado)

O exame do gráfico e o que se sabe sobre a ocorrência dos biomas no estado de São Paulo permite afirmar que os números 1 e 2 correspondem, respectivamente,','Médio','Biomas - cobertura vegetal de São Paulo','3ª Série EM','SARESP','B',7,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'às Pradarias e à Mata Atlântica.' AS texto
  UNION ALL SELECT @qid,'B','ao Cerrado e à Mata Atlântica.'
  UNION ALL SELECT @qid,'C','ao Cerrado e às Pradarias.'
  UNION ALL SELECT @qid,'D','às Restingas e à Floresta Tropical.'
  UNION ALL SELECT @qid,'E','às Pradarias e à Mata das Araucárias.'
) alts WHERE @ja_existe_23f = 0;

-- Q23
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Ainda é cedo para saber o quanto essa tecnologia transformará a vida das pessoas. É certo que ela abre uma fronteira de novas aplicações, prometendo reinventar desde mecanismos de busca on-line a assistentes de voz, como Alexa e Siri, e permitindo que pessoas conversem com computadores e outros dispositivos eletrônicos como se estivessem falando com humanos.
(Rodrigo de Oliveira Andrade. ChatGPT inaugura uma nova era na interação entre seres humanos e computadores. Revista Pesquisa FAPESP. 2023)

Considerando o excerto, a condição em que vivemos atualmente é melhor explicada como sendo resultado','Médio','Geografia - meio técnico-científico-informacional','3ª Série EM','SARESP','D',7,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'da desorganização espacial, que ocorre desde a Revolução Industrial, que provocou a diminuição dos processos de produção e circulação de mercadorias.' AS texto
  UNION ALL SELECT @qid,'B','da garantia da plena igualdade de acesso aos bens e serviços tecnológicos, que culminou com investimentos em pesquisa, ciência e inovação em escala mundial.'
  UNION ALL SELECT @qid,'C','das transformações causadas pela inteligência artificial, que ocorre desde a primeira Revolução Industrial, que provocou a compressão da relação espaço-tempo.'
  UNION ALL SELECT @qid,'D','da transição da sociedade industrial para a sociedade do conhecimento, que ocorre desde a década de 1970, que impactou na evolução do meio técnico científico informacional.'
  UNION ALL SELECT @qid,'E','das mudanças decorrentes no meio técnico, que implicaram na valorização do conhecimento tecnológico e desvalorização do conhecimento científico.'
) alts WHERE @ja_existe_23f = 0;

-- Q24
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise o mapa que representa os países com clubes de futebol administrados pela empresa City Football Group, em 2023. Pela legenda, os clubes estão nas Américas (Uruguai - Montevideo City Torque, 2020; Bolívia - Fútbol Club Bolívar, 2021; Estados Unidos - New York City, 2013; Brasil - Esporte Clube Bahia, 2023), na Europa (Espanha - Girona Fútbol Club, 2017; França - Espérance Sportive Troyes Aube Champagne, 2020; Bélgica - Lommel SK, 2020; Inglaterra - Manchester City, 2008; Itália - Palermo Football Club, 2022), na Ásia (Índia - Mumbai City Football Club, 2019; China - Sichuan Jiuniu Football Club, 2019; Japão - Yokohama F. Marinos, 2014) e na Oceania (Melbourne City Football Club, 2014).
(Iran Simões Santos et. al. Futebol, negócio e globalização. Revista do Departamento de Geografia, 2023. Adaptado)

A análise do mapa e o que se sabe sobre o processo de globalização permitem afirmar que o futebol','Médio','Globalização - futebol e capital financeiro','3ª Série EM','SARESP','E',7,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'valoriza a produção e a distribuição da riqueza gerada por grupos financeiros nos espaços nacionais, que permitem a participação democrática dos torcedores nas decisões esportivas dos clubes.' AS texto
  UNION ALL SELECT @qid,'B','assegura a apropriação igualitária do espaço esportivo mundial ao ser administrado por corporações transnacionais, que passam a atuar na defesa do interesse coletivo e na promoção de políticas públicas nos países onde operam.'
  UNION ALL SELECT @qid,'C','proporciona grandes operações de créditos nos países em desenvolvimento ao atuar no sistema financeiro mundial, que contribuem para valorizar os clubes menores e fortalecer a circulação de atletas dentro do mesmo continente.'
  UNION ALL SELECT @qid,'D','impulsiona o desenvolvimento dos países de industrialização tardia ao incluir grupos financeiros e investidores individuais nas operações das bolsas de valores, que possibilita atrair créditos internacionais aos clubes.'
  UNION ALL SELECT @qid,'E','assume uma nova forma de organização ao ser operado por grupos financeiros e indivíduos, que compram clubes e estabelecem estratégias de gestão centralizadas a partir de uma rede internacional de investimentos.'
) alts WHERE @ja_existe_23f = 0;

-- Q25
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um relatório recente do Painel Intergovernamental da ONU (IPCC), do ano de 2019, gerou muita discussão. Neste relatório, os cientistas do IPCC defenderam estar profundamente confiantes de que

"Dietas balanceadas, com alimentos à base de plantas, como grãos, leguminosas, frutas e vegetais, nozes e sementes, e alimentos de origem animal produzidos de forma sustentável e com baixa emissão de gases de efeito estufa, apresentam grandes oportunidades para adaptação e mitigação dos riscos das mudanças climáticas enquanto gera benefícios significativos em termos de saúde humana".
(Tradução livre de trecho do relatório "Climate Change and Land" organizado pelo IPCC, 2020)

Um argumento que corrobora a ideia defendida por estes cientistas é o de que','Médio','Geografia - agricultura e mudanças climáticas','3ª Série EM','SARESP','E',7,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a implementação de políticas agrícolas que favorecem o uso de defensivos químicos amplia as práticas de manejo voltadas à biodiversidade de espécies polinizadoras.' AS texto
  UNION ALL SELECT @qid,'B','a produção de carne bovina em áreas de pastagens reduz as emissões do gás metano associadas ao processo digestivo dos animais.'
  UNION ALL SELECT @qid,'C','a substituição de sistemas agrícolas monocultores pelo agronegócio amplia a disponibilidade de alimentos dos países subdesenvolvidos e promove a erradicação da fome.'
  UNION ALL SELECT @qid,'D','a adoção dos mecanismos de compostagem e beneficiamento de grãos reduz o desperdício de alimentos de origem agrícola comercializados no mercado nacional.'
  UNION ALL SELECT @qid,'E','o consumo de alimentos produzidos localmente e da estação reduz as emissões de combustíveis fósseis associadas ao transporte e à armazenagem refrigerada.'
) alts WHERE @ja_existe_23f = 0;

-- Q26
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise o mapa do continente africano, no qual a "Muralha Verde" é uma faixa que atravessa o continente de oeste a leste, do Senegal a Djibouti, passando por Mauritânia, Mali, Burkina Faso, Níger, Nigéria, Chade, Sudão, Etiópia e Somália, ao sul do deserto do Saara.
(www.researchgate.net, Acesso em 08/10/2023. Adaptado)

A implantação da muralha verde no continente africano tem como causa e consequência, respectivamente,','Médio','Geografia da África - Muralha Verde','3ª Série EM','SARESP','C',7,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a restrição do avanço do deserto do Kalahari e a ampliação das áreas úmidas ao agronegócio nas comunidades locais.' AS texto
  UNION ALL SELECT @qid,'B','a redução do avanço do deserto do Saara e a geração de empregos no setor secundário das comunidades locais.'
  UNION ALL SELECT @qid,'C','a limitação do avanço do deserto do Saara e ampliação das áreas agricultáveis nas comunidades locais.'
  UNION ALL SELECT @qid,'D','a dilatação do avanço do Sahel e a transformação climática produzida pelo plantio de árvores nas comunidades locais.'
  UNION ALL SELECT @qid,'E','a contenção do avanço do Sahel e a reversão da fertilidade dos solos nas comunidades locais.'
) alts WHERE @ja_existe_23f = 0;

-- Q27
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise o tuíte publicado pelo Instituto Brasileiro de Geografia e Estatística (IBGE) em 01.10.2023: "Você sabia que o número de pessoas que se dedicavam a cuidados de moradores de 60 anos ou mais cresceu em 2022?". O gráfico mostra as pessoas de 14 anos ou mais de idade que realizaram cuidados de moradores (do mesmo domicílio do cuidador) de 60 anos ou mais, Brasil, 2019/2022: 4,5 milhões em 2019 (8,8%) e 5,3 milhões em 2022 (11,6%). Fonte: IBGE - Pesquisa Nacional por Amostra de Domicílios - 5ª visita.
(https://twitter.com. Adaptado)

O contexto da dinâmica demográfica do Brasil desse tuíte se relaciona','Médio','Demografia - envelhecimento populacional','3ª Série EM','SARESP','A',7,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à transformação da pirâmide etária, marcada pela redução das taxas de fecundidade e natalidade com a elevação do percentual de pessoas idosas.' AS texto
  UNION ALL SELECT @qid,'B','ao engajamento dos jovens na realização de trabalho voluntário, em virtude da estagnação da população economicamente ativa (PEA).'
  UNION ALL SELECT @qid,'C','ao processo de aceleração do crescimento vegetativo e absoluto, representado pelo aumento do envelhecimento da população.'
  UNION ALL SELECT @qid,'D','à demanda do trabalho informal doméstico, em decorrência da elevação da razão de dependência dos jovens e dos idosos.'
  UNION ALL SELECT @qid,'E','à geração da explosão demográfica, em virtude da ampliação do porcentual da faixa etária de jovens e o aumento do tempo médio de vida no país.'
) alts WHERE @ja_existe_23f = 0;

-- Q28
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

A grande contribuição da noção de Antiguidade Tardia é ter situado a instalação dos bárbaros no Ocidente menos em termos de fim do mundo romano do que de um rearranjo de forças que conduziu à constituição de um mundo ainda marcado pela influência da românia, mas profundamente original. (...) De fato, a deposição do imperador Rômulo Augusto, em 476, não pôs fim à influência que as tradições romanas exerciam sobre aquela região.
(Marcelo Cândido da Silva. Entre "Antiguidade Tardia" e "Alta Idade Média". Diálogos. DHI/PPH/UEM, v. 12, n. 2/n.3, 2008, p. 58-59. Adaptado)

Considerando o texto, a respeito da Queda de Roma em 476 d.C, é correto afirmar que','Médio','Idade Antiga e Média - Antiguidade Tardia','3ª Série EM','SARESP','D',6,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a ruína do Império Romano, ocorrida a partir de 476 d.C, esteve associada à rápida e acentuada decadência do Império Bizantino.' AS texto
  UNION ALL SELECT @qid,'B','o Império Romano, ao longo do século V, prosseguiu na conquista de territórios e escravizados, o que gerou ameaças às suas instituições políticas.'
  UNION ALL SELECT @qid,'C','os povos bárbaros, por se encontrarem em um estágio de civilização primitivo, não tiveram papel relevante nesse processo.'
  UNION ALL SELECT @qid,'D','o período medieval foi marcado por trocas culturais entre a cultura romana e a dos chamados povos bárbaros.'
  UNION ALL SELECT @qid,'E','as migrações e invasões de povos bárbaros resultaram em um processo de trocas culturais que enfraqueceu e fez desaparecer a cultura romana.'
) alts WHERE @ja_existe_23f = 0;

-- Q29
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Uma certa imagem da migração, vista como um movimento desordenado, "irracional", feito às pressas, não corresponde à experiência de grande parte dos migrantes. A mudança, decisiva para a vida dos envolvidos, era, na maior parte das vezes, meticulosamente preparada tanto no âmbito familiar quanto no da comunidade.
Informações sobre São Paulo, suas oportunidades de emprego e possibilidades de moradia eram fundamentais para a decisão de migrar e o estabelecimento de uma rede de comunicação entre os migrantes e seus locais de origem frequentemente orientava o processo migratório. Correspondências, fotos, cartões-postais tinham papel importante no fornecimento de dados e criação de um imaginário cultural do local de destino.
(Paulo Fontes. Um Nordeste em São Paulo: trabalhadores migrantes em São Miguel Paulista (1945-1966). Rio de Janeiro: FGV, 2008. 348 p. pg. 55. Adaptado)

Entre os anos 1940-1960, a migração de trabalhadores para o estado de São Paulo','Médio','História de São Paulo - migrações (1940-1960)','3ª Série EM','SARESP','B',6,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'aconteceu num período de decrescente industrialização e urbanização paulistas.' AS texto
  UNION ALL SELECT @qid,'B','ocorreu baseada em decisões racionais em busca de oportunidades de trabalho e laços de apoio.'
  UNION ALL SELECT @qid,'C','se fundamentou em imagens enganosas e incentivada pela fuga da seca e dos coronéis.'
  UNION ALL SELECT @qid,'D','deu origem ao grande contingente de populações sem-teto que hoje se encontram principalmente na capital paulista.'
  UNION ALL SELECT @qid,'E','deu origem ao grande contingente de populações sem-teto que hoje se encontram principalmente na capital paulista.'
) alts WHERE @ja_existe_23f = 0;

-- Q30
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Em suas memórias sobre a Convenção de Itu, no dia 18 de abril de 1873, anotou José Vasconcellos:

Desde muito antes da abertura da sessão, o sobrado estava completamente cheio de republicanos e de curiosos. Tivemos receio que o soalho afundasse. Não se podia entrar nem subir, tal era a aglomeração de gente. Em cima, à porta que dava ingresso a sala de reunião, o livro de presença para os que fossem republicanos ou quisessem batizar-se como tais, naquela data. Foi uma bela festa cívica.
(citado por Afonso E. TAUNAY, Solenização do Cincoentenário da Convenção de Itu, realizada a 18 de abril de 1923 com a instalação do Museu Republicano "Convenção de Itu" pelo Governo do Estado de São Paulo a 18 de abril de 1923. São Paulo: Companhia Melhoramentos, 1923. p. 76)

A Convenção de Itu foi','Médio','Brasil Império - Convenção de Itu','3ª Série EM','SARESP','C',6,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'um movimento para aqueles que queriam ser reconhecidos como republicanos para manifestarem a sua intenção de fortalecer o Império.' AS texto
  UNION ALL SELECT @qid,'B','a inauguração do Museu Republicano de Itu e o tombamento de seu acervo de documentos e cultura material.'
  UNION ALL SELECT @qid,'C','um evento que defendia uma nova composição de poder político, com a participação de republicanos, cafeicultores do Oeste paulista e profissionais liberais.'
  UNION ALL SELECT @qid,'D','uma manifestação popular nesta cidade, no interior paulista, para comemorar a sua emancipação política.'
  UNION ALL SELECT @qid,'E','um encontro entre os membros do Partido Republicano Paulista, que havia sido fundado no contexto da Constituição de 1824.'
) alts WHERE @ja_existe_23f = 0;

-- Q31
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Simón Bolívar (1783-1830) é uma figura emblemática que ecoa paixões e construções políticas à direita e à esquerda. O culto a Bolívar ultrapassa as barreiras ideológicas. Os ciclos políticos na Venezuela, por exemplo, produziram uma instância histórica de legitimação de regimes a partir e em torno da figura de Bolívar: ora como herdeiro da ilustração e do liberalismo, ora como um porta-voz contra o imperialismo. Nessas operações, emerge uma visão heroica de um projeto histórico inacabado que flerta tanto com o ideal republicano quanto com o autoritarismo do poder vitalício para combater as divisões internas.
(José Alves Freitas Neto. A Venezuela e o sequestro de Bolívar. Jornal da Unicamp, 19/7/2017. Adaptado. https://www.unicamp.br/unicamp/ju/artigos/jose-alves-de-freitas-neto/venezuela-e-o-sequestro-de-bolivar)

Sobre Simón Bolívar, é correto afirmar que','Médio','América Latina - Simón Bolívar','3ª Série EM','SARESP','D',6,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a contínua utilização de sua imagem na política da Venezuela contemporânea acabou por acentuar sua irrelevância histórica como líder.' AS texto
  UNION ALL SELECT @qid,'B','é, por sua trajetória, um dos poucos líderes latino-americanos que não podem ser associados ao caudilhismo e ao mandonismo político.'
  UNION ALL SELECT @qid,'C','organizou o Congresso do Panamá em 1826, evento que permitiu a independência econômica das nações latino-americanas.'
  UNION ALL SELECT @qid,'D','ambicionou uma duradoura unificação do território fruto da conquista hispânica e sua figura segue sendo mobilizada por diferentes espectros políticos.'
  UNION ALL SELECT @qid,'E','o termo "bolivarianismo" passou a ser utilizado, com a ascensão de Hugo Chávez ao poder, em 1999, para indicar caminhos para a construção de um capitalismo pós-industrial no século XXI.'
) alts WHERE @ja_existe_23f = 0;

-- Q32
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise a charge (obra do cartunista inglês Leslie Illingworth. In: https://blogs.kent.ac.uk/specialcollections. Adaptado): dois homens, um deles com uniforme militar alemão e o outro com um casaco e botas de soldado soviético, abraçam-se de modo teatral; um deles crava um punhal, com a inscrição "Pacto Germano-Soviético", nas costas do outro, dizendo: "Desculpe, camarada, mas a oportunidade pareceu TÃO boa!".

A charge se refere','Médio','Segunda Guerra Mundial - Pacto Germano-Soviético (charge)','3ª Série EM','SARESP','A',6,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à parte da opinião pública europeia, expressa nos jornais da época, que encarava Hitler como uma figura política traiçoeira e violenta.' AS texto
  UNION ALL SELECT @qid,'B','ao pacto firmado entre Hitler e Lênin, que se mostrou vantajoso apenas para o lado alemão.'
  UNION ALL SELECT @qid,'C','ao rompimento da aliança entre alemães e soviéticos, no contexto da Primeira Guerra Mundial.'
  UNION ALL SELECT @qid,'D','à oscilação geopolítica no contexto da Segunda Guerra Mundial que ocasionou a invasão do território alemão por parte dos exércitos soviéticos.'
  UNION ALL SELECT @qid,'E','à quebra do pacto de não-agressão, apesar da duração prevista de 10 anos, o que levou Alemanha e União Soviética a invadirem a Polônia.'
) alts WHERE @ja_existe_23f = 0;

-- Q33
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Os africanos no Brasil viam suas ligações com seu continente de origem constantemente renovadas pelo tráfico. Podemos estimar que em meados do ano de 1850 entre 15% e 19% dos cativos africanos no Centro-Sul haviam estado menos de dois anos e meio no Brasil. Isto é, chegaram depois do início de 1848. Na mesma época, 35% a 42% tinham menos de sete anos e meio no país, e 51% a 56% tinham menos de doze anos e meio. Esses dados são especialmente importantes para entender as visões daqueles africanos que, sem dúvida, elaboraram "estratégias" de aproximação dos brancos: isto é, aqueles que, apesar da discriminação a favor dos crioulos, ganharam a confiança do senhor e conquistaram posições de mando sobre os outros escravos – por exemplo, como feitores ou líderes de tropas de muares. Em todas as sociedades escravistas da América, a situação deste tipo de pessoa era especialmente ambígua; se, de um lado, ele devia sua posição à confiança do senhor, de outro lado, só podia mantê-la (e resguardar sua própria vida das possíveis represálias de seus parceiros) se fosse visto pelos escravos como uma espécie de "representante" da senzala perante a Casa Grande. Não é estranho, portanto, que feitores (e outros cativos em posições administrativas, domésticas e qualificadas) tenham se destacado com frequência como líderes das revoltas escravas no hemisfério. De um modo geral, o feitor se situava entre dois mundos. Ao mesmo tempo em que seguia a estratégia de tornar-se cada vez mais "ladino" aos olhos do senhor, o grande volume do tráfico e as exigências de sua ocupação o obrigavam a renovar constantemente sua africanidade.
Trata-se, no entanto, de uma identidade africana que não era aquela das suas origens, nem das de qualquer outro escravo.
(Robert Slenes. "Malungu, ngoma vem!": África coberta e descoberta do Brasil. Revista USP, (12), 1992. pgs 10-11. Adaptado)

As informações do texto permitem concluir que','Difícil','Escravidão no Brasil - identidade africana','3ª Série EM','SARESP','E',6,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a presença de feitores negros indicava a total assimilação das ordens dadas pelos senhores.' AS texto
  UNION ALL SELECT @qid,'B','o tráfico perdeu força no início do século XIX, enfraquecendo os vínculos dos escravizados com sua origem africana.'
  UNION ALL SELECT @qid,'C','a experiência da diáspora forçada (ou rapto) dos africanos foi superada pela preservação da língua e cultura originais.'
  UNION ALL SELECT @qid,'D','a situação ambígua e limite em que viviam os feitores lhes deixava em posição social igual à dos escravizados.'
  UNION ALL SELECT @qid,'E','a identidade dos escravizados era construída numa situação de fronteira, entre suas origens e sua condição presente.'
) alts WHERE @ja_existe_23f = 0;

-- Q34
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto para responder à questão.

Durante décadas, os museus e as administrações culturais europeias frustraram a luta da África pela recuperação do seu patrimônio cultural, sufocando o debate público.
As forças destrutivas acumuladas pela empresa colonial enquanto máquina de destruição agora são expostas à luz do dia. Os saques de obras eram sintomas de uma sanha destruidora. A restituição tem um sentido de construção de um mundo sem as amarras coloniais. É hora de escutarmos as outras vozes até agora amordaçadas pelo discurso pretensamente universal da razão eurocêntrica. Não há mais espaço para a desautorização das falas dos outros, calados e infantilizados. Não se pode mais aceitar o argumento da "presunção de incapacidade" dos povos africanos com relação ao seu próprio patrimônio cultural.
(Márcio Seligmann-Silva, em comentário ao livro de Benedicte Savoy "A luta de África por sua arte". Editora da Unicamp, 2023. In: O retorno do bumerangue. https://select.art.br. Adaptado)

O autor se refere ao processo recente de devolução de obras de arte, por parte dos países europeus, aos povos africanos. Podemos entender essa situação como','Médio','Colonialismo - restituição de obras de arte à África','3ª Série EM','SARESP','D',6,2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'uma atitude irrefletida uma vez que os povos colonizados não são os reais detentores dessas obras de arte.' AS texto
  UNION ALL SELECT @qid,'B','um reconhecimento de que europeus e africanos partilham da mesma ancestralidade cultural.'
  UNION ALL SELECT @qid,'C','uma constatação de que os objetos de arte não podem ser utilizados para narrar a história dos povos.'
  UNION ALL SELECT @qid,'D','um disputado processo pela devolução que implica na reparação por violências coloniais cometidas no passado.'
  UNION ALL SELECT @qid,'E','uma vitória do eurocentrismo definida pela devolução desses objetos de arte que estavam sob a guarda de museus europeus.'
) alts WHERE @ja_existe_23f = 0;

-- Q35
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O filósofo Sócrates, considerado o patrono da Filosofia, rebelou-se contra os sofistas, dizendo que não eram filósofos, pois não tinham amor pela sabedoria nem respeito pela verdade, já que defendiam qualquer ideia, se isso fosse vantajoso. Corrompiam o espírito dos jovens, pois faziam o erro e a mentira valer tanto quanto a verdade.
(Marilena Chaui. Convite à Filosofia, 2008)

De acordo com o excerto, Sócrates afirma que os sofistas','Fácil','Filosofia antiga - Sócrates e os sofistas','3ª Série EM','SARESP','C',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'fundaram uma corrente filosófica.' AS texto
  UNION ALL SELECT @qid,'B','faziam apologia à injustiça.'
  UNION ALL SELECT @qid,'C','relativizavam o conhecimento.'
  UNION ALL SELECT @qid,'D','eram criteriosos com o saber.'
  UNION ALL SELECT @qid,'E','dominavam pouco a retórica.'
) alts WHERE @ja_existe_23f = 0;

-- Q36
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para Tomás de Aquino, havia ainda uma série de "verdades naturais teológicas" ao lado dessas "verdades de fé". Por "verdades naturais teológicas" ele se referia àquelas verdades a que podemos chegar tanto pela fé cristã quanto pela nossa própria razão "natural", inata. Tomás acreditava em dois caminhos que levavam a Deus. O primeiro passava pela fé e pela revelação cristã, o segundo pela razão e os sentidos. É claro que dos dois caminhos o mais seguro era o da fé e da revelação, pois o homem pode facilmente se enganar quando confia apenas na razão.
(Jostein Gaarden. O mundo de Sofia, 2001. Adaptado)

Tendo o excerto por referência, o filósofo Tomás de Aquino defendia que','Médio','Filosofia medieval - Tomás de Aquino','3ª Série EM','SARESP','A',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a fé e a razão existem juntas, com superioridade da fé.' AS texto
  UNION ALL SELECT @qid,'B','a razão pode nos enganar e deve ser desconsiderada.'
  UNION ALL SELECT @qid,'C','as verdades divinas são inacessíveis aos humanos.'
  UNION ALL SELECT @qid,'D','o conhecimento inato substitui o conhecimento religioso.'
  UNION ALL SELECT @qid,'E','o acesso que nos conduz à espiritualidade é único.'
) alts WHERE @ja_existe_23f = 0;

-- Q37
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para Thomas Hobbes, o núcleo de indivíduos de uma sociedade principiou a gravitar em torno de uma só pessoa ou grupo, que institucionalizou a figura do Estado. Este, todavia, ancorou-se em pactos recíprocos, realizados entre os membros das comunidades, que acataram a utilização de força coativa para a mantença da paz e a defesa comum. No referido contexto, o papel de concentração dos poderes outorgados pelos indivíduos coube ao soberano, sendo os outorgantes chamados de súditos.
(Williem da S. Barreto Júnior e Sérgio U. de Cademartori. Os contratualistas e a formação do Estado Moderno. Vertentes do Direito, vol. 8 nº 2, 2021. Adaptado)

De acordo com o excerto, a prática política mais coerente com o que foi defendido na teoria de Thomas Hobbes está','Médio','Filosofia política - Hobbes e o Estado','3ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'na democracia representativa.' AS texto
  UNION ALL SELECT @qid,'B','na monarquia parlamentarista.'
  UNION ALL SELECT @qid,'C','na república presidencialista.'
  UNION ALL SELECT @qid,'D','no socialismo democrático.'
  UNION ALL SELECT @qid,'E','na monarquia absolutista.'
) alts WHERE @ja_existe_23f = 0;

-- Q38
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Foucault achava que a natureza do governo havia mudado entre o século XVI – quando os problemas da política eram relacionados a como o monarca soberano poderia obter e manter seu poder – e o século XX, quando o poder do Estado não está desconectado de nenhuma outra forma de poder na sociedade. Ele sugeriu que os teóricos políticos precisavam "cortar a cabeça do rei" e desenvolver uma abordagem para entender o poder que refletia essa mudança.
(Paul Kelly et al. O livro da Política, 2013)

Com a metáfora "cortar a cabeça do rei", Foucault pretende dizer que','Médio','Filosofia contemporânea - Foucault e o poder','3ª Série EM','SARESP','B',(SELECT id FROM disciplinas WHERE nome = 'Filosofia'),2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'as monarquias absolutistas precisariam ser encerradas com a decapitação dos governantes.' AS texto
  UNION ALL SELECT @qid,'B','o Estado constitui-se como a manifestação dos poderes presentes nas relações sociais.'
  UNION ALL SELECT @qid,'C','a ausência do Estado revela-se eficaz para a boa organização política da população.'
  UNION ALL SELECT @qid,'D','a política contemporânea deve transformar-se sem perder a referência da modernidade.'
  UNION ALL SELECT @qid,'E','os estudos acerca da natureza de um governo são suficientes para a análise da ciência política.'
) alts WHERE @ja_existe_23f = 0;

-- Q39
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT '"Eu saí [da Bahia] porque estava precisando de emprego. Me ofereceram R$ 2.000 por mês, passagem de ida, de volta, alimentação e dormitório. Mas chegou lá, foi tudo enganoso", declarou o trabalhador. "Quando cheguei lá, o que encontrei foi um galpão com mais de 200 pessoas dentro, um quarto em frente ao outro com 9 pessoas. A gente acordava 4h da manhã à base de grito, chamando a gente de demônio", afirmou. Segundo ele, as pessoas que não acordavam rapidamente com os gritos, tomavam choque no pé ou murro na costela.
(www.poder360.com.br, 15.08.2023. Adaptado)

A situação retratada no excerto revela que, no Brasil, há','Fácil','Sociologia do trabalho - trabalho análogo à escravidão','3ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'oportunidades concretas de ascensão social por mérito.' AS texto
  UNION ALL SELECT @qid,'B','necessidade de legislação que impeça tal acontecimento.'
  UNION ALL SELECT @qid,'C','práticas de violências diversas em ocupações legalizadas.'
  UNION ALL SELECT @qid,'D','presença pouco expressiva de abusos por xenofobia.'
  UNION ALL SELECT @qid,'E','persistência de relações de trabalho análogas à escravidão.'
) alts WHERE @ja_existe_23f = 0;

-- Q40
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise um trecho da canção "Sampa", composta em 1978 pelo baiano Caetano Veloso. Ela revela a impressão do compositor ao chegar à cidade de São Paulo.

Alguma coisa acontece no meu coração
Que só quando cruzo a Ipiranga e Avenida São João
É que quando eu cheguei por aqui eu nada entendi
Da dura poesia concreta de tuas esquinas
Da deselegância discreta de tuas meninas
(...)
Quando eu te encarei frente a frente e não vi o meu rosto
Chamei de mau gosto o que vi, de mau gosto, mau gosto
É que Narciso acha feio o que não é espelho
(...)
(www.vagalume.com.br)

O relato presente na canção é analisado sociologicamente como uma postura','Médio','Sociologia - etnocentrismo','3ª Série EM','SARESP','C',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'relativista.' AS texto
  UNION ALL SELECT @qid,'B','impressionista.'
  UNION ALL SELECT @qid,'C','etnocêntrica.'
  UNION ALL SELECT @qid,'D','patrimonialista.'
  UNION ALL SELECT @qid,'E','democrática.'
) alts WHERE @ja_existe_23f = 0;

-- Q41
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Durkheim afirma que a Sociologia é o estudo dos fatos essencialmente sociais e a explicação desses fatos de maneira sociológica. Sua concepção baseia-se em uma teoria dos fatos sociais. Seu objetivo é demonstrar que é possível existir uma sociologia científica e objetiva, conforme o modelo das outras ciências naturais.
(Carlos Lucena. "O pensamento educacional de Émile Durkheim". Revista HISTEDBR On-line, nº 40, 2010. Adaptado)

A teoria que baseia a concepção sociológica de Durkheim, citada no excerto, é composta, segundo ele, por três características:','Médio','Sociologia clássica - Durkheim e os fatos sociais','3ª Série EM','SARESP','E',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'racionalidade, exterioridade e individualidade.' AS texto
  UNION ALL SELECT @qid,'B','individualidade, objetividade e coercitividade.'
  UNION ALL SELECT @qid,'C','generalidade, racionalidade e liberdade.'
  UNION ALL SELECT @qid,'D','previsibilidade, objetividade e liberdade.'
  UNION ALL SELECT @qid,'E','generalidade, exterioridade e coercitividade.'
) alts WHERE @ja_existe_23f = 0;

-- Q42
INSERT INTO questoes (enunciado,dificuldade,tema,serie,origem,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A criminalização da homofobia e da transfobia foi permitida pelo Supremo Tribunal Federal (STF) em decisão de junho de 2019. Por 8 votos a 3, os ministros consideraram que atos preconceituosos contra homossexuais e transexuais passariam a ser enquadrados no crime de racismo.
(https://g1.globo.com. 30.09.2021. Adaptado)

Os registros de racismo e homofobia (ou transfobia) cresceram mais de 50% no Brasil em 2022 na comparação com o ano anterior, segundo dados do Anuário Brasileiro de Segurança Pública divulgados em julho de 2023. As ocorrências de homofobia ou transfobia passaram de 316, em 2021, para 488, em 2022, o que representa aumento de 54% no período.
(https://g1.globo.com. 20.07.2023. Adaptado)

A análise dos excertos permite concluir que, em relação à homofobia e à transfobia,','Médio','Sociologia - cidadania e preconceito','3ª Série EM','SARESP','C',(SELECT id FROM disciplinas WHERE nome = 'Sociologia'),2,NULL,TRUE
WHERE @ja_existe_23f = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a legislação nacional permanece conivente com práticas discriminatórias.' AS texto
  UNION ALL SELECT @qid,'B','o judiciário brasileiro institui obstáculos legais para a efetivação da democracia.'
  UNION ALL SELECT @qid,'C','a ampliação formal da cidadania encontra barreiras significativas no cotidiano.'
  UNION ALL SELECT @qid,'D','a união de fatores sociais e políticos atenuaram as manifestações de violência.'
  UNION ALL SELECT @qid,'E','as demandas dos movimentos sociais foram supridas nos últimos anos.'
) alts WHERE @ja_existe_23f = 0;
