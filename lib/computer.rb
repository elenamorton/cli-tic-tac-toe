class Computer
  
  attr_reader :marker
    
  def initialize(parameters)
    @width = parameters[:width]
    @marker = parameters[:marker]
  end
  
end