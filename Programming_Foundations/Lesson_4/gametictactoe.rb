INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
CHARACTER_LENGTH = 55

def display(msg)
  puts " => #{msg}"
end

def format(character = "=")
  puts character * CHARACTER_LENGTH
end

def display_board(brd)
  system 'clear'
  puts " Player marker :#{PLAYER_MARKER}"
  puts " Computer marker:#{COMPUTER_MARKER}"
  format
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
  format
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER } 
end

def player_places_piece!(brd)
  square = ""
  loop do
    display "Please choose a square: (#{empty_squares(brd).join(',')})" 
    square = gets.chomp.to_i 
    break if empty_squares(brd).include?(square) 
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
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]
  winning_lines
end

def detect_winner(brd, array, name)
  array.each do |line|
    if brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
      return name 
    elsif brd[line[0]] == COMPUTER_MARKER &&
          brd[line[1]] == COMPUTER_MARKER &&
          brd[line[2]] == COMPUTER_MARKER
      return 'Computer'
    end
  end
  nil 
end

def winner?(brd)
  !!detect_winner(brd, winning_line_combinations, player_name) 
end

display "Please enter your name:"
player_name = gets.chomp

play_again = ''
loop do
  board = initialize_board
  
  loop do
    display_board(board)
    player_places_piece!(board)
    display_board(board)
    break if winner?(board) || board_full?(board)
    computer_places_piece!(board)
    display_board(board)
    break if winner?(board) || board_full?(board)
  end
  
  if winner?(board)
    format
    display "#{detect_winner(board, winning_line_combinations, player_name)} wins!"
  else
    display "It's a tie!"
  end
  
  display "Would you like to play again? (y/n)"
  format
  play_again = gets.chomp
  break unless play_again.downcase.start_with?("y")
end

display "Thanks for playing. See you next time."