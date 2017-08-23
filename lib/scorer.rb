class Scorer
  
  attr_reader :score_table
  
  SCORE_VALUE = 1
    
  def initialize(parameters)
    @width = parameters[:width]
    @x_marker = parameters[:x_marker]
    @o_marker = parameters[:o_marker]
   
    @score_default = Hash.new(0)
    @score_default[@x_marker.to_sym] = SCORE_VALUE
    @score_default[@o_marker.to_sym] = -SCORE_VALUE
    @score_table = default_score_table
  end
  
  def calculate_score(spot, marker)
    row = spot / @width
    col = spot % @width
    @score_table[:D] += @score_default[marker.to_sym] if row == col
    @score_table[:antiD] += @score_default[marker.to_sym] if (row + col) == @width - 1
    @score_table[("R" + row.to_s).to_sym] += @score_default[marker.to_sym]
    @score_table[("C" + col.to_s).to_sym] += @score_default[marker.to_sym]
    @score_table
  end
  
  def win?
    @score_table.has_value?(@width) || @score_table.has_value?(-@width)
  end
  
  private
  
  def default_score_table
    @score_table = Hash.new(0)
    @score_table.store(:D, 0)
    @score_table.store(:antiD, 0)
    @width.times do |row|
      @score_table.store(("R" + row.to_s).to_sym, 0)
    end
    @width.times do |col|
      @score_table.store(("C" + col.to_s).to_sym, 0)
    end
    @score_table
  end
  
  
 end