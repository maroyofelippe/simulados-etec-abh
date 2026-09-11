-- ==========================================================
--  Migração de conteúdo: Banco de questões — Vestibulinho Etec 1º SEM/2026
--  Exame aplicado em 30/11/2025 (Fundação FAT / Centro Paula Souza).
--  Fonte: caderno de questões + gabarito oficial fornecidos pela coordenação.
--  ----------------------------------------------------------
--  Escopo: as 50 questões do caderno foram importadas — todas plenamente
--  respondíveis a partir do texto do enunciado (inclusive a questão do
--  gráfico de setor e a do mapa de estados, cujos dados/coordenadas estão
--  descritos em texto, e a da tirinha, cuja "erro científico" depende da
--  premissa geral da história, não de um detalhe visual específico).
--
--  Este exame é interdisciplinar (não segue o formato SARESP de blocos por
--  disciplina) e não está associado a uma série do Ensino Médio (é uma
--  prova de admissão); o campo "serie" foi preenchido com 'Vestibulinho'.
--
--  Usa textos_apoio para os textos-base compartilhados por mais de uma
--  questão (RF07a).
--
--  Idempotente: mesma técnica das migrações anteriores — variável de
--  sessão travada no início (@ja_existe_vest), sem DELIMITER/stored
--  procedures (incompatível com a execução via db:migrate / mysql2).
--
--  Uso:
--    npm run db:migrate
--    (ou: mysql -u USUARIO -p simulados_etec_abh < database/migrations/2026-09_banco_vestibulinho_1sem2026.sql)
-- ==========================================================
SET @db := DATABASE();

INSERT INTO disciplinas (nome, area)
SELECT 'Língua Inglesa', 'Linguagens'
WHERE NOT EXISTS (SELECT 1 FROM disciplinas WHERE nome = 'Língua Inglesa');

SET @ja_existe_vest := (
  SELECT COUNT(*) FROM questoes WHERE enunciado LIKE 'Leia o texto: "A convivência com os animais mudou os seres humanos%'
);

-- ---------- Questão isolada: domesticação de animais e consumo de leite — Q01
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "A convivência com os animais mudou os seres humanos. Talvez o exemplo mais popular seja o consumo de leite: antes da domesticação animal, as pessoas naturalmente desenvolviam intolerância a lactose à medida que cresciam e não precisavam mais do leite materno. Quando os seres humanos começaram a criar gado, começaram a beber mais leite, havendo uma adaptação do sistema digestivo para o consumo do leite durante toda a vida. A domesticação é parte da conexão humana com os animais, que percorre toda a história e conecta grandes saltos evolutivos, como o desenvolvimento de ferramentas e até da linguagem." (Adaptado) Segundo o texto, a domesticação de animais','Médio','Interpretação de texto','Vestibulinho','D',1,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ocorreu recentemente, no período medieval, e foi possível devido à invenção da linguagem e das ferramentas de pedra.' AS texto
  UNION ALL SELECT @qid,'B','causou danos à saúde humana, que não estava preparada para o consumo de leite na vida adulta, diminuindo a expectativa média de vida do homem contemporâneo.'
  UNION ALL SELECT @qid,'C','aumentou os níveis naturais de intolerância a lactose no homem pré-histórico devido às diferenças entre o leite materno e o leite de vaca.'
  UNION ALL SELECT @qid,'D','contribuiu para o desenvolvimento de aspectos culturais que favoreceram a evolução humana, como a criação de ferramentas e da linguagem.'
  UNION ALL SELECT @qid,'E','provocou saltos evolutivos que atrasaram o desenvolvimento da linguagem e da tecnologia.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Texto de apoio: cães-guia no Brasil — Q02, Q03
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Cães-guia no Brasil',
'Cães-guia são treinados para facilitar a locomoção e conduzir a pessoa cega ou com baixa visão em segurança. Estima-se que, atualmente, 207 cães-guia estão em atividade no Brasil. Em uma perspectiva de distribuição quanto às raças, predominam Labradores (153) e Golden Retriever (16). (Adaptado)',
2, 2
WHERE @ja_existe_vest = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'De acordo com o texto e considerando que existem atualmente, no Brasil, cerca de 6,5 milhões de pessoas com deficiência visual, assinale a alternativa que apresenta a melhor aproximação da razão entre o número de cães-guia em atividade e o número de pessoas com deficiência visual em nosso país, respectivamente.','Médio','Razão e proporção','Vestibulinho','C',2,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'1 para cada 29 000' AS texto
  UNION ALL SELECT @qid,'B','1 para cada 30 500'
  UNION ALL SELECT @qid,'C','1 para cada 31 400'
  UNION ALL SELECT @qid,'D','1 para cada 31 800'
  UNION ALL SELECT @qid,'E','1 para cada 32 700'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Com base nos dados sobre as raças, assinale a alternativa que apresenta o gráfico de setor que melhor representa a distribuição de cães-guia. Cada alternativa mostra um gráfico de setor com os percentuais de Labradores, Golden Retriever e Outras raças, respectivamente:','Difícil','Gráficos e porcentagem','Vestibulinho','D',2,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Labradores 77%, Golden Retriever 8%, Outras raças 16%' AS texto
  UNION ALL SELECT @qid,'B','Labradores 77%, Golden Retriever 16%, Outras raças 8%'
  UNION ALL SELECT @qid,'C','Labradores 33%, Golden Retriever 33%, Outras raças 33%'
  UNION ALL SELECT @qid,'D','Labradores 74%, Golden Retriever 8%, Outras raças 18%'
  UNION ALL SELECT @qid,'E','Labradores 74%, Golden Retriever 18%, Outras raças 8%'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: Clarice Lispector, "Um sopro de vida" — Q04
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "Meu cão me revigora toda. Sem falar que dorme às vezes aos meus pés enchendo o quarto da cálida vida úmida. O meu cão me ensina a viver. Ele só fica ''sendo''. ''Ser'' é a sua atividade." (LISPECTOR, Clarice. Um sopro de vida. Org. Olga Borelli. Rio de Janeiro: Rocco, 1999, p. 43.) Na passagem apresentada, o cão é usado como modelo a ser seguido por','Médio','Interpretação de texto literário','Vestibulinho','E',1,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'realizar com simplicidade ações complexas, como acalentar as dores alheias e submeter-se constantemente às vontades dos outros.' AS texto
  UNION ALL SELECT @qid,'B','sentir-se acolhido ao ser inferiorizado diante de seus superiores hierárquicos, evidenciando a aceitação de sua posição social.'
  UNION ALL SELECT @qid,'C','manter uma atitude de inquietação constante diante da existência, levando-o a revigorar a sociedade em que se encontra.'
  UNION ALL SELECT @qid,'D','regozijar-se diante da possibilidade de tornar um outro indivíduo tenso pela simples companhia que pode oferecer.'
  UNION ALL SELECT @qid,'E','viver com plenitude sua existência, sem se deixar levar por infrutíferas angústias durante esse processo.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: felinos no Antigo Egito — Q05
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "Uma das primeiras domesticações de gatos aconteceu no antigo Egito. Os gatos, felinos menores, viviam entre os humanos, sendo essenciais para a sociedade egípcia na proteção contra pragas de casas e de celeiros. Já os felinos maiores, principalmente leões e leopardos, eram admirados por suas qualidades, sendo, muitas vezes, símbolos da realeza e de alguns deuses do panteão egípcio. Por meio da observação, os egípcios vieram a admirar os felinos pela sua natureza complexa e dual. Para eles, esses animais combinavam graça, fertilidade e cuidado suave com agressão, rapidez e perigo. Os deuses relacionados a essas qualidades eram frequentemente representados com características felinas." (Adaptado) A partir da leitura do texto, é correto concluir que','Médio','Interpretação de texto','Vestibulinho','A',1,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'os egípcios observavam nos felinos algumas características que consideravam admiráveis, como graça, fertilidade, cuidado e rapidez, e as projetavam em seus deuses.' AS texto
  UNION ALL SELECT @qid,'B','os felinos eram importantes para a sociedade egípcia apenas por suas funções práticas, como o controle de pragas em casas e em celeiros.'
  UNION ALL SELECT @qid,'C','a admiração dos egípcios se restringia aos felinos menores, que viviam entre os humanos e eram considerados símbolos de realeza.'
  UNION ALL SELECT @qid,'D','a observação atenta levou os egípcios a considerar os felinos uma espécie contraditória cujas características de personalidade deveriam ser evitadas.'
  UNION ALL SELECT @qid,'E','as divindades egípcias representavam ideais nobres e estavam relacionadas à crença de que os seres humanos são superiores aos animais.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: convivência com pets e desenvolvimento infantil — Q06
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "A convivência com pets pode ajudar no desenvolvimento afetivo e psicológico, aumentando a produção de endorfina no organismo, minimizando os efeitos da depressão, da dor e da ansiedade. Pesquisas revelam que 80% das pessoas se sentem menos solitárias ao conviver com um animal de estimação e que o ato de fazer carinho em um animal é capaz de diminuir a frequência cardíaca e a pressão sanguínea de uma pessoa. Entre os efeitos positivos de intervenções assistidas realizadas com animais e destinadas a crianças, estão melhora na convivência social, na capacidade de concentração e nas habilidades de comunicação." (Adaptado) De acordo com o texto, a convivência entre crianças e animais acarreta','Fácil','Interpretação de texto','Vestibulinho','E',1,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'aumento da produção de endorfina no organismo, tornando dispensável qualquer tipo de acompanhamento emocional.' AS texto
  UNION ALL SELECT @qid,'B','dependência emocional tão intensa que a criança rejeita completamente o convívio social, isolando-se do mundo.'
  UNION ALL SELECT @qid,'C','redução da necessidade de tomar medicamentos, de fazer exercícios físicos e de se preocupar com alimentação saudável.'
  UNION ALL SELECT @qid,'D','desfavorecimento do desenvolvimento da capacidade de organização, uma vez que ajuda a criança a criar uma rotina.'
  UNION ALL SELECT @qid,'E','melhora habilidades de convivência social e de comunicação, contribuindo para o desenvolvimento afetivo e psicológico.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: animais no espaço (Corrida Espacial) — Q07
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "A cachorrinha Laika, lançada no satélite russo Sputnik 2, em 1957, não retornou. Entre 1948 e 1961, União Soviética (URSS) e Estados Unidos (EUA) enviaram 65 animais ao espaço, sendo 48 cães, 15 macacos e 2 coelhos. Vinte e sete deles morreram em acidentes devido a circunstâncias imprevistas durante a empreitada. O envio de animais não humanos ao espaço começou a cessar com o lançamento de pessoas. Yuri Gagarin, que ficou uma hora e meia no espaço em 1961, brincou uma vez dizendo que foi, ao mesmo tempo, a \"primeira pessoa e o último cachorro no espaço\"." (Adaptado) O processo histórico referido no texto é característico do período conhecido como','Médio','Guerra Fria e corrida espacial','Vestibulinho','E',6,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Primeira Revolução Industrial.' AS texto
  UNION ALL SELECT @qid,'B','Segunda Guerra Mundial.'
  UNION ALL SELECT @qid,'C','Reconstrução Europeia.'
  UNION ALL SELECT @qid,'D','Grandes Navegações.'
  UNION ALL SELECT @qid,'E','Guerra Fria.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Texto de apoio: xerimbabos — animais de estimação indígenas — Q08, Q09, Q10, Q11, Q12
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Xerimbabos — a relação indígena com os animais',
'Certa manhã, as irmãs Yzuahy, de 6 anos, e Ywàna, de 3, tomaram um susto: um bicho-preguiça estava dentro de casa. O visitante inesperado entrou de mansinho pela janela e logo chegou ao colo das irmãs Tenetehar sem provocar medo. Pelo contrário, o que havia era encanto.

Moradoras da terra indígena do Alto Rio Guamá, no Pará, Yzuahy e Ywàna aprenderam com os pais e os avós que bichos da floresta não fazem mal nem precisam ser afugentados. A relação com eles é ancestral e baseada no cuidado mútuo. "Elas sempre foram ensinadas que, sem natureza e animais, nada progride", conta Josiane Tenetehar, mãe das meninas.

Além do bicho-preguiça, elas cuidaram por um tempo de um filhote de capivara. "Não temos animais de estimação. A preguiça vem às vezes, chega em casa e depois volta. A capivara ficava com as meninas porque os guerreiros da aldeia acharam ela na mata sem a mãe e trouxeram para ser cuidada. Quando cresceu, ficou livre e acabou indo com o seu bando", explica Josiane.

Nos territórios indígenas, não há pets do jeito como vemos nas cidades. Os animais vivem soltos na floresta. E mesmo os que recebem cuidados de crianças ou adultos nas aldeias podem voltar para a mata. A relação com eles é de cuidado e de respeito, equilibrando a subsistência e o bem-viver. Em vez de cachorros e gatinhos, são araras, papagaios, jabutis, macacos e capivaras os companheiros de brincadeiras e afagos dos pequenos.

Para esses bichinhos, dá-se o nome de xerimbabos, que em tupi significa "coisa muito querida". A palavra aparece em vários registros históricos quando há a descrição da relação entre os povos originários e os animais da mata, sendo o termo cunhado pelos próprios indígenas. Nas aldeias, faz parte da cultura cuidar de tudo o que tem vida na floresta.
(Adaptado)',
1, 2
WHERE @ja_existe_vest = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Segundo o texto, é correto afirmar que','Médio','Interpretação de texto','Vestibulinho','D',1,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o vocábulo "xerimbabos", cujo sentido equivale a "entes muito amados", é usado para se referir às crianças que desenvolvem afeto pelos animais silvestres.' AS texto
  UNION ALL SELECT @qid,'B','o movimento repentino de ataque do bicho-preguiça traumatizou as irmãs Yzuahy e Ywàna, desacostumadas ao convívio com a natureza local.'
  UNION ALL SELECT @qid,'C','a relação afetiva desenvolvida entre os animais silvestres e os domésticos acarretou desequilíbrio ecológico para a comunidade indígena.'
  UNION ALL SELECT @qid,'D','a relação com a fauna e a flora é essencial para uma vivência harmônica na sociedade em que as irmãs residem.'
  UNION ALL SELECT @qid,'E','o cuidado com a fauna local realizado pelos indígenas introduziu o conceito de "animais domésticos" à comunidade.'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Além dos animais citados no texto, muitos grupos indígenas ainda consideram águias, corujas, sabiás, raposas, cobras e tartarugas como animais sagrados, sendo a onça um símbolo cultural e espiritual, vista como a guardiã da floresta. Sobre os animais citados, é correto afirmar que','Difícil','Zoologia - características dos animais','Vestibulinho','D',3,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'as aves se caracterizam por serem animais carnívoros, dotados de bico forte e curvo, com garras afiadas, com pelos e escamas no corpo e nas patas.' AS texto
  UNION ALL SELECT @qid,'B','a relação dos indígenas com os xerimbabos tem o objetivo de garantir a criação desses animais em cativeiro para o abate diário e a alimentação da comunidade.'
  UNION ALL SELECT @qid,'C','os xerimbabos são muito queridos pelos indígenas e, apesar de estarem em cativeiro, são cuidados com muito respeito e soltos na floresta quando em perigo de extinção.'
  UNION ALL SELECT @qid,'D','a onça é considerada a guardiã da floresta, ocupa o topo da cadeia alimentar por se alimentar de herbívoros maiores e de predadores menores, mantendo dessa forma o equilíbrio ambiental.'
  UNION ALL SELECT @qid,'E','os animais considerados sagrados pelos indígenas se caracterizam por serem carnívoros e por conseguirem manter a temperatura corporal constante, independentemente da temperatura do ambiente.'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'No texto, aparecem em negrito as expressões "Certa manhã", "no Pará", "com as meninas" e "Nas aldeias". As expressões em negrito no texto denotam, respectivamente,','Difícil','Advérbios e adjuntos adverbiais','Vestibulinho','E',1,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'tempo, origem, causa e lugar.' AS texto
  UNION ALL SELECT @qid,'B','condição, destino, instrumento e causa.'
  UNION ALL SELECT @qid,'C','consequência, origem, companhia e tempo.'
  UNION ALL SELECT @qid,'D','condição, destino, ferramenta e causa.'
  UNION ALL SELECT @qid,'E','tempo, lugar, companhia e lugar.'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Na passagem "quando cresceu, ficou livre e acabou indo com o seu bando", a expressão "acabou indo" aponta','Médio','Locuções verbais e aspecto verbal','Vestibulinho','C',1,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'uma ação inacabada que é realizada recorrentemente.' AS texto
  UNION ALL SELECT @qid,'B','uma ação inacabada que se prolonga infinitamente.'
  UNION ALL SELECT @qid,'C','uma ação finalizada que é enfatizada ao terminar.'
  UNION ALL SELECT @qid,'D','o início de uma ação que se realiza rapidamente.'
  UNION ALL SELECT @qid,'E','o desenvolvimento de uma ação que não se concretiza.'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O pronome eles, sublinhado no quarto parágrafo do texto ("mesmo os que recebem cuidados de crianças ou adultos nas aldeias podem voltar para a mata. A relação com eles é de cuidado e de respeito"), refere-se aos termos','Difícil','Coesão pronominal','Vestibulinho','D',1,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'"territórios" e "pets".' AS texto
  UNION ALL SELECT @qid,'B','"pets" e "adultos".'
  UNION ALL SELECT @qid,'C','"indígenas" e "animais".'
  UNION ALL SELECT @qid,'D','"pets" e "animais".'
  UNION ALL SELECT @qid,'E','"territórios" e "adultos".'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: equoterapia — Q13
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Um município deseja implementar um projeto de equoterapia que terá uma equipe multidisciplinar (psicólogos, fisioterapeutas, pedagogos, fonoaudiólogos, entre outros) e 12 cavalos preparados especialmente para as atividades. Os atendimentos acontecerão de terça a sexta-feira, e cada pessoa assistida pelo projeto deverá realizar duas sessões por semana, tendo cada uma das sessões duração de 30 minutos. Sabendo que cada cavalo não pode trabalhar mais do que 3 horas por dia, o número máximo de pessoas que poderão ser atendidas, por semana, pelo projeto é','Difícil','Problemas de contagem e proporção','Vestibulinho','A',2,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'144.' AS texto
  UNION ALL SELECT @qid,'B','180.'
  UNION ALL SELECT @qid,'C','288.'
  UNION ALL SELECT @qid,'D','360.'
  UNION ALL SELECT @qid,'E','576.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: tirinha "Piteco" (Maurício de Sousa) — Q14
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia a tirinha "Piteco", de Maurício de Sousa: um homem pré-histórico encontra um ovo semienterrado que eclode, revelando um filhote de dinossauro; ele o adota como um "bebê de estimação" e passa a conviver normalmente com o pequeno réptil. Criado por Maurício de Sousa na década de 1960, Horácio é um adorável filhote de Tiranossauro Rex. Embora o personagem faça um grande sucesso desde sua criação, há um erro científico na tirinha, uma vez que','Médio','Evolução e extinção','Vestibulinho','D',3,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'filhotes de répteis carnívoros, como o Tiranossauro Rex, não se desenvolviam em ovos, mas no útero das fêmeas, como ocorre com os mamíferos.' AS texto
  UNION ALL SELECT @qid,'B','os dinossauros, embora convivessem harmonicamente com os seres humanos, não eram capazes de manter relações de afeto com as pessoas.'
  UNION ALL SELECT @qid,'C','o Tiranossauro Rex, assim como as aves, tinha o hábito instintivo de enterrar inteiramente seus ovos para protegê-los dos predadores.'
  UNION ALL SELECT @qid,'D','os dinossauros foram extintos há milhões de anos, muito antes da aparição dos primeiros hominídeos na Terra.'
  UNION ALL SELECT @qid,'E','as evidências paleontológicas indicam que as fêmeas de Tiranossauros Rex não se afastavam de seus ovos, já que eram animais domésticos.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Texto de apoio: respiração aeróbica (oxigênio + glicose) — Q15, Q16
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Respiração aeróbica: oxigênio e glicose',
'O oxigênio (O2) é essencial para a respiração aeróbica. Durante esse processo, o oxigênio reage com a glicose (C6H12O6) liberando energia.',
5, 2
WHERE @ja_existe_vest = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O principal produto gasoso formado no processo mencionado é','Fácil','Reações químicas - respiração celular','Vestibulinho','A',5,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'dióxido de carbono (CO2).' AS texto
  UNION ALL SELECT @qid,'B','monóxido de carbono (CO).'
  UNION ALL SELECT @qid,'C','nitrogênio (N2).'
  UNION ALL SELECT @qid,'D','hidrogênio (H2).'
  UNION ALL SELECT @qid,'E','ozônio (O3).'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O oxigênio e a glicose são classificados, respectivamente, como','Médio','Substâncias simples e compostas','Vestibulinho','B',5,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'substância composta e substância simples.' AS texto
  UNION ALL SELECT @qid,'B','substância simples e substância composta.'
  UNION ALL SELECT @qid,'C','substância composta e substância composta.'
  UNION ALL SELECT @qid,'D','substância composta e mistura.'
  UNION ALL SELECT @qid,'E','substância simples e mistura.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: Alfred Wegener e a Deriva Continental — Q17
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "Alfred Wegener foi um climatologista alemão que desenvolveu a teoria da Deriva Continental, apresentada numa palestra proferida em 1912. Em 1915, publicou o seu livro A origem dos Continentes e dos Oceanos, em que a ideia fundamental consistia no fato de que os continentes estiveram todos unidos no passado, constituindo um continente único, o supercontinente Pangeia, rodeado pelo oceano Pantalassa. Posteriormente, o continente Pangeia sofreu fragmentações sucessivas, o que originou diferentes continentes que se deslocaram até às posições atuais. Este conjunto de ideias ficou conhecido como a teoria da Deriva Continental." (Adaptado) Um dos argumentos de Wegener que fundamenta sua teoria é de base paleontológica e se respalda na existência de','Médio','Deriva continental e tectônica de placas','Vestibulinho','C',7,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'água doce presente em todos os continentes.' AS texto
  UNION ALL SELECT @qid,'B','formações geomorfológicas similares em continentes diferentes.'
  UNION ALL SELECT @qid,'C','fósseis idênticos encontrados em continentes hoje afastados.'
  UNION ALL SELECT @qid,'D','destroços de navios localizados ao longo das costas oceânicas.'
  UNION ALL SELECT @qid,'E','justaposição entre as linhas de costa da Ásia e da América do Sul.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: magnetorrecepção em aves — Q18
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "A Terra pode ser considerada um grande ímã, em que o polo Norte magnético está próximo ao polo Sul geográfico e, por sua vez, o polo Sul magnético está próximo ao polo Norte geográfico. Diversos animais, como as aves, possuem uma característica denominada magnetorrecepção, que é a capacidade de perceber o campo geomagnético. Isso permite ao animal orientar-se durante o voo em relação à sua localização (altitude, direção e sentido de deslocamento). Essa percepção do campo geomagnético pode ocorrer por diferentes mecanismos, como glândulas, células e/ou proteínas." Suponha que uma ave com essa capacidade migre diretamente do Canadá até o Brasil. Nessas condições, é correto afirmar que a ave','Difícil','Eletromagnetismo - campo magnético terrestre','Vestibulinho','D',4,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'se desloca de uma posição próxima ao polo Sul magnético no sentido do polo Sul geográfico.' AS texto
  UNION ALL SELECT @qid,'B','se desloca em trajetória retilínea traçada pelas linhas de campo geográfico.'
  UNION ALL SELECT @qid,'C','se desloca em uma trajetória paralela às linhas latitudinais.'
  UNION ALL SELECT @qid,'D','usa glândulas, células ou proteínas como bússolas elétricas.'
  UNION ALL SELECT @qid,'E','usam o sistema de geoposicionamento denominado GPS.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: campo magnético e notação científica — Q19
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "As aves conhecidas como pisco-de-peito-ruivo, ao migrarem, sempre conseguem retornar ao exato ponto de onde partiram, pois conseguem perceber o campo magnético da Terra que, próximo a sua superfície, tem densidade média de fluxo magnético estimada de 50 µT — cerca de um centésimo da força de um ímã de geladeira." (Adaptado) Sabendo que 1 µT = 1 × 10⁻⁶ T, assinale a alternativa que apresenta corretamente, em notação científica, a densidade média de fluxo magnético de um imã de geladeira, em T.','Difícil','Notação científica','Vestibulinho','E',4,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'5,0 × 10⁻⁹' AS texto
  UNION ALL SELECT @qid,'B','0,5 × 10⁻⁶'
  UNION ALL SELECT @qid,'C','5,0 × 10⁻⁶'
  UNION ALL SELECT @qid,'D','0,5 × 10⁻³'
  UNION ALL SELECT @qid,'E','5,0 × 10⁻³'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: migração do beija-flor-preto (mapa do Brasil) — Q20
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto e observe um mapa político do Brasil com os estados e a rosa dos ventos: "O domínio morfoclimático do Cerrado abriga diversas espécies da fauna. Somente de aves, são estimadas quase 900 espécies. Porém, apenas cerca de 40 espécies são endêmicas, ou seja, ocorrem apenas em seu domínio. Isso se deve ao fato de o Cerrado abrigar diversas aves migratórias. O beija-flor-preto é uma ave característica da Mata Atlântica, mas que migra para o interior do país, visitando as flores do Cerrado." (Adaptado) Com base no mapa, se, por ventura, um beija-flor-preto migrar de uma área de Mata Atlântica, localizada no estado de Sergipe, para uma área de Cerrado, localizada no estado de Goiás, ele voará no sentido','Difícil','Orientação geográfica e regiões do Brasil','Vestibulinho','C',7,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Noroeste.' AS texto
  UNION ALL SELECT @qid,'B','Nordeste.'
  UNION ALL SELECT @qid,'C','Sudoeste.'
  UNION ALL SELECT @qid,'D','Sudeste.'
  UNION ALL SELECT @qid,'E','Leste.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Texto de apoio: canção "Passaredo" (Chico Buarque e Francis Hime) — Q21, Q22, Q23, Q24
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Passaredo — Chico Buarque de Hollanda e Francis Hime',
'Ei, quero-quero
Oi, tico-tico
Anum, pardal, chapim
Xô, cotovia
Xô, ave-fria
Xô, pescador-martim
Some, rolinha
Anda, andorinha
Te esconde, bem-te-vi
Voa, bicudo
Voa, sanhaço
Vai, juriti
Bico calado
Muito cuidado
Que o homem vem aí
O homem vem aí
O homem vem aí.
(Adaptado)',
1, 2
WHERE @ja_existe_vest = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A letra da canção nos remete à','Médio','Interpretação de canção','Vestibulinho','D',1,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ameaça que os pássaros representam aos seres humanos.' AS texto
  UNION ALL SELECT @qid,'B','relação harmoniosa entre os seres humanos e a natureza.'
  UNION ALL SELECT @qid,'C','preocupação com as doenças transmitidas por pássaros.'
  UNION ALL SELECT @qid,'D','destruição da natureza causada pelos seres humanos.'
  UNION ALL SELECT @qid,'E','necessidade de construção de viveiros nas florestas.'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O título da canção apresentada se justifica pela','Difícil','Recursos estilísticos e título','Vestibulinho','E',1,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ação de expulsão dos seres humanos do meio ambiente.' AS texto
  UNION ALL SELECT @qid,'B','dimensão dos versos, ressaltando a velocidade do desmatamento.'
  UNION ALL SELECT @qid,'C','sonoridade das vogais fechadas que remetem à melancolia da canção.'
  UNION ALL SELECT @qid,'D','repetição inicial de termos, expressando a posição dos animais nas árvores.'
  UNION ALL SELECT @qid,'E','enumeração de substantivos, indicando a diversidade de aves existentes.'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Assinale a alternativa que apresenta um sinônimo para o termo destacado em negrito na canção, no verso "Muito cuidado / Que o homem vem aí".','Médio','Conjunções - relação causal','Vestibulinho','A',1,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'porque' AS texto
  UNION ALL SELECT @qid,'B','ainda que'
  UNION ALL SELECT @qid,'C','desde que'
  UNION ALL SELECT @qid,'D','contanto que'
  UNION ALL SELECT @qid,'E','à medida que'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A canção apresentada se utiliza tanto de imperativos, como em "some", "anda" e "te esconde", quanto de vocativos, como em "rolinha", "andorinha" e "bem-te-vi", com o objetivo de','Difícil','Funções da linguagem - imperativo e vocativo','Vestibulinho','C',1,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'expressar as emoções vivenciadas pelo eu lírico diante do canto dos pássaros.' AS texto
  UNION ALL SELECT @qid,'B','manter um diálogo necessário com a natureza para a preservação da humanidade.'
  UNION ALL SELECT @qid,'C','persuadir os interlocutores a realizarem ações para protegê-los de uma iminente ameaça.'
  UNION ALL SELECT @qid,'D','evidenciar o domínio de estruturas poéticas que valorizam a sonoridade dos versos.'
  UNION ALL SELECT @qid,'E','ensinar os leitores sobre a diversidade de espécies existentes na flora brasileira.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: visão da águia-de-asa-redonda — Q25
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "A águia-de-asa-redonda é uma ave de rapina com uma das visões mais poderosas do reino animal. A sua capacidade visual é ampla, tanto em acuidade, quanto em distinção cromática, características essenciais para a eficiência de um predador. Estima-se que essa ave consiga reconhecer um roedor a 5000m de altitude. Isso é possível, em parte, devido à altíssima densidade de cones, na fóvea do olho. Cones são células fotorreceptoras estimuladas pela percepção das cores primárias ópticas. Na águia-de-asa-redonda, os cones de tipos azul, verde, vermelho e duplos totalizam cerca de 1 milhão/mm2; enquanto o ser humano possui, aproximadamente, 200000/mm2. Além da visão tetracromática, a águia possui uma fotossensibilidade ao espectro UV e apresenta filtros naturais para luz polarizada, o que lhe permite localizar peixes rapidamente." Baseando-se no texto apresentado, sobre essa águia é correto afirmar que','Difícil','Fisiologia sensorial - visão','Vestibulinho','E',3,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'enxerga, em período diurno, todas as presas na mesma cor acinzentada.' AS texto
  UNION ALL SELECT @qid,'B','o fato de possuir cones duplos a impede de visualizar quaisquer cores.'
  UNION ALL SELECT @qid,'C','o ser humano leva vantagem ao perceber também o espectro infravermelho.'
  UNION ALL SELECT @qid,'D','a acuidade visual dela é, aproximadamente, cinco vezes inferior a de um ser humano com visão normal.'
  UNION ALL SELECT @qid,'E','a capacidade de ela enxergar mais cores com melhor definição é superior à do ser humano.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: guano e a Corrente do Peru — Q26
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "O guano é um fertilizante orgânico natural, rico em nitrogênio, fósforo e potássio, que provém das fezes de aves migratórias atraídas pela grande quantidade de peixes existentes no litoral norte do Chile, fazendo dessa região da América do Sul voltada para o Oceano Pacífico um grande depósito desse material. Essa profusão de peixes está relacionada ao fenômeno da Ressurgência, que é consequência da ação de uma determinada corrente marítima fria. A ausência de chuvas naquela região, também resultado dessa corrente marítima, contribui decisivamente para que o material fecal não perca suas propriedades químicas." De acordo com o texto, a corrente marítima citada no texto é a','Médio','Correntes marítimas','Vestibulinho','E',7,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'da Califórnia.' AS texto
  UNION ALL SELECT @qid,'B','da Antártica.'
  UNION ALL SELECT @qid,'C','de Benguela.'
  UNION ALL SELECT @qid,'D','do Brasil.'
  UNION ALL SELECT @qid,'E','do Peru.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: melanossomos e iridescência das penas — Q27
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "Em algumas espécies de aves, o design das penas permite alterar a trajetória da luz devido à presença de conjuntos de nanoestruturas semelhantes a cristais. Esse fenômeno é chamado iridescência ou coloração estrutural e está ligado a estruturas denominadas melanossomos." Considere que as penas de um tipo de ave possui melanossomos cilíndricos cujo diâmetro mede 300 nm e altura 500 nm. Assinale a alternativa que apresenta a expressão matemática que deve ser multiplicada pelo número irracional π para calcular o volume desse melanossomo, em nm3.','Difícil','Geometria - volume do cilindro','Vestibulinho','A',2,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'150² × 500' AS texto
  UNION ALL SELECT @qid,'B','250² × 300'
  UNION ALL SELECT @qid,'C','300² × 500'
  UNION ALL SELECT @qid,'D','500² × 300'
  UNION ALL SELECT @qid,'E','600² × 500'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: composição química da água — Q28
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A água (H2O) é indispensável para a sobrevivência dos animais. Ela atua como solvente no corpo, transporta nutrientes e regula a temperatura corporal. Sobre a água, é correto afirmar que é','Fácil','Substâncias e compostos','Vestibulinho','E',5,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'uma mistura de átomos de hidrogênio e oxigênio.' AS texto
  UNION ALL SELECT @qid,'B','uma mistura dos gases hidrogênio e oxigênio.'
  UNION ALL SELECT @qid,'C','um composto formado por 3 elementos químicos.'
  UNION ALL SELECT @qid,'D','um composto formado por 1 molécula de hidrogênio e 1 de oxigênio.'
  UNION ALL SELECT @qid,'E','um composto formado pela união de 2 átomos de hidrogênio com 1 átomo de oxigênio.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: ratões-do-banhado (Myocastor coypus) — Q29
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "Os ratões-do-banhado (Myocastor coypus) são animais nativos da América do Sul, onde vivem nas margens de lagos e rios. Possuem pelos, longa cauda cilíndrica e patas palmeadas. Além disso, são mais ágeis na água do que em terra. Uma característica distintiva importante são seus grandes dentes frontais cor de laranja devido à presença de ferro no esmalte dos dentes. Esses animais podem ser utilizados na produção de carne e de peles para consumo humano. Quando retirados de suas regiões de origem, podem se tornar espécies invasoras, porque se adaptam rapidamente aos locais onde são introduzidos, reproduzindo-se com eficiência na ausência de predadores e causando desequilíbrios nos ecossistemas." Sobre os animais citados no texto, é correto afirmar que','Médio','Zoologia - mamíferos e espécies invasoras','Vestibulinho','B',3,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'se adaptam ao meio ambiente em que são introduzidos, pois são mamíferos primatas facilmente domesticáveis, o que acarreta um grande equilíbrio do ecossistema local.' AS texto
  UNION ALL SELECT @qid,'B','podem ser utilizados como fonte de proteína animal e possuem adaptações que permitem a movimentação na água, apesar de serem mamíferos terrestres.'
  UNION ALL SELECT @qid,'C','dilaceram a carne das presas, pois são mamíferos carnívoros com dentes caninos pontiagudos e muito resistentes devido à presença de ferro.'
  UNION ALL SELECT @qid,'D','pertencem ao grupo dos mamíferos ruminantes, pois possuem a capacidade de engolir e de mastigar o mesmo alimento mais de uma vez.'
  UNION ALL SELECT @qid,'E','atuam no equilíbrio ecológico da fauna e da flora das matas e das florestas independentemente das regiões onde foram introduzidos.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: escala de pH e indicador ácido-base — Q30
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O pH é uma escala de acidez para identificar o caráter ácido ou básico de uma solução. Esse caráter também pode ser identificado com o auxílio de um indicador ácido-base, que muda de cor em função da acidez da solução em análise. A figura representa a escala de pH (de 0 a 14) e a coloração de um determinado indicador ácido-base: pH ácido (0 a 6) = vermelho; pH 7 (neutro) = verde; pH básico (8 a 14) = azul. O suco gástrico, presente no estômago de humanos e de muitos animais, é uma solução que auxilia na digestão dos alimentos e apresenta pH = 2. Podemos afirmar corretamente que, em presença de suco gástrico, o indicador apresentará cor','Fácil','Escala de pH e indicadores','Vestibulinho','D',5,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'azul, pois se trata de uma solução de caráter básico.' AS texto
  UNION ALL SELECT @qid,'B','azul, pois se trata de uma solução de caráter ácido.'
  UNION ALL SELECT @qid,'C','verde, pois se trata de uma solução neutra.'
  UNION ALL SELECT @qid,'D','vermelha, pois se trata de uma solução de caráter ácido.'
  UNION ALL SELECT @qid,'E','vermelha, pois se trata de uma solução de caráter básico.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Texto de apoio: migração de manadas e povos nômades africanos — Q31, Q32
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Migração de manadas nas savanas africanas',
'Para se adaptarem às mudanças sazonais, alguns povos nômades das savanas africanas seguem, tradicionalmente, a trilha de grandes manadas de gnus e zebras durante suas migrações em busca de água. Considere que uma dessas manadas percorreu uma distância de 240 km em 4 dias. O grupo humano que seguiu a trilha fez o mesmo percurso, mas levou 6 dias.',
2, 2
WHERE @ja_existe_vest = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Com base nesses dados, podemos afirmar corretamente que','Médio','Velocidade média','Vestibulinho','A',2,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a manada foi 20 km/dia mais rápida que os humanos.' AS texto
  UNION ALL SELECT @qid,'B','a manada foi 40 km/dia mais lenta que os humanos.'
  UNION ALL SELECT @qid,'C','a manada foi 20 km/dia mais lenta que os humanos.'
  UNION ALL SELECT @qid,'D','os humanos foram 40 km/dia mais lentos que a manada.'
  UNION ALL SELECT @qid,'E','os humanos foram 20 km/dia mais rápidos que a manada.'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A migração citada ocorre em função do ciclo da água. É correto afirmar que o princípio físico relacionado a esse ciclo está associado','Médio','Ciclo da água - mudanças de estado','Vestibulinho','E',4,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à aceleração centrípeta dos ventos tropicais.' AS texto
  UNION ALL SELECT @qid,'B','à diminuição da pressão atmosférica no solo.'
  UNION ALL SELECT @qid,'C','ao aquecimento constante de rochas vulcânicas.'
  UNION ALL SELECT @qid,'D','ao vasto aumento da umidade relativa nos desertos.'
  UNION ALL SELECT @qid,'E','à evaporação e à condensação provocadas pela energia solar.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Texto de apoio: tilápia — produção e benefícios — Q33, Q34
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Tilápia: produção e benefícios',
'O Brasil é o quarto maior produtor mundial de tilápia. Essa espécie representa 63,5% da produção de peixes do país.

Na Região Nordeste, o cultivo comercial de tilápias começou a ser expressivo em meados da década de 1990. O Ceará é o estado com maior tradição no consumo de tilápia em virtude da produção desses peixes em seus reservatórios de água doce. Esse povoamento é fruto dos peixamentos realizados pelo Departamento Nacional de Obras Contra as Secas (DNOCS). A primeira tilápia que chegou ao Ceará veio da região Sudeste do Brasil.

Por ser um alimento rico em proteínas, esse peixe é um forte aliado para quem deseja ganhar massa magra e perder peso, especialmente, por possuir uma quantidade muito baixa de carboidratos.

A tilápia também contém vitaminas A, B e D, bem como minerais, incluindo cálcio, ferro e zinco. Além disso, em 2015, médicos e pesquisadores do Ceará iniciaram uma pesquisa e descobriram que a pele desse peixe, quando usada como curativo para queimaduras de 2° e 3° graus, auxilia na cicatrização da pele humana.
(Adaptado)',
3, 2
WHERE @ja_existe_vest = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Com base no texto, é correto afirmar que a tilápia é','Fácil','Interpretação de texto e biologia aplicada','Vestibulinho','B',3,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'nativa da região Nordeste do Brasil, especificamente do Ceará.' AS texto
  UNION ALL SELECT @qid,'B','rica em vitaminas e minerais, podendo ser utilizada na medicina.'
  UNION ALL SELECT @qid,'C','cultivada em tanques de água salgada no interior da região Sudeste.'
  UNION ALL SELECT @qid,'D','o principal produto de exportação do Brasil desde a década de 1990.'
  UNION ALL SELECT @qid,'E','produzida e comercializada pelo Departamento de Obras Contra as Secas.'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Sobre o peixe citado no texto, assinale a alternativa correta.','Médio','Nutrição e fisiologia','Vestibulinho','A',3,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'Ao ser consumido, a presença de ferro nesses peixes, favorece a formação dos glóbulos vermelhos no sangue humano.' AS texto
  UNION ALL SELECT @qid,'B','A pele desses peixes, ao ser utilizada em queimaduras de 2° e 3° graus, impede a cicatrização da área lesada no corpo humano.'
  UNION ALL SELECT @qid,'C','Ao ser consumido, a vitamina D presente nesses peixes é importante para prevenir doenças em crianças, tais como o escorbuto e o sarampo.'
  UNION ALL SELECT @qid,'D','Ao ser consumido, a quantidade baixa de proteínas nesses peixes favorece o ganho de massa magra e fortalece o tecido muscular, principalmente em praticantes de atividades físicas.'
  UNION ALL SELECT @qid,'E','Ao ser consumido, a presença de minerais como cálcio e zinco, nesses peixes, ajuda a prevenir o aparecimento de tromboses, a febre amarela e a prisão de ventre nas pessoas idosas.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: hemoglobina e o elemento ferro — Q35
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'A hemoglobina é uma proteína presente no sangue de animais vertebrados. Ela contém ferro, que é responsável pelo transporte de oxigênio e é representado por: Fe (número de massa 56, número atômico 26). Sobre esse elemento, é correto afirmar que apresenta','Médio','Estrutura atômica','Vestibulinho','A',5,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'número de massa 56.' AS texto
  UNION ALL SELECT @qid,'B','número atômico 30.'
  UNION ALL SELECT @qid,'C','30 prótons.'
  UNION ALL SELECT @qid,'D','56 elétrons.'
  UNION ALL SELECT @qid,'E','26 nêutrons.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Texto de apoio: feromônios e controle de pragas — Q36, Q37
INSERT INTO textos_apoio (titulo, conteudo, disciplina_id, autor_id)
SELECT 'Feromônios: comunicação química e controle de pragas',
'Os feromônios são substâncias químicas usadas por muitos animais para se comunicarem. Essas moléculas podem transmitir informações sobre reprodução, perigo ou trilhas de alimentos. Portanto, as moléculas dos feromônios podem ser usadas em perfumes, em armadilhas e até no controle de pragas.

Entre mulheres que convivem juntas por muito tempo, os feromônios são responsáveis por regularem o ciclo menstrual entre elas.

Na agricultura brasileira, uma das maiores pragas do milho é o inseto percevejo escuro. Para livrar as plantações dessa praga, o homem sintetiza, em laboratório, seu feromônio sexual para ser usado em armadilhas como isca para atrair esses insetos e dificultar sua proliferação.

Fórmula estrutural do feromônio do percevejo escuro (cadeia linear de 8 carbonos, com um grupo hidroxila -OH no terceiro carbono, um grupo metila -CH3 ramificado no quarto carbono e um grupo carbonila C=O no quinto carbono):
CH3–CH2–CH(OH)–CH(CH3)–C(=O)–CH2–CH2–CH3
(Adaptado)',
5, 2
WHERE @ja_existe_vest = 0;
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Baseando-se no texto, é correto afirmar que','Difícil','Fórmula molecular e grupos funcionais','Vestibulinho','D',5,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'os feromônios são compostos produzidos por alguns animais, não sendo encontrados nos seres humanos.' AS texto
  UNION ALL SELECT @qid,'B','não é possível produzir feromônios em laboratório para usos específicos.'
  UNION ALL SELECT @qid,'C','utiliza-se, na agricultura, o feromônio de trilha do percevejo escuro para atrair predadores desse inseto.'
  UNION ALL SELECT @qid,'D','o feromônio sintetizado para controlar pragas no milho apresenta fórmula molecular C8H16O2.'
  UNION ALL SELECT @qid,'E','o feromônio representado tem, em sua estrutura, 15 átomos de hidrogênio e um átomo de oxigênio.'
) alts WHERE @ja_existe_vest = 0;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'O uso desses compostos, na agricultura, está associado','Médio','Química verde e controle biológico de pragas','Vestibulinho','C',5,2,@tid,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'à contaminação do solo e dos lençóis freáticos, causando danos irreversíveis ao meio ambiente.' AS texto
  UNION ALL SELECT @qid,'B','à exterminação de todos os insetos da área agrícola, incluindo polinizadores como abelhas.'
  UNION ALL SELECT @qid,'C','às alternativas sustentáveis, porque são específicos para o alvo-praga.'
  UNION ALL SELECT @qid,'D','à sua toxidade para humanos e animais, representando um risco à saúde pública.'
  UNION ALL SELECT @qid,'E','à produção de grande quantidade de produtos químicos industriais, contribuindo para a poluição do ar.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: importância e ameaças às abelhas — Q38
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "Em 2019, o Earthwatch Institute declarou que as abelhas são os seres vivos mais importantes do planeta, durante uma reunião da Royal Geographical Society de Londres. Essa declaração está associada ao fato de as abelhas serem os principais seres vivos responsáveis por polinizar cerca de 75% das culturas alimentares do mundo. No entanto, vários estudos demonstram que as abelhas enfrentam risco de extinção, em várias partes do mundo, devido a fatores como o desmatamento, o uso de agrotóxicos, a exposição a diferentes parasitas e as mudanças climáticas, que afetam a disponibilidade de flores e de alimentos." Baseando-se no texto, é correto afirmar que','Médio','Ecologia - polinização e agrotóxicos','Vestibulinho','E',3,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a pulverização de agrotóxicos e o uso de inseticidas alteram o material genético das abelhas, deixando-as lentas, sem asas, com maior capacidade de polinização e de produção de mel.' AS texto
  UNION ALL SELECT @qid,'B','o desmatamento beneficia a formação de enxames e a construção de novos ninhos de abelhas devido ao aumento da disponibilidade de alimento, como flores silvestres.'
  UNION ALL SELECT @qid,'C','o aumento do número de flores encurta o tempo de vida das abelhas, causando a redução da reprodução das plantas e prejudicando a biodiversidade terrestre.'
  UNION ALL SELECT @qid,'D','a ocorrência de doenças prejudiciais à visão e à memória de navegação das abelhas aumenta a capacidade de elas retornarem às colmeias.'
  UNION ALL SELECT @qid,'E','o uso de agrotóxicos na agricultura para o controle de pragas acarreta a diminuição da população de abelhas, interferindo na polinização natural.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: isolamento térmico e peles inuítes — Q39
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os povos inuítes, que habitam a região do Círculo Polar Ártico aprenderam a importância do uso de certos tipos de peles para o isolamento térmico por meio da observação dos animais locais. Uma aplicação desse aprendizado é a confecção de roupas feitas com pele de caribu (rena) que ajuda a manter a temperatura corporal aproximadamente constante. Assinale a alternativa que justifica corretamente o equilíbrio térmico estabelecido.','Difícil','Termologia - isolamento térmico','Vestibulinho','C',4,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'A alta capacidade de absorção de moléculas de água pela pele é a responsável por evitar a sudorese.' AS texto
  UNION ALL SELECT @qid,'B','A perda de calor da pele do corpo para o ambiente é a responsável por manter o corpo aquecido.'
  UNION ALL SELECT @qid,'C','A pele auxilia no equilíbrio térmico devido à convecção, mantendo o corpo aquecido.'
  UNION ALL SELECT @qid,'D','A reflexão total da radiação solar recebida pelo corpo aumenta a temperatura corporal.'
  UNION ALL SELECT @qid,'E','A presença de proteínas vivas isolantes na pele é a responsável por facilitar a transferência térmica.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: camelos e pressão superficial — Q40
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Alguns povos nômades do deserto do Saara utilizam camelos como meio de transporte. Esses animais têm a capacidade de caminhar longas distâncias sobre areia fofa sem afundar. Podemos afirmar corretamente que essa capacidade está relacionada ao princípio físico da','Médio','Mecânica - pressão','Vestibulinho','E',4,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'radiação solar, pois a areia úmida auxilia na sustentação do animal.' AS texto
  UNION ALL SELECT @qid,'B','gravidade, pois os desertos apresentam uma diminuição da gravidade local.'
  UNION ALL SELECT @qid,'C','condutividade térmica, pois os cascos são constituídos de uma resina isolante.'
  UNION ALL SELECT @qid,'D','resistividade elétrica, pois a areia apresenta sílica, um bom condutor de eletricidade.'
  UNION ALL SELECT @qid,'E','pressão superficial, pois os cascos amplos distribuem o peso do animal e da sua carga.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: monstros marinhos na cartografia medieval — Q41
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "Durante a Idade Média, os mapas eram frequentemente adornados com representações de monstros marinhos. Essas criaturas refletiam tanto o medo quanto a fascinação pelo desconhecido. Além disso, eram utilizadas para ilustrar os perigos do mar e das terras inexploradas. Com o avanço da ciência e da exploração marítima, as representações de monstros marinhos nos mapas começaram a desaparecer. Estudos mais precisos e relatos confiáveis substituíram as lendas e as superstições. Além disso, a biologia marinha ajudou a desmistificar muitas dessas criaturas. Mapas posteriores focaram-se mais em precisão e detalhes geográficos." (Adaptado) A partir da leitura do texto, é correto afirmar que','Médio','Interpretação de texto','Vestibulinho','B',1,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'os mapas da Idade Média retratavam as características monstruosas dos animais marinhos, demonstrando uma visão científica precisa em relação a esses seres e alertando para os perigos que representavam.' AS texto
  UNION ALL SELECT @qid,'B','a visão medieval sobre os animais marinhos era determinada por medo e superstição, e foi substituída pelo olhar científico na medida em que avançaram as expedições marítimas e os conhecimentos sobre biologia marinha.'
  UNION ALL SELECT @qid,'C','a fascinação pelo desconhecido evitou que os europeus da Idade Média se dedicassem ao estudo sistemático dos animais marinhos e impediu que essas criaturas fossem estudadas até a contemporaneidade.'
  UNION ALL SELECT @qid,'D','a cartografia medieval se baseou em relatos confiáveis para produzir mapas precisos em que as representações de monstros marinhos desmistificavam essas criaturas.'
  UNION ALL SELECT @qid,'E','o objetivo da cartografia é alertar os navegantes para os perigos do desconhecido, evitando os deslocamentos por mar, habitat ocupado por monstros marinhos.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: fake news sobre o equinócio — Q42
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "Uma das formas de participar ativamente da sociedade como cidadão responsável é impedir a propagação de desinformação causada por fake news. Certa vez, uma jovem recebeu, por uma de suas mídias sociais, uma mensagem, reproduzida exatamente como foi divulgada, que afirmava: ''Fenômeno do equinócio nos atingirá nos próximos 5 dias e trará calor ao Brasil. Vamos ficar atentos! O fenômeno do Equinócio nos afetará nos próximos 5 dias. Permaneça com os animais dentro de casa, especialmente a partir das 11h. Às 16h, todos os dias, a temperatura irá flutuar e pode atingir 40 graus Celsius. Isso pode causar desidratação e insolação facilmente. Este fenômeno é devido ao fato de que o Sol está diretamente acima do equador.'' Para reconhecer a mensagem como fake news, a jovem recorreu aos conhecimentos de Ciências da Natureza vistos na escola." Assinale a alternativa que identifica corretamente o conceito científico que evidencia o erro da fake news.','Difícil','Movimentos da Terra - equinócio','Vestibulinho','C',7,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'O equinócio provoca ondas de calor intenso em países localizados ao Sul da linha do Equador, sendo necessário se abrigar para evitar queimaduras solares.' AS texto
  UNION ALL SELECT @qid,'B','O fato de o Sol estar sobre o Equador faz com que a radiação solar se concentre em todo o Brasil, justificando a previsão de 40 °C às 16 h.'
  UNION ALL SELECT @qid,'C','O equinócio está relacionado à inclinação do eixo da Terra e se caracteriza pelo fato de o dia e a noite terem o mesmo período com duração de 12 horas, portanto, não é responsável direto por ondas de calor.'
  UNION ALL SELECT @qid,'D','As temperaturas de 40°C são previsíveis durante o equinócio porque ocorre aumento da atividade solar sobre o hemisfério sul nessa época.'
  UNION ALL SELECT @qid,'E','A recomendação de ficar em casa durante o equinócio é cientificamente válida, pois a energia solar atinge níveis perigosos entre 11 h e 17 h nesses dias.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: taxa de lotação (pecuária) — Q43
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Para garantir o equilíbrio entre o número de animais e o alimento disponível, os pecuaristas podem utilizar um indicador chamado taxa de lotação que auxilia na análise do número de unidades animais (UA) que uma área, em hectares (ha), pode sustentar com o alimento disponível. Sabe-se que 1 UA equivale a 450 kg de massa animal. Essa medida é utilizada, pois os animais podem apresentar massas e consumos diferentes, sobretudo devido às diversas fases da vida que os animais no pasto têm. Para determinar a quantidade de UAs que uma propriedade possui, deve-se dividir a massa total dos animais que irão ocupar a área por 450 kg. Além disso, a fórmula para calcular o total de UA em uma área é dada por: TOTAL DE UA = (ÁREA) × (TAXA DE LOTAÇÃO). Suponha que, em uma fazenda, sejam criados 900 animais com massa média de 250 kg, em uma área de 100 ha. Com base nas informações apresentadas, determine a taxa de lotação dessa área em UA/ha.','Difícil','Problemas com fórmulas e proporção','Vestibulinho','B',2,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'2,5' AS texto
  UNION ALL SELECT @qid,'B','5,0'
  UNION ALL SELECT @qid,'C','7,5'
  UNION ALL SELECT @qid,'D','12,5'
  UNION ALL SELECT @qid,'E','18,0'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: pecuária e desmatamento na Amazônia — Q44
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "O Brasil é o maior exportador de carne bovina do mundo, responsável por quase um quinto do total das exportações globais desse produto. Com mais de 230 milhões de cabeças de gado, o Brasil possui o segundo maior rebanho bovino do mundo cuja criação é, em grande parte, feita no pasto. Juntos, os nove estados que formam a Amazônia brasileira possuem quase 40% do rebanho nacional de bovinos. Inúmeros estudos sobre a dinâmica do desmatamento documentam que grande parte das áreas de floresta desmatadas na Amazônia é transformada em pastagem." (Adaptado) A partir do texto, é correto afirmar que','Difícil','Pecuária e desmatamento','Vestibulinho','C',7,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'o Brasil ainda precisa importar grande parte da carne consumida pelo mercado interno, mesmo possuindo o maior rebanho bovino de corte do mundo, pois o alto valor do dólar inibe as exportações desse produto.' AS texto
  UNION ALL SELECT @qid,'B','a expansão da fronteira agrícola para o cultivo de feijão, de trigo e de arroz, cereais utilizados como fonte de alimentação para o gado de corte, é a maior responsável pelo desmatamento verificado na Amazônia brasileira.'
  UNION ALL SELECT @qid,'C','a criação de gado é uma das principais causas do desmatamento no Brasil, principalmente na Amazônia, contribuindo para as mudanças climáticas, pois as florestas são importantes no sequestro de carbono.'
  UNION ALL SELECT @qid,'D','o Brasil ainda não conseguiu estancar o processo de desmatamento causado pela criação de gado de corte, principalmente na Amazônia brasileira, embora seja responsável por 50% das exportações mundiais de carne bovina.'
  UNION ALL SELECT @qid,'E','o estado do Amazonas, dentre as unidades da Federação localizadas na Amazônia Legal, concentra pouco mais de 40% do rebanho nacional de bovinos, tornando esse estado, em termos percentuais, o campeão brasileiro em áreas florestais desmatadas.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: cisticercose e teníase — Q45
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Ao consumir a carne suína ou bovina contaminada com cisticercos – quando não ocorre o cozimento adequado – o ser humano pode adquirir uma doença denominada ______ (I) causada pelo parasita conhecido como ______ (II). Assinale a alternativa que preenche correta e respectivamente os espaços numerados I e II.','Médio','Doenças parasitárias','Vestibulinho','B',3,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'ascaridíase; lombriga' AS texto
  UNION ALL SELECT @qid,'B','teníase; solitária'
  UNION ALL SELECT @qid,'C','mal de Chagas; barbeiro'
  UNION ALL SELECT @qid,'D','amebíase; ameba'
  UNION ALL SELECT @qid,'E','toxoplasmose; salmonella'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: origem histórica dos zoológicos — Q46
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "A origem dos zoológicos, como os conhecemos hoje, está diretamente ligada ao Imperialismo dos séculos XVIII e XIX, quando grandes impérios levavam animais exóticos de suas colônias para exibição na Europa, simbolizando não apenas a dominação de territórios, mas também o controle sobre a natureza. Milhões de pessoas visitavam zoológicos para ver criaturas exóticas que despertavam curiosidade e entretenimento. Essa exibição era tanto uma forma de lazer, quanto uma expressão de poder, em que a fauna de terras distantes estava à mercê dos colonizadores. Posteriormente, muitos zoológicos foram criados com intenções conservacionistas, especialmente no que tange à preservação de espécies nativas, ressaltando o papel que essas instituições têm desempenhado em termos de conservação e educação." (Adaptado) O processo histórico referido no texto, que explica o contexto de surgimento dos zoológicos modernos, é caracterizado por','Médio','Imperialismo e neocolonialismo','Vestibulinho','C',6,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'uma revolução cultural ocorrida nos países da Europa, que levou os governos a adotar políticas educacionais rígidas e universalizantes, com o objetivo de preparar a juventude para as transformações que ocorreriam no século XX.' AS texto
  UNION ALL SELECT @qid,'B','uma política de entretenimento, também conhecida como "política de pão e circo", voltada ao aprimoramento do repertório cultural dos colonos, para que superassem os males que os afligiam.'
  UNION ALL SELECT @qid,'C','uma política de expansão territorial, econômica, política e cultural de países europeus sobre outros continentes, também conhecida como neocolonialismo.'
  UNION ALL SELECT @qid,'D','uma forma de governo absolutista, em que todo o poder se concentrava nas mãos do rei e que desconsiderava as necessidades materiais imediatas de seus súditos.'
  UNION ALL SELECT @qid,'E','uma forma de governo democrática, que pressupunha a divisão do poder em Executivo, Legislativo e Judiciário e dava grande ênfase ao desenvolvimento científico e cultural da população europeia.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: Santuário de Elefantes Brasil — Q47
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "O único santuário de elefantes da América Latina fica no Brasil, no município de Chapada dos Guimarães, no Mato Grosso. É mantido pela Associação Santuário de Elefantes Brasil (SEB), uma organização da sociedade civil, sem fins lucrativos, que resgata elefantes cativos em situação de risco, sejam eles mantidos em circos, zoológicos ou propriedades privadas, oferecendo-lhes o espaço, as condições e os cuidados necessários para que possam se recuperar física e emocionalmente dos anos passados em cativeiro. Em razão da criação do Santuário, as áreas, que antes eram utilizadas para pastagem, estão em plena regeneração e recomposição. Esse processo acaba atraindo outros animais que estavam sumindo do local em razão da degradação ambiental." (Adaptado) Para os seres humanos, a existência do santuário é importante, pois ajuda a','Médio','Bem-estar animal e valores éticos','Vestibulinho','D',1,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'reconectar as pessoas com a atividade circense, que não existe mais no território nacional em função de uma lei federal que impede a utilização de animais em seus espetáculos.' AS texto
  UNION ALL SELECT @qid,'B','inspirar novas ações voltadas para incrementar o aumento do número de elefantes para suprir a ausência desses animais nos zoológicos privados brasileiros.'
  UNION ALL SELECT @qid,'C','compreender que os elefantes são dignos de respeito, mesmo sendo responsáveis pelo desmatamento de amplos espaços naturais do Santuário.'
  UNION ALL SELECT @qid,'D','promover a empatia e o respeito pelos elefantes, incentivando as pessoas a se preocuparem com o bem-estar desses e de outros animais.'
  UNION ALL SELECT @qid,'E','motivar as pessoas a se engajarem em ações que permitam a utilização de elefantes em eventos públicos e privados.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: Projeto TAMAR — Q48
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Leia o texto: "O Projeto Tartarugas Marinhas (TAMAR), que se dedica à proteção das tartarugas marinhas no Brasil, nasceu em 1980. Desde o início, os pesquisadores do projeto perceberam que, para proteger as tartarugas, era preciso envolver e cuidar das pessoas. Pescadores, que antes da chegada do Projeto consumiam tartarugas marinhas e ovos como recurso alimentar ou os vendiam, foram convidados a trabalhar formalmente na proteção, pois sabiam como encontrar a desova da tartaruga sem estragar os ovos ou qual a melhor época para vê-las na praia, dentre outras informações fundamentais para as atividades de conservação. As atividades de proteção e manejo trazidas pelo TAMAR buscam dialogar com as práticas e o conhecimento tradicionais. Espaços eficientes de aprendizagem e capacitação foram abertos naturalmente, subvertendo uma realidade anterior marcada pela falta de informação sobre as tartarugas marinhas. O compromisso em manter a própria comunidade engajada na ação educadora mais ampla envolve gerações de famílias e o meio ambiente para além das tartarugas, incluindo questões de cidadania e a preocupação constante com a qualidade ambiental do lugar onde vivem. A relação de trabalho estabelecida, as mudanças culturais gerais, a capacitação e os resultados positivos para a conservação colaboraram e continuam a colaborar com as mudanças de comportamento em relação à proteção necessária às tartarugas e ao seu habitat." (Adaptado) A partir da leitura do texto, é correto afirmar que','Médio','Cidadania e conservação ambiental','Vestibulinho','D',1,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'a necessidade de preservação ambiental inviabiliza a manutenção das culturas e os modos de vida das comunidades pescadoras.' AS texto
  UNION ALL SELECT @qid,'B','o projeto TAMAR capacita os membros das comunidades tradicionais para a pesca, o comércio e o consumo das tartarugas como recurso alimentar.'
  UNION ALL SELECT @qid,'C','é necessário convidar os pescadores a se retirarem de seus territórios, impedindo o contato entre humanos e animais para proteger as tartarugas marinhas do Brasil.'
  UNION ALL SELECT @qid,'D','o trabalho do TAMAR é bem-sucedido porque engaja as comunidades em ações de cidadania, respeitando as práticas e os conhecimentos locais.'
  UNION ALL SELECT @qid,'E','a capacitação e os resultados positivos para a conservação foram ineficazes na promoção das mudanças de comportamento necessárias à proteção das tartarugas e de seu habitat.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: ameaças às tartarugas marinhas — Q49
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Entre os principais fatores que ameaçam a sobrevivência das tartarugas marinhas do litoral do Brasil, destacam-se a captura acidental em redes de pesca e anzóis, a degradação de áreas de desova, a fotopoluição, a poluição dos oceanos e as mudanças climáticas. Essas ameaças ocorrem quando','Médio','Ecologia - conservação de espécies','Vestibulinho','C',3,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'as tartarugas marinhas vivem a maior parte de suas vidas nas praias prioritárias de reprodução, sem a presença de predadores.' AS texto
  UNION ALL SELECT @qid,'B','as tartarugas capturadas acidentalmente em redes de malha ou arrastos permanecem submersas, sem subir à superfície, pois realizam respiração branquial.'
  UNION ALL SELECT @qid,'C','os filhotes das tartarugas, em vez de seguirem para o mar guiados pela luminosidade natural do horizonte, deslocam-se para o continente, atraídos pela iluminação artificial nas praias.'
  UNION ALL SELECT @qid,'D','as mudanças climáticas ocasionam o aumento do nível do mar, cobrindo totalmente a areia das praias, o que favorece a formação de novos ninhos e aumenta a quantidade de filhotes.'
  UNION ALL SELECT @qid,'E','a ausência de predadores e o cuidado parental realizado nas praias prioritárias de reprodução diminuem a possibilidade de ocorrer alta taxa de mortalidade dos filhotes das tartarugas.'
) alts WHERE @ja_existe_vest = 0;

-- ---------- Questão isolada: cidadania e proteção animal — Q50
INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa)
SELECT 'Os animais têm uma grande importância para a vida humana e o equilíbrio ecológico do meio ambiente. No entanto, a relação entre humanos e animais nem sempre é harmoniosa, pois os animais são, por vezes, expostos a práticas cruéis e antiéticas, que colocam em risco as suas vidas. Desenvolver valores, como responsabilidade no cuidado do meio ambiente e de outro ser vivo, é importante para ampliar a consciência social. Para isso, faz-se necessário','Fácil','Cidadania e ética socioambiental','Vestibulinho','E',1,2,NULL,TRUE
WHERE @ja_existe_vest = 0;
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto)
SELECT * FROM (
  SELECT @qid AS questao_id,'A' AS letra,'incentivar a introdução de espécies invasoras em habitats naturais de outras espécies, a fim de permitir a transmissão de doenças aos animais nativos.' AS texto
  UNION ALL SELECT @qid,'B','comprar produtos feitos de animais ameaçados ou em perigo de extinção, a fim de inibir o tráfico ilegal desses animais e a propagação de zoonoses.'
  UNION ALL SELECT @qid,'C','combater ações de reflorestamento, a fim de impedir a migração de animais para ambientes ou habitats onde tenham espaço para se reproduzir.'
  UNION ALL SELECT @qid,'D','estimular a comercialização de animais silvestres vítimas do tráfico ilegal para serem usados como cobaias em testes de laboratórios.'
  UNION ALL SELECT @qid,'E','denunciar o cativeiro ou os maus-tratos de animais, os desmatamentos e as queimadas ilegais às autoridades competentes.'
) alts WHERE @ja_existe_vest = 0;
