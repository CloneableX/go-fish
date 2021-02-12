class Card
  attr_reader :rank
  protected :rank

  def initialize(rank)
    @rank = rank
  end
  
  def eq_rank(rank)
    @rank == rank
  end

  def ==(other)
    @rank == other.rank
  end
end