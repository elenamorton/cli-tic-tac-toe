class Board
  
  GRID_WIDTH = 3  
  attr_reader :width, :number_of_spots, :number_occupied_spots
    
  def initialize(width=GRID_WIDTH)
    @width = width
    @number_of_spots = width * width
    @number_occupied_spots = 0
    @board = Array.new(number_of_spots) { |i| i.to_s }
  end
    
    
  def board
    @board.dup    
  end
  
  def content_of(spot)
    @board[spot]
  end
  
  def place_marker(marker, spot)
    @board[spot] = marker
    @number_occupied_spots += 1
    self
  end
    
end