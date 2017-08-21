class Board
    
  attr_reader :width, :number_of_spaces
    
  def initialize(width)
    @width = width
    @number_of_spaces = width * width
    @board = Array.new(number_of_spaces) { |i| i.to_s }
  end
    
    
  def board
    @board.dup    
  end
  
  def content_of(space)
    @board[space]
  end
    
end