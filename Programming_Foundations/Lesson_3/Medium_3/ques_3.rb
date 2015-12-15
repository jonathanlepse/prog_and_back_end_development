def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}" => "pumpkins" # this is not destrcutive so the string does not change
puts "My array looks like this now: #{my_array}" => ["pumpkins", "rutabaga"] # this is destructive to the array changes