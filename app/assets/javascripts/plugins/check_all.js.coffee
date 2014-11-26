check_all = ->
  operate = undefined
  if $("#check_all").length > 0
    $("#check_all").on "ifChecked", ->
      $(".icheck-me").iCheck "check"

    $("#check_all").on "ifUnchecked", ->
      $(".icheck-me").iCheck "uncheck"

    operate = $("#operate-button")
    $(".icheck-me").on "ifChanged", ->
      if $(".icheck-me").is(":checked")
        operate.find("a").removeClass "disabled"
      else
        operate.find("a").addClass "disabled"

$(document).on "page:change", ->
  # 全选
  check_all()