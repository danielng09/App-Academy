require "colorize"
require_relative "piece.rb"

class Board

  attr_reader :grid

  def self.create_grid
    Array.new(8) { Array.new(8) }
  end

  def initialize(grid = Board.create_grid, duplicate = false)
    @grid = grid
    return true if duplicate
    populate_board(:white)
    populate_board(:red)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, mark)
    x, y = pos
    @grid[x][y] = mark
  end

  def place_piece(pos, piece)
    self[pos] = piece
  end

  def empty?(pos)
    self[pos].nil?
  end

  def find_piece(pos)
     self[pos]
  end

  def self.on_board?(pos)
    pos.all? { |ele| ele.between?(0,7) }
  end

  def display
    # print "    0    1    2    3    4    5    6    7\n"
    grid.each_with_index do |row, row_index|
      print "#{8 - row_index} "
      row.each_with_index do |col, col_index|
        if col.nil?
          print "    ".colorize(:background => bg_color(row_index, col_index))
        else
          print " #{col.render_piece}  ".colorize(:background => bg_color(row_index, col_index))
        end
      end
      print "\n"
    end
    print   "   A  B  C  D  E  F  G  H\n"

  end

  def bg_color(index1, index2)
    (index1 + index2).odd? ? :light_black : :light_red
  end

  # [:black, :light_black, :red, :light_red, :green, :light_green,
  #:yellow, :light_yellow, :blue, :light_blue, :magenta, :light_magenta, :cyan, :light_cyan, :white, :light_white, :default]

  def populate_board(color)
    case color
    when :white
      rows = [0,1,2]
      rows.each do |x|
        8.times do |y|
          next if (y + x).even?
          Piece.new([x,y], color, self)
        end
      end
    when :red
      rows = [5,6,7]
      rows.each do |x|
        8.times do |y|
          next if (y + x).even?
          Piece.new([x,y], color, self)
        end
      end
    end
  end

  def move(start_pos, end_pos)
    current = find_piece(start_pos)
    place_piece(end_pos, current)
    delete(start_pos)
  end

  def delete(pos)
    self[pos] = nil
  end

  def deep_dup
    # debugger
    board_copy = Board.new(Board.create_grid, true)
    self.grid.flatten.compact.each do |piece|
      Piece.new(piece.pos, piece.color, board_copy)
    end
    board_copy
  end

  def won?(color)
    opposite = (color == :white) ? :white : :red
    self.grid.flatten.compact.all? { |piece| piece.color == opposite }
  end

end

board = Board.new(Board.create_grid)
board.display
# Piece.new([1,1], :white, board)
# Piece.new([2,2], :red, board)
#
# piece = board[[1, 1]]
# piece.perform_moves([[3, 3]])
# piece.perform_slide([4,2])
# piece.perform_slide([5,3])
# piece.perform_slide([6,2])
# piece.perform_slide([7,1])
#
#
# board.display
#
#
# p board.won?(:white)


# b1 = board[[5,2]]
# b2 = board[[2,1]]
#
# #move
# b1.perform_slide([4,1])
# b1.perform_slide([3,2])
#
# board.display
# p b2.jump_moves + b2.slide_moves
# b2.perform_moves([[4,3]])
# board.display

# b1.perform_slide([3,4])
# b1.perform_slide([2,3])
#
# b2.perform_slide([5,2])
# b2.perform_slide([4,1])
#
# current = board[[1,4]]
# current.perform_moves!([[3, 2], [5, 0]]) if current.valid_move_seq?([[3, 2], [5, 0]])
