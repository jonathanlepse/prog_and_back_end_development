sentence = "Humpty Dumpty sat on a wall."

sentence.split.join.reverse

words = sentence.split(/\W/)
words.reverse!
backwards_sentence = words.join(' ') + '.'