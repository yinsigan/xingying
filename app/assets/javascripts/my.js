var picture_upload = function() {
  if ($("#upload").length > 0) {
    $("#picture_upload").fileupload({
      done: function(e, data) {
        $("#progress_div").hide();
        $("body").spin(false);
        Turbolinks.visit();
      },
      add: function(e, data) {
        $("body").spin();
        data.submit();
      },
      progressall: function(e, data) {
        var progress;
        progress = parseInt(data.loaded / data.total * 100, 10);
        $("#progress_div").show();
        $("#progress_div .progress-bar").css("width", progress + "%");
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
