require_relative "piece.rb"

class Board

  attr_reader :grid

  def self.create_grid
    Array.new(8) { Array.new(8) }
  end

  def initialize(grid = Board.create_grid)
    @grid = grid
    populate_board(:white)
    populate_board(:red)
  end

  def place_piece(piece, pos)
    grid[pos.first][pos.last] = piece
  end

  def empty?(pos)
    grid[pos.first][pos.last].nil?
  end

  def find_piece(pos)
     grid[pos.first][pos.last]
  end

  def self.on_board?(pos)
    pos.all? { |ele| ele.between?(0,7) }
  end

  def display
    # print "    A   B   C   D   E   F   G   H\n"
    print "    0    1    2    3    4    5    6    7\n"
    grid.each_with_index do |row, row_index|
      print "#{row_index}   "
      row.each do |col|
        if col.nil?
          print "--   "
        else
          print "  #{col.render_piece}  "
          # print col.display
        end
      end
      print "\n"
    end

  end

  def populate_board(color)
    case color
    when :white
      rows = [0,1]
      rows.each do |x|
        8.times do |y|
          Piece.new([x,y], color, self)
        end
      end
    when :red
      rows = [6,7]
      rows.each do |x|
        8.times do |y|
          Piece.new([x,y], color, self)
        end
      end
    end
  end

  def move(start_pos, end_pos)
    current = find_piece(start_pos)
    place_piece(current, end_pos)
  end

  def delete(pos)
    grid[pos.first][pos.last] = nil
  end

end

board = Board.new
board.display

board.move([6,1], [2,1])
board.delete([6,1])

board.move([1,3],[2,3])
board.delete([1,3])
board.display


current = board.find_piece([1,2])
p current.hop_moves

# current = board.find_piece([1,1])
# current.perform_slide([2,0])
# current.perform_slide([3,1])
# current.perform_slide([4,0])
# current.perform_slide([5,1])
# current.perform_slide([6,1])
