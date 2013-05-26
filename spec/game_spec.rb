require 'rspec'
require 'game'

describe Game do
  subject(:game) { Game.new(4) }
  
  it "should initialize with up to 4 players" do
    game.players.length.should == 4
  end
  
  describe "#deal" do
    it "should assign a hand of five cards to each player" do
      game.deal
      game.players.all? { |player| player.hand.cards.length == 5 }.should == true
    end
  end
end