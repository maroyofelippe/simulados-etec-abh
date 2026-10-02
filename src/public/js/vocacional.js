// ==========================================================
//  Motor do Teste Vocacional (modo visitante da Feira)
//  - Uma afirmação por vez, nota de 1 a 5 (atalho: teclas 1 a 5)
//  - Cada nota é salva no servidor ao responder (retoma de onde parou)
//  - Perguntas abertas e finalização; o cálculo é feito no servidor
// ==========================================================
(function () {
  const cfg = window.VOC_CFG;
  const raiz = document.getElementById('voc-app');
  if (!cfg || !raiz) return;

  const total = cfg.afirmacoes.length;
  const notas = Object.assign({}, cfg.notas);
  const abertas = Object.assign({}, cfg.abertas);
  let tela = 'perguntas';
  let i = cfg.afirmacoes.findIndex((q) => !notas[q.id]);
  if (i < 0) tela = 'abertas';

  function el(tag, attrs, filhos) {
    const e = document.createElement(tag);
    Object.keys(attrs || {}).forEach((k) => {
      if (k === 'class') e.className = attrs[k];
      else if (k === 'text') e.textContent = attrs[k];
      else if (k.startsWith('on')) e.addEventListener(k.slice(2), attrs[k]);
      else e.setAttribute(k, attrs[k]);
    });
    (filhos || []).forEach((f) => e.appendChild(f));
    return e;
  }

  function desenhar(foco) {
    raiz.replaceChildren(tela === 'perguntas' ? telaPergunta() : telaAbertas());
    const f = document.getElementById('voc-foco');
    if (foco !== false && f) f.focus({ preventScroll: true });
  }

  function telaPergunta() {
    const q = cfg.afirmacoes[i];
    const pct = Math.round((i / total) * 100);

    const opcoes = cfg.escala.map((rotulo, k) => {
      const n = k + 1;
      const input = el('input', { type: 'radio', name: 'nota', value: String(n), 'aria-label': `${n} – ${rotulo}`, onchange: () => responder(n) });
      if (notas[q.id] === n) input.checked = true;
      return el('label', { class: 'voc-opt' }, [input, el('span', {}, [document.createTextNode(String(n)), el('small', { text: rotulo })])]);
    });

    return el('div', {}, [
      el('div', { class: 'voc-topo' }, [el('span', { text: `Afirmação ${i + 1} de ${total}` }), el('span', { text: `${pct}%` })]),
      el('div', { class: 'voc-barra', role: 'progressbar', 'aria-valuemin': '0', 'aria-valuemax': '100', 'aria-valuenow': String(pct) },
        [el('span', { style: `width:${pct}%` })]),
      el('h2', { class: 'voc-afirmacao', tabindex: '-1', id: 'voc-foco', text: q.texto }),
      el('fieldset', { class: 'voc-escala' }, [el('legend', { class: 'sr-only', text: 'Quanto você concorda?' })].concat(opcoes)),
      el('div', { class: 'voc-extremos' }, [el('span', { text: 'Discordo totalmente' }), el('span', { text: 'Concordo totalmente' })]),
      el('p', { class: 'metric-label', text: 'Dica: use as teclas 1 a 5 para responder.' }),
      el('div', { class: 'voc-acoes' }, [
        el('button', Object.assign({ class: 'btn btn-outline', type: 'button', onclick: voltar }, i === 0 ? { disabled: 'disabled' } : {}), [document.createTextNode('Voltar')])
      ])
    ]);
  }

  function telaAbertas() {
    const campos = cfg.perguntas.map((p) => {
      const ta = el('textarea', { id: `voc-a${p.id}`, maxlength: '2000', rows: '4', oninput: (e) => { abertas[p.id] = e.target.value; } });
      ta.value = abertas[p.id] || '';
      return el('div', {}, [el('label', { for: `voc-a${p.id}`, text: p.texto }), ta]);
    });
    return el('div', {}, [
      el('h2', { tabindex: '-1', id: 'voc-foco', text: 'Agora, com as suas palavras' }),
      el('p', { class: 'metric-label', text: 'Estas respostas ajudam a desempatar áreas parecidas. Escreva o que vier à cabeça.' }),
      el('div', { class: 'voc-abertas' }, campos),
      el('p', { id: 'voc-erro', class: 'alerta alerta-erro', role: 'alert', style: 'display:none' }),
      el('div', { class: 'voc-acoes' }, [
        el('button', { class: 'btn btn-outline', type: 'button', onclick: voltar, text: 'Voltar' }),
        el('button', { class: 'btn btn-primario', type: 'button', id: 'voc-finalizar', onclick: finalizar, text: 'Ver meu resultado' })
      ])
    ]);
  }

  function voltar() {
    if (tela === 'abertas') { tela = 'perguntas'; i = total - 1; } else if (i > 0) { i--; }
    desenhar();
  }

  let salvando = false;
  async function responder(nota) {
    if (salvando) return;
    salvando = true;
    const q = cfg.afirmacoes[i];
    try {
      const r = await fetch('/api/vocacional/responder', {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ afirmacao_id: q.id, nota })
      });
      if (!r.ok) throw new Error((await r.json()).erro || 'Falha ao salvar.');
      notas[q.id] = nota;
      if (i < total - 1) i++; else tela = 'abertas';
      desenhar();
    } catch (e) {
      alert(e.message);
      desenhar(false);
    } finally { salvando = false; }
  }

  async function finalizar() {
    const btn = document.getElementById('voc-finalizar');
    const erro = document.getElementById('voc-erro');
    btn.disabled = true;
    try {
      const r = await fetch('/api/vocacional/finalizar', {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ abertas })
      });
      const d = await r.json();
      if (!r.ok) throw new Error(d.erro || 'Falha ao finalizar.');
      window.location.href = d.redirect;
    } catch (e) {
      erro.textContent = e.message;
      erro.style.display = 'block';
      btn.disabled = false;
    }
  }

  document.addEventListener('keydown', (e) => {
    if (tela !== 'perguntas' || e.ctrlKey || e.metaKey || e.altKey) return;
    if (/^[1-5]$/.test(e.key)) responder(parseInt(e.key, 10));
  });

  desenhar(false);
})();
