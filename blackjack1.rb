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
    elsif card[1] == "Ace" # Use value of 11 for now. Change to 1 later if total > 21
      total += 11
    else
      total += card[1].to_i
    end        
  end

  # Use value of 1 instead of 11 for Aces if the total > 21
  cards.select{ |card| card[1] == "Ace"}.count.times do
    total -= 10 if total > 21
  end    
  total       
end  

# Deal 2 cards to player and 2 cards to dealer
deck = new_deck
puts "I will deal two cards to each of us..."
puts "" 

2.times do
  player_cards << deck.pop
  dealer_cards << deck.pop
end  

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

# Player's turn
if player_total == 21
  puts "Congratulations! You have hit blackjack!"
  exit
end

while player_total < 21
  puts "What would you like to do? Enter 'H' for hit and 'S' for stay."
  hit_or_stay = gets.chomp.downcase
  if !['h', 's'].include?(hit_or_stay)
    puts "You did not enter a valid response. Enter 'H' for hit and 'S' for stay. "
    next
  end  
  if hit_or_stay == "s"
    puts "You have decided to stay."
    break
  end
  
  # chose hit  
  player_cards << deck.pop
  puts "I just dealt you a #{player_cards.last[1]} of #{player_cards.last[0]}"
  player_total = calculate_total(player_cards)
  puts "Your total is now: #{player_total}"

  if player_total == 21
    puts "Congratulations! You have hit blackjack!"
    exit
  elsif player_total > 21
    puts "You have busted!"
    exit
  end  
end 

# Dealer's turn
puts "It is now my turn."

dealer_total = calculate_total(dealer_cards)
if (dealer_total > player_total) && (dealer_total > 17)
  puts "I have won! My total is higher than your total"
else
  while ((dealer_total < 21) && (dealer_total < player_total)) || dealer_total < 17
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
