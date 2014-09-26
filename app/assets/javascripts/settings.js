// yamm菜单项点击不自动冒泡
$(document).on('click', '.yamm .dropdown-menu', function(e) {
  e.stopPropagation()
})

$(document).ready(function() {

  //让flash在5秒内自动消失
  var flash = ['info', 'success', 'danger', 'warning'];
  for (var key in flash) {
    var select = '.alert-autocloseable-' + flash[key]
    if ($(select).length > 0) {
      $(select).delay(5000).fadeOut();
    }
  }

  //表单提示必填项
  $('.required-icon').tooltip({
    placement: 'left',
    title: '必填项'
  });

});


