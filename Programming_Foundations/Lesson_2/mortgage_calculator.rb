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
end

display("Welcome to your mortgage signing.")

display("How big of a mortgage do your need?")
original_loan_amount = gets.chomp
validate(original_loan_amount)

display("What duration would you like to apply for? (in years)")
loan_duration = gets.chomp
validate(loan_duration)

display("What interest rate would you like to be charged?")
interest_rate = gets.chomp
validate(interest_rate)

loan_duration_in_months = loan_duration.to_i * MONTHS_IN_YEAR
apr = interest_rate.to_f / PERCENTAGE
monthly_interest = original_loan_amount.to_i * apr / MONTHS_IN_YEAR
monthly_payment = (original_loan_amount.to_i / loan_duration_in_months) + (original_loan_amount.to_i * monthly_interest)

display("This loan should be paid in full in #{loan_duration_in_months} months at a monthy interest rate of: #{monthly_interest}%.")
display("Your monthly payment will be: $#{monthly_payment}")
