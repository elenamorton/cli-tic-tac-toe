class Human
  
  attr_reader :marker, :spot, :name
    
  def initialize(parameters)
    @width = parameters[:width]
    @marker = parameters[:marker]
    @scorer = parameters[:scorer]
    @name = :human
  end
  
end