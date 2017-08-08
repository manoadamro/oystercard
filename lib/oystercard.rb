
MAX_BALANCE = 90
MIN_BALANCE = 0
OPENING_BALANCE = 0
JOURNEY_COST = 1

LIMIT_EXCEEDED = "Balance must not exceed £#{MAX_BALANCE}.".freeze
NO_FUNDS = 'Balance is too low!'.freeze
MINIMUM_FUNDS_REQUIRED = "A balance of £#{JOURNEY_COST} is required".freeze

ALREADY_IN_JOURNEY = 'Card is already in journey'.freeze
NOT_IN_JOURNEY = 'Card not in journey'.freeze

TOUCHED_IN = 'touched in!'.freeze
TOUCHED_OUT = 'touched out!'.freeze

# in lib/oystercard.rb
class Oystercard
  attr_reader :balance, :journeys

  def initialize(opening_balance = OPENING_BALANCE)
    @balance = opening_balance
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise LIMIT_EXCEEDED if limit?(@balance + amount)
    @balance += amount
    puts "added #{amount} to balance."
    puts "new balance: #{@balance}."
  end

  def touch_in(station)
    raise ALREADY_IN_JOURNEY if in_journey?
    raise MINIMUM_FUNDS_REQUIRED unless minimum?
    @entry_station = station
    puts TOUCHED_IN
  end

  def touch_out(station)
    raise NOT_IN_JOURNEY unless in_journey?
    deduct(JOURNEY_COST)
    @journeys << { start: @entry_station, end: station }
    @entry_station = nil
    puts TOUCHED_OUT
  end

  def limit?(amount)
    amount > MAX_BALANCE
  end

  def empty?(amount)
    amount < MIN_BALANCE
  end

  def minimum?
    @balance >= JOURNEY_COST
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def deduct(amount)
    raise NO_FUNDS if empty?(@balance - amount)
    @balance -= amount
    puts "deducted #{amount} from balance."
    puts "new balance: #{@balance}."
  end
end
