class Piece

  def initialize(position, color, board)
    @position, @color, @board = position, color, board
    @king = false
    @board.place_piece(self, @position)
  end

  FORWARD_DIR = [
    [-1,-1],
    [-1, 1]
  ]

  BACKWARD_DIR = [
    [1,-1],
    [1, 1]
  ]

  def render_piece
    if @color == :white
      print "\u2617"
    elsif @color == :red
      print "\u2616"
    end
  end

  def kinged?
    @king
  end

end
