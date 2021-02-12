class Pile
  def initialize
    @cards = Array.new
    (0...52).each { |index| @cards << Card.new(index % 13 + 1) }
    @cards.shuffle!
  end

  def size
    @cards.size
  end

  def has_many(card)
    @cards.count(card)
  end
  
  def first
    @cards.first
  end
end