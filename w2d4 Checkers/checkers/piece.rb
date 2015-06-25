require 'byebug'
class Piece
  attr_accessor :pos
  attr_reader :color, :king

  def initialize(pos, color, board)
    @pos, @color, @board = pos, color, board
    @king = false
    @board.place_piece(@pos, self)
  end

  def render_piece
    if @color == :white
      king ? "\u265B".colorize(:color => :default) : "\u26AA".colorize(:color => :default) #"\u26AA"
    elsif @color == :red
      king ? "\u2655".colorize(:color => :black) : "\u26AB".colorize(:color => :default) #"\u26AB".colorize(color => :blue)
    end
  end

  UP_DIR = [
    [-1,-1],
    [-1, 1]
  ]

  DOWN_DIR = [
    [1,-1],
    [1, 1]
  ]

  def kinged
    case color
    when :white
      @king = true if pos.first == 7
    when :red
      @king = true if pos.first == 0
    end
  end

  def move_diffs
    return UP_DIR.concat(DOWN_DIR) if king
    case @color
    when :white
      DOWN_DIR
    when :red
      UP_DIR
    end
  end

  def slide_moves
    move_diffs.map do |diff|
      # puts "pos: #{pos} : diff: #{diff} : added: #{[diff.first + pos.first, diff.last + pos.first]}"
      [diff.first + pos.first, diff.last + pos.last]
    end.reject do |spot|
      !@board.empty?(spot)
    end.select do |spot|
      Board.on_board?(spot)
    end
  end

  def jump_moves
    jumpable_opponent = move_diffs.map do |diff|
      # puts "pos: #{pos} : diff: #{diff} : added: #{[diff.first + pos.first, diff.last + pos.first]}"
      [diff.first + pos.first, diff.last + pos.last]
    end.reject do |pos|
      @board.empty?(pos)
    end.reject do |pos|
      @board.find_piece(pos).color == color
    end

    jumpable_opponent.map do |start|
      diff = [start.first - pos.first, start.last - pos.last]
      [start.first + diff.first, start.last + diff.last]
    end
  end

  def perform_slide(end_pos)
     if slide_moves.include?(end_pos)
       @board.move(pos, end_pos)
       @board.delete(pos)
       @pos = end_pos
     else
       raise "Not a valid slide move"
     end
  end

  def perform_jump(end_pos)
    if jump_moves.include?(end_pos)
      @board.move(pos, end_pos)
      @board.delete(pos)
      remove_jumped_piece(end_pos)
      @pos = end_pos
    else
      raise "Not a valid jump move"
    end
  end

  def remove_jumped_piece(end_pos)
    jumped_pos = [(end_pos.first + pos.first)/2, (end_pos.last + pos.last)/2]
    # puts "pos: #{pos} : end_pos: #{end_pos} : jumped_pos: #{jumped_pos}"
    @board.delete(jumped_pos)
  end

  def promote?
    case color
    when :white
      pos.first == 7
    when :red
      pos.first == 0
    end
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise "Sorry, you can't make that move!"
    end
  end

  def perform_moves!(move_sequence)
    if move_sequence.length == 1
      begin
        perform_slide(move_sequence.first)
      rescue
        perform_jump(move_sequence.first)
      end
    else
      queue = move_sequence.dup
      until queue.empty?
        current_move = queue.shift
        perform_jump(current_move)
      end
    end
  end

  def valid_move_seq?(move_sequence)
    begin
    board_copy = @board.deep_dup
    current_copy = board_copy[pos]
    current_copy.perform_moves!(move_sequence)
    true
    rescue
      false
    end
  end

end
