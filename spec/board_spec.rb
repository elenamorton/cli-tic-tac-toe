require 'spec_helper'

describe 'Board' do
  
  GRID_WIDTH = 3
  
  subject(:board) { Board.new(GRID_WIDTH) }
    
  it 'expects to be initialized with size' do
    expect(board.width).to eq GRID_WIDTH 
  end
  
  it 'expects number of spaces as square of grid size' do
    expect(board.number_of_spaces).to eq GRID_WIDTH * GRID_WIDTH
  end
  
  it 'expects number of spaces as square of grid size' do
    board_four = Board.new(4)
    expect(board_four.number_of_spaces).to eq 16
  end
    
end