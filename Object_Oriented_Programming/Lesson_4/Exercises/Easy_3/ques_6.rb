class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1 # we could remove the self prefix here and just call the instance method directly like so @age you cannot call the getter method and try to alter it you either have to reference the setter method or use the instance variable driectly.
  end
end

cat = Cat.new("tabby")
puts cat.age
cat.make_one_year_older
puts cat.age