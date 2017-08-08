
MAX_BALANCE = 90
MIN_BALANCE = 0
OPENING_BALANCE = 0

LIMIT_EXCEEDED = "Balance must not exceed £#{MAX_BALANCE}.".freeze
NO_FUNDS = 'Balance is too low!'.freeze
ALREADY_IN_JOURNEY = 'Card is already in journey'.freeze
NOT_IN_JOURNEY = 'Card not in journey'.freeze

class Journey; end

# in lib/oystercard.rb
class Oystercard
  attr_reader :balance, :journeys

  def initialize(opening_balance = OPENING_BALANCE)
    @balance = opening_balance
    @journey = nil
    @journeys = []
  end

  def top_up(amount)
    raise LIMIT_EXCEEDED if limit?(@balance + amount)
    @balance += amount
    puts "added #{amount} to balance."
    puts "new balance: #{@balance}."
  end

  def deduct(amount)
    raise NO_FUNDS if empty?(@balance - amount)
    @balance -= amount
    puts "deducted #{amount} from balance."
    puts "new balance: #{@balance}."
  end

  def touch_in
    raise ALREADY_IN_JOURNEY if in_journey?
    @journey = Journey.new
    puts 'touched in!'
  end

  def touch_out
    raise NOT_IN_JOURNEY unless in_journey?
    @journeys << @journey
    @journey = nil
    puts 'touched out!'
  end

  def limit?(amount)
    amount > MAX_BALANCE
  end

  def empty?(amount)
    amount < MIN_BALANCE
  end

  def in_journey?
    !@journey.nil?
  end
end
