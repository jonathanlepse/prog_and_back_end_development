class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
  
  def play # adding this play method here will override the inherited play method given to us by the game class, this can be verified by calling ancestors
    "anything goes here"
  end
end

puts Bingo.ancestors