class Player
  def initialize(cards)
    @cards = cards
  end
  
  def has_many_card
    @cards.size
  end
end