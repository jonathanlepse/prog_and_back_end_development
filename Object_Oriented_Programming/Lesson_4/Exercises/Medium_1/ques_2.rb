class InvoiceEntry
  attr_reader :quantity, :product_name # this needs to be changed to attr_accessor :quantity so you can use the setter.

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0 # this line need self prepended onto it b/c otherwise you are calling the getter method and trying to set it from the getter method, cannot be done.
  end
end