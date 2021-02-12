require "pile"
require "player"

describe Player, '#initialize' do
  it 'should has 7 cards' do
    pile = Pile.new
    player = Player.new(pile.deal(7))
    expect(player.has_many_card).to eq(7)
  end
end