####################################################
# As a user
# So as I can have a nice time
# I'd like to be able to play tic-tac-toe game
####################################################

require 'spec_helper'
require 'stringio'
require File.join(File.dirname(__FILE__), '../../lib/', 'game.rb')
require File.join(File.dirname(__FILE__), '../../lib/', 'board.rb')
require File.join(File.dirname(__FILE__), '../../lib/', 'human.rb')
require File.join(File.dirname(__FILE__), '../../lib/', 'scorer.rb')


describe Game do
  
  let(:board_play) { Board.new(Game::BOARD_WIDTH) }
  let(:scorer) { Scorer.new({:width => Game::BOARD_WIDTH, :x_marker => Game::X_MARKER, :o_marker => Game::O_MARKER}) }
  
  def io(input='')
    incoming = StringIO.new(input)
    @outgoing = StringIO.new
    described_class.new(@outgoing, incoming)
  end

  def output
    @outgoing.string
  end
  
  let(:human) { Human.new({:width => Game::BOARD_WIDTH, :marker => Game::O_MARKER, :scorer => scorer, :outgoing => io.outgoing, :incoming => io.incoming }) }
    
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
    
    it 'inside the board and on unoccupied space' do
      marker = Game::O_MARKER
      spot = io('6').human.get_next_move([2,6])
      board_play.place_marker(marker, spot)
      io.display_board(board_play)
      expect(output).to eq " 0 | 1 | 2 \n" \
                          "===+===+===\n" \
                          " 3 | 4 | 5 \n" \
                          "===+===+===\n" \
                          " #{marker} | 7 | 8 \n"
    end
    
    it 'inside the board and on an valid spaces: 1, 3, and 8 ' do
      marker = Game::O_MARKER
      spot = io("1\n3\n8\n6\n").human.get_next_move([2,6])
      board_play.place_marker(marker, spot)
      io.display_board(board_play)
      expect(output).to eq " 0 | 1 | 2 \n" \
                          "===+===+===\n" \
                          " 3 | 4 | 5 \n" \
                          "===+===+===\n" \
                          " #{marker} | 7 | 8 \n"
    end
    
    it 'inside the board and on an invalid space' do
      marker = Game::O_MARKER
      spot = io("6\n").human.get_next_move([6])
      board_play.place_marker(marker, spot)
      io.display_board(board_play)
      expect(output).to eq " 0 | 1 | 2 \n" \
                          "===+===+===\n" \
                          " 3 | 4 | 5 \n" \
                          "===+===+===\n" \
                          " #{marker} | 7 | 8 \n"
      io("1\n6\n").human.get_next_move([6])
      expect(output).to include "You've entered 1, which is invalid\n"
    end
  end

  it 'play a full game, user starts in a corner' do
    io("8\n6\n1\n5\n0\n3\n7\n").start_game
    expect(output).to include Game::O_MARKER
    expect(output).to include Game::X_MARKER
    expect(output).to include 'Game over'
    expect(output).to include '===+===+==='
  end
    
  it 'play a full game, user starts in the center' do
    io("4\n8\n2\n6\n7\n5\n3\n").start_game
    expect(output).to include Game::O_MARKER
    expect(output).to include Game::X_MARKER
    expect(output).to include 'Game over'
    expect(output).to include '===+===+==='
  end
  
end