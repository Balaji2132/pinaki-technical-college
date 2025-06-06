document.addEventListener('DOMContentLoaded', function() {
  function includePartial(id, file) {
    fetch(file)
      .then(response => response.text())
      .then(data => {
        document.getElementById(id).innerHTML = data;
      });
  }
  includePartial('header-partial', 'header.html');
  includePartial('footer-partial', 'footer.html');
}); 