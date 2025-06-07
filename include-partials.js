document.addEventListener('DOMContentLoaded', function() {
  function includePartial(id, file, callback) {
    fetch(file)
      .then(response => response.text())
      .then(data => {
        document.getElementById(id).innerHTML = data;
        if (typeof callback === 'function') callback();
      });
  }
  includePartial('header-partial', 'header.html', function() {
    // Re-attach sidebar toggle logic after header is injected
    const menuBtn = document.getElementById('mobile-menu-btn');
    const sidebar = document.getElementById('mobile-sidebar');
    const closeBtn = document.getElementById('close-sidebar');
    if(menuBtn && sidebar) {
      menuBtn.addEventListener('click', function() {
        sidebar.classList.remove('hidden');
      });
    }
    if(closeBtn && sidebar) {
      closeBtn.addEventListener('click', function() {
        sidebar.classList.add('hidden');
      });
    }
    if(sidebar) {
      sidebar.addEventListener('click', function(e) {
        if (e.target === sidebar) sidebar.classList.add('hidden');
      });
    }
  });
  includePartial('footer-partial', 'footer.html');
}); 