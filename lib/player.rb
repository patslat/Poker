require_relative 'hand'
require_relative 'game'
require_relative 'deck'
require_relative 'card'

class Player
  attr_accessor :hand, :money, :name
  def initialize(name)
    @name = name
    @money = 100
  end
  
  def show_cards
    @hand.show
  end
  
  def bet
    bet = gets.chomp
    @money -= bet.to_i if bet =~ /\d/
    bet.scan(/see|fold/)[0] || bet.to_i
  end
  
  def discard
    gets.chomp.scan(/\d/).map(&:to_i)
  end
    
end