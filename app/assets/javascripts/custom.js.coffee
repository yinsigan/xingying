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
    $(select).delay(5000).fadeOut()  if $(select).length > 0

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
  picture_upload("#upload_form")