class Fruit
  def initialize(name)
    name = name # could add an attr_reader :name to this class and then call self.name = name here
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# the pizza class has an instance variable, it can be seen with an @ symbol in front of it. The fruit class has a local variable set. 