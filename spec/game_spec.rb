require 'spec_helper'
require File.join(File.dirname(__FILE__), '../lib/', 'game.rb')

describe 'Game unit tests' do
  
  def io(input='')
    @incoming = StringIO.new(input)
    @outgoing = StringIO.new
    Game.new(@outgoing, @incoming)
  end
    
  def output
    @outgoing.string
  end

  def input
    @incoming.string
  end
    
  it 'has an empty players list' do
    expect(io.players.empty?).to be true
  end
  
  describe '#choose players' do
  
    it 'user chooses both players as Human' do
      io("human\nhuman\no\nx\n1\n").user_setup_game
      expect(input).to include 'human'
    end
  
    it 'user chooses both players as Computer' do
      io("computer\ncomputer\no\nx\nmedium\n2\n").user_setup_game
      expect(input).to include 'computer'
    end
    
    it 'user chooses one player as Human and the other as Computer' do
      io("human\ncomputer\no\nx\neasy\n2\n").user_setup_game
      expect(input).to include 'human'
      expect(input).to include 'computer'
    end
  end
  
  describe 'user chooses players order' do
    it 'current player is choosen as 1st player' do
      io("human\ncomputer\no\nx\neasy\n1\n").user_setup_game
      expect(input).to include '1'
    end

    it 'current player is choosen as 2nd player' do
      io("human\ncomputer\no\nx\neasy\n2\n").user_setup_game
      expect(input).to include '2'
    end
  end
  
end