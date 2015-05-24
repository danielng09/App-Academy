var readline = require("readline");
var Piece = require("./piece.js");
var Board = require("./board.js");

/**
 * Sets up the game with a board and the first player to play a turn.
 */
function Game () {
  this.board = new Board();
  this.turn = "black";
  this.symbol = "O";
  this.invalid = false;
}

/**
 * Flips the current turn to the opposite color.
 */
Game.prototype._flipTurn = function () {
  if (this.turn == "black") {
    this.turn = "white";
    this.symbol = "X";
  } else {
     this.turn = "black";
     this.symbol = "O";
  }
};

// Dreaded global state!
var rlInterface;

/**
 * Creates a readline interface and starts the run loop.
 */
Game.prototype.play = function () {
  rlInterface = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
  });

  this.runLoop(function () {
    rlInterface.close();
    rlInterface = null;
  });
};

/**
 * Gets the next move from the current player and
 * attempts to make the play.
 */
Game.prototype.playTurn = function (callback) {
  console.log('\033[2J');
  if (this.invalid) {
    console.log("Invalid move!");
    this.invalid = false;
  }
  this.board.print();
  rlInterface.question(
    this.turn + " (" + this.symbol + ") " + ", where do you want to move?",
    handleResponse.bind(this)
  );

  function handleResponse (answer) {
    var pos = JSON.parse(answer);
    if (!this.board.validMove(pos, this.turn)) {
      this.invalid = true;
      this.playTurn(callback);
      return;
    }

    this.board.placePiece(pos, this.turn);
    this._flipTurn();
    callback();
  }
};

/**
 * Continues game play, switching turns, until the game is over.
 */
Game.prototype.runLoop = function (overCallback) {
  if (this.board.isOver()) {
    console.log("The game is over!");
    overCallback();
  } else if (!this.board.hasMove(this.turn)) {
    console.log(this.turn + " has no move!");
    this._flipTurn();
    this.runLoop();
  } else {
    this.playTurn(this.runLoop.bind(this, overCallback));
  }
};

module.exports = Game;

var game = new Game();
game.play();
game.runLoop();
