(function() {
  if (typeof window.Snake !== "object") {
    window.Snake = {};
  }

  var View = Snake.View = function($el) {
    this.$el = $el;
    this.board = new Snake.Board($el);
    this.constructKeyBindings();
    this.step;
    // setInterval(this.step.bind(this), 5000);
  };

  View.prototype.constructKeyBindings = function() {
    this.$el.on('keydown', function(event) {
      this.handleKeyEvent(event);
    }.bind(this));
  };

  View.prototype.step = function() {
    this.board.snake.move();
    this.board.render();
  };

  View.prototype.handleKeyEvent = function(event) {
    var code = event.keyCode;
    switch (code) {
      case 37:
        this.board.snake.turn("W");
        break;
      case 38:
        this.board.snake.turn("N");
        break;
      case 39:
        this.board.snake.turn("E");
        break;
      case 40:
        this.board.snake.turn("S");
        break;
      default:
    }
  };
})();
