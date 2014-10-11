$(document).on "page:change", ->

  #让flash在5秒内自动消失
  flash = [
    "info"
    "success"
    "danger"
    "warning"
  ]
  for key of flash
    select = ".alert-autocloseable-" + flash[key]
    $(select).delay(5000).fadeOut()  if $(select).length > 0

  # 弹出冒泡型警告框
  $("button[data-popover], a[data-popover]").popover 'hide'

  # 弹出黑色提示框
  $('button[data-tooltip], a[data-tooltip]').tooltip()

  # 把圆形loading去掉
  # NProgress.configure { showSpinner: false }

$(document).on 'page:fetch', ->
  NProgress.start()
$(document).on 'page:change', ->
  NProgress.done()
$(document).on 'page:restore', ->
  NProgress.remove()
