(function () {
  if (typeof window.Snake !== 'object') {
    window.Snake = {};
  }

  var Coord = Snake.Coord = function(pos) {
    this.pos = pos;
  }
})();
