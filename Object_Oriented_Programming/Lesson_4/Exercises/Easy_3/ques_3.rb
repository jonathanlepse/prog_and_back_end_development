class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name 
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

kitty = AngryCat.new(10, "Mr.Boots")
cat = AngryCat.new(5, "Whiskers")