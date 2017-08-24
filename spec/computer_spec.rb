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
  
end