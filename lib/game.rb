class Game
  attr_reader :pile

  def initialize
    pile = Pile.new(nil)
    @players = [Player.new(pile.deal(7)), ComputerPlayer.new(pile.deal(7))]
    @current_index = 0
  end
  
  def players_size
    @players.size
  end

  def current_player
    @players[@current_index]
  end

  def other_player
    @players[(@current_index + 1) % @players.size]
  end

  def next_player
    @current_index = (@current_index + 1) % @players.size
    current_player
  end

  def ask_card(player, asked_player, rank)
    cards = asked_player.answer(rank)
    return false if cards.nil? || cards.empty?
    player.receipt_cards(cards)
    return true
  end

  def start
    rank = current_player.ask
    ask_result = ask_card(current_player, other_player, rank)
    deal_result = deal_card(current_player, rank) unless ask_result 
    next_player unless ask_result || deal_result
  end
  
  def deal_card(player, asked_rank)
    cards = @pile.deal(1)
    player.receipt_cards(cards)
    return true if cards.first == Card.new(asked_rank)
    return false
  end
end