(function () {
  var btn = document.getElementById('toggleMenu');
  var ov = document.getElementById('overlay');
  function close() {
    document.body.classList.remove('menu-open');
    if (btn) { btn.setAttribute('aria-expanded', 'false'); }
  }
  if (btn) {
    btn.addEventListener('click', function () {
      var open = document.body.classList.toggle('menu-open');
      btn.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
  }
  if (ov) { ov.addEventListener('click', close); }
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') { close(); }
  });
}());
