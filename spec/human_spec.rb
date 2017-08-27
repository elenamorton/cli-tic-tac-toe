require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib/', 'human.rb')
require File.join(File.dirname(__FILE__), '../lib/', 'scorer.rb')

describe 'Human' do
  
  let(:scorer) { Scorer.new({:width => 3, :x_marker => 'X', :o_marker => 'O'}) }
  let(:parameters) { { :marker => 'O', :width => 3, :scorer => scorer} }

  def humanio(input='')
    incoming = StringIO.new(input)
    @outgoing = StringIO.new
    Human.new(@outgoing, incoming, parameters)
  end
    
  def output
    @outgoing.string
  end
  
  it 'expects to be initialized with a marker ' do
    expect(humanio.marker).to eq 'O' 
  end
  
  it 'expects to be initialized with a name ' do
    expect(humanio.name).to eq :human
  end
  
  it 'returns a number as input' do
    move = humanio('2').get_next_move([0,2,3,4])
    expect(move).to eq 2
  end
  
  it 'human chooses a move on an invalid space' do
    move = humanio("2\n4\n").get_next_move([0,3,4])
    expect(output).to include "You've entered 2, which is invalid\n"
  end
  
end