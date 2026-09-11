// Alternância de tema claro/escuro (localStorage + persistência no banco)
(function () {
  const KEY = 'tema-simulados-etec';
  const root = document.documentElement;

  function aplicar(tema) {
    root.setAttribute('data-tema', tema);
    const btn = document.getElementById('btn-tema');
    if (btn) {
      btn.innerHTML = tema === 'escuro'
        ? '<i class="fa-solid fa-sun" aria-hidden="true"></i> Claro'
        : '<i class="fa-solid fa-moon" aria-hidden="true"></i> Escuro';
      btn.setAttribute('aria-pressed', tema === 'escuro' ? 'true' : 'false');
    }
  }

  // Preferência inicial: localStorage > atributo do servidor > claro
  const salvo = localStorage.getItem(KEY) || root.getAttribute('data-tema') || 'claro';
  aplicar(salvo);

  window.alternarTema = function () {
    const atual = root.getAttribute('data-tema') === 'escuro' ? 'escuro' : 'claro';
    const novo = atual === 'escuro' ? 'claro' : 'escuro';
    aplicar(novo);
    localStorage.setItem(KEY, novo);
    // Persiste no banco (se logado)
    fetch('/tema', {
      method: 'POST', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ tema: novo })
    }).catch(() => {});
  };

  // Dropdown do menu Admin (topbar)
  window.alternarMenu = function (ev) {
    ev.stopPropagation();
    const toggle = ev.currentTarget;
    const menu = toggle.nextElementSibling;
    document.querySelectorAll('.dropdown-menu.aberto').forEach(function (m) {
      if (m !== menu) {
        m.classList.remove('aberto');
        if (m.previousElementSibling) m.previousElementSibling.setAttribute('aria-expanded', 'false');
      }
    });
    const aberto = menu.classList.toggle('aberto');
    toggle.setAttribute('aria-expanded', aberto ? 'true' : 'false');
  };
  document.addEventListener('click', function () {
    document.querySelectorAll('.dropdown-menu.aberto').forEach(function (m) {
      m.classList.remove('aberto');
      if (m.previousElementSibling) m.previousElementSibling.setAttribute('aria-expanded', 'false');
    });
  });

  // Menu hambúrguer (nav mobile)
  window.alternarMenuMobile = function () {
    const nav = document.getElementById('nav-principal');
    const btn = document.querySelector('.menu-toggle');
    if (nav) {
      const aberto = nav.classList.toggle('aberto');
      if (btn) btn.setAttribute('aria-expanded', aberto ? 'true' : 'false');
    }
  };
  const navPrincipal = document.getElementById('nav-principal');
  if (navPrincipal) {
    navPrincipal.addEventListener('click', function (ev) {
      const link = ev.target.closest('a');
      if (link) navPrincipal.classList.remove('aberto');
    });
  }
  window.addEventListener('resize', function () {
    if (window.innerWidth > 600 && navPrincipal) {
      navPrincipal.classList.remove('aberto');
      const btn = document.querySelector('.menu-toggle');
      if (btn) btn.setAttribute('aria-expanded', 'false');
    }
  });

  // Rodapé fixo (z-index -1): reserva no fim do conteúdo um espaço do
  // tamanho do rodapé, para que a rolagem "revele" o rodapé em vez de
  // sobrepor o texto a ele.
  const conteudo = document.getElementById('conteudo-principal');
  const rodape = document.querySelector('.rodape');
  function ajustarEspacoRodape() {
    if (conteudo && rodape) conteudo.style.paddingBottom = rodape.offsetHeight + 'px';
  }
  if (conteudo && rodape) {
    ajustarEspacoRodape();
    window.addEventListener('resize', ajustarEspacoRodape);
    window.addEventListener('load', ajustarEspacoRodape);
    if (document.fonts && document.fonts.ready) document.fonts.ready.then(ajustarEspacoRodape);
  }
})();
