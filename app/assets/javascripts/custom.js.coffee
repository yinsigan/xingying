# ajax error
$(document).on 'ajax:error', ->
  $(".alert-warning.alert-fixed-top").html("数据加载失败").fadeIn().delay(5000).fadeOut() if $(".alert-warning.alert-fixed-top").css("display") == "none"

# 超时时到登录界面
$(document).ajaxError (e, xhr, settings) ->
  Turbolinks.visit "/users/sign_in" if xhr.status is 401

$(document).on "ajax:before", '.ajax_load', ->
  NProgress.start()
$(document).on "ajax:complete", '.ajax_load', ->
  NProgress.done()

  # 数据超时
  # $.rails.ajax = (options) ->
  #   options.timeout = 3000 unless options.timeout
  #   $.ajax options
$(document).on 'page:fetch', ->
  NProgress.start()
$(document).on 'page:change', ->
  NProgress.done()
$(document).on 'page:restore', ->
  NProgress.remove()

$(document).on "page:change", ->

  # 弹出黑色提示框
  $('button[data-tooltip], a[data-tooltip]').tooltip()
  # 把圆形loading去掉
  # NProgress.configure { showSpinner: false }

  # 让flash在5秒内自动消失
  flash = [
    "info"
    "success"
    "danger"
    "warning"
  ]
  for key of flash
    select = ".alert-autocloseable-" + flash[key]
    $(select).delay(5000).fadeOut()  if $(select).length > 0
