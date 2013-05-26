require_relative 'game'
require_relative 'card'
require_relative 'deck'
require_relative 'player'

class Hand
  PAIR_HANDS = {
    [3, 2] => :full_house,
    [4, 1] => :four_of_a_kind,
    [3, 1, 1] => :three_of_a_kind,
    [2, 1, 1, 1] => :one_pair,
    [1, 1, 1, 1, 1] => :high_card
  }
  
  HAND_SCORES = {
    :straight_flush => 9,
    :four_of_a_kind => 8,
    :full_house => 7,
    :flush => 6,
    :straight => 5,
    :three_of_a_kind => 4,
    :two_pair => 3,
    :one_pair => 2,
    :high_card => 1
  }
  
  attr_accessor :cards
  def initialize
    @cards = []
  end
  
  def show
    5.times { |n| print "(#{n}) #{cards[n].value}, #{cards[n].suit}  "}
    print "\n"
  end
  
  def discard(card_indices)
    card_indices.sort.reverse.each { |index| cards.delete_at(index) }
  end
  
  def self.calculate_winner(*hands)
    hands_and_scores = {}
    hands.each { |hand| hands_and_scores[hand] = HAND_SCORES[hand.calculate_hand] }
    highest_hands = Hand.highest_hands(hands_and_scores)
    return highest_hands[0] if highest_hands.length == 0
    tiebreaker(*highest_hands) 
  end
  
  def self.highest_hands(hands_and_scores)
    highest_score = 0
    highest_hands = []
    p hands_and_scores
    hands_and_scores.each do |hand, score|
      if score > highest_score
        highest_score = score
        highest_hands = [hand]
      elsif score == highest_score
        highest_hands << hand
      end
    end
    highest_hands
  end
  
  def calculate_hand
    if straight? && flush?
      :straight_flush
    elsif flush?
      :flush
    elsif straight?
      :straight
    else
      pair_type
    end
  end
  
  def self.tiebreaker(*hands)
    hand_scores = hands.map { |hand| hand.scores.dup.sort! }
    highs = hand_scores.map(&:pop)
    until find_highest_scores(highs).length == 1
      highs = hand_scores.map(&:pop)
    end
    hands[highs.index(highs.max)]
  end
  
  def self.find_highest_scores(highs)
    highs.select { |n| n == highs.max }
  end
  
  def flush?
    suits.uniq.length == 1
  end
  
  def straight?
    sorted_scores = scores.sort
    sorted_scores.each_with_index.all? do |score, index|
      return true if index == 4
      sorted_scores[index + 1] == (score % 14) + 1 #ace can be 1
    end
  end
  
  def pair_type
    p count_same_score
    a = PAIR_HANDS[count_same_score.values]
    p "after hash"
    p a
  end

  def count_same_score
    scores.each_with_object(Hash.new(0)) { |score, hsh| hsh[score] += 1}
  end

  def scores_and_suits
    scores.zip(suits)
  end
  
  def scores
    @cards.collect { |card| card.score }
  end
  
  def suits
    @cards.collect { |card| card.suit }
  end
end