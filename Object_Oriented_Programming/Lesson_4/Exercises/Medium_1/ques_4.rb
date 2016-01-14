class Greeting
  def greet(string)
    puts "#{string}"
  end
end

class Hello < Greeting
  def hi
    greet("hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("goodbye")
  end
end

hi = Hello.new
hi.hi
bye = Goodbye.new
bye.bye