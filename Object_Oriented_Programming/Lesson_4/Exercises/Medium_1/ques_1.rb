class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0 # @ sign not needed here b/c you are no longer calling the instance method(although you could) you are calling the getter method given to you by the attr_reader
  end
end