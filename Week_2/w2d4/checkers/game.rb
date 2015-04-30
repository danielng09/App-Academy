require_relative "board.rb"

class Game

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    @player1.color, @player2.color = :white, :red
  end

  def run
    board = Board.new
    @player1.board, @player2.board = board, board
    count = 1
    while true
      puts "This is turn #{count}"

      @player1.do_turn
      break if board.won?(@player1.color)

      @player2.do_turn
      break if board.won?(@player2.color)

      count += 1
    end
  end

end

class HumanPlayer

  attr_accessor :color, :board

  def initialize(name)
    @name = name
  end

  def do_turn
    This
    @board.
  end

end

daniel = HumanPlayer.new("Daniel")
carl = HumanPlayer.new("Carl")
checkers = Game.new(daniel, carl)
