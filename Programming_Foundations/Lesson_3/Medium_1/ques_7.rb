limit = 15 # not needed here outside the method

def fib(first_num, second_num, limit = 15) # need to add limit as an argument for the method to have access to it.
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"