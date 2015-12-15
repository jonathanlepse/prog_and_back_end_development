greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings # => {a: 'hi there'} b/c line 3 is destructive so it effects the varibale everywhere

# greetings is pointing to a space in memeory, informal_greetings is pointing to the greetings key, so when you change this variable with a destructive method it gets changes everywhere.