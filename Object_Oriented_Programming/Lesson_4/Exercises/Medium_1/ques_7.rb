class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information # as a ruby coding tip do not include the class name when difing method defininitons, its repetiitve
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end