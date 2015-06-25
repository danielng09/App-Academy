require_relative "board.rb"

class Game

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    @player1.color, @player2.color = :white, :red
  end

  def run
    board = Board.new
    @player1.board, @player2.board = board, board
    turn = 1
    while true
      puts "\n"
      puts "CHECKERS ROUND: #{turn/2}"
      puts "\n"

      @player1.play
      break if board.won?(@player1.color)
      turn += 1

      @player2.play
      break if board.won?(@player2.color)

      turn += 1
    end
    if turn.odd?
      winner = @player1.name
    else
      winner = @player2.name
    end

    puts "Congrats #{winner}, you won in #{turn/2} rounds!"
  end

end

class HumanPlayer

  attr_accessor :color, :board
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def play
    get_input
    make_move

  end

  def make_move
    begin
    selected_piece = board.find_piece(@from)
    selected_piece.perform_moves(@to)
    rescue => e
      if e
        puts e.message
      else
        puts "You entered an invalid move sequence"
      end
      play
    end
  end

  def get_input
    board.display
    print "\n"

    puts "It's your turn, #{name}! You are #{color} color."

    begin
      puts "Please enter the starting position of the piece you would like to move. Ex: A1"
      input = gets.chomp
      @from = HumanPlayer.parse_input(input)

      puts "Please enter where you would like to move this piece. You may enter a sequence - Ex: 'B3, D5'"
      input = gets.chomp.split(", ")
      @to = input.map { |move| HumanPlayer.parse_input(move) }


    rescue
        puts "Invalid move positions inputted"
      retry
    end
  end

  def self.parse_input(input)
    col = input[0].ord - 65
    row = 8 - input[1].to_i
    [row, col]
  end

end

daniel = HumanPlayer.new("Daniel")
carl = HumanPlayer.new("Carl")
checkers = Game.new(daniel, carl)
checkers.run
