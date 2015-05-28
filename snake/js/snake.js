(function () {
  if (typeof window.Snake !== 'object') {
    window.Snake = {};
  }

  var Snake = window.Snake.Snake = function(middle) {
    this.dir = "E";
    this.segments = [[middle,middle-1], [middle, middle]];

  };

  Snake.DIR = {"N" : [1,0],
               "E" : [0,1],
               "S" : [-1,0],
               "W" : [0,-1]
               };

  Snake.prototype.move = function () {
    var movingSegment = this.segments.shift();
    this.segments.push(this.plus(movingSegment, this.dir));
  };

  Snake.prototype.plus = function(position, direction) {
    var newPosition = this.segments[this.segments.length-1].slice();
    console.log(direction);
    newPosition[0] += Snake.DIR[direction][0];
    newPosition[1] += Snake.DIR[direction][1];
    return newPosition;
  };

  Snake.prototype.turn = function(direction) {
    this.dir = direction;
  };

})();
