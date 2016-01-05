class Move
  VALUES = ['rock', 'paper', 'scissors']
  def initialize(value)
    @value = value
  end
  
  def scissors?
    @value == 'scissors'
  end
  
  def rock?
    @value == 'rock'
  end
  
  def paper?
    @value == 'paper'
  end
  
  def >(other_move)
    if rock?
      return true if other_move.scissors?
      return false
    elsif paper?
      return true if other_move.rock?
      return false
    elsif scissors?
      return true if other_move.paper?
      return false
    end
  end
  
  def <(other_move)
    if rock?
      return true if other_move.paper?
      return false
    elsif paper?
      return true if other_move.scissors?
      return false
    elsif scissors?
      return true if other_move.rock?
      return false
    end
  end
  
  def to_s # this to_s method must be written in this class b/c we set the move instance variable from the player class equal to objects of this Move class and now we need to override to_s so it will return a value for us on string interpolation and not an object id
    @value
  end
end

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
      self.name = person # this will still string interpolate b/c it is set to a value of the person variable
  end
  
  def choose
    choice = nil
      loop do
        puts "------------------------------------------"
        puts "Please choose rock, paper or scissors"
        choice = gets.chomp
        break if Move::VALUES.include?(choice)
        puts "You must enter either rock paper or scissors"
      end
      self.move = Move.new(choice) # this will no longer string interpolate a value b/c it is now set to an object insetad, you need to override a to_s method in the Move class to get a value to be displayed on string interpolation
  end
end

class Computer < Player
  def set_name
    self.name = ["R2D2", "Optimus Prime", "Megatron", "Johnny5", "Terminator"].sample
  end
  
  def choose
    self.move = Move.new(Move::VALUES.sample) # this will no longer string interpolate a value b/c it is now set to an object insetad, you need to override a to_s method in the MOve class to get a value to be displayed on string interpolation
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
    puts "#{human.name} chose #{human.move}" # here we are now overriding the built in to_s and using our own to_s written in the move class b/c human.move returns an object and not a value b/c we set it equal to a new object of the Move class
    puts "#{computer.name} chose #{computer.move}"# here we are now overriding the built in to_s and using our own to_s written in the move class b/c human.move returns an object and not a value b/c we set it equal to a new object of the Move class
    
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
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
