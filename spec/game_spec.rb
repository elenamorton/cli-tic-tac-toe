require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib/', 'game.rb')

describe 'Game unit tests' do
  
  def io(input='')
    incoming = StringIO.new(input)
    @outgoing = StringIO.new
    Game.new(@outgoing, incoming)
  end
    
  def output
    @outgoing.string
  end

    
  it 'has an empty players list' do
    expect(io.players.empty?).to be true
  end
  
  describe '#choose players' do
  
    it 'user chooses both players as Human' do
      io("human\nhuman\no\nx\n1\n").user_setup_game
      expect(output).to include 'human'
    end
  
    it 'user chooses both players as Computer' do
      io("computer\ncomputer\no\nx\n2\n").user_setup_game
      expect(output).to include 'computer'
    end
    
    it 'user chooses both players as Computer' do
      io("human\ncomputer\no\nx\n2\n").user_setup_game
      expect(output).to include 'human'
      expect(output).to include 'computer'
    end
  end

  
end