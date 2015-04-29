class NumberGuessingGame
  attr_reader :answer
  def initialize
    @answer = rand(100) + 1
  end

  def prompt
    puts "Guess a number"
    Integer(gets)
  end

  def check(number)
    if answer > number
      puts "Too Low"
    elsif answer < number
      puts "Too High"
    end
  end

  def run_game
    guess_num = 0
    user_input = 0
    until won?(user_input)
      user_input = prompt
      check(user_input)
      guess_num += 1
    end
    puts "You won in #{guess_num} guesses"
  end

  def won?(number)
    answer == number
  end
end

class ShuffleLines
  def run
    prompt
    @file_contents.shuffle!
    write_to_file
    "shuffle file complete"
  end

  def prompt
    puts "Type in file name"
    @file_name = gets.chomp
    @file_contents = File.readlines(@file_name)
  end

  def write_to_file
    input_name = @file_name.gsub(/\..*$/,"")
    File.open("#{input_name}-shuffled.txt", "w") do |f|
      f.puts @file_contents
    end
  end

end

class RPNCalculator

  def prompt
    puts "Type in the file to read or write out the stack"
    @arguments = gets.chomp
    if file?
      @arguments = File.read(@arguments).split(/\s+/)
    else
      @arguments = @arguments.split(" ")
    end
    calculate
  end

  def file?
    @arguments =~ /\./
  end

  def calculate
    @output = []
    @arguments.each do |ele|
      if ele =~ /\d/
        @output << ele.to_i
      elsif ele =~ /\+/
        add
      elsif ele =~ /-/
        subtract
      elsif ele =~ /\//
        divide
      elsif ele =~ /\*/
        multiply
      end
    end
    @output.count == 1 ? @output.first : "Error"
  end

  def add
    first = @output.pop
    second = @output.pop
    @output << first + second
  end

  def subtract
    first = @output.pop
    second = @output.pop
    @output << second - first
  end

  def multiply
    first = @output.pop
    second = @output.pop
    @output << first * second
  end

  def divide
    first = @output.pop
    second = @output.pop
    @output << second / first
  end
end
