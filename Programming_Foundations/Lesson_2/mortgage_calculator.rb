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

display("Welcome to your mortgage signing.")

display("How big of a mortgage do you need?")
original_loan_amount = gets.chomp
original_loan_amount = validate(original_loan_amount) # by setting this variable to the valid value returned by the method you can work with a validated number in your calculations below

display("What duration would you like to apply for? (in years)")
loan_duration = gets.chomp
loan_duration = validate(loan_duration) # same here setting variable to valid value

display("What interest rate would you like to be charged?")
interest_rate = gets.chomp
interest_rate = validate(interest_rate) # same here setting variable to valid value

loan_duration_in_months = loan_duration.to_i * MONTHS_IN_YEAR
apr = interest_rate.to_f / PERCENTAGE
monthly_interest = original_loan_amount.to_i * apr / MONTHS_IN_YEAR
monthly_payment = (original_loan_amount.to_i / loan_duration_in_months) + (original_loan_amount.to_i * monthly_interest)

display("This loan should be paid in full in #{loan_duration_in_months} months at a monthy interest rate of: #{monthly_interest}%.")
display("Your monthly payment will be: $#{monthly_payment}")
