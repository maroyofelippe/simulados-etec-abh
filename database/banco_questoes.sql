-- Banco de questoes autoral (estrutura SARESP) - gerado automaticamente
USE simulados_etec_abh;

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Em "O menino, cansado da longa caminhada, sentou-se à sombra da árvore", a expressão destacada "cansado da longa caminhada" funciona como:','Fácil','Interpretação de texto','1ª Série EM','B',1,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Sujeito da oração');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Predicativo do sujeito, indicando estado do menino');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Objeto direto');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Adjunto adverbial de tempo');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Vocativo');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('A frase "Cê vai lá hoje?" apresenta uma marca típica de qual variedade linguística?','Fácil','Variação linguística','1ª Série EM','B',1,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Norma-padrão formal escrita');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Linguagem informal/coloquial oral');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Linguagem técnica científica');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Linguagem jurídica');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Linguagem literária arcaica');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Em "Seus olhos eram duas estrelas a brilhar na escuridão", identifica-se a figura de linguagem denominada:','Médio','Figuras de linguagem','1ª Série EM','C',1,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Metonímia');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Hipérbole');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Metáfora');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Eufemismo');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Ironia');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('No período "Estudou muito; portanto, foi aprovado", o conector "portanto" estabelece uma relação de:','Médio','Coesão textual','2ª Série EM','B',1,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Oposição');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Conclusão/consequência');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Adição');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Alternância');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Comparação');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Um texto que defende um ponto de vista com argumentos, tese e conclusão, buscando convencer o leitor, caracteriza-se predominantemente como:','Difícil','Gêneros textuais','2ª Série EM','D',1,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Narrativo');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Descritivo');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Injuntivo');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Dissertativo-argumentativo');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Expositivo neutro');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('A frase "Depois de tudo o que fez, ele ainda se diz inocente" carrega, pelo contexto, uma marca de:','Difícil','Semântica','3ª Série EM','B',1,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Objetividade informativa');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Ironia/crítica implícita');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Neutralidade científica');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Ambiguidade estrutural');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Redundância');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Um produto que custava R$ 200,00 recebeu desconto de 15%. Qual o novo preço?','Fácil','Porcentagem','1ª Série EM','B',2,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','R$ 185,00');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','R$ 170,00');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','R$ 175,00');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','R$ 160,00');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','R$ 150,00');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Dada a função f(x) = 2x + 3, o valor de f(4) é:','Fácil','Funções','1ª Série EM','B',2,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','8');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','11');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','14');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','7');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','5');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Em uma progressão aritmética de razão 5 cujo primeiro termo é 3, o quinto termo (a5) vale:','Médio','Progressões','2ª Série EM','C',2,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','18');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','20');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','23');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','25');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','28');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('A área de um triângulo de base 10 cm e altura 6 cm é:','Médio','Geometria','2ª Série EM','B',2,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','60 cm²');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','30 cm²');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','16 cm²');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','26 cm²');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','45 cm²');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('As raízes da equação x² - 5x + 6 = 0 são:','Difícil','Função quadrática','2ª Série EM','B',2,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','1 e 6');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','2 e 3');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','-2 e -3');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','0 e 5');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','-1 e -6');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Ao lançar um dado comum de 6 faces, a probabilidade de sair um número par é:','Difícil','Probabilidade','3ª Série EM','C',2,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','1/6');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','1/3');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','1/2');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','2/3');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','5/6');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('A organela responsável pela produção de energia (ATP) na célula, por meio da respiração celular, é:','Fácil','Citologia','1ª Série EM','B',3,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Ribossomo');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Mitocôndria');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Lisossomo');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Complexo golgiense');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Núcleo');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Em uma cadeia alimentar, os organismos que produzem seu próprio alimento por fotossíntese são chamados de:','Médio','Ecologia','1ª Série EM','C',3,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Consumidores primários');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Decompositores');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Produtores');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Consumidores secundários');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Predadores de topo');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('No cruzamento entre dois indivíduos heterozigotos (Aa x Aa), a proporção fenotípica esperada para uma característica de dominância completa é:','Médio','Genética','3ª Série EM','B',3,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','1:1');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','3:1');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','9:3:3:1');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','1:2:1');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','2:1');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('A teoria da seleção natural, proposta por Charles Darwin, baseia-se principalmente na ideia de que:','Difícil','Evolução','3ª Série EM','C',3,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Os organismos se transformam por necessidade e uso dos órgãos');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Características adquiridas em vida são herdadas');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Indivíduos mais adaptados ao ambiente tendem a sobreviver e reproduzir');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','As espécies são imutáveis desde a criação');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','A evolução ocorre por saltos aleatórios sem influência do ambiente');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Um carro percorre 120 km em 2 horas. Sua velocidade média é de:','Fácil','Cinemática','1ª Série EM','B',4,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','40 km/h');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','60 km/h');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','80 km/h');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','100 km/h');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','240 km/h');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Uma força resultante de 10 N atua sobre um corpo de massa 2 kg. A aceleração adquirida é:','Médio','Leis de Newton','1ª Série EM','B',4,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','2 m/s²');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','5 m/s²');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','10 m/s²');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','20 m/s²');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','0,2 m/s²');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('A energia associada ao movimento de um corpo é denominada energia:','Médio','Energia','2ª Série EM','B',4,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Potencial gravitacional');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Cinética');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Elástica');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Térmica');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Química');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Segundo a 1ª Lei de Ohm, em um resistor de 20 Ω submetido a 100 V, a corrente elétrica é:','Difícil','Eletricidade','3ª Série EM','C',4,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','0,2 A');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','2 A');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','5 A');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','20 A');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','2000 A');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('O elemento químico de símbolo "O" e número atômico 8 é o:','Fácil','Tabela periódica','1ª Série EM','B',5,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Ouro');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Oxigênio');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Ósmio');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Oganessônio');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Ontário');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('A ligação química formada pela transferência de elétrons entre um metal e um não-metal é do tipo:','Médio','Ligações químicas','1ª Série EM','C',5,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Covalente');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Metálica');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Iônica');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Dativa');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Ponte de hidrogênio');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('Uma substância que, em solução aquosa, libera como único ânion o hidroxila (OH⁻) é classificada como:','Difícil','Funções inorgânicas','2ª Série EM','B',5,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Ácido');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Base');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Sal');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Óxido');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Hidreto');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('O principal produto econômico do Brasil durante o período colonial no século XVI foi:','Fácil','Brasil Colônia','1ª Série EM','C',6,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Café');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Ouro');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Açúcar (cana-de-açúcar)');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Borracha');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Algodão');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('A Revolução Francesa (1789) teve como lema os ideais de:','Médio','Revoluções','2ª Série EM','B',6,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Ordem e Progresso');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Liberdade, Igualdade e Fraternidade');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Pão, Terra e Paz');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Deus, Pátria e Família');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','União e Trabalho');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('O período da história brasileira conhecido como "Era Vargas" iniciou-se em:','Difícil','Brasil República','3ª Série EM','C',6,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','1822');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','1889');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','1930');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','1964');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','1985');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('A linha imaginária que divide a Terra em hemisférios Norte e Sul é denominada:','Fácil','Cartografia','1ª Série EM','C',7,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','Meridiano de Greenwich');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','Trópico de Câncer');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Linha do Equador');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Círculo Polar Ártico');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Trópico de Capricórnio');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('O fenômeno de aquecimento anormal das águas do Oceano Pacífico que altera o clima em várias regiões do planeta é conhecido como:','Médio','Climatologia','2ª Série EM','B',7,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','La Niña');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','El Niño');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Efeito estufa');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','Inversão térmica');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','Monção');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,ativa) VALUES ('O bloco econômico formado por Brasil, Argentina, Paraguai e Uruguai é o:','Difícil','Geopolítica','3ª Série EM','C',7,2,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','União Europeia');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','NAFTA/USMCA');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','Mercosul');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','BRICS');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','ASEAN');

-- Exemplo de texto de apoio compartilhado por 2 questões de Geografia
INSERT INTO textos_apoio (titulo,conteudo,disciplina_id,autor_id) VALUES (
  'Êxodo rural no Brasil',
  'Ao longo do século XX o Brasil passou de um país predominantemente rural para um país majoritariamente urbano. Esse processo, conhecido como êxodo rural, foi impulsionado sobretudo pela mecanização da agricultura e pela escassez de postos de trabalho no campo, levando milhões de trabalhadores a migrar para as cidades em busca de emprego na indústria e nos serviços.',
  7, 2
);
SET @tid = LAST_INSERT_ID();

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa) VALUES ('De acordo com o texto de apoio, a principal causa do êxodo rural apontada é:','Médio','Urbanização','2ª Série EM','B',7,2,@tid,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','A busca por lazer nas cidades');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','A mecanização do campo e a falta de emprego rural');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','O clima favorável nas cidades');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','A proximidade com o mar');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','A tradição familiar urbana');

INSERT INTO questoes (enunciado,dificuldade,tema,serie,gabarito,disciplina_id,autor_id,texto_apoio_id,ativa) VALUES ('Um dos efeitos socioespaciais do êxodo rural descrito no texto de apoio foi:','Difícil','Urbanização','2ª Série EM','B',7,2,@tid,TRUE);
SET @qid = LAST_INSERT_ID();
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'A','O esvaziamento total das cidades');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'B','A expansão desordenada das periferias urbanas');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'C','A redução da população urbana');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'D','O fim da industrialização');
INSERT INTO alternativas (questao_id,letra,texto) VALUES (@qid,'E','A diminuição do consumo urbano');

