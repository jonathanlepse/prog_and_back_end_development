def string_tricky(string_param)
  string_param += "rutabaga"
end

def array_tricky!(array_param)
  array_param << "rutabaga"
end

my_string = "pumpkins "
my_array = ["pumpkins"]

new_string = string_tricky(my_string)
new_array = array_tricky!(my_array)

puts "My string looks like this now: #{new_string}"
puts "My array looks like this now: #{new_array}"

