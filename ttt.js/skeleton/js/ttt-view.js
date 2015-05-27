(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.$el = $el;
    this.game = game;
  };

  View.prototype.bindEvents = function () {
    var that = this;
    $('.cell').on('click', function(event) {
      var $target = $(event.currentTarget);
      that.makeMove($target);
    });
  };

  View.prototype.makeMove = function ($square) {
    if ($square.attr('class') !== 'cell') {
      alert("Invalid move!");
    } else {
      var piece = this.game.currentPlayer;
      var pos = [$square.data('rowIdx'), $square.data('colIdx')];
      $square.html(piece);
      $square.addClass(piece);

      this.game.playMove(pos);

      if (this.game.isOver()) {
        $('.cell').each(function(idx, ele) {
          $(ele).addClass("empty");
        });
        $('.cell').off('click');
        if (this.game.winner()) {
          console.log(typeof ('.' + piece));
          var klass = '.' + piece;
          $(klass).addClass('winner');
          alert(this.game.winner() + " has won!");
        } else {
          alert("NO ONE WINS!");
        }
      }
    }
  };

  View.prototype.setupBoard = function () {
    for(var rowIdx = 0; rowIdx < 3; rowIdx++) {
      $('<div>').addClass('row').appendTo(this.$el);
    }

    $('.row').each( function(rowIdx, el) {
      for(var colIdx = 0; colIdx < 3; colIdx++) {
        $('<div>').data({'rowIdx':rowIdx,'colIdx':colIdx})
                  .addClass('cell').appendTo(el);
      }
    });
  };

})();
