require "pile"
require "player"
require "card"

describe Player do
  let(:cards) { [Card.new(3), Card.new(3), Card.new(7), Card.new(1)] }
  let(:player) { Player.new(cards) }

  describe '#initialize' do
    it 'should has 7 cards' do
      pile = Pile.new(nil)
      player = Player.new(pile.deal(7))
      expect(player.has_many_card).to eq(7)
    end
  end

  describe '#ask' do
    it 'should asked card rank from cards handed' do
      allow(player).to receive(:gets).and_return("3")
      rank = player.ask
      expect(cards).to include(Card.new(rank))
    end
  end

  describe '#answer' do
    it 'should print "Go Fish" if not hand the rank' do
      expect { player.answer(2) }.to output("Go Fish!\n").to_stdout
    end

    it 'should give all cards about this rank' do
      cards = player.answer(3)
      expect(cards.size).to eq(2)
      expect(player.card_size).to eq(2)
    end
  end

  describe '#count_score' do
    let(:score_cards) { [Card.new(3), Card.new(3), Card.new(3), Card.new(3)] }
    let(:score_player) { Player.new(score_cards) }

    it 'should count 1 score when there are 4 same cards' do
      expect(score_player.count_score(Card.new(3))).to eq(1)
    end

    it 'should retract 4 cards when there are 4 same cards' do
      expect_cards_size = score_cards.size - 4
      score_player.count_score(Card.new(3))
      expect(score_player.card_size).to eq(expect_cards_size)
    end
  end

  describe '#receipt_cards' do
    it 'should add score 1 when receipt cards as 4 same cards' do
      score = player.score
      cards = [Card.new(3), Card.new(3)]
      puts "#receipt_cards "
      player.receipt_cards(cards)
      expect(player.score).to eq(score + 1)
    end
  end
end
