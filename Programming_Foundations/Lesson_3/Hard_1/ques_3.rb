def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three) # only on this method call does the method body take effect b/c it is not destuctive

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

#vs.

def mess_with_vars(one, two, three) 
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three) # only on this method call does the method body take effect b/c it is not destuctive

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

#vs.

def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three) # gsub with a bang operator is destructive so it effects the variable 

puts "one is: #{one}" # => two
puts "two is: #{two}" #=> three
puts "three is: #{three}" #=> one