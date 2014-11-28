last_step = null,
  itv = null,
  isFunction = function(obj) {
    return "function" == typeof obj
  },
  revertWordWrapper = function(frame) {
    $(".frame-" + frame + ".article-wrapper h1").removeClass("magictime slideRightRetourn slideLeftRetourn").css({
      opacity: 0
    }), $(".frame-" + frame + ".article-wrapper p").removeClass("show")
  },
  showWordWraper = function(frame) {
    $(".frame-" + frame + ".article-wrapper h1").addClass("magictime").addClass(frame % 2 == 0 ? "slideRightRetourn" : "slideLeftRetourn").animate({
      opacity: 1
    }, 1500), $(".frame-" + frame + ".article-wrapper p").addClass("show")
  },
  doAnimation = function(frame, step, opts) {
    var animations = {
        1: {
          0: function() {
            $(".frame-1 .magictime").removeClass("magictime slideLeftRetourn slideDownRetourn slideUpRetourn slideUpRetourn slideRightRetourn element-show");
          },
          1: function() {
            $(".frame-1 .left").addClass("magictime slideLeftRetourn element-show");
            $(".frame-1 .up").addClass("magictime slideUpRetourn element-show");
            $(".frame-1 .down").addClass("magictime slideDownRetourn element-show");
            $(".frame-1 .right").addClass("magictime slideRightRetourn element-show");
          }
        },
        2: {
          0: function() {
            for (var i = 2; 6 >= i; i++) $(".frame-2-" + i + ".table-wrapper").addClass("hidden");
            $("img.frame-2").removeClass("magictime puffOut puffIn").hide(),
              revertWordWrapper(2),
              $(".frame-2-2 > .word-wrapper").removeClass("magictime swap holeOut"),
              $(".frame-2-3 > .word-wrapper").removeClass("magictime slideLeftRetourn openUpRightOut"),
              $(".frame-2-4 > .word-wrapper").removeClass("magictime slideRightRetourn openDownLeftOut"),
              $(".frame-2-5 > .word-wrapper").removeClass("magictime"),
              $(".frame-2-5 h2").removeClass("magictime holeOut").css({
                height: "auto",
                "margin-top": "40px"
              }),
              $(".frame-2-6").removeClass("together"),
              $(".frame-2-6-1").hide().css({
                opacity: 0,
                top: "20%"
              })
          },
          1: function() {
            showWordWraper(2),
              $(".frame-2-2.table-wrapper").removeClass("hidden"),
              $(".frame-2-2 > .word-wrapper").addClass("magictime swashIn")
          },
          2: function() {
            return $(".frame-2-2 > .word-wrapper").addClass("holeOut"), setTimeout(function() {
              $(".frame-2-2.table-wrapper").addClass("hidden")
            }, 800), 500
          },
          3: function() {
            $(".frame-2-3.table-wrapper").removeClass("hidden"), $(".frame-2-3 > .word-wrapper").addClass("magictime slideLeftRetourn")
          },
          4: function() {
            return $(".frame-2-3 > .word-wrapper").removeClass("slideLeftRetourn").addClass("openDownRightOut"), setTimeout(function() {
              $(".frame-2-3.table-wrapper").addClass("hidden")
            }, 800), 500
          },
          5: function() {
            $(".frame-2-4.table-wrapper").removeClass("hidden"), $(".frame-2-4 > .word-wrapper").addClass("magictime slideRightRetourn")
          },
          6: function() {
            return $(".frame-2-4 > .word-wrapper").removeClass("slideRightRetourn").addClass("openUpLeftOut"), setTimeout(function() {
              $(".frame-2-4.table-wrapper").addClass("hidden")
            }, 800), 500
          },
          7: function() {
            $(".frame-2-5.table-wrapper").removeClass("hidden"), $(".frame-2-5 > .word-wrapper").addClass("magictime slideDownRetourn")
          },
          8: function() {
            return $(".frame-2-5 > .word-wrapper").removeClass("slideDownRetourn").addClass("swashOut"), 800
          },
          9: function() {
            $(".frame-2-5").addClass("hidden"), $(".frame-2-6").removeClass("hidden"), $(".frame-2-6 img").addClass("magictime swashIn")
          },
          10: function() {
            $(".frame-2-6 img").removeClass("magictime swashIn")
          },
          11: function() {
            return $(".frame-2-6").addClass("together"), $(".frame-2-6-1").show().animate({
              opacity: 1,
              top: "54%"
            }, 1e3), 200
          },
          12: function() {
            $(".frame-2-6-2").show().addClass("magictime swashIn")
          }
        },
        5: {
          0: function() {
            $("#two-top").removeClass("magictime slideUpRetourn element-show");
            $("#two-left").removeClass("magictime slideLeftRetourn element-show");
            $("#two-right").removeClass("magictime slideRightRetourn element-show");
          },
          1: function() {
            $("#two-top").addClass("magictime slideUpRetourn element-show");
            $("#two-left").addClass("magictime slideLeftRetourn element-show");
            $("#two-right").addClass("magictime slideRightRetourn element-show");
          }
        }
      },
      fn = animations[frame] && animations[frame][step],
      wrapFn = function(fn, callback) {
        var time = 1e3;
        isFunction(fn) && (time = fn(callback, opts) || time, itv = setTimeout(function() {
          callback && callback(fn.step);
        }, time))
      };
    isFunction(fn) && (fn.frame = frame, fn.step = step, fn.options = opts, fn.revert = function() {
      return function() {
        var revert = animations[frame] && animations[frame][0];
        isFunction(revert) && revert();
      }()
    });
    var callback = function(step) {
      var new_fn = animations[frame] && animations[frame][step + 1];
      isFunction(new_fn) && (fn.step = step + 1, new_fn.step = fn.step, wrapFn(new_fn, callback))
    };
    isFunction(last_step) && isFunction(last_step.revert) && (last_step.revert(), last_step = null), wrapFn(fn, callback), isFunction(fn) && (last_step = fn);
  };
