# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i != 0
end

def operation_to_message(op)
  case op
  when '1' then "Adding"
  when '2' then "Subtracting"
  when '3' then "Multiplying"
  when '4' then "Dividing"
  end
end

prompt("Welcome to Calculator! Please enter your name:")
name = gets.chomp
while name.empty?
  prompt("You must enter a name to continue.")
  name = gets.chomp
end
  
prompt("Hi #{name}")
  
again = ""
while again != "n"
    
  
  number_1 = ""
  number_2 = ""
  operator = ""

  loop do 
    prompt("Please enter your first number.")
    number_1 = gets.chomp
    
    if valid_number?(number_1)
      break
    else
      prompt("You must enter a valid number.")
    end
  end
  
  loop do 
    prompt("Please enter your second number.")
    number_2 = gets.chomp
    
    if valid_number?(number_2)
      break
    else
      prompt("You must enter a valid number.")
    end
  end
  
  operator_prompt = <<-MSG # <<- this is a heredoc you can use it to add a message in your code like so notice how there is no space between it <<-(no space here)MSG
  "What operation would you like to perform? Please enter a number 1-4: 
  1) add 
  2) subtract 
  3) multiply 
  4) divide."
  MSG
  
  prompt(operator_prompt) # calling the heredoc variable
  operator = gets.chomp
  until ("1".."4").include?(operator)
  prompt("Please enter a number 1-4 that corresspondes with an operation.")
  operator = gets.chomp
  end
  
  prompt("#{operation_to_message(operator)} the two numbers....")
  
  result = case operator
           when "1" then number_1.to_i + number_2.to_i
           when "2" then number_1.to_i - number_2.to_i
           when "3" then number_1.to_i * number_2.to_i
           when "4" then number_1.to_f / number_2.to_f
           end

prompt("Here are your results #{name}. \nYour calculation is: ~~ #{result} ~~")

prompt("Would you like to try another calculation? (y/n)")
again = gets.chomp
if again == "y"
  prompt("Preparing to recalculate...")
else
  prompt("Good-Bye.")
end
end
