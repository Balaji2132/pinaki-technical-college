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
    // Simple sidebar toggle logic
    const menuBtn = document.getElementById('mobile-menu-btn');
    const sidebar = document.getElementById('mobile-sidebar');
    const closeBtn = document.getElementById('close-sidebar');
    
    // Open sidebar
    if (menuBtn && sidebar) {
      menuBtn.addEventListener('click', function() {
        sidebar.style.display = 'block';
        console.log('Sidebar opened'); // Debug log
      });
    }
    
    // Close sidebar
    function closeSidebar() {
      if (sidebar) {
        sidebar.style.display = 'none';
        console.log('Sidebar closed'); // Debug log
      }
    }
    
    if (closeBtn) {
      closeBtn.addEventListener('click', closeSidebar);
    }
    
    // Close on overlay click
    if (sidebar) {
      sidebar.addEventListener('click', function(e) {
        if (e.target === sidebar) {
          closeSidebar();
        }
      });
    }
    
    // Close on link click
    const links = sidebar?.querySelectorAll('a');
    if (links) {
      links.forEach(link => {
        link.addEventListener('click', closeSidebar);
      });
    }
  });
  
  includePartial('footer-partial', 'footer.html');
});