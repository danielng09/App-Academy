require_relative "piece.rb"

class Pawn < Piece

  def valid_moves
    moves.reject do |index|
    
  end

# create posible positions to move to
  def moves
    deltas = [[1, 0], [-1, -1], [-1, 1]]
    deletas << [2,0] unless moved?

#invert direction of movement if black pawn
    delta.map { |position| [position.first * -1, position.last]} if color == :black

    super(deltas)
  end



end
