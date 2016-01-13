class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# here self on line 10 is representing the object, it is the same as instantiating an object and then calling that method you are returns there the object_name.age +=