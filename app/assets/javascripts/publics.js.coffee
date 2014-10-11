$(document).ready ->
  # 显示微信token和url信息
  $(document).on 'click', '#display-dev-info', ->
    $(this).parent().next(".alert").toggle 'fast'
