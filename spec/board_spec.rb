require 'spec_helper'

describe 'Board' do
  
  GRID_SIZE = 3
  
  subject(:board) { Board.new(GRID_SIZE) }
    
  it 'expects to be initialized with size' do
    expect(board.width).to eq GRID_SIZE 
  end
  
  it 'expects number of spaces as square of grid size' do
    expect(board.number_of_spaces).to eq GRID_SIZE * GRID_SIZE
  end
    
end