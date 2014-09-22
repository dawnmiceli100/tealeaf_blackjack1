# blackjack1.rb

# Game Logic:
# Start game by dealing 2 cards to the player and 2 cards to the dealer.
# The player goes first and chooses to hit or stay.
# If the player chooses hit, another card is dealt.
#   If the player's cards total 21, she wins. If the player's cards total > 21, she loses. 
#   The player can choose hit again and again until she wins, loses or stays.
# When the player chooses stay, it becomes the dealer's turn.
# The dealer must choose hit until her card total is >= 17
# If the dealer reaches exactly 21 with a hit, she wins.
# If the dealer goes over 21 with a hit, she loses.
# If the dealer stays, then the player total and the dealer total are compared and the highest total wins.

 
SUITS = ["Hearts", "Diamonds", "Clubs", "Spades"]
CARDS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
deck = SUITS.product(CARDS)
player_cards = []
dealer_cards = []
game_over = false

puts "Welcome to Blackjack!" 

def new_deck
  deck = SUITS.product(CARDS)
  deck.shuffle!
end  

def calculate_total(cards)
  total = 0
  face_cards = ["Jack", "Queen", "King"]
  cards.each do |card|
    if face_cards.include?(card[1]) 
      total += 10
    elsif card[1] == "Ace"
      if total < 11
        total += 11
      else
        total += 1
      end
    else
      total += card[1].to_i
    end        
  end 
  return total       
end  

deck = new_deck
puts "I will deal two cards to each of us..."
puts "" 
player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

puts "Player cards: "
player_cards.each { |card| puts "-> #{card[1]} of #{card[0]}" } 
player_total = calculate_total(player_cards)
puts "-> Total: #{player_total}"
puts ""
puts "Dealer cards: "
dealer_cards.each { |card| puts "-> #{card[1]} of #{card[0]}" } 
dealer_total = calculate_total(dealer_cards)
puts "-> Total: #{dealer_total}" 
puts ""

puts "What would you like to do? Enter 1 for 'hit' and 2 for 'stay'"
hit_or_stay = gets.chomp
while (hit_or_stay != "2") && (!game_over)
  player_cards << deck.pop
  puts "I just dealt you a #{player_cards.last[1]} of #{player_cards.last[0]}"
  player_total = calculate_total(player_cards)
  puts "Your total is now: #{player_total}"
  if player_total == 21
    puts "Congratulations! You have hit blackjack!"
    game_over = true
  elsif player_total > 21
    puts "You have busted!"
    game_over = true
  else      
    puts "What would you like to do? Enter 1 for 'hit' and 2 for 'stay'"
    hit_or_stay = gets.chomp
  end  
end 

if !game_over
  puts "It is now my turn."
  dealer_total = calculate_total(dealer_cards)
  if dealer_total > player_total
    puts "I have won! My total is higher than your total"
  else
    while (dealer_total < 21) && (dealer_total < player_total)
      dealer_cards << deck.pop 
      puts "I just dealt myself a #{dealer_cards.last[1]} of #{dealer_cards.last[0]}"
      dealer_total =  calculate_total(dealer_cards)
      puts "My total is now: #{dealer_total}" 
    end

    if dealer_total == 21
      puts "I have hit blackjack! Dealer has won!"
    elsif dealer_total > 21
      puts "I have busted! You have won!" 
    else
      puts "I have won! My total is higher than your total."
    end  
  end  
end
  



