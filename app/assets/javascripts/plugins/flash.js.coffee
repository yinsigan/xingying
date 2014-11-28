$(document).on "page:change", ->

  # # 让flash在5秒内自动消失
  # flash = [
  #   "info"
  #   "success"
  #   "danger"
  #   "warning"
  # ]
  # for key of flash
  #   select = ".alert-autocloseable-" + flash[key]
  #   $(select).delay(5000).fadeOut()  if $(select).length > 0