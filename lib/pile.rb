class Pile
  def initialize(shuffle_seed)
    @cards = Array.new
    (0...52).each { |index| @cards << Card.new(index % 13 + 1) }
    shuffle_seed = Random.new_seed if shuffle_seed.nil?
    @cards.shuffle!(random: Random.new(shuffle_seed))
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

  def deal(card_num)
    @cards.shift(card_num)
  end

  def clear
    @cards.clear
  end

  def empty?
    @cards.empty?
  end
end