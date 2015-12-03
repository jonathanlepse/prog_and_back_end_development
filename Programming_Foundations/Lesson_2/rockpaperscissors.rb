VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message)
  puts "=> #{message}"
end

def display_message(choice, computer_choice)
  if (choice == 'rock' && computer_choice == 'scissors') ||
     (choice == 'paper' && computer_choice == 'rock') ||
     (choice == 'scissors' && computer_choice == 'paper')
    prompt("You Won!")
  elsif (choice == 'rock' && computer_choice == 'rock') ||
        (choice == 'paper' && computer_choice == 'paper') ||
        (choice == 'scissors' && computer_choice == 'scissors')
    prompt("It's a tie.")
  else
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
  
  display_message(choice, computer_choice)
  
  prompt("Do you want to play again? (y/n)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end