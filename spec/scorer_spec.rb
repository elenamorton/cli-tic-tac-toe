require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib/', 'scorer.rb')

describe 'Scorer' do
  
  subject(:scorer) { Scorer.new(parameters) }
  let(:parameters) { { :x_marker => "X", :o_marker => "O",  :width => 3 } }
    
  describe '#score' do
    
    it 'calculates score for an empty board' do
      expect(scorer.calculate_score(3, parameters[:x_marker])).to eq ({:D=>0, :antiD=>0, :R0=>0, :R1=>1, :R2=>0, :C0=>1, :C1=>0, :C2=>0})
      expect(scorer.win?).to be false
    end
  
    it 'calculates score for "O" wins and "X" loses game, gets win? true ' do
      scorer.calculate_score(4, parameters[:o_marker])
      scorer.calculate_score(0, parameters[:x_marker])
      scorer.calculate_score(2, parameters[:o_marker])
      scorer.calculate_score(5, parameters[:x_marker])
      scorer.calculate_score(8, parameters[:o_marker])
      scorer.calculate_score(7, parameters[:x_marker])
      expect(scorer.calculate_score(6, parameters[:o_marker])).to eq ({:D=>-1, :antiD=>-3, :R0=>0, :R1=>0, :R2=>-1, :C0=>0, :C1=>0, :C2=>-1})
      expect(scorer.win?).to be true
    end
    
    it 'calculates score for a tie game, gets win? false' do
      scorer.calculate_score(1, parameters[:o_marker])
      scorer.calculate_score(4, parameters[:x_marker])
      scorer.calculate_score(2, parameters[:o_marker])
      scorer.calculate_score(0, parameters[:x_marker])
      scorer.calculate_score(3, parameters[:o_marker])
      scorer.calculate_score(6, parameters[:x_marker])
      scorer.calculate_score(7, parameters[:o_marker])
      scorer.calculate_score(5, parameters[:x_marker])
      expect(scorer.calculate_score(8, parameters[:o_marker])).to eq ({:D=>1, :antiD=>1, :R0=>-1, :R1=>1, :R2=>-1, :C0=>1, :C1=>-1, :C2=>-1})
      expect(scorer.win?).to be false
    end
    
  end
  
end