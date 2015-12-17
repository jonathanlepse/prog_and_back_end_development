INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
CHARACTER_LENGTH = 55
WINNING_LINES = [
                  [1, 2, 3], [4, 5, 6], [7, 8, 9],
                  [1, 4, 7], [2, 5, 8], [3, 6, 9],
                  [1, 5, 9], [3, 5, 7]
                ]

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

def easy_level_computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def find_at_risk_square(line, brd, marker) # line that gets passed into this method comes from the line variable in the block of all the computer_places_piece! methods (lines 73, 87)
  if brd.values_at(*line).count(marker) == 2
    brd.select{ |k, v| line.include?(k) && v == ' ' }.keys.first
  else
    nil # nil needed here in case if statemet does not execute this method will return nil so loop on line 75 will break, is this nessessary? b/c an empty method will return nil also 
  end
end

def medium_level_computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, PLAYER_MARKER) # if if statement on line 66 does not execute this square variable should return nil anyway b/c empty method returns nil
    break if square
  end

  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def hard_level_computer_places_piece!(brd)
    square = nil

  # defense first
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, PLAYER_MARKER)
    break if square
  end

  # offense
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, COMPUTER_MARKER)
      break if square
    end
  end

  # just pick a square
  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def detect_winner(brd, array, name)
  array.each do |line|
    if brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
      return "#{name}" 
    elsif brd[line[0]] == COMPUTER_MARKER &&
          brd[line[1]] == COMPUTER_MARKER &&
          brd[line[2]] == COMPUTER_MARKER
      return 'Computer'
    end
  end
  nil 
end

def winner?(brd, name)
  !!detect_winner(brd, WINNING_LINES, name) 
end

display "Please enter your name:"
player_name = gets.chomp

  display "Would you like to play this game on easy, meduim, or hard?"
  game_difficulty = gets.chomp
  until ["easy", "medium", "hard"].include?(game_difficulty)
  display "You must choose either easy, medium or hard"
  game_difficulty = gets.chomp
  end

case game_difficulty
when "easy"
  win_counter = 0
  play_again = ''
  loop do
    board = initialize_board
    
    loop do
      display_board(board)
      player_places_piece!(board)
      display_board(board)
      break if winner?(board, player_name) || board_full?(board)
      easy_level_computer_places_piece!(board)
      display_board(board)
      break if winner?(board, player_name) || board_full?(board)
    end
    
    if winner?(board, player_name)
      display_divider
      display "#{detect_winner(board, WINNING_LINES, player_name)} wins!"
        if detect_winner(board, WINNING_LINES, player_name) == "#{player_name}" ||
           detect_winner(board, WINNING_LINES, player_name) == 'Computer'
          win_counter+=1
           if win_counter == 5
             display "#{detect_winner(board, WINNING_LINES, player_name)} is the first to 5 wins!."
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
  
  display "Thanks for playing Tic Tac Toe easy version. See you next time."
  
when "medium"
  win_counter = 0
  play_again = ''
  loop do
    board = initialize_board
    
    loop do
      display_board(board)
      player_places_piece!(board)
      display_board(board)
      break if winner?(board, player_name) || board_full?(board)
      medium_level_computer_places_piece!(board)
      display_board(board)
      break if winner?(board, player_name) || board_full?(board)
    end
    
    if winner?(board, player_name)
      display_divider
      display "#{detect_winner(board, WINNING_LINES, player_name)} wins!"
        if detect_winner(board, WINNING_LINES, player_name) == "#{player_name}" ||
           detect_winner(board, WINNING_LINES, player_name) == 'Computer'
          win_counter+=1
           if win_counter == 5
             display "#{detect_winner(board, WINNING_LINES, player_name)} is the first to 5 wins!."
             break
           end
        end
    else
      display "It's a tie!"
    end
    
    display "Would you like to play again? (y/n)"
    display_divider()
    play_again = gets.chomp
    break unless play_again.downcase.start_with?("y")
  end
  
  display "Thanks for playing Tic Tac Toe medium version. See you next time."

when "hard"
  win_counter = 0
  play_again = ''
  loop do
    board = initialize_board
    
    loop do
      display_board(board)
      player_places_piece!(board)
      display_board(board)
      break if winner?(board, player_name) || board_full?(board)
      hard_level_computer_places_piece!(board)
      display_board(board)
      break if winner?(board, player_name) || board_full?(board)
    end
    
    if winner?(board, player_name)
      display_divider
      display "#{detect_winner(board, WINNING_LINES, player_name)} wins!"
        if detect_winner(board, WINNING_LINES, player_name) == "#{player_name}" ||
           detect_winner(board, WINNING_LINES, player_name) == 'Computer'
          win_counter+=1
           if win_counter == 5
             display "#{detect_winner(board, WINNING_LINES, player_name)} is the first to 5 wins!."
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
  
  display "Thanks for playing Tic Tac Toe hard version. See you next time."
end
