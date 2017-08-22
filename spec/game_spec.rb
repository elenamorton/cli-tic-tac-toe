require 'spec_helper'

describe 'Game' do
  
  subject(:game) { Game.new }

    
  describe '#score' do
    
    it 'calculates score for an empty board' do
      expect(game.calculate_score(3, Game::X_MARKER)).to eq ({:D=>0, :antiD=>0, :R0=>0, :R1=>1, :R2=>0, :C0=>0, :C1=>0, :C2=>0})
       expect(game.game_is_over?).to be false
    end
  
    it 'calculates score for "O" wins and "X" loses game ' do
      game.calculate_score(4, Game::O_MARKER)
      game.calculate_score(0, Game::X_MARKER)
      game.calculate_score(2, Game::O_MARKER)
      game.calculate_score(5, Game::X_MARKER)
      game.calculate_score(8, Game::O_MARKER)
      game.calculate_score(7, Game::X_MARKER)
      expect(game.calculate_score(6, Game::O_MARKER)).to eq ({:D=>-1, :antiD=>-3, :R0=>0, :R1=>1, :R2=>2, :C0=>0, :C1=>1, :C2=>2})
      expect(game.game_is_over?).to be true
    end
    
    it 'calculates score for a tie game' do
      game.calculate_score(1, Game::O_MARKER)
      game.calculate_score(4, Game::X_MARKER)
      game.calculate_score(2, Game::O_MARKER)
      game.calculate_score(0, Game::X_MARKER)
      game.calculate_score(3, Game::O_MARKER)
      game.calculate_score(6, Game::X_MARKER)
      game.calculate_score(7, Game::O_MARKER)
      game.calculate_score(5, Game::X_MARKER)
      expect(game.calculate_score(8, Game::O_MARKER)).to eq ({:D=>1, :antiD=>1, :R0=>0, :R1=>1, :R2=>2, :C0=>0, :C1=>1, :C2=>2})
      expect(game.game_is_over?).to be true
    end
    
  end
  
end