(function() {
  (function($) {
    return $.fn.CoffeeClapSlider = function(opt) {
      var Style, animate, liCount, move, s, ulWidth,
        _this = this;
      s = $.extend({
        'cssReset': {
          "padding": "0",
          "margin": "0",
          "max-width": "none"
        },
        'width': '500',
        'height': '300',
        'autoPlay': true,
        'time': 3000,
        'speed': 600,
        'btnNext': void 0,
        'btnPrev': void 0
      }, opt);
      ulWidth = 0;
      liCount = 0;
      animate = false;
      this.find('img').each(function() {
        ulWidth += $(this).width();
        return liCount++;
      });
      Style = {
        "div": {
          "width": s.width + "px",
          "overflow": "hidden",
          "height": s.height + "px"
        },
        "ul": {
          "height": s.height + "px",
          "list-style": "none",
          "width": ulWidth
        },
        "li": {
          "float": "left"
        }
      };
      this.init = function() {
        _this.find('*').css(s.cssReset);
        _this.css(Style.div).find('ul').css(Style.ul).find('li').css(Style.li).find('li').css('height', "" + s.height + "px", "important");
        if (s.autoPlay) {
          return setInterval(function() {
            if (s.autoPlay) {
              return _this.move("next");
            }
          }, s.time);
        }
      };
      if (s.btnNext) {
        s.btnNext.click(function(even) {
          even.preventDefault();
          s.autoPlay = false;
          return _this.move("next");
        });
      }
      if (s.btnPrev) {
        s.btnPrev.click(function(even) {
          even.preventDefault();
          s.autoPlay = false;
          return _this.move("prev");
        });
      }
      move = {
        "next": function() {
          var li;
          li = _this.find('li').eq(0);
          li.clone().appendTo($(_this).find("ul"));
          return li.animate({
            "width": 0
          }, s.speed, function() {
            $(this).remove();
            return animate = false;
          });
        },
        "prev": function() {
          var li;
          li = _this.find('li').eq(liCount - 1);
          li.css({
            "width": 0
          }).clone().prependTo($(_this).find("ul"));
          return _this.find('li').eq(0).animate({
            "width": s.width
          }, s.speed, function() {
            li.remove();
            return animate = false;
          });
        }
      };
      this.move = function(to) {
        if (to == null) {
          to = 'next';
        }
        if (!animate && (to === 'next' || to === 'prev')) {
          animate = true;
          return move[to]();
        }
      };
      this.init();
      return this;
    };
  })(jQuery);

}).call(this);
