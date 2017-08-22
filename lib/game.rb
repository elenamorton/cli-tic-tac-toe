require_relative 'board'

class Game
    
  attr_accessor :outgoing, :incoming, :score_table
  
  O_MARKER = "O"
  X_MARKER = "X"
  SCORE_DEFAULT = { X_MARKER.to_sym => 1, O_MARKER.to_sym => -1 }

  BOARD_WIDTH = 3
    
  def initialize(outgoing=$stdout, incoming=$stdin)
    @board_play = Board.new(BOARD_WIDTH)
    @board = @board_play.board
    @com = X_MARKER # the computer's marker
    @hum = O_MARKER # the user's marker
    @score_table = default_score_table

    self.outgoing = outgoing
    self.incoming = incoming
  
  end

  def start_game
    # start by printing the board
    display_board(@board_play)
    valid_moves = @board.map{ |move| move.to_i}
    
    # loop through until the game was won or tied
    until game_is_over?(@board) || tie(@board)
    
      move = get_human_spot(valid_moves)
      @board= update_board(@board_play, @hum, move).board
      valid_moves.delete(move)
      
      if !game_is_over?(@board) && !tie(@board)
        eval_board
      end
      
      display_board(@board_play)
    end
    
    outgoing.puts "Game over"
  end

  def display_board(board_play)
    outgoing.puts board_play.board_stringify
  end
  
  def update_board(board, marker, spot)
    board.place_marker(marker, spot)
  end
    
  def get_human_spot(valid_spots)
    get_input("Enter your move", /\A[#{valid_spots.join('')}]\z/).to_i
  end
  
  def eval_board
    spot = nil
    until spot
      if @board_play.content_of(4) == "4"
        spot = 4
        @board= update_board(@board_play, @com, spot).board
      else
        spot = get_best_move(@board, @com)
        if @board_play.content_of(spot) != X_MARKER && @board_play.content_of(spot) != O_MARKER
          @board= update_board(@board_play, @com, spot).board
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != X_MARKER && s != O_MARKER
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over?(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over?(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def game_is_over?(b)
    @score_table.has_value?(BOARD_WIDTH) || @score_table.has_value?(-BOARD_WIDTH)
  end

  def calculate_score(spot, marker)
    row = spot / BOARD_WIDTH
    col = spot % BOARD_WIDTH
    @score_table[:D] += SCORE_DEFAULT[marker.to_sym] if row == col
    @score_table[:antiD] += SCORE_DEFAULT[marker.to_sym] if (row + col) == BOARD_WIDTH - 1
    @score_table[("R" + row.to_s).to_sym] = row
    @score_table[("C" + col.to_s).to_sym] = col
    @score_table
  end
  
  
  private
  
  def get_input(message_prompt, validation)
    prompt message_prompt
    input = incoming.gets.chomp
    return input if input =~ validation
    invalid_data input
    get_input(message_prompt, validation)
  end
  
  def invalid_data(data)
    outgoing.puts "You've entered #{data}, which is invalid"
  end
  
  def prompt(message)
    outgoing.print "#{message}: "
  end
  
  def tie(b)
    b.all? { |s| s == X_MARKER || s == O_MARKER }
  end

  def default_score_table
    @score_table = Hash.new(0)
    @score_table.store(:D, 0)
    @score_table.store(:antiD, 0)
    BOARD_WIDTH.times do |row|
      @score_table.store(("R" + row.to_s).to_sym, 0)
    end
    BOARD_WIDTH.times do |col|
      @score_table.store(("C" + col.to_s).to_sym, 0)
    end
    @score_table
  end
  
end

#game = Game.new($stdout, $stdin)
#game.start_game
