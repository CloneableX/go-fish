require_relative "../lib/player"

class ComputerPlayer < Player
  def ask
    ranks = @cards.uniq.collect { |card| card.rank }
    rank = ranks[Random.rand(ranks.size)]
    puts "Computer asks card #{rank}"
    return rank
  end
end