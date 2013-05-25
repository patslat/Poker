require 'rspec'
require 'card'
describe Card do
  subject(:card) { Card.new("10", "Spades") }
  let(:jack_of_spades) { Card.new("Jack", "Spades") }
  
  describe "#value" do
    it "has a value" do
      card.value.should == "10"
    end
  end
  
  describe "#suit" do
    it "has a suit" do
      card.suit.should == "Spades"
    end
  end
  
  describe "#score" do
    it "should have a score equal to its number value" do
      card.score.should == 10
    end
    
    it "should convert face cards to a score" do
      jack_of_spades.score.should == 11
    end
  end

end