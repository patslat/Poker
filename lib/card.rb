require_relative 'hand'
require_relative 'game'
require_relative 'deck'
require_relative 'player'

class Card
  attr_reader :value, :suit, :score
  FACE_SCORE = { "Jack" => 11, "Queen" => 12, "King" => 13, "Ace" => 14 }
  def initialize(value, suit)
    @value = value
    @score = FACE_SCORE[value] || value.to_i
    @suit = suit
  end
end