require_relative "../lib/pile"
require_relative "../lib/player"
require_relative "../lib/computer_player"

class Game
  attr_accessor :pile
  attr_writer :players

  def initialize
    @pile = Pile.new(nil)
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

  def play_one_round
    rank = current_player.ask
    ask_result = ask_card(current_player, other_player, rank)
    deal_result = deal_card(current_player, rank) unless ask_result 
    next_player unless ask_result || deal_result
    supplied_players = @players.select { |player| player.cards_empty? }
    supplied_players.each { |player| supply_cards(player) }
  end

  def deal_card(player, asked_rank)
    cards = @pile.deal(1)
    player.receipt_cards(cards) unless cards.empty?
    if cards.first == Card.new(asked_rank)
      puts "Deal Card: #{asked_rank}"
      return true 
    end
    return false
  end

  def clear_cards
    @pile.clear
    @players.each { |player| player.clear_cards }
  end

  def start
    puts "Welcom Play Game: Go Fish!"
    while !cards_empty?
      puts "== Your Score: #{@players.first.score}, Computer Player Score: #{@players.last.score} =="
      play_one_round
    end
    if winner.is_a? ComputerPlayer
      puts 'Winner is Computer'
    else
      puts 'Winner is You'
    end
    return winner
  end

  def cards_empty?
    return @pile.empty? && @players.first.cards_empty? && @players.last.cards_empty?
  end

  def winner
    return @players.max { |player, other_player| player.score <=> other_player.score }
  end

  def supply_cards(player)
    return if @pile.empty?
    player.receipt_cards(@pile.deal(7))
  end
end
