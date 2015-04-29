require_relative "piece.rb"

class SlidingPiece < Piece

  def initialize(color, pos, moved, board, type)
    super(color, pos, moved, board)
    @type = type
  end

  def moves
    case @type
    when :rook
      deltas = [[0,1],[1,0],[-1,0],[0,-1]]
    when :bishop
      deltas = [[1,1],[-1,-1],[-1,1],[1,-1]]
    when :queen
      deltas = [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]
    end
    list = []
    deltas.each { |delta| list += explore(delta) }
    list.uniq
  end

  def explore(dir)
    y_diff = dir.first
    x_diff = dir.last
    diff = []
    current = @pos.dup
    while current.all? { |ele| ele.between?(0,7) } && @board.grid[current.first][current.last].nil?
      diff << current.dup
      current[0] += y_diff
      current[1] += x_diff
    end
    diff
  end

end

board = Board.new
rook = SlidingPiece.new(:black, [4, 4], false, board, :rook)
# current = [0,0]
# p board.grid[current[0]][current[1]].nil?
# p rook.rook_move("right")
p rook.valid_moves

# p queen.valid_moves
# p queen.deltas
# + Rook
#   + #move_dirs()
#   + #symbol "R"
