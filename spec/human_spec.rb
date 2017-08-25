require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib/', 'human.rb')
require File.join(File.dirname(__FILE__), '../lib/', 'scorer.rb')

describe 'Human' do
  
  #subject(:human) { Human.new(parameters) }
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
    #allow($stdin).to receive(:gets).and_return('2\n')
    move = humanio('2').get_next_move([0,2,3,4])
    expect(move).to eq 2
  end
  
end