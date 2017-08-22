require 'spec_helper'
require 'stringio'

# As a user
# So as I can have a nice time
# I'd like to be able to play tic-tac-toe game

describe Game do
  
  let(:board_play) { Board.new(Game::BOARD_WIDTH) }
    
  def io(input='')
    incoming = StringIO.new(input)
    @outgoing = StringIO.new
    described_class.new(@outgoing, incoming) 
  end
    
  def output
    @outgoing.string
  end
  
  describe '#display_board' do
    
    it 'displaying an starting board of 0 to 8 chars' do
      io.display_board(board_play)
      expect(output).to eq " 0 | 1 | 2 \n" \
                          "===+===+===\n" \
                          " 3 | 4 | 5 \n" \
                          "===+===+===\n" \
                          " 6 | 7 | 8 \n"
    end
  end
  
  describe 'asking for the user move' do
    
    it 'move is inside the board and on unoccupied space' do
      marker = Game::HUMAN_MARKER
      spot = io('6').get_human_spot([2,6])
      io.update_board(board_play, marker, spot)
      io.display_board(board_play)
      expect(output).to eq " 0 | 1 | 2 \n" \
                          "===+===+===\n" \
                          " 3 | 4 | 5 \n" \
                          "===+===+===\n" \
                          " #{marker} | 7 | 8 \n"
    end
    
    it 'move is inside the board and on an invalid spaces: 1, 3, and 8 ' do
      marker = Game::HUMAN_MARKER
      spot = io("1\n3\n\8\n6\n").get_human_spot([2,6])
      io.update_board(board_play, marker, spot)
      io.display_board(board_play)
      expect(output).to eq " 0 | 1 | 2 \n" \
                          "===+===+===\n" \
                          " 3 | 4 | 5 \n" \
                          "===+===+===\n" \
                          " #{marker} | 7 | 8 \n"
    end
  end

  it 'play a full game, user starts in a corner' do
    io("8\n6\n1\n5\n0\n3\n").start_game
    expect(output).to include 'O'
    expect(output).to include 'X'
    expect(output).to include 'Game over'
    expect(output).to include '===+===+==='
  end
    
  it 'play a full game, user starts in the center' do
    io("4\n8\n2\n6\n").start_game
    expect(output).to include 'O'
    expect(output).to include 'X'
    expect(output).to include 'Game over'
    expect(output).to include '===+===+==='
  end
  
end