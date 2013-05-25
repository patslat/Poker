require 'rspec'
require 'hand'
require 'card'

describe Hand do
  subject(:hand) { Hand.new }
  
  let(:hand2) { Hand.new }
  let(:ace_spades) { Card.new("Ace", "Spades") }
  let(:ace_hearts) { Card.new("Ace", "Hearts") }
  let(:ace_diamonds) { Card.new("Ace", "Diamonds") }
  let(:jack_spades) { Card.new("Jack", "Spades") }
  let(:queen_spades) { Card.new("Queen", "Spades") }
  let(:king_clubs) { Card.new("King", "Clubs")}
  let(:king_spades) { Card.new("King", "Spades") }
  let(:ten_spades) { Card.new("10", "Spades") }
  let(:six_clubs) { Card.new("6", "Clubs") }
  let(:five_clubs) { Card.new("5", "Clubs") }
  let(:three_hearts) { Card.new("3", "Hearts") }
  let(:two_diamonds) { Card.new("2", "Diamonds") }
  
  
  let(:full_house) { [ace_spades, ace_hearts, ace_diamonds, king_spades, king_clubs] }
  let(:three_of_a_kind) { [ace_spades, ace_hearts, ace_diamonds, king_spades, ten_spades] }
  
  let(:straight_flush) { [ten_spades, jack_spades, queen_spades, king_spades, ace_spades] }
  let(:ten_high) { [two_diamonds, five_clubs, three_hearts, six_clubs, ten_spades] }
  let(:ace_high) { [ace_diamonds, five_clubs, three_hearts, six_clubs, ten_spades] }

  
  describe "#cards" do
    it "holds 5 cards" do
      hand.cards = three_of_a_kind
      hand.cards.length.should == 5
    end
  end
  
  describe "#scores_and_suits" do
    it "returns an array of pairs of [score, suit]" do
      hand.cards = three_of_a_kind
      scores_suits = [ [14, "Spades"], [14, "Hearts"], [14, "Diamonds"], 
                       [13, "Spades"], [10, "Spades"]
      ]
      hand.scores_and_suits.should == scores_suits
    end
  end
  
  describe "#count_same_score" do
    it "returns a hash of the counts of each score" do
      hand.cards = full_house
      hand.count_same_score.should == { 14 => 3, 13 => 2 }
    end
  end
  
  describe "flush?" do #not necessary to test helpers
    it "is true if hand is a flush" do
      hand.cards = straight_flush
      hand.flush?.should == true
    end
    
    it "is false if hand is not a flush" do
      hand.cards = three_of_a_kind
      hand.flush?.should == false
    end
  end
  
  describe "straight?" do
    it "is true if hand is a straight" do
      hand.cards = straight_flush
      hand.straight?.should == true
    end
  end
  
  describe "#calculate_hand" do
    it "knows a hand with a three of a kind" do
      hand.cards = three_of_a_kind
      hand.calculate_hand.should == :three_of_a_kind
    end
    
    it "knows a straight flush" do
      hand.cards = straight_flush
      hand.calculate_hand.should == :straight_flush
    end
  end
    
   describe "::calculate_winner" do
    it "should solve an easy comparison" do
      hand.cards = straight_flush
      hand2.cards = three_of_a_kind
      Hand.calculate_winner(hand, hand2).should == hand
    end
    
    it "should solve a tie" do
      hand.cards = ten_high
      hand2.cards = ace_high
      Hand.calculate_winner(hand, hand2).should == hand2
    end
  end
  
  
end