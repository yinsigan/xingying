$(document).on "page:change", ->

  #让flash在2秒内自动消失
  flash = [
    "info"
    "success"
    "danger"
    "warning"
  ]
  for key of flash
    select = ".alert-autocloseable-" + flash[key]
    $(select).delay(2000).fadeOut()  if $(select).length > 0

  # 弹出冒泡型警告框
  $("button[data-popover], a[data-popover]").popover 'hide'

  # 弹出黑色提示框
  $('button[data-tooltip], a[data-tooltip]').tooltip()
  # 把圆形loading去掉
  # NProgress.configure { showSpinner: false }

  # 复选框样式
  my_icheck('.icheck-me')

  # 图片上传样式
  filestyle()

  # 全选
  check_all()

  # 图片上传
  picture_upload()

  $(document).on 'ajax:error', ->
    $(".alert-warning.alert-fixed-top").html("数据加载失败").fadeIn().delay(5000).fadeOut() if $(".alert-warning.alert-fixed-top").css("display") == "none"

  $(document).ajaxError (e, xhr, settings) ->
    Turbolinks.visit "/users/sign_in" if xhr.status is 401

$(document).on 'page:fetch', ->
  NProgress.start()
$(document).on 'page:change', ->
  NProgress.done()
$(document).on 'page:restore', ->
  NProgress.remove()
