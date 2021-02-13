require "pile"

describe Pile do
  let(:pile) { Pile.new(1) }

  describe '#initialize' do
    it 'should has 52 cards' do
      expect(pile.size).to eq(52)
    end

    it 'should has four same cards' do
      expect(pile.has_many(Card.new(2))).to eq(4)
    end

    it 'should not ordered' do
      expect(pile.first).not_to eq(Card.new(1))
    end
  end

  describe '#deal' do
    it 'should deal some cards' do
      expect(pile.deal(7).size).to eq(7)
    end
  end
end
