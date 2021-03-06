require "game"

describe Game do
  let(:game) { Game.new }
  let(:current_player) { Player.new([Card.new(1), Card.new(2)]) }

  describe '#initialize' do
    it 'should have two players' do
      expect(game.players_size).to eq(2)
    end

    it 'should own 7 cards each player' do
      expect(game.current_player.card_size).to eq(7)
    end
  end

  describe '#next_player' do
    it 'should turn next player' do
      current_player = game.current_player
      next_player = game.next_player
      expect(next_player).to_not eq(current_player)
      expect(game.current_player).to eq(next_player)
    end
  end

  describe '#ask_card' do
    let(:other_player) { Player.new([Card.new(3), Card.new(1), Card.new(1)]) }

    it 'should receipt cards when asked rank in hand of other player' do
      ask_result = game.ask_card(current_player, other_player, 1)

      expect(current_player.card_size).to eq(4)
      expect(other_player.card_size).to eq(1)
      expect(ask_result).to be
    end

    it 'should return false when asked rank not exist in other player' do
      ask_result = game.ask_card(current_player, other_player, 2)

      expect(ask_result).to_not be
    end
  end

  describe '#play_one_round' do
    it 'should continue ask when ask cards successfully' do
      allow(game.current_player).to receive(:ask).and_return(1)
      current_player = game.current_player
      allow(game).to receive(:ask_card).and_return(true)
      game.play_one_round
      expect(game.current_player).to eq(current_player)
    end

    it 'should continue ask when ask cards failed but deal card as asked rank' do
      allow(game.current_player).to receive(:ask).and_return(2)
      current_player = game.current_player
      allow(game).to receive(:ask_card).and_return(false)
      allow(game).to receive(:deal_card).and_return(true)
      game.play_one_round
      expect(game.current_player).to eq(current_player)
    end

    it 'should switch player when ask cards failed and deal card not as asked rank' do
      allow(game.current_player).to receive(:ask).and_return(2)
      current_player = game.current_player
      allow(game).to receive(:ask_card).and_return(false)
      allow(game).to receive(:deal_card).and_return(false)
      game.play_one_round
      expect(game.current_player).to_not eq(current_player)
    end
  end

  describe '#deal_card' do
    RSpec.configure {|c| c.mock_with :rspec}

    before(:each) do
      allow_message_expectations_on_nil
    end

    it 'should return true when deal card as aksed rank' do
      allow(game.pile).to receive(:deal).and_return([Card.new(1)])

      card_size = current_player.card_size
      deal_result = game.deal_card(current_player, 1)
      expect(deal_result).to be
      expect(current_player.card_size).to eq(card_size + 1)
    end

    it 'should return false when deal card not as aksed rank' do
      allow(game.pile).to receive(:deal).and_return([Card.new(1)])

      deal_result = game.deal_card(current_player, 2)
      expect(deal_result).to_not be
    end

    it 'should return false when deal cards empty' do
      allow(game.pile).to receive(:deal).and_return([])

      deal_result = game.deal_card(current_player, 2)
      expect(deal_result).to_not be
    end
  end

  describe '#start' do
    it 'should end game when pile and cards of all player is empty' do
      game.clear_cards
      winner = game.start
      expect(winner).to_not be_nil
    end
  end

  describe '#cards_empty?' do
    it 'should return true when pile and all players cards is empty' do
      game.clear_cards
      expect(game.cards_empty?).to be
    end
  end

  describe '#winner' do
    it 'should return highest score player' do
      player = Player.new([])
      player.score = 7
      game.players = [ComputerPlayer.new([]), player]
      expect(game.winner).to eq(player)
    end
  end

  describe '#supply_cards' do
    let(:player) { Player.new([]) }
    let(:pile) { Pile.new(nil) }

    it 'should not supply cards when pile is empty' do
      game.pile.clear
      game.supply_cards(player)
      expect(player.cards_empty?).to be
    end

    it 'should supply 7 cards when pile cards greater than and equal 7' do
      pile.deal(45)
      game.pile = pile
      game.supply_cards(player)
      expect(player.card_size).to eq(7)
    end

    it 'should supply all pile cards when pile cards less than 7' do
      pile.deal(46)
      game.pile = pile
      game.supply_cards(player)
      expect(player.card_size).to eq(6)
    end
  end
end