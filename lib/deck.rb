require_relative 'hand'
require_relative 'game'
require_relative 'player'
require_relative 'card'

class Deck
  attr_reader :cards
  def initialize
    @cards = generate_cards
  end
  
  def generate_cards
    value_suit_pairs = generate_card_values
    value_suit_pairs.map { |card| Card.new(card[0], card[1]) }
  end
  
  def shuffle
    @cards.shuffle!
  end
  
  def draw
    @cards = generate_cards if @cards.empty?
    @cards.pop
  end
  
  private
  def generate_card_values
    suits = ["Hearts", "Spades", "Diamonds", "Clubs"]
    values = (2..10).to_a.map(&:to_s) + ["King", "Queen", "Jack", "Ace"]
    (values * 4).shuffle.zip((suits * 13).shuffle)
  end
end