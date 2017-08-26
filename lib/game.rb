require_relative 'board'
require_relative 'scorer'
require_relative 'computer'
require_relative 'human'
require_relative 'iolike'

class Game
    
  attr_accessor :outgoing, :incoming, :human
  
  O_MARKER = "O"
  X_MARKER = "X"

  BOARD_WIDTH = 3
    
  def initialize(outgoing=$stdout, incoming=$stdin)
    @width ||= BOARD_WIDTH
    @board_play = Board.new(@width)
    @board = @board_play.board
    @valid_moves = @board.map{ |move| move.to_i}
    
    @scorer = Scorer.new({:width => @width, :x_marker => X_MARKER, :o_marker => O_MARKER})
    @score_table = @scorer.score_table
    
    @players = []
    @computer = Computer.new({:width => @width, :marker => X_MARKER, :scorer => @scorer, :depth => 0})
    @human = Human.new(outgoing, incoming, {:width => @width, :marker => O_MARKER, :scorer => @scorer})
    
    self.outgoing = outgoing
    self.incoming = incoming
  end

  include Iolike
  
  def start_game
    # start by printing the board
    display_board(@board_play)
    
    # loop through until the game was won or tied
    until game_is_over?
      move = @human.get_next_move(@valid_moves)
      post_move_updates(@human.marker, move)
      
      if !game_is_over?
        move = @computer.get_next_move(@valid_moves)
        post_move_updates(@computer.marker, move)
      end
      
      display_board(@board_play)
    end
    outgoing.puts "Game over"
  end

  def display_board(board_play)
    outgoing.puts board_play.board_stringify
  end
  
  def game_is_over?
    @scorer.win? || @board_play.tie?
  end

  
  private
  
  def post_move_updates(marker, spot)
    @board_play.place_marker(marker, spot)
    @scorer.calculate_score(spot, marker)
    @valid_moves.delete(spot)
  end
  
end

#game = Game.new
#game.start_game
