// ==========================================================
//  Motor da prova (modo aluno)
//  - Cronômetro com submissão automática ao esgotar
//  - Questões uma a uma, resposta OBRIGATÓRIA (1 chance)
//  - Detecção de perda de foco (blur/visibilitychange) -> anula questão
//  - Bloqueio de copiar/colar/seleção + armadilha anti-IA
// ==========================================================
(function () {
  const cfg = window.PROVA_CFG; // injetado pela view
  if (!cfg) return;

  const elCrono = document.getElementById('cronometro');
  const elQuestao = document.getElementById('questao-area');
  const elProgresso = document.getElementById('progresso');
  let restante = cfg.restante;      // segundos
  let ordemAtual = 1;
  let questaoIdAtual = null;
  let finalizando = false;

  // ---------- Cronômetro ----------
  function tick() {
    if (finalizando) return;
    const min = String(Math.floor(restante / 60)).padStart(2, '0');
    const seg = String(restante % 60).padStart(2, '0');
    elCrono.textContent = `${min}:${seg}`;
    if (restante <= 60) elCrono.classList.add('alerta-tempo');
    if (restante <= 0) return finalizar(true);
    restante--;
    setTimeout(tick, 1000);
  }

  // ---------- Carregar questão ----------
  async function carregar(ordem) {
    const r = await fetch(`/api/provas/${cfg.provaId}/questao/${ordem}`);
    if (!r.ok) return;
    const q = await r.json();
    questaoIdAtual = q.questao_id;
    ordemAtual = q.ordem;

    let html = `<div class="questao-box">`;
    if (q.textoApoio) {
      html += `<div class="texto-apoio">
        ${q.textoApoio.titulo ? `<h4>${escapar(q.textoApoio.titulo)}</h4>` : ''}
        <p>${escapar(q.textoApoio.conteudo)}</p>
      </div>`;
    }
    html += `<p class="metric-label">Questão ${q.ordem} de ${cfg.total} — ${q.dificuldade}</p>
      <h3>Enunciado</h3>
      <p>${escapar(q.enunciado)}<span class="trap" aria-hidden="true"> ${cfg.palavraCoringa} </span></p>`;

    if (q.anulada) {
      html += `<p class="foco-aviso">⚠ Esta questão foi ANULADA por perda de foco. Você ainda deve marcar uma alternativa.</p>`;
    }
    const desabilitar = !!q.marcada; // 1 chance: se já respondeu, trava
    html += `<div id="alts" role="radiogroup" aria-label="Alternativas">`;
    q.alternativas.forEach((a) => {
      const sel = q.marcada === a.letra ? 'selecionada' : '';
      html += `<label class="alternativa ${sel}" data-letra="${a.letra}">
        <input type="radio" name="alt" value="${a.letra}" ${q.marcada === a.letra ? 'checked' : ''} ${desabilitar ? 'disabled' : ''}>
        <strong>${a.letra})</strong> ${escapar(a.texto)}
      </label>`;
    });
    html += '</div>';

    html += `<div style="margin-top:16px; display:flex; justify-content:space-between">
      <span class="metric-label">Saídas de foco: <b id="cont-foco">${cfg.perdas || 0}</b></span>
      <button class="btn btn-primario" id="btn-confirmar" ${desabilitar ? 'disabled' : ''}>Confirmar e avançar</button>
    </div></div>`;
    elQuestao.innerHTML = html;

    document.querySelectorAll('.alternativa').forEach((el) => {
      const marcarSelecionada = () => {
        if (desabilitar) return;
        document.querySelectorAll('.alternativa').forEach((x) => x.classList.remove('selecionada'));
        el.classList.add('selecionada');
        el.querySelector('input').checked = true;
      };
      // 'change' cobre seleção por teclado (Tab + setas/espaço); 'click' cobre mouse/toque
      el.addEventListener('click', marcarSelecionada);
      el.querySelector('input').addEventListener('change', marcarSelecionada);
    });

    const btn = document.getElementById('btn-confirmar');
    if (btn && !desabilitar) btn.addEventListener('click', confirmar);
    else if (btn) btn.addEventListener('click', avancar);
  }

  // ---------- Confirmar resposta (obrigatória) ----------
  async function confirmar() {
    const sel = document.querySelector('input[name="alt"]:checked');
    if (!sel) { alert('Resposta obrigatória: selecione uma alternativa.'); return; }
    const r = await fetch(`/api/provas/${cfg.provaId}/responder`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ questao_id: questaoIdAtual, letra: sel.value })
    });
    const data = await r.json();
    if (!r.ok) { alert(data.erro || 'Erro ao salvar.'); return; }
    elProgresso.textContent = `${data.respondidas}/${data.total} respondidas`;
    if (data.concluiu) return finalizar(false);
    avancar();
  }

  function avancar() {
    if (ordemAtual < cfg.total) carregar(ordemAtual + 1);
    else finalizar(false);
  }

  // ---------- Finalizar ----------
  async function finalizar(automatico) {
    if (finalizando) return;
    finalizando = true;
    if (automatico) alert('Tempo esgotado! Sua prova será enviada automaticamente.');
    const r = await fetch(`/api/provas/${cfg.provaId}/finalizar`, { method: 'POST' });
    const data = await r.json();
    window.location.href = data.redirect || `/aluno/provas/${cfg.provaId}/resultado`;
  }

  // ---------- Detecção de perda de foco ----------
  async function registrarFoco(tipo) {
    if (finalizando) return;
    const r = await fetch(`/api/provas/${cfg.provaId}/foco`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ tipo, questao_id: questaoIdAtual })
    });
    const data = await r.json();
    const c = document.getElementById('cont-foco');
    if (c) c.textContent = data.perdas_foco;
    if (data.questao_anulada) {
      const box = document.querySelector('.questao-box');
      if (box && !box.querySelector('.foco-aviso')) {
        const p = document.createElement('p');
        p.className = 'foco-aviso';
        p.textContent = '⚠ Questão ANULADA por perda de foco.';
        box.insertBefore(p, box.querySelector('#alts'));
      }
    }
    // Política configurável: encerra após N saídas (0 = anula por questão, sem encerrar)
    if (cfg.maxPerdasFoco > 0 && data.perdas_foco >= cfg.maxPerdasFoco) {
      alert('Limite de saídas de foco atingido. A prova será encerrada.');
      finalizar(true);
    }
  }

  window.addEventListener('blur', () => registrarFoco('blur'));
  document.addEventListener('visibilitychange', () => {
    if (document.hidden) registrarFoco('visibilitychange');
  });

  // ---------- Bloqueio de copiar/colar/seleção/menu ----------
  ['copy', 'cut'].forEach((ev) =>
    document.addEventListener(ev, (e) => { e.preventDefault(); registrarFoco('copy'); }));
  document.addEventListener('paste', (e) => { e.preventDefault(); registrarFoco('paste'); });
  document.addEventListener('contextmenu', (e) => e.preventDefault());
  document.addEventListener('selectstart', (e) => {
    if (e.target.closest('.questao-box')) e.preventDefault();
  });

  // Sanitiza HTML para exibição segura
  function escapar(s) {
    const d = document.createElement('div');
    d.textContent = s == null ? '' : String(s);
    return d.innerHTML;
  }

  // Start
  elProgresso.textContent = `${cfg.respondidas}/${cfg.total} respondidas`;
  carregar(cfg.respondidas + 1 <= cfg.total ? cfg.respondidas + 1 : 1);
  tick();
})();
