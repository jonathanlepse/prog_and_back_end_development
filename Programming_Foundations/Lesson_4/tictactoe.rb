INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
CHARACTER_LENGTH = 55
MAXIMUM_WINS = 5

def display(msg)
  puts " => #{msg}"
end

def display_divider(character = "=")
  puts character * CHARACTER_LENGTH
end

def display_board(brd)
  system 'clear'
  puts " Player marker :#{PLAYER_MARKER}"
  puts " Computer marker:#{COMPUTER_MARKER}"
  display_divider
  puts " "
  puts "              |             |"
  puts "  #{brd[1]}           | #{brd[2]}           |  #{brd[3]}"
  puts "              |             |"
  puts "--------------+-------------+-----------"
  puts "              |             |"
  puts "  #{brd[4]}           | #{brd[5]}           |  #{brd[6]}"
  puts "              |             |"
  puts "--------------+-------------+-----------"
  puts "              |             |"
  puts "  #{brd[7]}           | #{brd[8]}           |  #{brd[9]}"
  puts "              |             |"
  display_divider
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER } # .keys returns an array, .select here is arrays instance method
end

def player_places_piece!(brd)
  square = ""
  loop do
    display "Please choose a square: (#{empty_squares(brd).join(',')})" # calling .join on an array, returning a string
    square = gets.chomp.to_i # remember gets.chomp gets a string so it must be converted to an integer to use as a key from our new_board hash
    break if empty_squares(brd).include?(square) # here you are inside another method so you have to pass in brd instead of board, the new_board hash will get passed in at the start of player_places_piece method
    display "Please try again, your selection is not currently valid."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def winning_line_combinations
  [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]
  
end

def detect_winner(brd, array, name)
  array.each do |line|
    return "#{name}" if line.all? { |position| brd[position] == PLAYER_MARKER } # reason for return here is b/c this method is used in winner method and you need to return 
    return 'Computer' if line.all? { |position| brd[position] == COMPUTER_MARKER }
  end
  nil # must return nil b/c the loop on line 92 breaks on an or boolean so if nobody wins this method must return false in order to evaluate one side of line 92 to false
end

def winner?(brd, name)
  !!detect_winner(brd, winning_line_combinations, name) # !! will turn this method into a boolean which we need b/c we are asking winner? on line 102 so we need a true or false, a tie will return nil which is not truthy so the if statement below will not execute.
end

display "Please enter your name:"
player_name = gets.chomp

win_counter = 0
play_again = ''
loop do
  board = initialize_board
  
  loop do
    display_board(board)
    player_places_piece!(board)
    display_board(board)
    break if winner?(board, player_name) || board_full?(board)
    computer_places_piece!(board)
    display_board(board)
    break if winner?(board, player_name) || board_full?(board)
  end
  
  if winner?(board, player_name)
    display_divider
    display "#{detect_winner(board, winning_line_combinations, player_name)} wins!" #this detect_winner method is not using all its params it still needs them all listed
    if detect_winner(board, winning_line_combinations, player_name) == "#{player_name}" || 'Computer'
      win_counter+=1
        if win_counter == MAXIMUM_WINS
          display "#{detect_winner(board, winning_line_combinations, player_name)} is the first to 5 wins!."
          break
        end
    end
  else
    display "It's a tie!"
  end
  
  display "Would you like to play again? (y/n)"
  display_divider
  play_again = gets.chomp
  break unless play_again.downcase.start_with?("y")
end

display "Thanks for playing. See you next time."
