# this design is much more readable than OOP_RPS.rb and more true to form for object oriented programming. By adding classes (note we are note adding anything to code) just adding classes to clarify functionality. each class now is much smaller and its responsibilyity is much more organized.
class Player
  attr_accessor :move, :name
  
  def initialize
    set_name
  end
  
end

class Human < Player
  def set_name
    person = nil
      loop do
        puts "What is your name?"
        person = gets.chomp
        break unless person.empty?
        puts "You must enter a name."
      end
      self.name = person
  end
  
  def choose
    choice = nil
      loop do
        puts "------------------------------------------"
        puts "Please choose rock, paper or scissors"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include?(choice)
        puts "You must enter either rock paper or scissors"
      end
      self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = ["R2D2", "Optimus Prime", "Megatron", "Johnny5", "Terminator"].sample
  end
  
  def choose
    self.move = ["rock", "paper", "scissors"].sample
  end
end

class RPSGame
  attr_accessor :human, :computer
  
  def initialize
    @human = Human.new 
    @computer = Computer.new
  end
  
  def display_welcome_message
    puts "Welcome to Rock,Paper,Scissors #{human.name}!"
  end
  
  def display_winner
    puts "------------------------------------------"
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
    
    case human.move
    when "rock" 
      puts "It's a Tie." if computer.move == 'rock'
      puts "#{human.name} won!" if computer.move == 'scissors'
      puts "#{computer.name} won!" if computer.move == 'paper'
    when "paper"
      puts "It's a Tie." if computer.move == 'paper'
      puts "#{human.name} won" if computer.move == 'rock'
      puts "#{computer.name} Won!" if computer.move == 'scissors'
    when "scissors"
      puts "It's a Tie" if computer.move == 'scissors'
      puts "#{human.name} won." if computer.move == 'paper'
      puts "#{computer.name} won." if computer.move == 'rock'
    end
    puts "------------------------------------------"
  end
  
  def display_goodbye_message
    puts "Thanks for Playing #{human.name}. Good-Bye."
  end
  
  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?(y/n)"
      answer = gets.chomp
      break if ['y','n'].include?(answer.downcase) 
      puts "You must enter the letter 'y' or 'n'."
    end
    
    return true if answer == 'y'
    return false
  end
  
  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    puts "------------------------------------------"
    display_goodbye_message
  end
  
end

RPSGame.new.play
