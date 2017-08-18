require 'spec_helper'
require 'stringio'

# As a user
# So as I can have a nice time
# I'd like to be able to play tic-tac-toe game

describe Game do
    
  def io(input='')
    incoming = StringIO.new(input)
    @outgoing = StringIO.new
    described_class.new(@outgoing, incoming) 
  end
    
  def output
    @outgoing.string
  end
  
  it 'displaying an empty board' do
    empty_board = Array.new(9) { nil }
    io.display_board(empty_board)
    expect(output).to eq "   |   |   \n" \
                        "===+===+===\n" \
                        "   |   |   \n" \
                        "===+===+===\n" \
                        "   |   |   \n"
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