picture_upload = (picture_upload_form) ->
  picture_upload_wrapper = $(picture_upload_form)
  if picture_upload_wrapper.find("#upload").length > 0
    picture_upload_wrapper.find(".picture_upload").fileupload
      done: (e, data) ->
        picture_upload_wrapper.find(".progress").hide()
        $.unblockUI()
        return

      add: (e, data) ->
        $.blockUI message: "<h1>正在上传...请稍等...</h1>"

        # var file_size = parseFloat(data.files[0].size / 1024);
        # console.log(file_size.toFixed(2) + "KB");
        # console.log(data.files[0].name);
        data.submit()
        return

      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        picture_upload_wrapper.find(".progress").show()
        picture_upload_wrapper.find(".progress .progress-bar").css "width", progress + "%"
        return

  return

$(document).on "page:change", ->
  # 图片上传
  picture_upload "#upload_form"