class Board
  WINNING_LINES = [ [1,2,3], [4,5,6], [7,8,9],
                    [1,4,7], [2,5,8], [3,6,9],
                    [1,5,9], [3,5,7],
                  ]  
  def initialize
    @squares = {}
    reset
  end
  
  def []=(num, marker) #this method is not an override of the hash[]= method b/c our board object is just that an object of Board class, the state of that object(i var) happens to be a hash object. the i var has access to hashs instance methods b/c its a hash object, our board object DOES NOT, it is simply a BOard class object. which is why we are creating this method here to set the values in our i var hash, this method returns the i var and allows us to set the key, value pairs, we can then call our board object on this []= method.
    @squares[num].marker = marker
  end
  
  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end
  
  def full?
    unmarked_keys.empty?
  end
  
  def someone_won?
    !!winning_marker # this is going to return the boolean value of detect winner which we need for this method
  end
  
  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end
  
  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER) # not representing the squares getter method here, there is no squares getter method.
  end
  
  def winning_marker
    WINNING_LINES.each do |line|
      if count_human_marker(@squares.values_at(*line)) == 3 # the splat operator here gives line[0] line[1] line[2] here when we pass in line.
        return TTTGame::HUMAN_MARKER
      elsif count_computer_marker(@squares.values_at(*line)) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end
  
  def reset
    (1..9).each { |key| @squares[key] = Square.new}
  end
  
  def draw # drawing the board is a board responsibily and belongs here, now we can call it anywhere we need to below, b/c we've abstarcted it away to the board class. we also no longer need the Board#get_squares_at method b/c that only returned the @squares[key], which we can now call directly b/c @squares is avail. to the draw method b/c there in the same class
    puts "     |     |     "
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
    puts "     |     |     "
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker
  
  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end
  
  def to_s
    @marker # again just like RPS game calling string interpolation on a square object returns object id so we need to override to_s in the objects class and call the instance variable here
  end
  
  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  
  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  attr_reader :board, :human, :computer
  
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end
  
  def display_welcome_message
    puts "Welcome to TicTacToe!"
    puts ""
  end
  
  def display_goodbye_message
    puts "Thanks for playing TicTacToe. GoodBye."
  end
  
  def display_board
    puts "Human squares are: #{human.marker}"
    puts "Computer squares are: #{computer.marker}"
    puts "--------------------------"
    puts " "
    board.draw
    puts " "
  end
  
  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Choose a square #{board.unmarked_keys.join(",")}:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry that is not a valid choice."
    end
    board.[]=(square, human.marker)
  end
  
  def computer_moves
    board.[]=(board.unmarked_keys.sample, computer.marker)
  end
  
  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker  
      puts "You won!"
    when computer.marker 
      puts "Computer won."
    else
      puts "The board is full."
    end
  end
  
  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?(y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "You must choose 'y' or 'n'"
    end
    answer == 'y'
  end
  
  def clear
    system 'clear'
  end
  
  def reset
    board.reset
    clear
    puts "Lets play again."
    puts " "
  end
  
  def play_again_message
    puts "Lets play again."
    puts " "
  end
  
  def play 
    display_welcome_message
    loop do
      display_board
      loop do
        human_moves
        break if board.someone_won? || board.full?
        computer_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
      play_again_message
    end
    display_goodbye_message
  end
end

game = TTTGame.new
game.play