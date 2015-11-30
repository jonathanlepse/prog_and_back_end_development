# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

puts "Welcome to Calculator!"

puts "Please enter your first number."
number_1 = gets.chomp
puts number_1

puts "Please enter your second number."
number_2 = gets.chomp
puts number_2

puts "What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide."
operator = gets.chomp

if operator == "1"
  result = number_1.to_i + number_2.to_i
elsif operator == "2"
  result = number_1.to_i - number_2.to_i
elsif operator == "3"
  result = number_1.to_i * number_2.to_i
elsif operator == "4"
  result = number_1.to_f / number_2.to_f
end 

puts result