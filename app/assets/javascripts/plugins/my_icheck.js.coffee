my_icheck = (my_class) ->
  icheck = (my_class) ->
    if $(my_class).length > 0
      $(my_class).each ->
        $el = $(this)
        skin = (if ($el.attr("data-skin") isnt `undefined`) then "_" + $el.attr("data-skin") else "")
        color = (if ($el.attr("data-color") isnt `undefined`) then "-" + $el.attr("data-color") else "")
        opt =
          checkboxClass: "icheckbox" + skin + color
          radioClass: "iradio" + skin + color

        $el.iCheck opt

  $ ->
    icheck my_class


$(document).on "page:change", ->
  # 复选框样式
  my_icheck ".icheck-me"