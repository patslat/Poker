require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }
  
  describe "#generate_cards" do
    it "returns an array of cards" do
      cards = deck.generate_cards
      deck.cards.all? { |card| card.class == Card }.should == true
    end
  end
  
  describe "#cards" do
    it "has 52 cards" do
      deck.cards.length.should == 52
    end
    
    it "has no duplicates" do
      deck.cards.uniq.length.should == 52
    end
  end
  
  describe "#shuffle" do
    it "shuffles the order of the cards" do
      unshuffled_cards = deck.cards.dup
      deck.shuffle
      deck.cards.should_not == unshuffled_cards
    end
  end
  
  describe "#draw" do
    it "returns a card" do
      deck.draw.class.should == Card
    end
    
    it "removes the card from the deck" do
      card = deck.draw
      deck.cards.include?(card).should == false
    end
    
    it "generates a new deck and shuffles it if you run out of cards" do
      drawn_deck = (1..52).map { deck.draw }
      new_deck = deck.draw
      deck.cards.length.should == 51
    end
  end
end