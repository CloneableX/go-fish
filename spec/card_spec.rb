require "card"

describe Card, '#initialize' do
  let(:card) { Card.new(4) }

  it 'should has rank' do
    expect(card.eq_rank(4)).to be
  end

  it 'should has equal card' do
    expect(card).to eq(Card.new(4))
  end
end