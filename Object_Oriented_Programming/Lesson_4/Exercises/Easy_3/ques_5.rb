class Television
  def self.manufacturer
    # method logic
  end 

  def model
    # method logic
  end
end


tv = Television.new
tv.manufacturer #returns an error cannot call an object on a class method
tv.model # returns the method logic

Television.manufacturer # returns the methd logic, can call a class on a class name, can also be called without instantiating an object of the class
Television.model # returns an error b/c cannot call a class on an instance method