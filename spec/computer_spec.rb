require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib/', 'computer.rb')

RSpec.describe 'Computer' do
  
  subject(:computer) { Computer.new(parameters) }
  let(:parameters) { { :marker => "X", :width => 3, :scorer => scorer, :depth => 0 } }
  let(:scorer) { double :scorer }
  let(:board_play) { double :board }
    
  it 'expects to be initialized with a marker ' do
    expect(computer.marker).to eq "X" 
  end
  
  it 'expects to be initialized with a name ' do
    expect(computer.name).to eq :computer
  end
  
  context 'gets next computer move for depth set to 0' do
    
    it 'get move for default center spot' do
      expect(computer.get_next_move([0,1,2,3,4,5,6,7,8])).to eq 4
    end
    
    it 'get next move from valid moves, no wins' do
      allow(scorer).to receive(:score_table).and_return({:D=>-1, :antiD=>-1, :R0=>0, :R1=>0, :R2=>-1, :C0=>0, :C1=>-2, :C2=>1})
      allow(scorer).to receive(:calculate_score).and_return({:D=>-1, :antiD=>-1, :R0=>0, :R1=>1, :R2=>-1, :C0=>1, :C1=>-2, :C2=>1})
      allow(scorer).to receive(:win?).and_return false
      expect(computer.get_next_move([0,1,2,3,6,8])).not_to eq 4
    end
  
    it 'get next move from valid moves, a player wins' do
      allow(scorer).to receive(:score_table).and_return({:D=>-1, :antiD=>-3, :R0=>0, :R1=>0, :R2=>-1, :C0=>0, :C1=>0, :C2=>-1})
      allow(scorer).to receive(:calculate_score).and_return({:D=>-1, :antiD=>-3, :R0=>0, :R1=>0, :R2=>-1, :C0=>0, :C1=>0, :C2=>-1})
      allow(scorer).to receive(:win?).and_return true
      expect(computer.get_next_move([3,6])).to eq 3
    end
    
  end
  
end