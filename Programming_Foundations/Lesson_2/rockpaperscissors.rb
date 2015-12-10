VALID_CHOICES = %w('rock', 'paper', 'scissors')

def prompt(message)
  puts "=> #{message}"
end

  # seperated display messages for clarity
  def display_winning_message(choice, computer_choice)
    if (choice == 'rock' && computer_choice == 'scissors') ||
       (choice == 'paper' && computer_choice == 'rock') ||
       (choice == 'scissors' && computer_choice == 'paper')
      prompt("You Won!")
    end
  end

  def display_tie_message(choice, computer_choice)
    if (choice == 'rock' && computer_choice == 'rock') ||
       (choice == 'paper' && computer_choice == 'paper') ||
       (choice == 'scissors' && computer_choice == 'scissors')
      prompt("It's a tie.")
    end
  end

  def display_losing_message(choice, computer_choice)
    if (choice == 'scissors' && computer_choice == 'rock') ||
       (choice == 'rock' && computer_choice == 'paper') ||
       (choice == 'paper' && computer_choice == 'scissors')
      prompt("The computer wins!")
    end
  end

loop do
  choice = ''
  loop do
    prompt("Choose One: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("Thats not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}.\nThe computer chose: #{computer_choice}.")

  display_winning_message(choice, computer_choice)
  display_losing_message(choice, computer_choice)
  display_tie_message(choice, computer_choice)

  prompt("Do you want to play again? (y/n)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
