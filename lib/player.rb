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
    target_card = Card.new(rank)
    unless @cards.include?(target_card)
      puts "Go Fish!"
      return
    end
    cards =  @cards.select { |card| card == target_card }
    @cards.delete_if { |card| card == target_card }
    return cards
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

  def receipt_cards(cards)
    @cards.concat(cards)
  end
end
