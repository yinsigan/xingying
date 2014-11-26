#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap/alert
#= require bootstrap/dropdown
#= require nprogress
#= require_self

# ajax error
$(document).on 'ajax:error', ->
  $(".alert-warning.alert-fixed-top").html("数据加载失败").fadeIn().delay(5000).fadeOut() if $(".alert-warning.alert-fixed-top").css("display") == "none"

# 超时时到登录界面
$(document).ajaxError (e, xhr, settings) ->
  Turbolinks.visit "/users/sign_in" if xhr.status is 401

$(document).on 'page:fetch', ->
  NProgress.start()
$(document).on 'page:change', ->
  NProgress.done()
$(document).on 'page:restore', ->
  NProgress.remove()