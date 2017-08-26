require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib/', 'game.rb')
require File.join(File.dirname(__FILE__), '../lib/', 'human.rb')
require File.join(File.dirname(__FILE__), '../lib/', 'computer.rb')

describe 'Game unit tests' do
  
  def io(input='')
    incoming = StringIO.new(input)
    @outgoing = StringIO.new
    Game.new(@outgoing, incoming)
  end
    
  def output
    @outgoing.string
  end
  
  let(:computer) {Computer.new({ :width => Game::BOARD_WIDTH, :marker => Game::X_MARKER, :scorer => scorer, :depth => 0 }) }
  let(:human) { Human.new($stdout, $stdin, {:width => Game::BOARD_WIDTH, :o_marker => Game::O_MARKER, :scorer => scorer }) }
  let(:scorer) { double :scorer }
    
  it 'can swap players' do
    expect(io.swap_players(human, computer)).to eq computer
  end
  
  
end