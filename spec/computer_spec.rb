require 'spec_helper'

describe 'Computer' do
  
  subject(:computer) { Computer.new(parameters) }
  let(:scorer) { double :scorer }
  let(:parameters) { { :marker => "X", :width => 3, :scorer => scorer, :depth => 0 } }
    
  it 'expects to be initialized with a marker ' do
    expect(computer.marker).to eq "X" 
  end
  
  it 'expects to be initialized with a name ' do
    expect(computer.name).to eq :computer
  end
  
  describe 'gets computer move for various depth values' do
    
    it 'get next move for default center spot' do
      expect(computer.get_next_move([0,1,2,3,4,5,6,7,8])).to eq 4
    end
  
  end
  
end