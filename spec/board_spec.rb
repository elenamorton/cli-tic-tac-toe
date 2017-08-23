require 'spec_helper'

describe 'Board' do
  
  subject(:board) { Board.new(Board::GRID_WIDTH) }
    
  it 'expects to be initialized with size' do
    expect(board.width).to eq Board::GRID_WIDTH 
  end
  
  it 'expects for grid 3 number of spaces as 9' do
    expect(board.number_of_spots).to eq Board::GRID_WIDTH**2
  end
  
  it 'expects fir grid 4 number of spaces as 16' do
    board_four = Board.new(4)
    expect(board_four.number_of_spots).to eq 16
  end
  
  describe 'board spots changes' do
    
    it 'shows the default content of a board spot' do
      expect(board.content_of(3)).to eq "3"
    end
  
    it 'updates board with a marker' do
      board.place_marker("X", 4)
      expect(board.content_of(4)).to eq "X"
    end
    
  end
  
  describe 'checks for tie' do
    it 'updates one spot a marker, no tie' do
      board.place_marker("X", 4)
      expect(board.content_of(4)).to eq "X"
      expect(board.tie?).to be false
    end
    
    it 'updates all spots resulting in a tie' do
      board.place_marker("O", 1)
      board.place_marker("X", 0)
      board.place_marker("O", 2)
      board.place_marker("X", 4)
      board.place_marker("O", 3)
      board.place_marker("X", 5)
      board.place_marker("O", 6)
      board.place_marker("X", 7)
      board.place_marker("O", 8)
      expect(board.tie?).to be true
    end
  end
   
  it 'stringifies an empty board with no markers' do
    expect(board.board_stringify).to eq " 0 | 1 | 2 \n" \
                          "===+===+===\n" \
                          " 3 | 4 | 5 \n" \
                          "===+===+===\n" \
                          " 6 | 7 | 8 \n"
  end
    
end