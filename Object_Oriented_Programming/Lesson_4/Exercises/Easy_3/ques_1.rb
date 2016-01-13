class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new
puts hello.hi


hello = Hello.new
puts hello.bye # return error b/c hello object does not have access to goodbye class


hello = Hello.new
puts hello.greet # error b/c not enough arguments given to greet


hello = Hello.new
puts hello.greet("Goodbye") # puts goodbye to the screen


puts Hello.hi # error hi is not a class method