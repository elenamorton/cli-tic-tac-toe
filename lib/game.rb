require_relative 'board'
require_relative 'scorer'
require_relative 'computer'

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
    
    @players = []
    @computer = Computer.new({:width => @width, :marker => X_MARKER, :scorer => @scorer, :depth => 0})
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
      post_move_updates(@hum, move)
      
      if !game_is_over?
        move = @computer.get_next_move(@valid_moves)
        post_move_updates(@com, move)
      end
      
      display_board(@board_play)
    end
    outgoing.puts "Game over"
  end

  def display_board(board_play)
    outgoing.puts board_play.board_stringify
  end
    
  def get_human_spot(valid_spots)
    get_input("Enter your move", /\A[#{valid_spots.join('')}]\z/).to_i
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
  
  def post_move_updates(marker, spot)
    @board_play.place_marker(marker, spot)
    @scorer.calculate_score(spot, marker)
    @valid_moves.delete(spot)
  end
  
end

#game = Game.new($stdout, $stdin)
#game.start_game
