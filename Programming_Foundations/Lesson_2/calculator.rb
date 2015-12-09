# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

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

prompt(MESSAGES['welcome'])
name = gets.chomp
while name.empty?
  prompt(MESSAGES['valid_name'])
  name = gets.chomp
end
  
prompt(MESSAGES['greeting']) # this config file hash does not work correctly b/c you cannot extract string interpolated messages to a config file
  
again = ""
while again != "n"
    
  
  number_1 = ""  # all 3 of these variables need to be initialized here in outerscope b/c you cannot initialize a variable in loop do...end block
  number_2 = ""
  operator = ""

  loop do 
    prompt(MESSAGES['first_number'])
    number_1 = gets.chomp
    
    if valid_number?(number_1)
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end
  
  loop do 
    prompt(MESSAGES['second_number'])
    number_2 = gets.chomp
    
    if valid_number?(number_2)
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end
  
  operator_prompt = <<-MSG # <<- this is a heredoc you can use it to add a message in your code like so notice how there is no space between it <<-(no space here)MSG
  "What operation would you like to perform? Please enter a number 1-4: 
  1) add 
  2) subtract 
  3) multiply 
  4) divide."
  MSG
  # always have to close your heredoc on its own line
  
  prompt(operator_prompt) # calling the heredoc variable
  operator = gets.chomp
  until ("1".."4").include?(operator)
  prompt(MESSAGES['operation'])
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

prompt(MESSAGES['another_calc'])
again = gets.chomp
if again == "y"
  prompt(MESSAGES['recalculate'])
else
  prompt(MESSAGES['good'])
end
end
