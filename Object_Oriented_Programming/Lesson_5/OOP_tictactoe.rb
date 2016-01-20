class Board
  WINNING_LINES = [ [1,2,3], [4,5,6], [7,8,9],
                    [1,4,7], [2,5,8], [3,6,9],
                    [1,5,9], [3,5,7],
                  ]  
  def initialize
    @squares = {}
    reset
  end
  
  def get_squares_at(key)
    @squares[key]
  end
  
  def set_square_at(key, mark)
    @squares[key].marker = mark # calling @squares[key] object here so you can call the getter method for marker
  end
  
  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end
  
  def full?
    unmarked_keys.empty?
  end
  
  def someone_won?
    !!detect_winner # this is going to return the boolean value of detect winner which we need for this method
  end
  
  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end
  
  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER) # not representing the squares getter method here, there is no squares getter method.
  end
  
  def detect_winner
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
  
  def display_board(options = {clear_screen: true}) # this means each time system clear will execute unless we pass in false to display board somewhere else
    clear if options[:clear_screen]
    puts "Human squares are: #{human.marker}"
    puts "Computer squares are: #{computer.marker}"
    puts "--------------------------"
    puts " "
    puts "     |     |     "
    puts "  #{board.get_squares_at(1)}  |  #{board.get_squares_at(2)}  |  #{board.get_squares_at(3)}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{board.get_squares_at(4)}  |  #{board.get_squares_at(5)}  |  #{board.get_squares_at(6)}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{board.get_squares_at(7)}  |  #{board.get_squares_at(8)}  |  #{board.get_squares_at(9)}  "
    puts "     |     |     "
    puts " "
  end

  def human_moves
    puts "Choose a square #{board.unmarked_keys.join(",")}:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry that is not a valid choice."
    end
    board.set_square_at(square, human.marker)
  end
  
  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker)
  end
  
  def display_result
    display_board
    case board.detect_winner
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
  
  def play 
    display_welcome_message
    loop do
      display_board(clear_screen: false) # clear_screen is key, false is value. flase gets passed in so system clear will not execute. curly braces are not nessessary here b/c the hash is the last argument passed in so we can omit the curly braces if we want.
      loop do
        display_board
        human_moves
        break if board.someone_won? || board.full?
        computer_moves
        break if board.someone_won? || board.full?
        display_board
      end
      display_result
      break unless play_again?
      puts "Lets play again."
      board.reset
      clear
      puts "Lets play again."
      puts " "
    end
    display_goodbye_message
  end
end

game = TTTGame.new
game.play