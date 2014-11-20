var picture_upload = function(picture_upload_form) {
  var picture_upload_wrapper = $(picture_upload_form);

  if (picture_upload_wrapper.find("#upload").length > 0) {
    picture_upload_wrapper.find(".picture_upload").fileupload({
      done: function(e, data) {
        picture_upload_wrapper.find(".progress").hide();
        $("body").spin(false);
      },
      add: function(e, data) {
        $("body").spin();
        // var file_size = parseFloat(data.files[0].size / 1024);
        // console.log(file_size.toFixed(2) + "KB");
        // console.log(data.files[0].name);
        data.submit();
      },
      progressall: function(e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        picture_upload_wrapper.find(".progress").show();
        picture_upload_wrapper.find(".progress .progress-bar").css("width", progress + "%");
      }
    });
  }
};

var filestyle = function() {

  $('.filestyle').each(function() {
    var $this = $(this), options = {

      'input' : $this.attr('data-input') === 'false' ? false : true,
      'icon' : $this.attr('data-icon') === 'false' ? false : true,
      'buttonBefore' : $this.attr('data-buttonBefore') === 'true' ? true : false,
      'disabled' : $this.attr('data-disabled') === 'true' ? true : false,
      'size' : $this.attr('data-size'),
      'buttonText' : $this.attr('data-buttonText'),
      'buttonName' : $this.attr('data-buttonName'),
      'iconName' : $this.attr('data-iconName'),
      'badge' : $this.attr('data-badge') === 'false' ? false : true
    };

    $this.filestyle(options);
  });
};

var my_icheck = function(my_class) {
  function icheck(my_class){
    if($(my_class).length > 0){
      $(my_class).each(function(){
        var $el = $(this);
        var skin = ($el.attr('data-skin') !== undefined) ? "_" + $el.attr('data-skin') : "",
        color = ($el.attr('data-color') !== undefined) ? "-" + $el.attr('data-color') : "";
        var opt = {
          checkboxClass: 'icheckbox' + skin + color,
          radioClass: 'iradio' + skin + color,
        }
        $el.iCheck(opt);
      });
    }
  }

  $(function(){
    icheck(my_class);
  })
}

var check_all = function() {
  var operate;

  if ($("#check_all").length > 0) {
    $("#check_all").on("ifChecked", function() {
      $(".icheck-me").iCheck("check");
    });
    $("#check_all").on("ifUnchecked", function() {
      $(".icheck-me").iCheck("uncheck");
    });
    operate = $("#operate-button");
    $(".icheck-me").on("ifChanged", function() {
      if ($(".icheck-me").is(":checked")) {
        operate.find("a").removeClass("disabled");
      } else {
        operate.find("a").addClass("disabled");
      }
    });
  }
};


var showGuide = function(selector, option){
  selector = selector ||  ".boot-tour";
  var options =  {
    prevButtonText: "上一步",
    nextButtonText: "下一步",
    finishButtonText: "关闭"
  };
  $.extend(options, option || {});
  bootstro.start(selector, options);
};
