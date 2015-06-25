(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function (game, pos) {
    Asteroids.MovingObject.call(this, {game: game, pos: pos});
    this.radius = 20;
    this.color = "#ffff00";
    this.vel = [0,0];
    this.type = "Ship";
  };
  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.prototype.fireBullet = function () {
    if (this.vel[0] !== 0 || this.vel[1] !== 0) {
      var pos = this.pos.slice();
      var vel = this.vel.slice();
      vel[0] *= 2;
      vel[1] *= 2;

      var bullet = new Asteroids.Bullet(this.game, pos, vel);
      this.game.bullets.push(bullet);
    }
  };

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

  Ship.prototype.relocate = function () {
    this.pos = [this.game.DIM_X/2, this.game.DIM_Y/2];
    this.vel = [0,0];
  };
})();
