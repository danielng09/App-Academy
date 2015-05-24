var Piece = require("./piece");

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
 var board = [];
 for ( var i = 0; i < 8; i++ ) {
   var row = [];
   for ( var j = 0; j < 8; j++) {
     row.push(null);
   }
   board.push(row);
 }
 board[3][3] = new Piece("white");
 board[4][4] = new Piece("white");
 board[3][4] = new Piece("black");
 board[4][3] = new Piece("black");

 return board;
}
/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  if ( !this.isValidPos(pos) ) {
    throw new Error("no piece returned, invalid position given");
  }

  var rowIdx = pos[0];
  var colIdx = pos[1];
  return this.grid[rowIdx][colIdx];
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  return this.validMoves(color).length !== 0 ;
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  var piece = this.getPiece(pos);
  return ( piece && piece.color === color );
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  return ( !!this.getPiece(pos) );
};

/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  return !this.hasMove("white") && !this.hasMove("black");
};

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  var rowIdx = pos[0];
  var colIdx = pos[1];
  return (rowIdx >= 0 && rowIdx < 8 && colIdx >= 0 && colIdx < 8);
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns null if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns null if it hits an empty position.
 *
 * Returns null if no pieces of the opposite color are found.
 */
function _positionsToFlip (board, pos, color, dir, piecesToFlip) {
  if (!piecesToFlip) {
    piecesToFlip = [];
  } else {
    piecesToFlip.push(pos);
  }

  newPos = [ pos[0] + dir[0], pos[1] + dir[1] ];

  if ( !board.isValidPos(newPos) ) {
    return null;
  } else if ( !board.isOccupied(newPos) ) {
    return null;
  } else if ( board.isMine(newPos, color) ) {
    return piecesToFlip.length === 0 ? null : piecesToFlip;
  } else {
    return _positionsToFlip ( board, newPos, color, dir, piecesToFlip );
  }
}

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  if ( this.validMove (pos, color) ) {

    var that = this;
    Board.DIRS.forEach( function (dir) {
      var piecesToFlip = _positionsToFlip(that, pos, color, dir);
      if ( piecesToFlip ) {
        piecesToFlip.forEach( function(piecePos) {
          that.getPiece(piecePos).flip();
        });
      }
    });

    var newPiece = new Piece(color);
    this.grid[ pos[0] ][ pos[1] ] = newPiece;

  } else {
    throw new Error("This is an invalid move");
  }
};

/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  console.log( "[~][0][1][2][3][4][5][6][7]");
  for ( var rowIdx = 0; rowIdx < 8; rowIdx++ ) {
    var rowToPrint = JSON.stringify([rowIdx]);
    for ( var colIdx = 0; colIdx < 8; colIdx++ ) {
      var piece = this.grid[rowIdx][colIdx];
      if ( piece ) {
        rowToPrint += "[" + piece.toString() + "]";
      } else {
        rowToPrint += "[" + " " + "]";
      }
    }
  console.log(rowToPrint);
  }
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  if ( this.isOccupied(pos) || !this.isValidPos(pos) ) {
    return false;
  }

  var boolean = false;
  var that = this;
  Board.DIRS.forEach( function (dir) {
    if ( _positionsToFlip(that, pos, color, dir) ) {
      boolean = true;
    }
  });

  return boolean;
};
/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  var allPoss = [];
  var that = this;

  for( var rowIdx = 0; rowIdx < 7; rowIdx++ ) {
    for ( var colIdx = 0; colIdx < 7; colIdx++ ) {
      var pos = [rowIdx, colIdx];
      if ( this.validMove(pos, color) ) {
        allPoss.push(pos);
      }
    }
  }

  return allPoss;
};

module.exports = Board;
