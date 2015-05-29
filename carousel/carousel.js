$.Carousel = function (html) {
  this.$el = $(html);
  this.activeIdx = 0;
  $('div').find('.items').eq(0).addClass('active');
  this.$right = $(".slide-right");
  this.$left = $(".slide-left");
  this.$right.on("click", this.slide.bind(this, 1));
  this.$left.on("click", this.slide.bind(this, -1));
};


$.Carousel.prototype.slideLeft = function ($oldItem, $nextItem) {
  var that = this;
  $oldItem.addClass("right");
  setTimeout(function() {
    $oldItem.one("transitionend", function () {
      $oldItem.removeClass('active').removeClass('right');
      $nextItem.removeClass('left');
    });
  }, 0);
  $nextItem.addClass("left");
};

$.Carousel.prototype.slideRight = function ($oldItem, $nextItem) {
  var that = this;
  $oldItem.addClass("left");
  setTimeout(function() {
    $oldItem.one("transitionend", function () {
      $oldItem.removeClass('active').removeClass('left');
      $nextItem.removeClass('right');
    });
  }, 0);
  $nextItem.addClass("right");
};

$.Carousel.prototype.slide = function (dir) {
  var current = dir+ this.activeIdx;
  if (current > 3) {
    current -= 4;
  }
  var that = this;
  var $oldItem = $('[data-index=' + this.activeIdx + ']');

  var $nextItem = $(".items").children().eq(current);
  $nextItem.addClass('active');
  if (dir === 1) {
    this.slideRight($oldItem, $nextItem);
  } else {
    this.slideLeft($oldItem, $nextItem);
  }
  this.activeIdx = $nextItem.index();
  // var current = dir+ this.activeIdx;
  // if (current > 3) {
  //   current -= 4;
  // }
  // var that = this;
  // var $oldItem = $('[data-index=' + this.activeIdx + ']');
  //
  // var $nextItem = $(".items").children().eq(current);
  // $nextItem.addClass('active');
  // if (dir > 0) {
    // $oldItem.addClass("right");
    // $nextItem.addClass("right");
    // setTimeout(function() {
    //   that.moveImage("right");
    //   $oldItem.one("transitionend", function () {
    //     $oldItem.removeClass('active');
    //   });
    // }, 1);
  // } else {
  //   $oldItem.addClass("left");
  //   $nextItem.addClass("left");
  //   setTimeout(function() {
  //     that.moveImage("left");
  //     $oldItem.one("transitionend", function () {
  //       $oldItem.removeClass('active');
  //     });
  //   }, 1);
  // }
  // this.activeIdx = $nextItem.index();
};

// $.Carousel.prototype.moveImage = function(dir) {
//   var movedImages = $('img').filter("." + dir);
//   movedImages.removeClass(dir);
// };

$.fn.carousels = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
