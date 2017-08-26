require_relative 'board'
require_relative 'scorer'
require_relative 'computer'
require_relative 'human'
require_relative 'iolike'

class Game
    
  attr_accessor :outgoing, :incoming, :current_player, :players
  attr_reader :human
  
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
    @current_player = nil
    @opposing_player = nil
    
    self.outgoing = outgoing
    self.incoming = incoming
  end

  include Iolike
  
  def start_game
    
    user_setup_game
    
    # start by printing the board
    display_board(@board_play)
    
    # loop through until the game was won or tied
    until game_is_over?
      move = @current_player.get_next_move(@valid_moves)
      post_move_updates(@current_player.marker, move)
      
      display_board(@board_play)
      swap_players if !game_is_over?
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
  
  def user_setup_game
    user_choose_players
    create_players
    setup_players
  end
  
  def post_move_updates(marker, spot)
    @board_play.place_marker(marker, spot)
    @scorer.calculate_score(spot, marker)
    @valid_moves.delete(spot)
  end
  
  def user_choose_players
    @players << get_input("Please, choose a player (human|computer)", /\Ahuman|computer\z/).to_sym
    @players << get_input("Please, choose another player (human|computer)", /\Ahuman|computer\z/).to_sym
  end
    
  def create_players
    @players[0] = create_player(player_1, O_MARKER)
    @players[1] = create_player(player_2, X_MARKER)
  end
  
  def create_player(player, marker)
    case player
    when :human
      return Human.new(outgoing, incoming, {:width => @width, :marker => marker, :scorer => @scorer})
    when :computer
      return Computer.new({:width => @width, :marker => marker, :scorer => @scorer, :depth => 0})
    end
  end
  
  def setup_players
    player = get_input("Please, choose which players goes first (1|2)", /\A1|2\z/)
    @current_player, @opposing_player = player_1, player_2 if player == '1'
    @current_player, @opposing_player = player_2, player_1 if player == '2'
  end
  
  def swap_players
    @current_player, @opposing_player = @opposing_player, @current_player
  end
  
  def player_1
    @players.first
  end
  
  def player_2
    @players.last
  end
  
end

#game = Game.new
#game.start_game
