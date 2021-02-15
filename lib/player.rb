class Player
  attr_accessor :score
  
  def initialize(cards)
    @cards = cards.sort { |card, other_card| card.rank <=> other_card.rank }
    @score = 0
  end
  
  def has_many_card
    @cards.size
  end

  def ask
    show_cards
    print 'Please input asked rank:'
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
    @cards.sort! { |card, other_card| card.rank <=> other_card.rank }
    count_score(cards.first)
  end

  def clear_cards
    @cards.clear
  end

  def cards_empty?
    @cards.empty?
  end

  def show_cards
    print 'Your Cards: '
    puts @cards.map { |card| card.rank }.join(',')
  end
end
