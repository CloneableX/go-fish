require "computer_player"

describe ComputerPlayer do
  describe '#ask' do
    it 'should return rank haned' do
      cards = [Card.new(3), Card.new(3), Card.new(7), Card.new(1)]
      player = ComputerPlayer.new(cards)
      rank = player.ask
      expect(cards).to include(Card.new(rank))
    end
  end
end