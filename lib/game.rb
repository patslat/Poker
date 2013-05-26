require_relative 'hand'
require_relative 'deck'
require_relative 'player'
require_relative 'card'

class Game
  attr_accessor :players
  def initialize(number_of_players)
    @players = generate_players(number_of_players)
    @in_play = @players
    @deck = Deck.new
    @pot = 0
  end
  
  def play
    @in_play = @players.select { |player| player.money > 0 }
    until game_over?
      deal
      show_hands
      get_bets
      show_hands
      discard_phase
      show_hands
      get_bets
      winner = @in_play.length > 1 ? calculate_winner : @in_play[0]
      announce_winner(winner)
      give_winnings(winner)
    end
    
  end
  
  def show_hands
    @in_play.each do |player|
      puts player.name
      player.hand.show
    end
  end
  
  def game_over?
    false
  end
  
  def calculate_winner
    hands_to_player = {}
    @in_play.each { |player| hands_to_player[player.hand] = player }
    hands_to_player[Hand.calculate_winner(*hands_to_player.keys)]
  end
  
  def deal
    @in_play.each do |player|
      hand = Hand.new
      hand.cards = (1..5).map { @deck.draw }
      player.hand = hand
    end
  end
  
  def get_bets
    current_bet = 0
    @in_play.each do |player|
      prompt_bet_options(player)
      until (bet = player.bet).is_a?(Fixnum) && bet >= current_bet
        case bet
        when "fold"
          @in_play.delete(player)
        when "see"
          puts "The current bet is #{current_bet}"
        else
          puts "You must bet at least #{current_bet}"
        end
      end
      current_bet = bet
      @pot += bet
    end
  end
  
  def discard_phase
    @in_play.each do |player|
      prompt_discard(player)
      cards_to_discard = player.discard
      player.hand.discard(cards_to_discard)
      cards_to_discard.length.times { player.hand.cards << @deck.draw }
    end
  end
  
  def announce_winner(winner)
    puts "#{winner.name} wins #{@pot}!"
  end
  
  def give_winnings(player)
    player.money += @pot
    @pot = 0
  end
  
  def prompt_bet_options(player)
    puts "#{player.name}, you may (fold), see the current bet, or raise"
  end
  
  def prompt_discard(player)
    puts "#{player.name}, enter which cards you would like to discard: \n"
  end
  
  def generate_players(n)
    (1..n).map { |n| Player.new("Player #{n}") }
  end
  
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new(2)
  g.play
end