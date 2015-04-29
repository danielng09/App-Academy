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
    populate_board
  end

  def populate_board

    @grid = @grid.map.with_index do |row, row_index|
      row.map do |col|
        if row_index == 1
          Pawn.new(:black, [7,1], false, self)
        end
      end
    end

  end

  def display
    puts "   A  B  C  D  E  F  G  H"

    @grid.each_with_index do |row, row_index|
      print "#{row_index} "
      row.each_with_index do |col, col_index|
        if col.nil?
          print " _ "
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
