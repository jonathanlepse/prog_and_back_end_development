class InvoiceEntry
  attr_reader :product_name
  attr_accessor :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0 # nothing wrong with this code syntactically but using an attr_accessor allows a client to change a value directly, circumventing this update quantity method altogether, whcih can be an issue.
  end
end