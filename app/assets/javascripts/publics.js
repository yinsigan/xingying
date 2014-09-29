$(document).ready(function() {
  //显示微信token和url信息
  $(document).on('click', '#display-dev-info', function() {
    $(this).parent().next(".alert").toggle('fast');
  })
});
