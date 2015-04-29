require_relative "piece.rb"

class Pawn < Piece
  attr_reader :color

  def valid_moves
    moves
  end

# create posible positions to move to
  def moves
    deltas = [[1, 0], [1, -1], [1, 1]]
    deltas << [2,0] unless moved?

#invert direction of movement if black pawn
    deltas.map! { |position| [position.first * -1, position.last]} if color == :black


    output = deltas.map do |diff|
      [diff.first + @pos.first, diff.last + @pos.last]
    end.select do |position|
      position.all? { |coordinate| coordinate.between?(0,7) }
    end

    output.reject do |ele|
      col_index = @pos.last
      tile_piece = @board.grid[ele.first][ele.first]

      if ele.last == col_index && tile_piece
        true
      elsif ele.last != col_index
         if tile_piece
           tile_piece.color == self.color ? true : false
         else
           true
         end
      else
        false
      end
    end

  end

end

board = Board.new
puts board.display
rook = Pawn.new(:black, [7,1], false, board)
p rook.valid_moves
