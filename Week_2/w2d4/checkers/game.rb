require_relative "board.rb"

class Game

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    @player1.color, @player2.color = :white, :red
  end

  def run
    board = Board.new
    @player1.board, @player2.board = board, board
    round = 1
    while true
      puts "This is round #{round}"

      @player1.do_turn
      break if board.won?(@player1.color)

      puts "This is round #{round}"
      @player2.do_turn
      break if board.won?(@player2.color)

      round += 1
    end
  end

end

class HumanPlayer

  attr_accessor :color, :board
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def do_turn
    puts "It's your turn#{name}!"

    begin
    puts "Please enter the starting position of the piece you would like to move. Ex: 1, 1"
    from = gets.chomp.intput.split(", ")

    puts "Please enter where you would like to move this piece. You may enter a sequence - Ex: '[2, 2] / [3, 3]'"
    from = gets.chomp.intput.split(", ")
    if from ==
    rescue
      "You entered invalid positions, please try again!"
      retry
    end

    selected_piece = board.find_piece(from)
    selected_piece

  end

end

daniel = HumanPlayer.new("Daniel")
carl = HumanPlayer.new("Carl")
checkers = Game.new(daniel, carl)
