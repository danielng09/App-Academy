require_relative "piece.rb"

class SteppingPiece < Piece

  attr_reader :deltas
  def initialize(color, pos, moved, board, type)
    super(color, pos, moved, board)
    @type = type
  end

# 1) changed name is valid_moves
  def valid_moves
    case @type
    when :knight
      list = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    when :king
      list = [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]
    end
    list
  end

#added moves => maps valid moves onto the position and rejects positions outside board
  def moves
    valid_moves.each do |diff|
      [diff.first + @pos.first, diff.last + @pos.last]
    end.select do |position|
      position.all? { |coordinate| coordinate.between?(0,7)}
    end
  end

end

board = Board.new
knight = SteppingPiece.new(:black, [0, 0], false, board, :knight)
p knight.moves

#   + #move_diffs()
  #  + King
  #  + Knight
