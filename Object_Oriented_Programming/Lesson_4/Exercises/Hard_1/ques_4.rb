module Something
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Something

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Seacraft
  include Something
  
  attr_accessor :propeller_count, :hull_count
  
  def initialize(propeller_count, hull_count, fuel_effieciency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    @fuel_efficiency = fuel_efficiency
    @fuel_capacity = fuel_capacity
  end
  
  def range
    range_of_fuel = super
    return range_of_fuel + 10
  end
  
end

class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super
  end
end

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1,1,km_traveled_per_liter, liters_of_fuel_capacity)
  end
end