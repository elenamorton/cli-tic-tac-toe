require_relative 'board'
require_relative 'scorer'

class Game
    
  attr_accessor :outgoing, :incoming
  
  O_MARKER = "O"
  X_MARKER = "X"

  BOARD_WIDTH = 3
    
  def initialize(outgoing=$stdout, incoming=$stdin)
    @width ||= BOARD_WIDTH
    
    @board_play = Board.new(@width)
    @board = @board_play.board
    
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
    valid_moves = @board.map{ |move| move.to_i}
    
    # loop through until the game was won or tied
    until game_is_over?
    
      move = get_human_spot(valid_moves)
      @board = update_board(@board_play, @hum, move).board
      @scorer.calculate_score(move, @hum)
      valid_moves.delete(move)
      
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
        @scorer.calculate_score(spot, @com)
      else
        spot = get_best_move(@board, @com)
        if @board_play.content_of(spot) != @com && @board_play.content_of(spot) != @hum
          @board= update_board(@board_play, @com, spot).board
          @scorer.calculate_score(spot, @com)
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
      if game_is_over?
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over?
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

  def game_is_over?
    @scorer.win? || tie?(@board)
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
  
  def tie?(board)
    board.all? { |spot| spot == @com || spot == @hum }
  end
  
  
end

#game = Game.new($stdout, $stdin)
#game.start_game
