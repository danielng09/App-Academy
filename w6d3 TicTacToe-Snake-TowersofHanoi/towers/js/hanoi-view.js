(function() {
  if (typeof Hanoi === undefined) {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    this.render();
    this.fromPile = null;
    this.clickTower();
  };

  View.prototype.clickTower = function() {
    var that = this;
    $(".pile").on("click", function(event) {
      var $target = $(event.currentTarget);
      if (that.fromPile !== null) {
        var toPile = $target.data("pileNumber");
        if (that.game.isValidMove(that.fromPile, toPile)) {
          that.game.move(that.fromPile, toPile);
        } else {
          alert("This is an invalid move!");
        }
        $('.pile' + that.fromPile).removeClass("clicked");
        that.fromPile = null;

      } else {
        that.fromPile = $target.data("pileNumber");
        $target.addClass("clicked");
      }
      that.render();
      if (that.game.isWon()) {
        $('h1').html("YOU WON!!!");
        $('.pile').off('click');
      }
    });
  };

  View.prototype.render = function() {
    var towers = this.game.towers;
    for (var towerIdx = 0; towerIdx < towers.length; towerIdx++) {
      for (var discIdx = 0; discIdx < towers[towerIdx].length; discIdx++) {
        var discVal = towers[towerIdx][discIdx];
        $('.disc' + discVal).prependTo($('.container' + towerIdx));
      }
    }
  };

  View.prototype.setupTowers = function() {
    var numTowers = this.game.towers.length;
    for (var idx = 0; idx < numTowers; idx++) {
      $('<div>').data("pileNumber", idx).addClass('pile' + idx)
                .addClass('pile').appendTo(this.$el);
      $('<ul>').addClass('disc-container').addClass('container' + idx)
               .appendTo($('.pile' + idx));
    }

    var tower = this.game.towers[0];
    for (idx = tower.length - 1; idx >= 0; idx--) {
      $('<div>').addClass('disc').addClass('disc' + tower[idx])
                .css('width', 50*(tower[idx]) + "px")
                .prependTo('.container0');
    }

  };

})();
