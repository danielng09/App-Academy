(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }

  var Asteroid = Asteroids.Asteroid = function (pos, game) {
    Asteroids.MovingObject.call(this, {pos: pos});
    this.color = '#6f6d6d';
    this.radius = 30;
    this.vel = randomVec(3);
    this.game = game;
    this.type = "Asteroid";
  };
  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

  var randomVec = function (length) {
    var angle = 2 * Math.PI * Math.random();
    return [length * Math.sin(angle), length * Math.cos(angle)];
  };

  Asteroid.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
    }
  };
})();
