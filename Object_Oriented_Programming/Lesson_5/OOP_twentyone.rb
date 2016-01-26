module Hand
  def show_hand
    puts "---#{name}'s hand---"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
    puts " "
  end
  
  def total
    total = 0
    cards.each do |card|
      if card.ace?
        total += 11
      elsif card.jack? || card.queen? || card.king?
        total += 10
      else
        total += card.face.to_i
      end
    end

    cards.select(&:ace?).count.times do
      break if total <= 21
      total -= 10
    end
    total
  end
   
  def add_card(new_card)
    cards << new_card
  end

  def busted?
    total > 21
  end
end

class Card
  SUITS = ['H', 'D', 'S', 'C']
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "The #{face} of #{suit}."
  end

  def face
    case @face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else 
      @face
    end
  end

  def suit
    case @suit
    when 'H' then 'Hearts'
    when 'D' then 'Diamonds'
    when 'S' then 'Spades'
    when 'C' then 'Clubs'
    end
  end

  def ace?
    face == 'Ace'
  end

  def king?
    face == 'King'
  end

  def queen?
    face == 'Queen'
  end

  def jack?
    face == 'Jack'
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face) # each card you push into this array is a new object of Card class, @cards IS NOT a Card class object
      end
    end
  scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end 
end

class Participant
  include Hand
  attr_accessor :name, :cards # attr_accessor here b/c your not defining name in the initialize method so we need to an aceessor so we can call self.name = name.

  def initialize
    @cards = []
    set_name
  end
end

class Player < Participant
  def set_name
    name = ""
    loop do
      puts "Please enter your name:"
      name = gets.chomp
      break unless name =~ (/\d/) || name.empty?
      puts "Sorry, that is not a valid entry, please try again."
    end
    self.name = name
  end

  def show_flop
    show_hand
  end
end

class Dealer < Participant
  ROBOTS = %w(Mr.Data Megatron TheHulk OptimusPrime BumbleBee)

  def set_name
    self.name = ROBOTS.sample
  end

  def show_flop
    puts "---#{name}'s hand:"
    puts "#{cards.first}"
    puts "??"
    puts ""
  end
end

class TwentyOne
  DEALER_HIT_MIN = 17
  BLACKJACK = 21
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def reset
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_one)
      dealer.add_card(deck.deal_one)
    end
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def player_turn
    puts "#{player.name}'s turn:"
    loop do
      hit_or_stay = nil
      loop do
        puts "Your total is now: #{player.total}. Would you like to hit or stay? (h/s)"
        hit_or_stay = gets.chomp.downcase
        break if %w(h s).include?(hit_or_stay)
        puts "Sorry, must enter h or s"
      end

      if hit_or_stay == 's'
        puts "#{player.name} stays."
        sleep(0.75)
        break
      elsif player.busted?
        break
      else
        player.add_card(deck.deal_one)
        puts "#{player.name} hits..."
        sleep(0.5)
        player.show_hand
        break if player.busted?
      end
    end
  end

  def dealer_turn
    puts "#{dealer.name}'s turn:"
    sleep(1.0)
    loop do
      if dealer.total >= DEALER_HIT_MIN && dealer.total < BLACKJACK
        puts "#{dealer.name} stays"
        sleep(0.75)
        break
      elsif dealer.busted?
        break
      else
        puts "#{dealer.name} hits..."
        sleep(0.5)
        dealer.add_card(deck.deal_one)
      end
    end
  end

  def show_busted
    if player.busted?
      puts "#{player.name} busted. #{dealer.name} wins."
    elsif dealer.busted?
      puts "#{dealer.name} busted. #{player.name} wins!"
    end
  end

  def show_cards
    player.show_hand
    dealer.show_hand
  end

  def show_result
    if player.total == BLACKJACK
      puts "#{player.name} has BlackJack!."
    elsif dealer.total == BLACKJACK
      puts "#{dealer.name} has BlackJack!"
    elsif player.total > dealer.total
      puts "#{player.name} wins!"
    elsif player.total < dealer.total
      puts "#{dealer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would You like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "You must enter wither y or n"
    end

    answer == 'y'
  end

  def player_outcome_
    
  end
  
  def dealer_outcome
    
  end

  def start
    loop do 
      system 'clear'
      deal_cards
      show_flop

      player_turn
      if player.busted?
        show_busted
        if play_again?
          reset
          next
        else
         break
        end
      end

      dealer_turn
      if dealer.busted?
        show_busted
        if play_again?
          reset
          next
        else
          break
        end
      end

      show_cards
      show_result
      play_again? ? reset : break
    end

    puts "Thank You for playing Twenty One."
  end
end

game = TwentyOne.new
game.start
