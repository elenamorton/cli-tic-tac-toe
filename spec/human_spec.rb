require 'spec_helper'

describe 'Human' do
  
  subject(:human) { Human.new(parameters) }
  let(:parameters) { { :marker => "O", :width => 3, :scorer => scorer} }
  let(:scorer) { double :scorer }
  let(:board_play) { double :board }
    
  it 'expects to be initialized with a marker ' do
    expect(human.marker).to eq "O" 
  end
  
  it 'expects to be initialized with a name ' do
    expect(human.name).to eq :human
  end
  
end