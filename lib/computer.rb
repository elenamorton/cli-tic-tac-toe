class Computer
  
  attr_reader :marker, :spot, :name
    
  def initialize(parameters)
    @width = parameters[:width]
    @marker = parameters[:marker]
    @depth = parameters[:depth] || 0
    @scorer = parameters[:scorer]
    @name = :computer
    @center = @width + @width / 2
  end
  
  def get_next_move(valid_moves)
    if valid_moves.include?(@center)
        spot = @center
    else
      spot = get_best_move(valid_moves, @depth)
    end
    spot
  end
  
  private
  
  def get_best_move(valid_moves, depth, best_score = {})
    score_table_copy = @scorer.score_table.dup
    valid_moves.each do |as|
      @scorer.calculate_score(score_table_copy, as, @marker)
      if @scorer.win?
        return as
      end
    end
    valid_moves.sample
  end
  

end