numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end =>[3,4]

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end => [1,2]

when you modify an array while iterating over it you alter the array thats being iterated over so each iteration is working with a different array, dont modify arrays while iterating through them, only iterate though elements of an array