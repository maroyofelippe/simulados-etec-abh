-- ==========================================================
--  Migração de conteúdo: Banco de questões — Vestibulinho Etec 1º SEM/2025
--  Exame aplicado em 15/12/2024 (Fundação FAT / Centro Paula Souza).
--  Fonte: caderno de questões (Prova.pdf) + gabarito oficial (Gabarito2025.pdf).
--  ----------------------------------------------------------
--  Escopo: as 50 questões do caderno foram importadas — todas plenamente
--  respondíveis a partir do texto do enunciado. As questões 13, 15, 41 e 42
--  dependem, no caderno original, de uma figura (estruturas químicas do
--  eugenol/vanilina, aparato de destilação, dados isotópicos e estruturas
--  das vitaminas A/C); foram incluídas descrevendo textualmente os dados
--  necessários (fórmulas moleculares, montagem do aparato, número atômico/
--  massa dos isótopos e contagem de grupos hidroxila), sem depender de
--  leitura de imagem.
--
--  Exame interdisciplinar, tema plantas; não associado a uma série do
--  Ensino Médio (prova de admissão) — "serie" preenchido com 'Vestibulinho'.
--
--  Usa textos_apoio para os textos-base compartilhados por mais de uma
--  questão (RF07a): Q07-09, Q10-11, Q12-15, Q16-17, Q23-24, Q25-26, Q28-29,
--  Q35-36, Q39-42, Q46-49.
--
--  Idempotente: variável de sessão travada no início (@ja_existe_v25), sem
--  DELIMITER/stored procedures (incompatível com a execução via
--  db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-09_banco_vestibulinho_1sem2025.sql)
-- ==========================================================
SET @db := DATABASE();

SET @ja_existe_v25 := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'As plantas proporcionam uma infinidade de benefícios%'
);

-- ---------- Questão isolada: benefícios das plantas e cultivo — Q01
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As plantas proporcionam uma infinidade de benefícios que são essenciais para a manutenção da vida na Terra, como a produção de alimentos e de oxigênio. Além disso, são fontes de matéria-prima para a indústria, uma vez que são utilizadas para a produção de biocombustíveis e de remédios.

Outro papel fundamental das plantas é o controle da dinâmica da água na Terra e da temperatura do planeta. Compreender suas funções vitais é importante para promover esforços de conservação do meio ambiente.

Em relação ao cultivo de plantas, uma ação que devemos adotar é','Médio','Práticas agrícolas sustentáveis','Vestibulinho','C',3,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'evitar adubar a terra, a fim de impedir o excesso de nutrientes tóxicos e a proliferação tanto de pragas quanto de plantas daninhas.' AS texto
  UNION ALL SELECT @qid,'B','permitir que lesmas e caramujos cresçam entre as plantas, a fim de estimular a polinização das flores e a formação dos frutos.'
  UNION ALL SELECT @qid,'C','utilizar a quantidade certa de água para cada tipo de planta, a fim de impedir que o solo fique encharcado e as raízes não consigam respirar.'
  UNION ALL SELECT @qid,'D','evitar o uso de qualquer tipo de controle biológico, a fim de impedir a proliferação de pragas e insetos transmissores de doenças.'
  UNION ALL SELECT @qid,'E','optar por locais bem ventilados, a fim de impedir a evaporação da água do solo, o que facilita a condução de seiva pelos vasos das plantas.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: espécies de plantas comestíveis (FAO) — Q02
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Segundo a Organização das Nações Unidas para Alimentação e Agricultura (FAO), na história da humanidade, das 30 mil espécies de plantas comestíveis, somente de 6 a 7 mil espécies foram cultivadas para produzir alimentos.

Atualmente, usamos apenas 170 culturas em uma escala comercial significativa, no entanto, dependemos somente de 30 delas para nos fornecer as calorias e os nutrientes de que precisamos todos os dias.

Geralmente, 60% das calorias vegetais da dieta humana são provenientes de três grãos – arroz, milho e trigo – que não fornecem as doses necessárias de vitaminas e minerais.

Além disso, a monocultura desses grãos pode provocar a degradação do solo, acarretando o esgotamento de seus nutrientes e, consequentemente, o empobrecimento nutricional.

Por outro lado, existem milhares de culturas que foram esquecidas ou subutilizadas e que nunca entraram no mercado mundial. Isso ocorre talvez pelo fato de terem sido cultivadas em pequenas áreas geográficas, ou terem baixo rendimento, ou ainda porque não foram devidamente pesquisadas.

Baseando-se no texto, é correto afirmar que','Médio','Biodiversidade agrícola mundial','Vestibulinho','D',7,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a totalidade das espécies de plantas comestíveis conhecidas foi cultivada, desenvolvida e usada comercialmente, ao longo do tempo, para a produção de alimento.' AS texto
  UNION ALL SELECT @qid,'B','dependemos, atualmente, de todas as culturas usadas em escala comercial para conseguirmos obter as calorias e os nutrientes de que precisamos todos os dias.'
  UNION ALL SELECT @qid,'C','as culturas atuais de arroz, trigo e milho, fornecem às pessoas todas as calorias vegetais necessárias à sobrevivência e oferecem todos os tipos de minerais e vitaminas essenciais à dieta humana.'
  UNION ALL SELECT @qid,'D','o cultivo de uma mesma espécie em uma determinada área está associado a diversos impactos ambientais, como o empobrecimento do solo e o desenvolvimento de doenças ou pragas.'
  UNION ALL SELECT @qid,'E','as culturas esquecidas ou subutilizadas, apesar de terem sido muito pesquisadas e apresentarem elevado rendimento de produção, não foram produzidas e comercializadas em escala global.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: trigo (Harari, Sapiens) — Q03
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Há dez mil anos, o trigo era apenas uma gramínea silvestre, confinada a uma pequena região do Oriente Médio. Em apenas alguns milênios, estava crescendo no mundo inteiro. Em áreas como as Grandes Planícies da América do Norte, onde não crescia um único pé de trigo há 10 mil anos, hoje podemos caminhar por centenas de quilômetros sem encontrar nenhuma outra planta. Atualmente, o trigo cobre 2,25 milhões de quilômetros quadrados da superfície do globo, quase 10 vezes o tamanho da Grã-Bretanha.

O trigo não gostava de rochas e pedregulhos, nem de dividir espaço, água e nutrientes com outras plantas, por isso os seres humanos tiveram que dedicar cada vez mais esforços para seu cultivo. (HARARI, Yuval Noah. Sapiens – Uma breve história da humanidade. Adaptado.)

Sobre o cereal mencionado no texto, é correto afirmar que é','Fácil','Interpretação de texto — história do trigo','Vestibulinho','D',1,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o principal produto agrícola plantado na região Centro-Oeste do Brasil.' AS texto
  UNION ALL SELECT @qid,'B','na Grã-Bretanha onde se encontra a maior área plantada do planeta.'
  UNION ALL SELECT @qid,'C','o principal produto de exportação dos países do Oriente Médio.'
  UNION ALL SELECT @qid,'D','plantado em larga escala nos Estados Unidos e no Canadá.'
  UNION ALL SELECT @qid,'E','cultivado nos desertos rochosos da Europa e da África.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: PANCs — Q04
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A sigla PANCs significa Plantas Alimentícias Não Convencionais, ou seja, espécies já conhecidas, mas que não são popularmente consumidas. Acredita-se que o Brasil tenha, aproximadamente, 10 mil espécies de plantas com potencial de uso alimentar.

Elas são uma excelente alternativa de alimentação sustentável, já que atendem à demanda por nutrientes que suprem as necessidades humanas. No entanto, os estudos e os cultivos dessas espécies ainda não são amplamente desenvolvidas.

Infelizmente, essas plantas ainda não são produzidas em larga escala. Isso poderia ajudar a combater a fome, por exemplo.

O que se sabe é que essas espécies são rústicas, propagadas por mudas ou sementes e resistentes a doenças e pragas.

Além disso, as PANCs, geralmente hortaliças, têm como característica a boa adaptação climática e a grande eficiência na absorção de nutrientes.

Atualmente, PANCs são cultivadas por pequenas comunidades agrícolas brasileiras, muitas vezes para consumo próprio.

De acordo com o texto, é correto afirmar que','Médio','Plantas Alimentícias Não Convencionais','Vestibulinho','B',3,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'as PANCs não permitem uma alimentação adequada ao ser humano.' AS texto
  UNION ALL SELECT @qid,'B','a utilização das PANCs tem potencial para minimizar o problema da fome.'
  UNION ALL SELECT @qid,'C','a pouca resistência às pragas é um empecilho ao cultivo das PANCs.'
  UNION ALL SELECT @qid,'D','as PANCs não suportam as condições climáticas brasileiras.'
  UNION ALL SELECT @qid,'E','a grande produção de PANCs torna o Brasil exportador desse alimento.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: café, pingado e date (torrefação/proporção) — Q05
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Sócrates não tomou um pingado (leite com café) com Platão. Cleópatra e Júlio César jamais marcaram um date (encontro romântico com alguém) num café de Alexandria. A humanidade só conheceu o café bem depois. Hoje, ele é um dos mais valiosos produtos primários comercializados no mundo, tanto que, em 2022, foi produzido um total de 171,7 milhões de sacas desse grão.

É curioso observar que cada saca de café verde tem 60 kg e rende somente 48 kg de café torrado, ou seja, o café perde cerca de ......I......% de sua massa durante o processo de torrefação. Deste modo, é possível estimar que, para produzir uma tonelada de café torrado, são necessárias, no mínimo, ......II...... sacas de café verde.

Leia o texto e assinale a alternativa que completa correta e respectivamente os espaços numerados I e II.','Difícil','Porcentagem e proporção — torrefação do café','Vestibulinho','C',2,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'I = 12; II = 21' AS texto
  UNION ALL SELECT @qid,'B','I = 12; II = 35'
  UNION ALL SELECT @qid,'C','I = 20; II = 35'
  UNION ALL SELECT @qid,'D','I = 20; II = 21'
  UNION ALL SELECT @qid,'E','I = 21; II = 35'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: dioneias, tigmonastia e Lei de Ohm — Q06
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Plantas carnívoras, como as dioneias, são conhecidas pelo aprisionamento de suas presas. Esse movimento ocorre por um processo denominado tigmonastia, em que, ao serem tocadas, as células sensíveis da planta geram sinais elétricos que são propagados rapidamente e fazem com que a planta se feche.

Durante o fechamento das folhas, a resistência elétrica entre dois pontos do caule pode ser obtida por meio da Lei de Ohm, conhecida por U = R . i, em que a diferença de potencial (U) aplicada nesses pontos gera uma corrente elétrica (i) que depende da resistência elétrica (R) do material.

Se uma diferença de potencial de 1 x 10^-1 volt é aplicada entre esses pontos e a corrente elétrica medida é de 2 x 10^-8 ampères, a resistência elétrica, medida em ohm, do caule da planta é','Médio','Lei de Ohm — notação científica','Vestibulinho','D',4,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'5 x 10^-9' AS texto
  UNION ALL SELECT @qid,'B','5 x 10^-7'
  UNION ALL SELECT @qid,'C','5 x 10^-1'
  UNION ALL SELECT @qid,'D','5 x 10^6'
  UNION ALL SELECT @qid,'E','5 x 10^8'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Texto de apoio: quadrinho "Cientirinhas #180" (planta carnívora) — Q07, Q08, Q09
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Cientirinhas #180 — quadrinho da planta carnívora',
'Quadrinho em 4 quadros (Cientirinhas #180, @dragoesdegaragem / comicorama.tumblr.com):

1º quadrinho — uma planta carnívora (dioneia) fala para uma flor Rosa: "Aí eu disse pra Rosa: ''Amiga, para de sofrer por esse boy lixo!'' Porque tu me conhece, né? Eu falo na lata!"

2º quadrinho — a planta carnívora continua, olhando para um Cravo (flor): "A coitada tava lá debaixo da sacada, toda borocochó. Mas me deu uma ojeriza do Cravo, menina!"

3º quadrinho — um girassol responde: "Gente! Como é tagarela essa Planta Carnívora! Ela é desse jeito pra não morrer de fome."

4º quadrinho — outro girassol pergunta "Uai, você não sabia?" e a planta carnívora explica: "Como assim? Em boca fechada não entra mosca!"',
1,2
WHERE @ja_existe_v25 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A construção de humor no texto se deve, entre outros fatores,','Médio','Humor e linguagem figurada','Vestibulinho','D',1,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à valorização do masculino, ao representá-lo como uma flor, o Cravo.' AS texto
  UNION ALL SELECT @qid,'B','à linguagem cerimoniosa e solene empregada pela Planta Carnívora.'
  UNION ALL SELECT @qid,'C','ao uso da linguagem verbal para amenizar atos de violência doméstica.'
  UNION ALL SELECT @qid,'D','à atribuição de comportamentos animalizados, como o canibalismo, a seres humanos.'
  UNION ALL SELECT @qid,'E','à prática da fofoca como um traço essencial para a sobrevivência da Planta Carnívora.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Após a leitura atenta dos quadrinhos, é correto afirmar que','Difícil','Coloquialidade e vocativo','Vestibulinho','C',1,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'as referências a "Rosa", "Cravo" e "debaixo da sacada" constroem uma relação metalinguística imprescindível para a compreensão do humor nos quadrinhos.' AS texto
  UNION ALL SELECT @qid,'B','o termo "ojeriza", no contexto apresentado, assume uma conotação positiva, em oposição ao seu sentido original de "aversão", "antipatia".'
  UNION ALL SELECT @qid,'C','os termos "amiga" e "menina" cumprem a mesma função de interlocução com o receptor, conhecida como vocativo.'
  UNION ALL SELECT @qid,'D','o termo "pra", presente no primeiro e no terceiro quadrinhos, expressa localização em ambas as ocorrências.'
  UNION ALL SELECT @qid,'E','os traços de coloquialidade, como "pra", "né" e "falo na lata", são inadequados ao gênero desenvolvido.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No quarto quadrinho, a interjeição "uai" evidencia que a personagem, diante da pergunta de sua amiga, experiencia','Fácil','Interjeições','Vestibulinho','A',1,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'surpresa.' AS texto
  UNION ALL SELECT @qid,'B','alegria.'
  UNION ALL SELECT @qid,'C','medo.'
  UNION ALL SELECT @qid,'D','apatia.'
  UNION ALL SELECT @qid,'E','aversão.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Texto de apoio: Revolução dos Cravos — Q10, Q11
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Revolução dos Cravos (1974)',
'O movimento, que completou 50 anos em 2024, foi o responsável pelo fim da longeva ditadura de António de Oliveira Salazar, substituído, em 1968, por Marcello Caetano. Esse movimento ficou conhecido pelo nome da flor que a população colocava nos canos das armas dos soldados do exército, que se rebelaram para dar um basta ao estado de coisas que sufocava a vida do país, restabelecendo a democracia.

Um dos motivos da insatisfação foi a desastrosa campanha militar do governo ditatorial para enfrentar os movimentos de libertação nacional que estavam ocorrendo em suas colônias na África.',
6,2
WHERE @ja_existe_v25 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O evento histórico descrito no texto foi batizado de','Fácil','Revolução dos Cravos','Vestibulinho','E',6,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Guerra da Papoula, e ocorreu na China.' AS texto
  UNION ALL SELECT @qid,'B','Guerra das Duas Rosas, e ocorreu na Inglaterra.'
  UNION ALL SELECT @qid,'C','Revolução do Mandacaru, e ocorreu no Brasil.'
  UNION ALL SELECT @qid,'D','Revolução do Lótus, e ocorreu na Índia.'
  UNION ALL SELECT @qid,'E','Revolução dos Cravos, e ocorreu em Portugal.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Dentre as colônias a que o texto se refere, podemos citar corretamente','Médio','Colônias portuguesas na África','Vestibulinho','A',6,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Angola e Cabo Verde.' AS texto
  UNION ALL SELECT @qid,'B','Nigéria e África do Sul.'
  UNION ALL SELECT @qid,'C','Madagascar e Senegal.'
  UNION ALL SELECT @qid,'D','Etiópia e Saara Ocidental.'
  UNION ALL SELECT @qid,'E','República Centro-Africana e Mali.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Texto de apoio: cravo-da-índia — Q12, Q13, Q14, Q15
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'O cravo-da-índia',
'O cravo-da-índia é uma especiaria usada desde a Antiguidade. Seu comércio motivou inúmeras viagens de navegadores europeus para o continente Asiático. Essa especiaria já foi comercializada a preço de ouro e, até hoje, é utilizada na Medicina Ayurveda, na Medicina Chinesa e na fitoterapia ocidental.

O cravo-da-índia é amplamente utilizado na culinária como condimento no preparo de pratos e doces. Seu uso em doces teve início por sua ação repelente que impede a invasão de formigas, motivo pelo qual é usado popularmente em açucareiros. Além disso, ele é usado na fabricação de medicamentos por suas propriedades antimicrobianas, antifúngicas, antivirais e anti-inflamatórias.

Seu óleo essencial é rico em eugenol, princípio ativo responsável pelas propriedades analgésicas e antissépticas, sendo bastante usado em odontologia. Fonte de matéria-prima para a fabricação de fragrâncias e aromatizantes, também foi usado anteriormente para sintetizar a vanilina (aroma artificial de baunilha).',
5,2
WHERE @ja_existe_v25 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Sobre o texto, é correto afirmar que','Fácil','Interpretação de texto técnico','Vestibulinho','B',1,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'se extraía ouro, junto ao eugenol, na Antiguidade.' AS texto
  UNION ALL SELECT @qid,'B','o cravo-da-índia pode ser usado em açucareiros por repelir formigas.'
  UNION ALL SELECT @qid,'C','o eugenol, devido a sua ação repelente, é usado na fabricação de medicamentos.'
  UNION ALL SELECT @qid,'D','a vanilina está presente no óleo essencial do cravo-da-índia.'
  UNION ALL SELECT @qid,'E','o eugenol exala o aroma artificial de baunilha.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O eugenol e a vanilina, citados no texto, têm fórmulas moleculares C10H12O2 e C8H8O3, respectivamente.

Assinale a alternativa que apresenta a comparação correta entre o eugenol e a vanilina.','Difícil','Fórmula molecular — comparação de compostos','Vestibulinho','E',5,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'O eugenol e a vanilina apresentam o mesmo número de átomos de carbono.' AS texto
  UNION ALL SELECT @qid,'B','O eugenol e a vanilina apresentam o mesmo número de átomos de hidrogênio.'
  UNION ALL SELECT @qid,'C','O eugenol apresenta elementos químicos diferentes da vanilina em sua estrutura.'
  UNION ALL SELECT @qid,'D','O eugenol e a vanilina apresentam estruturas idênticas com mesmo número de átomos.'
  UNION ALL SELECT @qid,'E','O eugenol e a vanilina apresentam estruturas que diferem por um átomo de oxigênio, dois átomos de carbono e quatro átomos de hidrogênio.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Arroz doce, canjica, doce de abóbora... Muitos doces consumidos no Brasil levam cravo-da-índia em suas receitas.

Assinale a alternativa que apresenta, corretamente, a forma como esse ingrediente foi introduzido em nosso território.','Médio','Introdução do cravo-da-índia no Brasil','Vestibulinho','D',6,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'O cravo-da-índia foi trazido pelos portugueses ao território brasileiro no processo das Grandes Navegações, que conectaram Europa, Ásia, África e América do Sul.' AS texto
  UNION ALL SELECT @qid,'B','As primeiras mudas de cravo-da-índia chegaram ao território do atual Brasil há cerca de 5 000 anos pela Amazônia, por meio de uma rede de trilhas incas chamada de "caminho do rei".'
  UNION ALL SELECT @qid,'C','Os caçadores-coletores da cultura de Clóvis trouxeram o cravo-da-índia durante o processo de migração pelo Estreito de Bering, da Europa para a América do Norte, há cerca de 13 000 anos.'
  UNION ALL SELECT @qid,'D','As mulheres negras africanas trouxeram para o Brasil, além de um novo jeito de preparar a comida, alimentos tipicamente africanos, como o cravo-da-índia, a canela e o gengibre.'
  UNION ALL SELECT @qid,'E','O cravo-da-índia, especiaria típica do norte da Itália, foi introduzido na culinária brasileira durante o período da imigração italiana, ocorrida entre os anos de 1870 e 1930.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A obtenção do eugenol é relativamente simples e pode ser realizada no seguinte aparato experimental: cravo triturado e água são colocados em um balão de fundo redondo e aquecidos; o vapor gerado passa por um tubo que é resfriado externamente por água fria (condensador); o líquido condensado (a emulsão) é recolhido em um béquer na saída do condensador.

O processo representado é denominado','Fácil','Métodos de separação de misturas — destilação','Vestibulinho','D',5,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'filtração.' AS texto
  UNION ALL SELECT @qid,'B','decantação.'
  UNION ALL SELECT @qid,'C','sublimação.'
  UNION ALL SELECT @qid,'D','destilação.'
  UNION ALL SELECT @qid,'E','floculação.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Texto de apoio: "Hora do Flerte" (Madri) — Q16, Q17
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT '"Hora do Flerte" em supermercado de Madri',
'Em uma rede de supermercados de Madri, uma nova forma de paquera tem chamado a atenção: a "Hora do Flerte". Entre 19h e 20h, solteiros circulam pelo supermercado sinalizando disponibilidade ao andar com um abacaxi virado para baixo dentro do carrinho. Caso encontre alguém interessante, basta bater no carrinho do "crush" e começar a conversar. Os solteiros se dividem em três faixas etárias, cada uma circulando por uma seção diferente do supermercado:

- pessoas entre 18 e 24 anos ficam no setor de congelados;
- pessoas entre 25 e 40 anos ficam na peixaria; e
- pessoas com mais de 40 anos ficam no corredor de vinhos.

A popularidade é tamanha que, segundo relatos em redes sociais, o abacaxi tem acabado em várias noites.',
2,2
WHERE @ja_existe_v25 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Suponha que a rede de supermercados decida promover uma campanha de marketing para divulgar ainda mais essa nova forma de paquera. A campanha terá como chamariz uma sigla formada por 3 letras diferentes retiradas do nome da fruta utilizada para sinalizar disponibilidade (ABACAXI).

Assinale a alternativa que apresenta corretamente o total de siglas que podem ser formadas.','Médio','Análise combinatória — arranjos','Vestibulinho','C',2,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'24' AS texto
  UNION ALL SELECT @qid,'B','35'
  UNION ALL SELECT @qid,'C','60'
  UNION ALL SELECT @qid,'D','98'
  UNION ALL SELECT @qid,'E','210'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para além das prateleiras e corredores dos mercados, o amor virtual também está em alta. Um dos aplicativos de namoro mais populares do mundo divulgou que tem cerca de 80 milhões de usuários, dos quais 75% são homens. A tabela apresenta, por faixas etárias, qual é a porcentagem de usuários que usam esse aplicativo de namoro:

Faixa etária 18-24: 38%; faixa etária 25-34: 45%; faixa etária 35-44: 13%; faixa etária 45-54: 3%; faixa etária 55-64: 1%.

Suponha que os frequentadores da "Hora do Flerte" sigam o mesmo padrão percentual daqueles que utilizam o aplicativo de namoro referido no texto (incluindo a proporção de 75% de homens).

Logo, se for constatado que existe um total de 200 pessoas na rede de supermercados participando dessa nova forma de paquera, o número de homens, no setor de congelados, é','Difícil','Porcentagem — proporções combinadas','Vestibulinho','B',2,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'19.' AS texto
  UNION ALL SELECT @qid,'B','57.'
  UNION ALL SELECT @qid,'C','93.'
  UNION ALL SELECT @qid,'D','107.'
  UNION ALL SELECT @qid,'E','143.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: plantas domésticas populares (grupos vegetais) — Q18
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Uma pesquisa permitiu a identificação de algumas espécies de plantas domésticas muito populares em diversos países do mundo, por exemplo:

- na América do Sul, a planta doméstica mais popular foi a Passiflora caerulea (maracujá-azul). Essa planta se caracteriza por ser uma espécie de trepadeira, com folhas verde-escuras e flores de pétalas brancas, além de possuir filamentos roxos e azuis. Seus frutos possuem casca laranja, polpa comestível avermelhada e numerosas sementes.

- na América do Norte, a planta doméstica mais popular foi a Monstera deliciosa (costela-de-adão). Essa planta possui grandes folhas verdes em forma de coração, com recortes profundos formando furos. Ela também produz flores; suas sementes ficam no interior de frutos suculentos e comestíveis, cujo sabor lembra uma mistura de abacaxi com banana.

Assinale a alternativa que associa corretamente o grupo vegetal, ao qual pertencem as plantas domésticas descritas no enunciado (ambas possuem vasos condutores, folhas, flores, frutos comestíveis e sementes no interior dos frutos), às suas respectivas características.','Médio','Classificação dos grupos vegetais','Vestibulinho','C',3,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Pteridófitas — sem vasos condutores, sem folhas, com flores, com frutos comestíveis, sem sementes no interior dos frutos.' AS texto
  UNION ALL SELECT @qid,'B','Gimnospermas — com vasos condutores, com folhas, sem flores, com frutos comestíveis, com sementes no interior dos frutos.'
  UNION ALL SELECT @qid,'C','Angiospermas — com vasos condutores, com folhas, com flores, com frutos comestíveis, com sementes no interior dos frutos.'
  UNION ALL SELECT @qid,'D','Gimnospermas — sem vasos condutores, com folhas, com flores, sem frutos comestíveis, com sementes no interior dos frutos.'
  UNION ALL SELECT @qid,'E','Angiospermas — sem vasos condutores, com folhas, sem flores, sem frutos comestíveis, com sementes no interior dos frutos.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: fotossíntese e respiração — Q19
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As plantas purificam o ar, pois, por absorverem a luz graças à presença de clorofila, realizam o processo da fotossíntese. Este processo transforma o dióxido de carbono e a água em glicose e oxigênio, o qual é liberado para o ambiente. Dessa forma, elas renovam o ar necessário ao processo de respiração.

Sobre os dois processos mencionados, é correto afirmar que','Médio','Fotossíntese e respiração celular','Vestibulinho','D',3,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ambos atuam na transformação de dióxido de carbono e água em glicose e oxigênio.' AS texto
  UNION ALL SELECT @qid,'B','ambos dependem da presença de clorofila para absorver a energia luminosa.'
  UNION ALL SELECT @qid,'C','apenas a fotossíntese ocorre tanto na presença como na ausência de luz.'
  UNION ALL SELECT @qid,'D','apenas a respiração ocorre tanto na presença como na ausência de luz.'
  UNION ALL SELECT @qid,'E','apenas a respiração transforma o dióxido de carbono em glicose.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: equação da fotossíntese — Q20
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Analise a equação que representa o processo da fotossíntese:

6 CO2 + 6 H2O --(luz)--> C6H12O6 + 6 O2

Sobre esse processo, é correto afirmar que','Fácil','Equação química da fotossíntese','Vestibulinho','E',3,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'temos apenas uma substância simples.' AS texto
  UNION ALL SELECT @qid,'B','temos apenas uma substância composta.'
  UNION ALL SELECT @qid,'C','a água é produto da reação.'
  UNION ALL SELECT @qid,'D','o gás carbônico é liberado.'
  UNION ALL SELECT @qid,'E','ocorre com liberação de energia.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: condições de luz e crescimento — Q21
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um grupo de cientistas está estudando como diferentes condições de luz afetam o crescimento de plantas. Para isso, eles dividem as plantas em três grupos e as expõem às seguintes condições de iluminação:

- grupo I – exposto à luz branca (composta por todas as cores do espectro visível);
- grupo II – exposto apenas à luz monocromática verde; e
- grupo III – mantido no escuro, sem nenhuma luz.

Após algumas semanas, os cientistas avaliam o crescimento das plantas. O maior crescimento ocorrerá no grupo','Médio','Fotossíntese — espectro de luz','Vestibulinho','C',3,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'III, porque a ausência de luz reduz o estresse nas plantas, permitindo um crescimento mais saudável.' AS texto
  UNION ALL SELECT @qid,'B','II, porque a luz verde é a mais eficiente para ser absorvida pelas folhas e alcançar os cloroplastos, estimulando o crescimento.'
  UNION ALL SELECT @qid,'C','I, porque a luz branca é composta de todas as cores presentes no espectro visível, o que estimula a fotossíntese e acelera o crescimento.'
  UNION ALL SELECT @qid,'D','I, porque a luz branca está na mesma faixa de frequência que a luz ultravioleta, essencial para que ocorra a fotossíntese.'
  UNION ALL SELECT @qid,'E','II, porque a luz verde é mais eficiente para estimular a floração, o que induz o maior crescimento desse grupo.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: frutos da Caatinga — Q22
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Embora pouco conhecidos, os frutos da Caatinga – como o umbuzeiro, o juazeiro, o mandacaru, o cajueiro e o jenipapo – possuem não só uma abundância de sabores e cores, mas também servem de alimento tanto para os seres humanos como para os animais.

O bioma citado se caracteriza por possuir formação vegetal','Médio','Bioma Caatinga','Vestibulinho','C',7,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'homogênea, adaptada a uma estação seca e outra úmida, com predomínio de palmáceas, caracterizadas por galhos retorcidos e folhas cobertas por pelos e com raízes rasas, devido à proximidade com o lençol freático.' AS texto
  UNION ALL SELECT @qid,'B','heterogênea, densa, com árvores altas e copas largas, onde se encontra uma enorme biodiversidade vegetal, pois a umidade constante e o calor são condições ideais para a proliferação de grande variedade de espécies.'
  UNION ALL SELECT @qid,'C','heterogênea, associada ao clima semiárido, com a presença de vegetais com folhas atrofiadas, caules grossos e raízes profundas, adaptadas para suportar os longos períodos de estiagem.'
  UNION ALL SELECT @qid,'D','homogênea, densa e exuberante, com árvores de grande porte, associadas a formações campestres compostas basicamente por gramíneas com vegetação arbustiva esparsa.'
  UNION ALL SELECT @qid,'E','homogênea, com predomínio de coníferas com árvores muito altas, capazes de suportar baixas temperaturas, apresentando poucos estratos e ausência de vegetação rasteira.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Texto de apoio: Ilha de Calor em Medellín — Q23, Q24
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Ilha de Calor e corredores verdes em Medellín',
'Conhecida como a Cidade da Primavera Eterna, Medellín costuma atrair turistas por todo o ano, mas o aumento da urbanização expôs a cidade ao efeito de Ilha de Calor das áreas urbanas, que causa a absorção e a retenção do calor pelas ruas e construções da cidade.

Em 2016, Medellín deu início ao seu programa de "corredores verdes" devido às preocupações com a poluição do ar e o aumento do calor. Os corredores verdes mostraram-se claramente eficientes para reverter este impacto. A temperatura caiu em 2°C por toda a cidade, segundo dados da prefeitura local.',
4,2
WHERE @ja_existe_v25 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A solução, apontada no texto, foi adotada para minimizar um fenômeno climático que ocorre devido à transmissão de calor por meio da','Médio','Transmissão de calor — irradiação, condução e convecção','Vestibulinho','A',4,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'irradiação, uma vez que o material utilizado na construção das cidades absorve a radiação solar e irradia esse calor para o ambiente.' AS texto
  UNION ALL SELECT @qid,'B','irradiação, já que os prédios das cidades dificultam a movimentação das nuvens e, dessa forma, impedem a ocorrência de chuvas.'
  UNION ALL SELECT @qid,'C','condução, porque veículos, como ônibus e motos, transportam o calor para dentro dos grandes centros urbanos.'
  UNION ALL SELECT @qid,'D','condução, dado que o material utilizado na construção das cidades conduz o calor gerado nas residências para o meio exterior.'
  UNION ALL SELECT @qid,'E','convecção, pois o calor gerado pelos metrôs, no subterrâneo das grandes cidades, esquenta o ambiente e se transmite para o solo.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os corredores verdes, abordados no texto, contribuem para a mudança no microclima de Medellín porque as árvores','Médio','Papel ecológico das árvores no microclima urbano','Vestibulinho','B',3,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'aumentam a quantidade de oxigênio na atmosfera do local a ponto de modificar o clima regional.' AS texto
  UNION ALL SELECT @qid,'B','absorvem parte da radiação solar, diminuindo o aquecimento do solo e das construções ao redor.'
  UNION ALL SELECT @qid,'C','absorvem todo o gás carbônico na atmosfera local, eliminando completamente a poluição do ar.'
  UNION ALL SELECT @qid,'D','realizam o processo de fotossíntese, que cria uma barreira para a absorção da energia proveniente do sol.'
  UNION ALL SELECT @qid,'E','funcionam como barreiras físicas contra o vento, impedindo que as brisas quentes entrem na cidade.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Texto de apoio: dormentes ferroviários de madeira — Q25, Q26
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Dormentes ferroviários de madeira',
'A utilização de dormentes de madeira em ferrovias garante a fixação e o alinhamento dos trilhos. Eles podem ser de tipos variados: roliços, semi-roliços, de duas faces e prismáticos.

Um dormente prismático, por exemplo, mede 2 metros de comprimento, 0,24 metros de largura, 0,16 metros de altura e tem o formato de um paralelepípedo retorretângulo.

Em ferrovias brasileiras, são usados, normalmente, 1600 dormentes por quilômetro.',
2,2
WHERE @ja_existe_v25 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Suponha que, em uma região do Brasil, será construída uma linha férrea de 2 km usando apenas dormentes prismáticos.

Logo, o volume total de madeira, em metros cúbicos, necessária para os dormentes utilizados na construção dessa linha é','Difícil','Geometria — volume de paralelepípedo','Vestibulinho','D',2,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'76,80.' AS texto
  UNION ALL SELECT @qid,'B','122,88.'
  UNION ALL SELECT @qid,'C','168,92.'
  UNION ALL SELECT @qid,'D','245,76.'
  UNION ALL SELECT @qid,'E','368,64.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Suponha que, na construção de um trecho de 1 km de ferrovia no Brasil, uma empresa distribuiu os dormentes de forma que:

- 25% sejam do tipo roliço;
- 30% sejam do tipo semi-roliço;
- 35% sejam do tipo de duas faces;
- e o restante sejam do tipo prismático.

Diante dessas condições, é correto afirmar que','Difícil','Porcentagem e razões','Vestibulinho','E',2,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a razão entre a quantidade de dormentes do tipo roliço e do tipo prismático, nessa ordem, é igual a 2/1.' AS texto
  UNION ALL SELECT @qid,'B','a soma das porcentagens dos dormentes semi-roliços e prismáticos é igual a 35%.'
  UNION ALL SELECT @qid,'C','300 metros da ferrovia serão compostos por dormentes do tipo prismático.'
  UNION ALL SELECT @qid,'D','a diferença percentual entre os dormentes de duas faces e prismáticos é de 5%.'
  UNION ALL SELECT @qid,'E','a razão entre a quantidade de dormentes do tipo de duas faces e do tipo semi-roliço, nessa ordem, é igual a 7/6.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: "bruxas" medievais e Inquisição — Q27
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para a população camponesa da Idade Média, as mulheres reconhecidas como "bruxas" eram membros fundamentais da comunidade. Elas eram normalmente mais velhas, acumulavam anos de experiência e dominavam os saberes necessários para lidar com a vida e a morte: as plantas que curavam doenças, que auxiliavam os partos ou que causavam alívio no processo de falecimento. Como define o historiador francês Jules Michelet (1798-1874): "a elas se pedia a vida, a morte, remédios, venenos".

Durante dez séculos, a Igreja Católica tolerou práticas consideradas pagãs em toda a Europa. Porém, entre o final do século XIV e a primeira metade do século XV, passou a reprimir tudo o que contrariasse os dogmas cristãos.

Esse período foi caracterizado pela','Médio','Inquisição e perseguição às "bruxas"','Vestibulinho','C',6,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'consolidação do Iluminismo, movimento intelectual cristão que valorizava a razão, considerada a única forma de garantir o progresso da humanidade, em detrimento da fé e do poder dos reis.' AS texto
  UNION ALL SELECT @qid,'B','intensificação dos fluxos de capitais, mercadorias, pessoas e informações, devido ao avanço técnico na comunicação e nos transportes, o que consolidou o poder político dos papas.'
  UNION ALL SELECT @qid,'C','atuação da Inquisição na investigação e na repressão de práticas contrárias ao catolicismo, bem como na perseguição das "bruxas", mulheres vistas como agentes do demônio na Terra.'
  UNION ALL SELECT @qid,'D','proclamação das Repúblicas europeias e o início de um período em que todas as crenças religiosas, à exceção do cristianismo, foram consideradas primitivas e atrasadas.'
  UNION ALL SELECT @qid,'E','substituição do trabalho humano por máquinas a vapor, que condenou as mulheres à vida privada e ao trabalho doméstico, excluindo-as da vida social.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Texto de apoio: queimadas e qualidade do ar (INPE) — Q28, Q29
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Queimadas de 2024 e qualidade do ar no Brasil',
'O Instituto Nacional de Pesquisas Espaciais (INPE) registrou cerca de 160 mil focos de incêndio de janeiro até setembro de 2024, um aumento de 100% em relação ao mesmo período de 2023, que deixaram 60% do país sob fumaça. A seca prolongada no Brasil, aliada a incêndios por todo o país, provocou uma onda de clima seco severo por todo o território brasileiro.

Na cidade de São Paulo, que já apresenta tempo seco no inverno, foi registrada a pior qualidade de ar do mundo em setembro, levando a um aumento do aparecimento de problemas do sistema respiratório, como rinite e sinusite.

Em consequência do atual cenário, é importante tomar medidas para se proteger e evitar que o corpo humano possa ser impactado negativamente.',
3,2
WHERE @ja_existe_v25 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Assinale a alternativa em que a ação enunciada amenize a vivência no cenário descrito no texto.','Fácil','Saúde e clima seco','Vestibulinho','E',3,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Usar umidificador de ar ou uma bacia com água no ambiente, pois tornam o ambiente mais seco, colaborando com o ressecamento da mucosa respiratória.' AS texto
  UNION ALL SELECT @qid,'B','Não beber muita água para evitar a transpiração, bem como fazer refeições leves, pois não se perde minerais no suor. E não fazer exercícios físicos entre 10 e 16 horas.'
  UNION ALL SELECT @qid,'C','Manter ambientes fechados, pois isso ajuda a fazer o ar circular, aumentando a ação de ácaros, amigos da saúde respiratória, principalmente de quem já tem predisposição de alguma alergia.'
  UNION ALL SELECT @qid,'D','Evitar lavar cobertores e casacos, que estavam guardados no armário antes do inverno, para favorecer o desenvolvimento de fungos e mofos, benéficos ao sistema respiratório.'
  UNION ALL SELECT @qid,'E','Cuidar, especialmente de crianças e idosos, que são os mais afetados pela baixa umidade do ar, incentivando a ingestão de bastante água, além de sucos naturais.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Intervenções governamentais que poderiam contribuir com a melhora do problema apontado são','Médio','Políticas públicas ambientais','Vestibulinho','D',7,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a construção de novas rodovias próximas às áreas de maior incidência de incêndios e a liberação de queimadas em áreas de proteção ambiental.' AS texto
  UNION ALL SELECT @qid,'B','a redução da fiscalização para queimadas ilegais e a criação de incentivos fiscais para a expansão de pastagens em áreas de floresta.'
  UNION ALL SELECT @qid,'C','o estímulo ao desmatamento como forma de aumentar a área cultivável e o aumento da exportação de produtos agrícolas.'
  UNION ALL SELECT @qid,'D','a criação de programas de divulgação que abordem a educação ambiental e o incentivo a práticas agrícolas sustentáveis.'
  UNION ALL SELECT @qid,'E','o incentivo ao uso de queimadas como método de limpeza de terrenos e a liberação de agrotóxicos mais potentes para combater pragas nas plantações.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: Hera Venenosa e consultoria de sustentabilidade — Q30
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Pamela Isley, conhecida como Hera Venenosa, é uma personagem da DC Comics obcecada por ambientalismo, ecologia, botânica e plantas, chegando até mesmo a praticar ativismo terrorista em defesa do meio ambiente. Em uma de suas histórias, ao falar sobre o processo de cultivo de agave — planta com a qual se faz a tequila — ela aponta que, apesar de esse cultivo ter degradado cada vez mais terras no México, isso não impede que vegetarianos, muitas vezes defensores de causas ambientais, comprem o xarope feito a partir dessa planta para uso medicinal.

Imagine que você é um(a) consultor(a) de sustentabilidade. Sua missão é ajudar a Hera Venenosa a fazer escolhas que sejam verdadeiramente sustentáveis e não violentas, considerando não só o meio ambiente, mas também as implicações sociais e éticas dessas escolhas.

Com base nisso, assinale, dentre as alternativas, aquela que seria a melhor orientação para dar a Hera Venenosa.','Médio','Ética e sustentabilidade','Vestibulinho','A',3,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Orientar que ela adote uma abordagem na qual todas as suas ações considerem o equilíbrio entre a preservação do meio ambiente e o bem-estar humano, escolhendo cuidadosamente suas batalhas para minimizar impactos negativos.' AS texto
  UNION ALL SELECT @qid,'B','Incentivar o uso de plantas exóticas ou transgênicas que crescem rapidamente, sem avaliar os efeitos que isso pode ter nos ecossistemas locais.'
  UNION ALL SELECT @qid,'C','Sugerir que ela continue usando métodos agressivos de ativismo para proteger a natureza, mesmo que isso possa prejudicar comunidades humanas.'
  UNION ALL SELECT @qid,'D','Optar por ações que suscitem a diminuição do consumo de produtos de origem animal, uma vez que não é necessário pensar como os produtos vegetais são cultivados e processados, pois eles não causam efeitos negativos como o desmatamento.'
  UNION ALL SELECT @qid,'E','Propor que ela concentre seus esforços em promover o uso de alimentos ultraprocessados, visto que não dependem de recursos naturais para serem produzidos e, por isso, auxiliam na preservação de plantas e na diminuição da poluição do meio ambiente.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: dedaleira, digoxina e função quadrática — Q31
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Durante o Renascimento, houve um aumento de interesse por plantas medicinais. Desse período, data o primeiro uso medicinal da dedaleira, da qual, hoje, é obtido um fitofármaco conhecido como digoxina, usado no tratamento de insuficiência cardíaca.

Suponha que, nesse período histórico, a eficácia do tratamento com dedaleira, em função das semanas de tratamento, pudesse ser estimada pela expressão matemática

E(t) = -2t^2 + 15t + 9

em que E(t) é a eficácia do tratamento, em porcentagem, e t é o tempo, em semanas, desde o início do tratamento (t maior ou igual a 0).

Assinale a alternativa na qual é apontada a eficácia do tratamento após 6 semanas.','Médio','Função quadrática — aplicação','Vestibulinho','B',2,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'11%' AS texto
  UNION ALL SELECT @qid,'B','27%'
  UNION ALL SELECT @qid,'C','43%'
  UNION ALL SELECT @qid,'D','59%'
  UNION ALL SELECT @qid,'E','75%'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: Casa Familiar Rural — Q32
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No estado de Santa Catarina, em algumas escolas rurais, funciona o projeto Casa Familiar Rural, promovido pela Secretaria de Estado da Educação em parceria com a Associação das Casas Familiares Rurais. Essas escolas recebem principalmente filhos de agricultores que terminaram o Ensino Fundamental II e irão cursar o Ensino Médio com Qualificação Técnica em Agricultura. Esses jovens passam uma semana em aula na escola e a outra no sítio da família, aplicando o que aprenderam.

A primeira Casa Familiar Rural foi criada em 1937, na França. A implantação desse modelo foi ideia de algumas famílias de agricultores que queriam para os filhos, além da educação formal, um ensino profissionalizante.

Em um determinado dia, a primeira aula é de História, sobre o processo de independência do Brasil. A segunda é o dimensionamento de piquetes (área cercada para pastagem animal), depois da qual, na aula de matemática, com os números coletados na aula prática, são feitos cálculos que serão usados no dia a dia da propriedade. Assim, os alunos vão tomando gosto pelos assuntos da terra.

Com base no texto, é correto afirmar que','Fácil','Educação do campo — Casa Familiar Rural','Vestibulinho','E',1,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'as aulas são ministradas nas propriedades rurais das famílias dos alunos para evitar o desperdício de dinheiro público na construção de escolas.' AS texto
  UNION ALL SELECT @qid,'B','as escolas, como a Casa Familiar Rural, apesar de ensinar os filhos de agricultores a plantar e a tratar de animais, não são reconhecidas pelo governo brasileiro.'
  UNION ALL SELECT @qid,'C','o modelo educacional Casa Familiar Rural foi criado para ser aplicado na França, inviabilizando sua implantação no Brasil, que não detém tecnologias agrícolas avançadas.'
  UNION ALL SELECT @qid,'D','o ensino profissionalizante implantado pelas escolas rurais impede seus estudantes de ingressarem em um curso de nível superior pela ausência de disciplinas obrigatórias.'
  UNION ALL SELECT @qid,'E','os estudantes, além de adquirir competências e habilidades comuns a qualquer escola brasileira, também adquirem conhecimentos relacionados ao seu dia a dia no campo.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: Chico Mendes — Q33
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Francisco Alves Mendes Filho, mais conhecido como Chico Mendes, foi um profissional seringueiro. Morava na cidade de Xapuri, interior do Acre. Ele era um ativista que lutava pela conservação do meio ambiente e defendia uma reforma agrária que tornasse a distribuição de terras mais igualitária. Além disso, era, também, fundador de reservas extrativistas não predatórias em seu estado. Com seu ativismo em prol da defesa do meio ambiente, começou a criar inimigos em seu entorno. Em 1988, recebeu diversas ameaças de morte, mas não parou de lutar por aquilo que acreditava. Em 22 de dezembro daquele ano, Chico Mendes foi assassinado na cozinha de sua casa.

Uma das principais atividades inerentes à profissão de Chico Mendes é','Fácil','Extrativismo — seringueiros','Vestibulinho','C',7,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'distribuir terras na floresta para projetos de plantação de soja e para a pecuária leiteira.' AS texto
  UNION ALL SELECT @qid,'B','derrubar as seringueiras, que são árvores exóticas, para a implantação de reservas extrativistas.'
  UNION ALL SELECT @qid,'C','talhar a seringueira para extrair e recolher o látex, que é a matéria-prima da borracha natural.'
  UNION ALL SELECT @qid,'D','demarcar as terras indígenas para serem utilizadas, posteriormente, em projetos de reforma agrária.'
  UNION ALL SELECT @qid,'E','organizar sindicatos que permitam o desmatamento da floresta para fomentar o processo de industrialização da região.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: drogas do sertão — Q34
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A partir do século XVI, a Bacia Amazônica se configurou um cenário de disputas territoriais entre alguns países europeus, que se digladiaram pelo domínio da região a fim de se apropriar dos ricos e variados recursos naturais ali existentes. A vitória ficou com a Coroa Portuguesa, que intensificou o processo de ocupação territorial e exploração das chamadas "drogas do sertão", produtos da atividade extrativista de alto valor econômico na época.

Essas drogas eram','Médio','Extrativismo colonial na Amazônia','Vestibulinho','E',6,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'entorpecentes sintéticos vendidos para os Estados Unidos.' AS texto
  UNION ALL SELECT @qid,'B','produtos pecuários utilizados pela população indígena.'
  UNION ALL SELECT @qid,'C','artefatos semi-industrializados consumidos no Brasil.'
  UNION ALL SELECT @qid,'D','insumos agrícolas comercializados com o povo Maia.'
  UNION ALL SELECT @qid,'E','especiarias exportadas para o mercado europeu.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Texto de apoio: soja e tratores a diesel — Q35, Q36
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Produção de soja e tratores a diesel',
'O Brasil é o maior produtor mundial de soja, com mais de 150 milhões de toneladas na safra 2022/2023, representando aproximadamente 42% da produção global. Para atingir essa produtividade agrícola, os tratores movidos a diesel são essenciais, pois permitem a cobertura mais eficiente de grandes áreas de plantio.',
4,2
WHERE @ja_existe_v25 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No equipamento mencionado no texto, a transformação de energia ocorrida que mais contribui para a produtividade agrícola é de energia','Médio','Transformações de energia — motor a combustão','Vestibulinho','A',4,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'química para energia cinética.' AS texto
  UNION ALL SELECT @qid,'B','elétrica para energia térmica.'
  UNION ALL SELECT @qid,'C','química para energia sonora.'
  UNION ALL SELECT @qid,'D','cinética para energia térmica.'
  UNION ALL SELECT @qid,'E','luminosa para energia cinética.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considerando que a velocidade média de um trator movido a diesel é de 10 km/h, assinale a alternativa que apresenta o tempo necessário, em minutos, para que ele percorra o perímetro externo de uma plantação com formato quadrado de lado igual a 500 m.','Médio','Velocidade média e perímetro','Vestibulinho','B',2,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'3' AS texto
  UNION ALL SELECT @qid,'B','12'
  UNION ALL SELECT @qid,'C','20'
  UNION ALL SELECT @qid,'D','200'
  UNION ALL SELECT @qid,'E','250'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: quina amarela e malária — Q37
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No Peru, colonizadores espanhóis observaram que os povos indígenas tratavam a febre com produtos obtidos da casca e das folhas da planta Cinchona ledgeriana (quina amarela).

Posteriormente, pesquisadores descobriram que essa planta tinha grande eficácia no tratamento da febre causada pela malária, um tipo de doença infecciosa. Isso ocorre devido ao fato de o princípio ativo importante nesse tratamento, a quinina, quando ingerida, elimina a febre dessa doença por causar a morte do parasita da malária.

A respeito dessa doença, pode-se afirmar corretamente que é','Fácil','Malária — agente etiológico','Vestibulinho','E',3,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'transmitida por contato direto de pessoa a pessoa.' AS texto
  UNION ALL SELECT @qid,'B','transmitida pela fêmea infectada do inseto barbeiro.'
  UNION ALL SELECT @qid,'C','causada pela bactéria parasita do gênero Escherichia.'
  UNION ALL SELECT @qid,'D','causada pelo protozoário parasita do gênero Trypanosoma.'
  UNION ALL SELECT @qid,'E','causada pelo protozoário parasita do gênero Plasmodium.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: mandioca, alimento do século XXI — Q38
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A importância da mandioca para diferentes povos ao redor do mundo conferiu-lhe o título de alimento do século XXI pela Organização das Nações Unidas (ONU), após um esforço para que diversos países aumentassem a sua produção.

No Brasil, a mandioca foi produto fundamental também na dieta dos colonizadores europeus, dos navegadores e dos africanos escravizados, chegando até os dias atuais.

Sobre essa planta, é correto afirmar que','Médio','Mandioca — história e cultura indígena','Vestibulinho','B',6,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'não tem valor nutricional, sendo utilizada apenas em cultos religiosos como forma de abrir a mente e criar visões místicas, devido ao seu potencial alucinógeno.' AS texto
  UNION ALL SELECT @qid,'B','é cultivada há mais de quatro mil anos no território que, atualmente, corresponde ao Brasil, e é considerada um alimento sagrado por diferentes povos indígenas.'
  UNION ALL SELECT @qid,'C','seu consumo está restrito a grupos ribeirinhos tradicionais da Amazônia, uma vez que a planta perdeu espaço na mesa dos brasileiros de outras regiões.'
  UNION ALL SELECT @qid,'D','contém cianeto, uma substância tóxica fatal para humanos e animais e, por isso, sua comercialização foi proibida em todo o território nacional.'
  UNION ALL SELECT @qid,'E','foi introduzida pelos imigrantes árabes, especialmente os libaneses, que chegaram ao país entre o final do século XIX e o início do século XX.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Texto de apoio: moringa (Moringa oleífera) — Q39, Q40, Q41, Q42
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Moringa (Moringa oleífera) — superalimento do futuro',
'A organização não governamental World Wide Fund for Nature (WWF) elaborou um relatório, no qual listou vários "superalimentos do futuro". Nessa lista, destaca-se a planta moringa (Moringa oleífera), também conhecida em algumas culturas como "acácia-branca" ou "árvore-da-vida" devido a suas propriedades antivirais, anti-inflamatórias, antidepressivas e antifúngicas.

Suas folhas são ricas em proteínas, aminoácidos, vitaminas A e C, além de possuírem elevado teor de minerais como cálcio, potássio, fósforo, magnésio e ferro. Alguns desses minerais não só fortalecem ossos e dentes, como também colaboram na contração muscular. Possuem também muitas fibras que ajudam na atividade intestinal e mantêm a sensação de saciedade.

Dentro de suas longas vagens, ficam as sementes, que, quando trituradas e adicionadas à água barrenta, têm a capacidade de atrair impurezas, atuando como um agente purificador natural. Essas sementes são ricas em ácido oleico, que tem sido associado aos níveis elevados de colesterol "bom" no corpo.',
3,2
WHERE @ja_existe_v25 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Baseando-se no texto, é correto afirmar que essa planta','Médio','Propriedades funcionais da moringa','Vestibulinho','E',3,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'provoca intoxicações graves, infecções, alergias e doenças degenerativas que prejudicam a atividade intestinal e o metabolismo do corpo.' AS texto
  UNION ALL SELECT @qid,'B','auxilia na contração muscular, além de fortalecer ossos e dentes devido ao fato de ser rica em minerais, como cálcio, fósforo e magnésio.'
  UNION ALL SELECT @qid,'C','dificulta a mobilidade do tubo digestório, prejudicando o peristaltismo intestinal e aumentando a constipação ou prisão-de-ventre.'
  UNION ALL SELECT @qid,'D','possui longas vagens, que, moídas e ingeridas, regulam a função da tireoide e do pâncreas, diminuindo os níveis do colesterol bom no sangue.'
  UNION ALL SELECT @qid,'E','atua purificando águas barrentas, pois suas sementes liberam substâncias que matam os micro-organismos parasitas e as larvas dos vermes do ambiente aquático.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Sobre os nutrientes da planta mencionada no texto, é correto afirmar que','Médio','Nutrientes — função fisiológica','Vestibulinho','A',3,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o ferro atua como componente da hemoglobina, pigmento responsável pelo transporte de oxigênio dos pulmões aos tecidos do corpo.' AS texto
  UNION ALL SELECT @qid,'B','o potássio regula a quantidade de água no corpo e é essencial para o funcionamento dos olhos, de modo que sua escassez gera uma doença chamada escorbuto.'
  UNION ALL SELECT @qid,'C','a vitamina A atua como anticorpo, defendendo o organismo de micro-organismos parasitas e fortalecendo o sistema imunológico humano.'
  UNION ALL SELECT @qid,'D','o magnésio é essencial para o funcionamento e a produção hormonal da glândula tireoide, além de atuar também no aumento da sensibilidade térmica.'
  UNION ALL SELECT @qid,'E','a vitamina C atua na síntese de proteínas e é produzida pelo corpo humano, de modo que não precisa ser ingerida na alimentação.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Considerando os dados dos elementos químicos encontrados nas folhas da planta moringa, com número atômico (Z) e número de massa (A): cálcio (Ca, Z=20, A=40); potássio (K, Z=19, A=39); fósforo (P, Z=15, A=31); magnésio (Mg, Z=12, A=24); ferro (Fe, Z=26, A=56), assinale a alternativa correta.','Médio','Estrutura atômica — número de nêutrons','Vestibulinho','A',5,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'O cálcio apresenta 20 nêutrons.' AS texto
  UNION ALL SELECT @qid,'B','O ferro apresenta número atômico 56.'
  UNION ALL SELECT @qid,'C','O potássio apresenta número atômico 15.'
  UNION ALL SELECT @qid,'D','O elemento de menor número de massa é o fósforo.'
  UNION ALL SELECT @qid,'E','O elemento com maior número de nêutrons é o magnésio.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As vitaminas são moléculas que não podem ser sintetizadas pelo organismo humano, dessa forma necessita-se da suplementação destes compostos por meio da alimentação. Podem ser divididas, quanto a sua solubilidade, em duas classes: hidrossolúveis (solúvel em água) e lipossolúveis (solúvel em óleo ou gordura). Para uma vitamina ser hidrossolúvel, ela deve apresentar, em sua estrutura, vários grupos que interajam com a água, como os grupos hidroxilas (O-H), bem espalhados por toda sua estrutura.

Observando as estruturas das vitaminas A e C presentes nas folhas da planta moringa: a vitamina A apresenta uma longa cadeia de hidrocarboneto com apenas um grupo hidroxila (O-H) em uma das extremidades; já a vitamina C apresenta uma estrutura menor, com quatro grupos hidroxila (O-H) espalhados por toda a molécula.

De acordo com o texto, é correto afirmar que a vitamina','Médio','Solubilidade de vitaminas e polaridade','Vestibulinho','C',5,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'A é hidrossolúvel.' AS texto
  UNION ALL SELECT @qid,'B','C é lipossolúvel.'
  UNION ALL SELECT @qid,'C','C é mais solúvel em água que a vitamina A.'
  UNION ALL SELECT @qid,'D','A apresenta várias hidroxilas em sua estrutura, por isso é solúvel em água.'
  UNION ALL SELECT @qid,'E','C apresenta vários grupos que interagem com óleo e gordura.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: cana-de-açúcar no Brasil colonial — Q43
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'As atividades ligadas à cana-de-açúcar praticamente definiram a economia colonial. A vida cotidiana girava em torno dos engenhos e do modo de viver que emanavam, por isso os vínculos sociais foram se definindo nesses espaços, nos quais público e privado se misturavam, e os quais agregavam colonizadores, colonos e colonizados em torno das relações de trabalho.

A produção de açúcar no Brasil colonial se baseou em três características que definiram as estruturas de nossa sociedade até a atualidade. Essas características são','Fácil','Economia açucareira colonial','Vestibulinho','C',6,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'diversificação de culturas, reforma agrária e mão de obra assalariada.' AS texto
  UNION ALL SELECT @qid,'B','rotação trienal de cultivos, feudalismo e mão de obra servil.'
  UNION ALL SELECT @qid,'C','monocultura, latifúndio e mão de obra escravizada.'
  UNION ALL SELECT @qid,'D','sistema agroflorestal, agricultura familiar e mão de obra livre.'
  UNION ALL SELECT @qid,'E','produção orgânica, propriedade coletiva da terra e trabalho voluntário.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: o papiro no Egito Antigo — Q44
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O papiro foi uma planta de grande importância para os egípcios, uma vez que era abundante em seu território. A planta era utilizada tanto para a confecção de cordas, como para a construção de barcos.

Os egípcios antigos também utilizavam partes dessa planta para','Fácil','Egito Antigo — usos do papiro','Vestibulinho','C',6,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'fabricar uma arma que garantiu sua hegemonia no norte da África.' AS texto
  UNION ALL SELECT @qid,'B','construir os canais que desviavam a água do rio Nilo para as suas plantações de trigo.'
  UNION ALL SELECT @qid,'C','produzir o material fino e resistente que foi utilizado como suporte para a sua escrita.'
  UNION ALL SELECT @qid,'D','criar os pigmentos utilizados na concepção de maquiagem para os olhos e os lábios.'
  UNION ALL SELECT @qid,'E','compor unguentos e pomadas utilizadas no tratamento de doenças de pele.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: Ernest Götsch e agrofloresta — Q45
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Quando o agricultor suíço Ernest Götsch comprou sua fazenda na Bahia, nos anos 1980, quase todos os 510 hectares da propriedade haviam sido desmatados, e os animais silvestres eram raros. Os donos anteriores passaram anos criando porcos e cultivando mandioca de forma convencional, o que esgotou o solo e assoreou 14 riachos que cruzavam a fazenda. "Dentro de pouco menos de dois anos, eu tinha reflorestado tudo", conta o suíço, que também viu todos os riachos renascerem no processo.

Hoje a maior parte da propriedade virou uma reserva ambiental privada, e somente 5 hectares — menos de 1% do terreno — lhe geram receitas. É nessa área que, em meio a grande variedade de frutas, legumes e árvores imensas, ele cultiva um cacau de alto valor, exportado para Portugal.

A partir da leitura do texto, é correto afirmar que','Médio','Agrofloresta e desenvolvimento sustentável','Vestibulinho','E',7,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'investir em áreas desmatadas não gera lucros e receitas.' AS texto
  UNION ALL SELECT @qid,'B','preservar o meio ambiente impede a produção de alimentos.'
  UNION ALL SELECT @qid,'C','criar porcos e cultivar mandioca de forma convencional ajuda a reflorestar áreas degradadas.'
  UNION ALL SELECT @qid,'D','investir na melhora do bem-estar da população necessariamente provoca danos ao meio ambiente.'
  UNION ALL SELECT @qid,'E','preservar o meio ambiente pode gerar renda e desenvolvimento econômico.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Texto de apoio: "Biotecnologia Indígena" (domesticação do cupuaçu) — Q46, Q47, Q48, Q49
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Biotecnologia Indígena — a domesticação do cupuaçu',
'Entre 5 e 8 mil anos atrás, o cupuaçu estava em desenvolvimento na região do médio-alto Rio Negro. Fruta hoje muito apreciada na culinária amazônica, ela (I) não surgiu da evolução natural da floresta: foi obra da mão humana. Os indígenas que viviam na região milhares de anos antes da colonização portuguesa empregaram técnicas de domesticação de plantas para criá-la (II).

Pesquisadores, auxiliados por mateiros – os guias locais da região amazônica –, foram em busca das florestas primárias, aquelas (III) nas quais houve pouca ou nenhuma interferência humana, e constataram que nelas (IV) não se encontrava o cupuaçu.

Se o cupuaçu não nascia "naturalmente" em áreas de fraca interferência humana, era razoável supor que ele (V) seria uma variante domesticada do cupuí, desenvolvida pelos antigos ocupantes da Amazônia.

Como muitas civilizações antigas, os pré-colombianos se valiam de técnicas elaboradas para cruzar os melhores espécimes vegetais, com a finalidade de obter frutas e grãos aprimorados – é isso (VI) que Charles Darwin chamou de "seleção artificial". Foi assim que, a partir do mirrado cupuí, os indígenas do Rio Negro desenvolveram o cupuaçu, fruta mais gorda.

A análise genética também permitiu datar o processo original de domesticação do cupuaçu em meados do Holoceno, época geológica iniciada há cerca de 11 mil anos e na qual (VII) vivemos ainda hoje. Uma segunda fase da domesticação se deu mais recentemente, nos últimos dois séculos, quando a fruta se popularizou e foi introduzida em outras regiões.

Antes da colonização, a Amazônia foi um centro de domesticação e modificação de espécies selvagens. O cupuaçu, sabemos agora, é mais um entre tantos outros frutos criados a partir de técnicas complexas de manejo e cultivo utilizadas pelos povos indígenas para desenvolver novas plantas. "A mandioca, o bacuri e a castanha-do-pará são alguns exemplos de frutos que (VIII) foram manipulados por eles (IX)", diz Matheus Colli-Silva, da USP, responsável pela descoberta. Desenvolvidas há milhares de anos, essas técnicas não comprometiam a estrutura selvagem da Floresta Amazônica. O desmatamento só viria com a ocupação europeia.',
1,2
WHERE @ja_existe_v25 = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Pronomes são importantes elementos de coesão textual e têm a função de retomar ou antecipar informações com as quais eles estabelecem uma referência.

Analisando os pronomes em destaque no texto (numerados de I a IX), é correto afirmar que','Difícil','Coesão textual — referência pronominal','Vestibulinho','E',1,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'I e II se referem ao termo "culinária".' AS texto
  UNION ALL SELECT @qid,'B','II, III e IV se referem ao termo "florestas".'
  UNION ALL SELECT @qid,'C','IV e V se referem à expressão "variante domesticada".'
  UNION ALL SELECT @qid,'D','VI e VII se referem, respectivamente, a "frutas" e "pré-colombianos".'
  UNION ALL SELECT @qid,'E','VIII e IX se referem, respectivamente, a "frutos" e "povos indígenas".'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Sobre as informações presentes no texto, é correto afirmar que','Médio','Domesticação de plantas na Amazônia pré-colonial','Vestibulinho','C',1,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'houve interferência humana nas florestas primárias, pois os guias locais encontraram tanto cupuaçu quanto cupuí nessas áreas.' AS texto
  UNION ALL SELECT @qid,'B','a interferência esporádica dos povos originários da Amazônia na natureza acarretou o surgimento de novas espécies, como o cupuí e o cupuaçu.'
  UNION ALL SELECT @qid,'C','houve duas etapas no processo de domesticação do cupuaçu: a primeira, datada entre 5 e 8 mil anos atrás; a segunda, há cerca de 200 anos.'
  UNION ALL SELECT @qid,'D','as civilizações pré-colombianas se apropriaram dos estudos de Darwin para desenvolver frutas e grãos mais adaptados ao meio em que se encontravam.'
  UNION ALL SELECT @qid,'E','os povos originários já utilizavam técnicas complexas de manejo agrícola, como a modificação genética e o desmatamento, para ampliar a produção de alimentos.'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Assinale a alternativa na qual o elemento coesivo em destaque contribui para expressar uma hipótese.','Médio','Coesão textual — conjunções condicionais','Vestibulinho','D',1,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"Entre 5 e 8 mil anos atrás, o cupuaçu estava sendo desenvolvido na região do médio-alto Rio Negro."' AS texto
  UNION ALL SELECT @qid,'B','"...ela não surgiu da evolução natural da floresta: foi obra da mão humana."'
  UNION ALL SELECT @qid,'C','"Os indígenas que viviam na região milhares de anos antes da colonização portuguesa empregaram técnicas de domesticação de plantas para criá-la."'
  UNION ALL SELECT @qid,'D','"Se o cupuaçu não nascia ''naturalmente'' em áreas de fraca interferência humana, era razoável supor que ele seria uma variante domesticada do cupuí..."'
  UNION ALL SELECT @qid,'E','"Antes da colonização, a Amazônia foi um centro de domesticação e modificação de espécies selvagens."'
) alts WHERE @ja_existe_v25 = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No segundo parágrafo, os travessões em "– os guias locais da região amazônica –" destacam trecho que se refere aos mateiros, apresentando uma','Fácil','Pontuação — função do travessão','Vestibulinho','B',1,2,@tid,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'contradição.' AS texto
  UNION ALL SELECT @qid,'B','explicação.'
  UNION ALL SELECT @qid,'C','retificação.'
  UNION ALL SELECT @qid,'D','enumeração.'
  UNION ALL SELECT @qid,'E','advertência.'
) alts WHERE @ja_existe_v25 = 0;

-- ---------- Questão isolada: poema "cresci feito árvore torta" — Q50
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o poema de João Doederlein (@AKAPOETA):

"cresci feito árvore torta
numa horta
que não deveria ter dado espaço para mim.
cresci perdendo folhas,
alcancei o sol cedo demais,
queimei a ponta dos meus galhos,
e choro junto ao céu em dias de chuva
pra ninguém perceber.
crescer é um pouco de se adaptar
com se aceitar.
é um pouco injusto,
mas é necessário.
minhas raízes me empurram pro céu,
sou árvore que queria ser estrela."

Depreende-se do poema que o processo de crescimento pressupõe','Médio','Interpretação de poema','Vestibulinho','B',1,2,NULL,TRUE
WHERE @ja_existe_v25 = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'reconhecer que esse processo é justo por exigir subserviência e aceitação.' AS texto
  UNION ALL SELECT @qid,'B','conciliar a aceitação de si mesmo com a necessidade de ser resiliente diante dos problemas enfrentados.'
  UNION ALL SELECT @qid,'C','expor sem receios os sofrimentos a fim de depender do apoio das pessoas com quem se convive.'
  UNION ALL SELECT @qid,'D','acelerar o processo de evolução por meio da busca constante pelo sucesso a qualquer custo.'
  UNION ALL SELECT @qid,'E','resignar-se a viver de maneira limitada, mesmo que haja condições propícias ao desenvolvimento.'
) alts WHERE @ja_existe_v25 = 0;
