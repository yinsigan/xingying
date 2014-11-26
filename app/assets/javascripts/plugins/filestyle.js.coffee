filestyle = ->
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

$(document).on "page:change", ->
  # 图片上传样式
  filestyle()