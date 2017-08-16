require 'spec_helper'
require 'stringio'

# As a user
# So as I can have a nice time
# I'd like to be able to play tic-tac-toe game

describe Game do
    
    def io(input='')
       incoming = StringIO.new(input)
       @outgoing = StringIO.new
       described_class.new(@outgoing, incoming) 
    end
    
    def output
        @outgoing.string
    end

    it 'play a full game' do
        io("8\n6\n1\n5\n0\n3\n").start_game
        expect(output).to include 'O'
        expect(output).to include 'X'
        expect(output).to include 'Game over'
        expect(output).to include "===+===+==="
    end
    
end