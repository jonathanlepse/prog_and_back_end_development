statement = "The Flintstones Rock"

#{ "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

hash = {}
letters = ("A".."Z").to_a + ("a".."z").to_a

letters.each do |letter|
  letter_freq = statement.scan(letter).count
  hash[letter] = letter_freq if letter_freq > 0
end

puts hash
  