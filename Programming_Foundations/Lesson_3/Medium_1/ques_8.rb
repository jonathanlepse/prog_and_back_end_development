string = "this is my title!"

titleize_words = string.split.each do |word|
  word.capitalize!
end

print titleize_words.join(" ")