class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# the @@cats_count variable is a class variable only one copy is shared by by the entire class and all objects of that class.

cat = Cat.new("tabby")
Cat.cats