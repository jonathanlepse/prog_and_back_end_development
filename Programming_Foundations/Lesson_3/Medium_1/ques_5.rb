def factors(number)
  dividend = number if number > 0
  divisors = []
  begin
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end until dividend == 0
  divisors
end

def factors(number)
  dividend = number if number > 0
  divisors = []
  while dividend > 0 do
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end 
  divisors
end

number % dividend == 0 # validation check to make sure divisors evenly divide into the number

divisors # this allows this method to execute all of this code but ultimately just return an array of all the divisors of a number