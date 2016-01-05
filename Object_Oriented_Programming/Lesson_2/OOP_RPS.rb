class Player
  attr_accessor :move, :name
  
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end
  
  def set_name
    if human?
      person = nil
      loop do
        puts "What is your name?"
        person = gets.chomp
        break unless person.empty?
        puts "You must enter a name."
      end
      self.name = person # by calling the setter method here you are allowing the name to be set everytime you play instead of hardcoding it in the initialize method, then b/c you have an attr_accessor wherever you instantiate an object below you have access to the getter to call the name(see line 65 for example.)
    else
      self.name = ["R2D2", "Optimus Prime", "Megatron", "Johnny5", "Terminator"].sample
    end
  end
  
  def choose
    if human?
      choice = nil
      loop do
        puts "------------------------------------------"
        puts "Please choose rock, paper or scissors"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include?(choice)
        puts "You must enter either rock paper or scissors"
      end
      self.move = choice
    else
      self.move = ["rock", "paper", "scissors"].sample
    end
  end
  
  def human?
    @player_type == :human
  end
end

class RPSGame
  attr_accessor :human, :computer
  
  def initialize
    @human = Player.new # player class constructor method has a default papramter so we can leave this blank, by instantiateing an object from the player class in this class you are giving the player object access to all its instance methods inside of this class BUT ONLY THE PLAYER OBJECT HAD DIRECT ACCESS TO THE PLAYER CLASS INSTANCE METHODS.
    @computer = Player.new(:computer)
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
      puts "#{human.name}Won" if computer.move == 'rock'
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
