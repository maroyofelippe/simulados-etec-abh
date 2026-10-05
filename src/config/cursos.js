// Cursos da Feira de Profissões: alimenta o formulário de cadastro (curso de interesse)
// e as páginas da seção CURSOS (/cursos e /cursos/:slug).
//
// - valor:     texto exato gravado em usuarios.curso_interesse (não alterar sem migrar os dados)
// - imagem:    nome do arquivo em public/img/cursos SEM extensão (aceita .jpg, .jpeg, .png ou .webp).
//              Cursos que existem em mais de um turno podem compartilhar a mesma imagem.
//              Se o arquivo ainda não existir, a página mostra um espaço reservado.
// - descricao: texto da página; deixe '' enquanto não estiver escrito ("Descrição em breve").
//              Parágrafos separados por linha em branco.
const fs = require('fs');
const path = require('path');

const PASTA_IMAGENS = path.join(__dirname, '..', 'public', 'img', 'cursos');
const EXTENSOES = ['.jpg', '.jpeg', '.png', '.webp'];

const CURSOS = [
  { slug: 'desenvolvimento-de-sistemas-manha', nome: 'Desenvolvimento de Sistemas', modalidade: 'Técnico integrado ao Ensino Médio (M-Tec)', periodo: 'Manhã', imagem: 'Técnico em Desenvolvimento de Sistemas', valor: 'Desenvolvimento de Sistemas-M-Tec-Manhã', descricao: '' },
  { slug: 'eletronica-manha', nome: 'Eletrônica', modalidade: 'Técnico integrado ao Ensino Médio (M-Tec)', periodo: 'Manhã', imagem: 'Técnico em Eletrônica', valor: 'Eletrônica-M-Tec-Manhã', descricao: '' },
  { slug: 'marketing-manha', nome: 'Marketing', modalidade: 'Técnico integrado ao Ensino Médio (M-Tec)', periodo: 'Manhã', imagem: 'Técnico em Marketing', valor: 'Marketing-M-Tec-Manhã', descricao: '' },
  { slug: 'recursos-humanos-manha', nome: 'Recursos Humanos', modalidade: 'Técnico integrado ao Ensino Médio (M-Tec)', periodo: 'Manhã', imagem: 'Técnico em Recursos Humanos', valor: 'Recursos Humanos-M-Tec-Manhã', descricao: '' },
  { slug: 'programacao-de-jogos-digitais-tarde', nome: 'Programação de Jogos Digitais', modalidade: 'Técnico integrado ao Ensino Médio (M-Tec)', periodo: 'Tarde', imagem: 'Técnico em Programação de Jogos Digitais', valor: 'Programação de Jogos Digitais-M-Tec-Tarde', descricao: '' },
  { slug: 'farmacia-tarde', nome: 'Farmácia', modalidade: 'Técnico integrado ao Ensino Médio (M-Tec)', periodo: 'Tarde', imagem: 'Técnico em Farmácia', valor: 'Farmácia-M-Tec-Tarde', descricao: '' },
  { slug: 'biotecnologia-tarde', nome: 'Biotecnologia', modalidade: 'Técnico', periodo: 'Tarde', imagem: 'Técnico em Biotecnologia', valor: 'Biotecnologia-Tarde', descricao: '' },
  { slug: 'administracao-tarde', nome: 'Administração', modalidade: 'Técnico integrado ao Ensino Médio (M-Tec)', periodo: 'Tarde', imagem: 'Técnico em Administração', valor: 'Administração-M-Tec-Tarde', descricao: 'Como funcionam as organizações, desde empresas privadas até ONGs, passando por órgãos públicos, comércio e indústria. O estudante vai precisar de conhecimentos de língua portuguesa, matemática, história e geografia para compreender os principais assuntos do curso, como história da administração, evolução das organizações ao longo do tempo, contabilidade, leis que regulam o funcionamento das empresas e redação de documentos.O aluno vai aprender ainda a analisar as chances de um negócio ou produto ser bem-sucedido e o comportamento do consumidor. Estudará também técnicas de atendimento ao cliente, empreendedorismo (iniciativas para realizar novos negócios) e como uma organização planeja alcançar seus objetivos e define suas metas para o futuro.O candidato que ingressar no curso técnico de Administração, na modalidade AMS, poderá prosseguir os estudos em uma Fatec no curso superior de tecnologia em Processos Gerenciais.' },
  { slug: 'informatica-para-internet-noite', nome: 'Informática para Internet', modalidade: 'Técnico integrado ao Ensino Médio (M-Tec)', periodo: 'Noite', imagem: 'Técnico em Infonet', valor: 'Informática para Internet-M-Tec-Noite', descricao: '' },
  { slug: 'farmacia-noite', nome: 'Farmácia', modalidade: 'Técnico', periodo: 'Noite', imagem: 'Técnico em Farmácia', valor: 'Farmácia-Noite', descricao: '' },
  { slug: 'administracao-noite', nome: 'Administração', modalidade: 'Técnico integrado ao Ensino Médio (M-Tec)', periodo: 'Noite', imagem: 'Técnico em Administração', valor: 'Administração-M-Tec-Noite', descricao: 'Como funcionam as organizações, desde empresas privadas até ONGs, passando por órgãos públicos, comércio e indústria. O estudante vai precisar de conhecimentos de língua portuguesa, matemática, história e geografia para compreender os principais assuntos do curso, como história da administração, evolução das organizações ao longo do tempo, contabilidade, leis que regulam o funcionamento das empresas e redação de documentos.O aluno vai aprender ainda a analisar as chances de um negócio ou produto ser bem-sucedido e o comportamento do consumidor. Estudará também técnicas de atendimento ao cliente, empreendedorismo (iniciativas para realizar novos negócios) e como uma organização planeja alcançar seus objetivos e define suas metas para o futuro.O candidato que ingressar no curso técnico de Administração, na modalidade AMS, poderá prosseguir os estudos em uma Fatec no curso superior de tecnologia em Processos Gerenciais.' },
  { slug: 'eletroeletronica-noite', nome: 'Eletroeletrônica', modalidade: 'Técnico integrado ao Ensino Médio (M-Tec)', periodo: 'Noite', imagem: 'Técnico em Eletroeletrônica', valor: 'Eletroeletrônica-M-Tec-Noite', descricao: '' },
  { slug: 'eletrotecnica-noite', nome: 'Eletrotécnica', modalidade: 'Técnico', periodo: 'Noite', imagem: 'Técnico em Eletrotécnica', valor: 'Eletrotécnica-Noite', descricao: '' },
  { slug: 'especializacao-em-gestao-de-projetos-ead', nome: 'Especialização em Gestão de Projetos', modalidade: 'Especialização técnica', periodo: 'EAD', imagem: 'Especialização em Gestão de Projetos', valor: 'Especialização em Gestão de Projetos- EAD', descricao: '' },
  { slug: 'guia-de-turismo-ead', nome: 'Guia de Turismo', modalidade: 'Técnico', periodo: 'EAD', imagem: 'Técnico em Guia de Turismo', valor: 'Guia de Turismo-EAD', descricao: '' },
  { slug: 'comercio-ead', nome: 'Comércio', modalidade: 'Técnico', periodo: 'EAD', imagem: 'Técnico em Comércio', valor: 'Comércio-EAD', descricao: '' },
  { slug: 'secretariado-ead', nome: 'Secretariado', modalidade: 'Técnico', periodo: 'EAD', imagem: 'Técnico em Secretariado', valor: 'Secretariado-EAD', descricao: '' },
  { slug: 'transacoes-imobiliarias-ead', nome: 'Transações Imobiliárias', modalidade: 'Técnico', periodo: 'EAD', imagem: 'Técnico em Transações Imobiliárias', valor: 'Transações Imobiliárias-EAD', descricao: '' }
];

// URL da imagem do curso, ou null se o arquivo ainda não foi carregado.
// Consulta o disco a cada chamada: imagens novas aparecem sem reiniciar o servidor.
function urlImagem(curso) {
  const ext = EXTENSOES.find((e) => fs.existsSync(path.join(PASTA_IMAGENS, curso.imagem + e)));
  return ext ? '/img/cursos/' + encodeURIComponent(curso.imagem + ext) : null;
}

function comImagem(curso) {
  return Object.assign({}, curso, { imagemUrl: urlImagem(curso) });
}

module.exports = {
  CURSOS,
  VALORES: CURSOS.map((c) => c.valor),
  listar: () => CURSOS.map(comImagem),
  buscar: (slug) => {
    const i = CURSOS.findIndex((c) => c.slug === slug);
    if (i < 0) return null;
    return { curso: comImagem(CURSOS[i]), anterior: CURSOS[i - 1] || null, proximo: CURSOS[i + 1] || null };
  }
};
