require_relative "../lib/player"

class ComputerPlayer < Player
  def ask
    ranks = @cards.uniq.collect { |card| card.rank }
    ranks[Random.rand(ranks.size)]
  end
end