class Board
    
    attr_reader :width, :number_of_spaces
    
    def initialize(width)
       @width = width
       @number_of_spaces = width * width
    end
    
end