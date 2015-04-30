require_relative "piece.rb"

class Board

  def self.create_grid
    Array.new(8) { Array.new(8) }
  end

  def initialize(grid = Board.create_grid)
    @grid = grid
  end

  def display
    print "    A   B   C   D   E   F   G   H\n"
    @grid.each_with_index do |row, row_index|
      print "#{row_index} "
      row.each do |col|
        print "[  ]"
        # print col.display
      end
      print "\n"
    end

  end

end

board = Board.new
board.display
