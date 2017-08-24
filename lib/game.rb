require_relative 'board'
require_relative 'scorer'

class Game
    
  attr_accessor :outgoing, :incoming
  
  O_MARKER = "O"
  X_MARKER = "X"

  BOARD_WIDTH = 3
    
  def initialize(outgoing=$stdout, incoming=$stdin)
    @width ||= BOARD_WIDTH
    @center = @width + @width / 2
    @board_play = Board.new(@width)
    @board = @board_play.board
    @valid_moves = @board.map{ |move| move.to_i}
    
    @scorer = Scorer.new({:width => @width, :x_marker => X_MARKER, :o_marker => O_MARKER})
    @score_table = @scorer.score_table
      
    @com = X_MARKER # the computer's marker
    @hum = O_MARKER # the user's marker
    
    self.outgoing = outgoing
    self.incoming = incoming
  
  end

  def start_game
    # start by printing the board
    display_board(@board_play)
    
    # loop through until the game was won or tied
    until game_is_over?
    
      move = get_human_spot(@valid_moves)
      @board = update_board(@board_play, @hum, move).board
      @scorer.calculate_score(move, @hum)
      @valid_moves.delete(move)
      
      if !game_is_over?
        eval_board
      end
      
      display_board(@board_play)
    end
    
    outgoing.puts "Game over"
  end

  def display_board(board_play)
    outgoing.puts board_play.board_stringify
  end
  
  def update_board(board_play, marker, spot)
    board_play.place_marker(marker, spot)
  end
    
  def get_human_spot(valid_spots)
    get_input("Enter your move", /\A[#{valid_spots.join('')}]\z/).to_i
  end
  
  def eval_board
    if @board_play.content_of(@center) == @center.to_s
        spot = @center
    else
      spot = get_best_move(@board, @com)
    end
    update_board(@board_play, @com, spot)
    @scorer.calculate_score(spot, @com)
    @valid_moves.delete(spot)
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    best_move = nil
    @valid_moves.each do |as|
      board[as] = @com
      if game_is_over?
        best_move = as
        board[as] = as
        return best_move
      else
        board[as] = @hum
        if game_is_over?
          best_move = as
          board[as] = as
          return best_move
        else
          board[as] = as
        end
      end
    end
    if best_move
      return best_move
    else
      return @valid_moves.sample
    end
  end

  def game_is_over?
    @scorer.win? || @board_play.tie?
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
  
end

#game = Game.new($stdout, $stdin)
#game.start_game
