require_relative 'io'

class Human
    
  attr_reader :marker, :name, :incoming, :outgoing
  include Io
    
  def initialize(outgoing, incoming, parameters)
    @width = parameters[:width]
    @marker = parameters[:marker]
    @scorer = parameters[:scorer]
    @name = :human
    
    @outgoing = outgoing
    @incoming = incoming

  end

  def get_next_move(valid_spots)
    get_input("Enter your move", /\A[#{valid_spots.join('')}]\z/).to_i
  end

  
end