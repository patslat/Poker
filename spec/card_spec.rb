require 'rspec'
require 'card'
describe Card do
  subject(:card) { Card.new("10", "Spades")}
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

end