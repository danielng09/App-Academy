#first test Hangman where human player is guessing and the computer player is checking

class Hangman

  def initialize(player1, player2)
    @guessing_player = player1
    @checking_player = player2
    @guesses = 6
  end

  def won?
    !(@game_state.include?('_'))
  end

  def no_more_guesses?
    @guesses == 0
  end

  def display_starting_board
    @game_state = '_' * @checking_player.secret_word_length
  end

  def run
    @checking_player.pick_secret_word
    p display_starting_board
    until won? || no_more_guesses?
      guess = @guessing_player.guess
      if @checking_player.correct_guess?(guess)
        @checking_player.handle_guess_response(guess)
        @game_state = @checking_player.change_board
        p @game_state
      else
        puts "WRONG GUESS"
        @game_state
        @guesses -= 1
      end
      puts "=== You have #{@guesses} limbs left ==="
    end

    if won?
      puts "YOU WIN!"
    elsif no_more_guesses?
      puts "GAME OVER! YOU RAN OUT OF TURNS!"
    end

  end
end

class HumanPlayer
  attr_reader :secret_word_length

  def initialize
    @matching_indices = []
  end

  def pick_secret_word
    puts "What is the length of your word?"
    @secret_word_length = Integer(gets)
    @starting_board = ''
    @secret_word_length.times { @starting_board << "_" }
  end

  def receive_secret_length(other_player)
    other_player.secret_word_length
  end

  def guess
    puts "Guess a letter."
    gets.chomp
  end

  def correct_guess?(guess)
    puts "Does the word include the letter #{guess}? (y/n)"
    response = gets.chomp
    if response == "y"
      true
    elsif response == "n"
      false
    end
  end

  def change_board
    @matching_indices.each { |index| @starting_board[index] = @guess }
    @starting_board
  end

  def handle_guess_response(guess)
    @guess = guess
    puts "Please state the position of the letter(s), #{guess}, are in the word"
    input = gets.chomp.gsub(/\s/,"").split(",")
    @matching_indices = input.map { |num| num.to_i - 1 }
  end
end

class ComputerPlayer
  attr_reader :secret_word_length

  def initialize
    @words = File.readlines("dictionary.txt").map { |line| line.chomp }
    @matching_indices = []
    @choices = ("a".."z").to_a.shuffle
  end

  def pick_secret_word
    @secret_word = @words.sample
    @secret_word_length = @secret_word.length
    p @secret_word
    @secret_word
  end

  def receive_secret_length
    other_player.secret_word_length
  end

  def guess
    @choices.pop
  end

  def correct_guess?(guess)
    @secret_word.include?(guess)
  end

  def change_board
    output = ''
    @secret_word.split("").each_with_index do |letter, index|
      if @matching_indices.include?(index)
        output << letter
      else
        output << "_"
      end
    end
    output
  end

  def handle_guess_response(guess)
    @secret_word.length.times do |index|
      if @secret_word[index] == guess
        @matching_indices << index
      end
    end
  end
end


bob = HumanPlayer.new
apple = ComputerPlayer.new
game = Hangman.new(apple,bob)
game.run
