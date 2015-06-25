(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }

  var Bullet = Asteroids.Bullet = function (game, pos, vel) {
    Asteroids.MovingObject.call(this, {game: game, pos: pos, vel: vel});
    this.radius = 5;
    this.color = "#FF0000";
    this.isWrappable = false;
    this.type = "Bullet";
  };


  Asteroids.Util.inherits(Bullet, Asteroids.MovingObject);
})();
