require_relative "pawn.rb"
require_relative "sliding_piece.rb"
require_relative "stepping_piece.rb"

class Board
  attr_reader :grid

  def self.blank_grid
    Array.new(8) { Array.new(8) }
  end

  def initialize(grid = self.class.blank_grid)
    @grid = grid
    populate_board(:black)
    populate_board(:white)
  end

  def populate_board(color)

    sliding_positions = {
      :rook => [[0,0],[0,7]],
      :bishop => [[0,2],[0,5]],
      :queen => [[0,4]]
    }

    stepping_positions = {
      :king => [[0,3]],
      :knight => [[0,1],[0,6]]
    }

#change row index of each value if color is white
    case color
    when :black
      pawn_index = 1
    when :white
      sliding_positions.each do |key, value|
        sliding_positions[key] = value.map { |pair| [7 - pair.first, pair.last] }
      end
      stepping_positions.each do |key, value|
        stepping_positions[key] = value.map { |pair| [7 - pair.first, pair.last] }
      end
      pawn_index = 6
    end

    @grid = @grid.map.with_index do |row, row_index|
      row.map do |col, col_index|
        if row_index == pawn_index
          Pawn.new(color, [row_index,col_index], false, self)
        else
          col
        end
      end
    end

    sliding_positions.each do |key, value|
      value.each do |coord|
      @grid[coord.first][coord.last] = SlidingPiece.new(color, [coord.first, coord.last], false, self, key)
      end
    end

    stepping_positions.each do |key, value|
      value.each do |coord|
      @grid[coord.first][coord.last] = SteppingPiece.new(color, [coord.first, coord.last], false, self, key)
      end
    end

  end

  def display
    puts "   A  B  C  D  E  F  G  H"

    @grid.each_with_index do |row, row_index|
      print "#{row_index}  "
      row.each_with_index do |col, col_index|
        if col.nil?
          print "__ "
        else
          print " #{col.display} "
        end
      end
      print "\n"
    end
    true
  end

  def on_board?

  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def occupied?(pos)
    !@grid[pos.first][pos.last].nil?
  end

  def piece_at(pos)
    @grid[pos.first][post.last]
  end

  def checkmate?
    #king is checked and has no valid moves
  end

  def check?

  end

  def deep_dup

  end

end

game = Board.new
p game.display
