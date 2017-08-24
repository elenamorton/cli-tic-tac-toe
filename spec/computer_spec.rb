require 'spec_helper'

describe 'Computer' do
  
  subject(:computer) { Computer.new(parameters) }
  let(:parameters) { { :marker => "X", :width => 3 } }
    
  it 'expects to be initialized with a marker ' do
    expect(computer.marker).to eq "X" 
  end
  
end