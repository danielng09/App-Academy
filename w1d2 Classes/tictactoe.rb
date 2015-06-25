class Board
  attr_reader :grid
  def initialize
    @grid = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
      ]
      @player1 = 'x'
      @player2 = 'o'
  end

  def won?(player)
    @dimensions = @grid.count
    if horizontal_win?(player) || vertical_win?(player) || diagonal_win?(player)
      true
    else
      false
    end
  end

  def horizontal_win?(player)
    (0...@dimensions).each do |row|
      return true if @grid[row].all? { |ele| ele == player }
    end
    false
  end

  def vertical_win?(player)
    (0...@dimensions).each do |column|
      victory_column = []
      (0...@dimensions).each do |row|
        victory_column << @grid[row][column]
      end
      return true if victory_column.all? { |ele| ele == player }
    end
    false
  end

  def diagonal_win?(player)
    victory_column = []
    (0...@dimensions).each do |row|
      victory_column << @grid[row][row]
    end
    return true if victory_column.all? { |ele| ele == player }
    victory_column = []
    (0...@dimensions).each do |row|
      victory_column << @grid[row][@dimensions - row - 1]
    end
    victory_column.all? { |ele| ele == player }
  end


  def winner
    if won?(@player1)
      return "Player 1 wins"
    elsif won?(@player2)
      return "Player 2 wins"
    else
      return "Continue"
    end
  end

  def empty?(pos)
    if grid[pos[0]][pos[1]].nil?
      true
    else
      false
    end
  end

  def place_mark(pos, mark)
    if empty?(pos)
      grid[pos[0]][pos[1]] = mark
      puts "Placed #{mark} on #{pos}"
      return true
    end
    false
  end

  def display
    @grid.each do |x|
      p x
    end
  end

end

class Game
  attr_accessor :turn
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn = false #false = player 1's turn
  end
  def play
    board = Board.new
    board.display
  end

  def prompt
    puts "Enter an x coordinate"
    x = 

end
#
# class Player
#
# end
#
# class HumanPlayer < Player
#
# end
#
# class ComputerPlayer < Player
#
# end

something = Board.new
something.place_mark([0,0], "o")
something.place_mark([1,2], "o")
something.place_mark([2,2], "o")
something.display
p something.won?(@player1)
p something.won?(@player2)
p something.winner
