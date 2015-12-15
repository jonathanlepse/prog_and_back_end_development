def tricky_method_two(a_string_param, an_array_param)
  a_string_param.gsub!('pumpkins', 'rutabaga')
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}" #=> "rutabaga" gsub with bang operator is destructive so string now gets changes everywhere
puts "My array looks like this now: #{my_array}" #=> ["pumpkins"] only the method call reassigns this array varibale outside the method my_array does not change.