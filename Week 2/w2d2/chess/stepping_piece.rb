require_relative "piece.rb"

class SteppingPiece < Piece

#deleted delta attribute
  def initialize(color, pos, moved, board, type)
    super(color, pos, moved, board)
    @type = type
  end


# switched name of valid_moves and moves in this file to make them consister
# -> moves are the movements you can make while valid_moves are the positions you can move to!
# moved contents of valid_moves to the end of moves for consistentcy
  def valid_moves
    super
  end

# moves should output all possible positions a piece can move to (without filtering for other pieces)
# changed name is valid_moves & changed 'list' to 'deltas'
  def moves
    case @type
    when :knight
      deltas = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    when :king
      deltas = [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]
    end

    super(deltas)
  end

end

board = Board.new
knight = SteppingPiece.new(:black, [0, 0], false, board, :knight)
p knight.moves
