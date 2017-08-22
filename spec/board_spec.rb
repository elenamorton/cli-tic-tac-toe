require 'spec_helper'

describe 'Board' do
  
 # GRID_WIDTH = 3
  
  subject(:board) { Board.new(Board::GRID_WIDTH) }
    
  it 'expects to be initialized with size' do
    expect(board.width).to eq Board::GRID_WIDTH 
  end
  
  it 'expects number of spaces as square of grid size' do
    expect(board.number_of_spots).to eq Board::GRID_WIDTH**2
  end
  
  it 'expects number of spaces as square of grid size' do
    board_four = Board.new(4)
    expect(board_four.number_of_spots).to eq 16
  end
  
  it 'shows the content of a board spot' do
    expect(board.content_of(3)).to eq "3"
  end
  
  it 'updates board with a marker' do
    board.place_marker("X", 4)
    expect(board.content_of(4)).to eq "X"
  end
    
end