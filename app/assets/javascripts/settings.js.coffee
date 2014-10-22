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
  icheck = ->
    if $(".icheck-me").length > 0
      $(".icheck-me").each ->
        $el = $(this)
        skin = (if ($el.attr("data-skin") isnt `undefined`) then "_" + $el.attr("data-skin") else "")
        color = (if ($el.attr("data-color") isnt `undefined`) then "-" + $el.attr("data-color") else "")
        opt =
          checkboxClass: "icheckbox" + skin + color
          radioClass: "iradio" + skin + color

        $el.iCheck opt

  $ ->
    icheck()

  # 图片上传样式
  $(".filestyle").each ->
    $this = $(this)
    options =
      input: (if $this.attr("data-input") is "false" then false else true)
      icon: (if $this.attr("data-icon") is "false" then false else true)
      buttonBefore: (if $this.attr("data-buttonBefore") is "true" then true else false)
      disabled: (if $this.attr("data-disabled") is "true" then true else false)
      size: $this.attr("data-size")
      buttonText: $this.attr("data-buttonText")
      buttonName: $this.attr("data-buttonName")
      iconName: $this.attr("data-iconName")
      badge: (if $this.attr("data-badge") is "false" then false else true)

    $this.filestyle options

$(document).on 'page:fetch', ->
  NProgress.start()
$(document).on 'page:change', ->
  NProgress.done()
$(document).on 'page:restore', ->
  NProgress.remove()
