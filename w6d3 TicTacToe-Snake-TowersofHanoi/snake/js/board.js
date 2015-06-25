(function() {
  if (typeof window.Snake !== 'object') {
    window.Snake = {};
  }

  var Board = Snake.Board = function($el) {
    this.apples = [];
    this.$el = $el;
    this.setupGrid();
    this.snake = new Snake.Snake(10);
    this.render();
  };

  Board.prototype.render = function() {
    for (var i = 0; i < 20; i++) {
      for (var j = 0; j < 20; j++) {
        if (this.checkIfSnake(i, j)) {
          this.grid[i][j] = "S";
        } else {
          this.grid[i][j] = "_";
        }
      }
    }
    $('.container').html("");
    this.grid.forEach( function(row) {
      $('.container').append(row.join(" ")+"<br>");
    });
  };

  Board.prototype.checkIfSnake = function(i, j) {
    var segs = this.snake.segments;
    var isSnake = false;
    for (var k = 0; k < segs.length; k++) {
      if (segs[k][0] === i && segs[k][1] === j) {
        isSnake = true;
      }
    }

    return isSnake;
  };

  Board.prototype.setupGrid = function() {
    for (var i = 0; i < 20; i++) {
      $("<div>").addClass("row").addClass("row" + i).appendTo(this.$el);
      for (var j = 0; j < 20; j++) {
        $("<div>").addClass("cell").data({'rowIdx':i,'colIdx':j})
                  .appendTo($('.row' + i));
      }
    }

    //
    // var grid = new Array (gridSize);
    // for (var i = 0; i < gridSize; i++) {
    //   grid[i] = new Array(gridSize);
    //   for (var j = 0; j < gridSize; j++) {
    //     grid[i][j] = "_";
    //   }
    // }
    //
    // return grid;
  };

})();
