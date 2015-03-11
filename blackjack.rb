require 'pry'

SUITS = ['♥', '♣', '♦', '♠']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

#######################################################################################################################################

class Card
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def rank
    @rank
  end

  def suit
    @suit
  end

  def value(card)
    value = 0
    rank = card.rank
      if rank == "A"
        value = 11
      elsif rank == "J" || rank == "Q" || rank == "K"
        value = 10
      else
        point = rank.to_i
        value = value + point
      end
  value
  end

end

#######################################################################################################################################

class Deck
  def initialize
    @deck_of_cards = []
     SUITS.each do |suit|
       VALUES.each do |rank|
         @deck_of_cards << Card.new(rank, suit)
       end
     end
    @deck_of_cards.shuffle!
  end

  #deal one card and return it
  def deal_card
    @deck_of_cards.pop
  end
end

#######################################################################################################################################

class Hand
  def initialize(name)
    @name = name
    @cards = []
  end

  def cards
    @cards
  end

  def hit(card)
    @cards << card
  end
end

#######################################################################################################################################

deck = Deck.new
player = Hand.new("Player")
computer = Hand.new("Computer")


  #Start game
  2.times do
    player.hit(deck.deal_card)
    computer.hit(deck.deal_card)
  end

  player.cards.each do |read|
    puts "Player was dealt a #{read.rank} of #{read.suit}."
  end

  dealer_show_card = computer.cards.first
  dealer_show =  "Dealer shows a #{dealer_show_card.rank} of #{dealer_show_card.suit}."
  puts dealer_show

  player_score = 0
  player.cards.each do |card|
    points = card.value(card)
    player_score = player_score + points
  end

  computer_score = 0
  computer.cards.each do |card|
    points = card.value(card)
    computer_score = computer_score + points
  end

  while player_score < 22

    if player_score == 21 && computer_score == 21
    puts "Player and Dealer both score Blackjack.  Push."

  elsif player_score <= 21

    puts "Players score : #{player_score}"
    print "Hit or Stand? : "
    decision = gets.chomp

      if decision == "h"
          player.hit(deck.deal_card)
          new_card = player.cards.last
          puts "Player was dealt a #{new_card.rank} of #{new_card.suit}."
          player_score = 0
          player.cards.each do |card|
            points = card.value(card)
            player_score = player_score + points
          end

      elsif decision == "s" && computer_score > player_score
          dealer_card_two = computer.cards[1]
          puts "\nPulling card..."
          puts "Dealer turns over a #{dealer_card_two.rank} of #{dealer_card_two.suit}."
          puts "Dealers #{computer_score} beats Players #{player_score}."
          puts "Better luck next time."
          break

        elsif decision == "s" && computer_score <= player_score
          puts "\nPulling card..."
          dealer_card_two = computer.cards[1]
          puts "Dealer turns over a #{dealer_card_two.rank} of #{dealer_card_two.suit}."
          puts "Dealers score is #{computer_score}."
          while computer_score < 17
            computer.hit(deck.deal_card)
            dealer_card_last = computer.cards.last
            puts "\nPulling card..."
            puts "Dealer turns over a #{dealer_card_last.rank} of #{dealer_card_last.suit}."
            computer_score = 0
            computer.cards.each do |card|
              points = card.value(card)
              computer_score = computer_score + points
            end
            puts "Dealers score is #{computer_score}."
          end

          if computer_score > 21
            puts "Dealer busts, Player wins!"

          elsif computer_score == 21 && computer_score > player_score
            puts "Dealer hits Blackjack, Dealer wins."

          elsif computer_score > player_score
            puts "Dealers #{computer_score} beats Players #{player_score}."
            puts "Better luck next time."

          elsif computer_score < player_score
            puts "Dealer stands on #{computer_score}."
            puts "Players #{player_score} beats Dealers #{computer_score}."

          elsif computer_score == player_score
            puts "Tie.  Dealer and Player both have #{player_score}."

          elsif player_score == 21 && computer_score < 21
          puts "Player wins with Blackjack!"

          end
          break
      end

    end

    if player_score > 21
      puts "Player busts.  Better luck next time!"
    end

end
