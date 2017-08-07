
require './lib/oystercard'

# Create an oystercard object
card = Oystercard.new

# print the balance
puts "1) current balance: #{card.balance}"

# top up with 5
puts '2) topping up card with 5 credits'
card.top_up(5)

# print the new balance
puts "3) new balance: #{card.balance}"
