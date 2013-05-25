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

  def self.calculate_winner(hand1, hand2)
    hand1_score = HAND_SCORES[hand1.calculate_hand]
    hand2_score = HAND_SCORES[hand2.calculate_hand]
    if hand1_score == hand2_score
      Hand.tiebreaker(hand1, hand2)
    elsif hand1_score > hand2_score
      hand1
    else
      hand2
    end
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
  
  def self.tiebreaker(hand1, hand2)
    hand1_dup, hand2_dup = hand1.scores.dup.sort, hand2.scores.dup.sort
    until hand1_dup.empty? || hand2_dup.empty?
      hand1_high, hand2_high = hand1_dup.pop, hand2_dup.pop
      next if hand1_high == hand2_high
      return hand1_high > hand2_high ? hand1 : hand2
    end
    [hand1, hand2].sample #random if total tie
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
    PAIR_HANDS[count_same_score.values]
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