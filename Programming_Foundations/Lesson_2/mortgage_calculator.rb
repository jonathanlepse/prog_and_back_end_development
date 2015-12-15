MONTHS_IN_YEAR = 12
PERCENTAGE = 100.0

def display(msg)
  puts "#{msg}"
end

def validate(num)
  until num =~ /\A\d+\Z/
    display("Please try again. This time do not add any special characters to your numbers. (i.e. $, %)")
    num = gets.chomp
  end
  num # by extracting this to a method you must return the num so when you call the method below it returns a value, your vairables below are then set to this valid value
end

def format
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
end

display("Welcome to your mortgage signing.")

display("How big of a mortgage do you need?")
original_loan_amount = gets.chomp
original_loan_amount = validate(original_loan_amount) # by setting this variable to the valid value returned by the method you can work with a validated number in your calculations below

display("What duration would you like to apply for? (in years)")
loan_duration = gets.chomp
loan_duration = validate(loan_duration) # same here setting variable to valid value

mortgage_rates = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10]
interest_rate = mortgage_rates.sample
format
display("You will charged an interest rate of: #{interest_rate}% for this loan.")

loan_duration_in_months = loan_duration.to_i * MONTHS_IN_YEAR
apr = interest_rate / PERCENTAGE
monthly_interest = original_loan_amount.to_i * apr / MONTHS_IN_YEAR
monthly_payment = (original_loan_amount.to_i / loan_duration_in_months) + monthly_interest
time = Time.now

display("This loan should be paid in full on: #{time + (60 * 60 * 24 * 365 * loan_duration.to_i)}.")
display("Your monthly payment will be: $#{sprintf('%0.2f', monthly_payment)}")
format
