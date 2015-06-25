(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function (numAsteroids) {
    this.DIM_X = 1280;
    this.DIM_Y = 720;
    this.numAsteroids = numAsteroids;
    this.asteroids = this.addAsteroids(numAsteroids);
    this.ship = new Asteroids.Ship(this, [800, 350]);
    this.bullets = [];
  };

  Game.prototype.allObjects = function () {
    return this.asteroids.concat([this.ship], this.bullets);
  };

  Game.prototype.addAsteroids = function (numAsteroids) {
    var asteroids = [];
    for ( var i = 0; i < numAsteroids; i++ ) {
      var randPos = [Math.random() * this.DIM_X, Math.random() * this.DIM_Y];
      var asteroid = new Asteroids.Asteroid(randPos, this);
      asteroids.push(asteroid);
    }
    return asteroids;
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
    ctx.fillStyle = "black";
    ctx.fillRect(0, 0, this.DIM_X, this.DIM_Y);

    var background = new Image();

    background.src = "http://www.mrwallpaper.com/wallpapers/space-sparkling-stars-1280x720.jpg";
    // http://data.hdwallpapers.im/night_sky_hd.jpg
    ctx.drawImage(background,0,0);


    this.allObjects().forEach(function (movingObject) {
      movingObject.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.allObjects().forEach(function (movingObject) {
      movingObject.move();
    });
  };

  Game.prototype.wrap = function (pos) {
    var _wrap = function(coord, dim) {
      if (coord < 0) {
        coord += dim;
      } else if ( coord > dim ) {
        coord = coord % dim;
      }
      return coord;
    };

    return [_wrap(pos[0], this.DIM_X), _wrap(pos[1], this.DIM_Y)];
  };

  Game.prototype.isOutofBounds = function (pos) {
    if (pos[0] > this.DIM_X || pos[0] < 0 ||
        pos[1] > this.DIM_Y || pos[1] < 0) {
          return true;
        } else {
          return false;
        }
  };

  Game.prototype.checkCollisions = function () {
    var movingObjects = this.allObjects();
    for ( var i = 0; i < movingObjects.length; i++ ) {
      for ( var j = 0; j < movingObjects.length; j++ ) {
        if (i === j) { continue; }
        if ( movingObjects[i].isCollidedWith(movingObjects[j]) ) {
          movingObjects[i].collideWith(movingObjects[j]);
        }
      }
    }
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.remove = function (object) {
    if (object instanceof Asteroids.Asteroid) {
      var idx = this.asteroids.indexOf(object);
      this.asteroids.splice(idx, 1);
    } else if (object instanceof Asteroids.Bullet) {
      var idx = this.bullets.indexOf(object);
      this.bullets.splice(idx, 1);
    } else if (object instanceof Asteroids.Ship) {
      this.ship.relocate();
    }
  };

})();
