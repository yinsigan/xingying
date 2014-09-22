$(document).on('click', '.yamm .dropdown-menu', function(e) {
  e.stopPropagation()
})

$(document).ready(function() {
  var flash = ['info', 'success', 'danger', 'warning'];
  for (var key in flash) {
    var select = '.alert-autocloseable-' + flash[key]
    if ($(select).length > 0) {
      $(select).delay(5000).fadeOut();
    }
  }
});
