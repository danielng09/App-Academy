
class Piece
  attr_reader :color

  def initialize(color, pos, moved, board)
    @color = color
    @pos = pos
    @moved = moved
    @board = board
  end

#checks moves for objects in the way
  def valid_moves
    moves.reject do |index|
      other_piece = @board.grid[index.first][index.last]
      if other_piece.nil?
        false
      else
        other_piece.color == self.color
      end
    end
  end

#this just maps deltas from the original pos
  def moves(deltas)
    deltas.map do |diff|
      [diff.first + @pos.first, diff.last + @pos.last]
    end.select do |position|
      position.all? { |coordinate| coordinate.between?(0,7) }
    end
  end

# removed duplicate explore method that should exist in sliding_piece

  def moved?
    @moved
  end

end
