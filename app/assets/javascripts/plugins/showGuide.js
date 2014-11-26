var showGuide = function(selector, option) {
  selector = selector ||  ".boot-tour";
  var options =  {
    prevButtonText: "上一步",
    nextButtonText: "下一步",
    finishButtonText: "关闭"
  };
  $.extend(options, option || {});
  bootstro.start(selector, options);
};