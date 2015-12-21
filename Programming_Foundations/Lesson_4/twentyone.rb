SUITS = %w(H D C S)
VALUES = %W(1 2 3 4 5 6 7 8 9 10 J Q K A)
BLACKJACK = 21
DEALER_HIT_MIN = 17

def display(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  values = cards.map { |card| card[1]}
  
  sum = 0
  values.each do |value|
    if value == 'A'
      sum +=11
    elsif value.to_i == 0
      sum +=10
    else
      sum +=value.to_i
    end
  end
  
  values.select { |value| value == 'A'}.count.times do 
    sum-=10 if sum > BLACKJACK 
  end
  sum
end

def busted?(cards)
  total(cards) > BLACKJACK
end

def detect_results(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)
  
  if player_total > BLACKJACK
    display "Player Busted."
  elsif dealer_total > BLACKJACK
    display "Dealer Busted"
  elsif dealer_total < player_total
    display "Congratulations PLayer Won!"
  elsif dealer_total > player_total
    display "Sorry Dealer Won."
  else
    display "It's a tie."
  end
end

def play_again?
  puts "--------"
  display "Do you want to play again? (y/n)"
  play_again = gets.chomp
  play_again.downcase.start_with?('y')
end

loop do 
  display "Welcome to twenty-one"
  
  deck = initialize_deck
  player_cards = []
  dealer_cards = []
  
  2.times do 
    player_cards << deck.pop
    dealer_cards << deck.pop
  end
  
  display "Dealer has #{dealer_cards[0]} and ???"
  display "Player has #{player_cards[0]} and #{player_cards[1]}"
  
  loop do 
    player_turn = nil
    loop do 
      display "Would you like to hit or stay? (h/s)"
      player_turn = gets.chomp.downcase
      break if ['h', 's'].include?(player_turn)
      display "Sorry you must enter and 'h' or 's'."
    end
    
    if player_turn == 'h'
      player_cards << deck.pop
      display "You chose to hit."
      display "Your cards are now #{player_cards}"
      display "Your total is now #{total(player_cards)}"
    end
  
    break if player_turn == 's' || busted?(player_cards)
  end

  if busted?(player_cards)
    detect_results(dealer_cards, player_cards)
    play_again? ? next : break
  else
    display "You stayed at #{total(player_cards)}"
  end

  display "Dealer turn..."

  loop do
    break if busted?(dealer_cards) || total(dealer_cards) >= DEALER_HIT_MIN

    display "Dealer hits!"
    dealer_cards << deck.pop
    display "Dealer's cards are now: #{dealer_cards}"
  end

  if busted?(dealer_cards)
    display "Dealer total is now: #{total(dealer_cards)}"
    detect_results(dealer_cards, player_cards)
    play_again? ? next : break
  else
    display "Dealer stays at #{total(dealer_cards)}"
  end

  puts "=============="
  display "Dealer has #{dealer_cards}, for a total of: #{total(dealer_cards)}"
  display "Player has #{player_cards}, for a total of: #{total(player_cards)}"
  puts "=============="

  detect_results(dealer_cards, player_cards)

  break unless play_again?
end

display "Thank you for playing Twent-One! Good bye!"
