class Game
    
  attr_accessor :outgoing, :incoming
  
  HUMAN_MARKER = "O"
  COMPUTER_MARKER = "X"
    
  def initialize(outgoing, incoming)
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = COMPUTER_MARKER # the computer's marker
    @hum = HUMAN_MARKER # the user's marker
    
    self.outgoing = outgoing
    self.incoming = incoming
  
  end

  def start_game
    # start by printing the board
    display_board(@board)
    valid_moves = @board.map{ |move| move.to_i}
    
    # loop through until the game was won or tied
    until game_is_over(@board) || tie(@board)
      move = get_human_spot(valid_moves)
      update_board(@board, move)
      valid_moves.delete(move)
      
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      display_board(@board)
    end
    outgoing.puts "Game over"
  end

  def display_board(board)
    outgoing.puts board_stringify(board)
  end
  
  def update_board(board, spot)
    board[spot] = @hum
  end
    
  def get_human_spot(valid_spots)
    get_input("Enter your move", /\A[#{valid_spots.join('')}]\Z/).to_i
  end
  
  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_best_move(@board, @com)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
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
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
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

  def game_is_over(b)

    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
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
    outgoing.print message
    outgoing.puts ': '
  end

  def board_stringify(board)
    board.map { |val| val || ' ' }
        .each_slice(3)
        .map {|col1, col2, col3| " #{col1} | #{col2} | #{col3} \n" }
        .join("===+===+===\n")
  end

end

#game = Game.new($stdout, $stdin)
#game.start_game
