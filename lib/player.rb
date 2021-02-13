class Player
  def initialize(cards)
    @cards = cards
    @score = 0
  end
  
  def has_many_card
    @cards.size
  end

  def ask
    gets.chomp.to_i
  end

  def answer(rank)
    unless @cards.include?(Card.new(rank))
      puts "Go Fish!"
      return
    end
    return @cards.select! { |card| card == Card.new(rank) }
  end

  def count_score(card)
    if @cards.count(card) == 4
      @score += 1
      @cards.delete_if { |compared_card| compared_card == card }
    end
    return @score
  end

  def card_size
    @cards.size
  end
end
