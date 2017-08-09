
require './lib/journey'

MAX_BALANCE = 90
MIN_BALANCE = 0

LIMIT_EXCEEDED = "Balance must not exceed £#{MAX_BALANCE}.".freeze
NO_FUNDS = 'Balance is too low!'.freeze
MINIMUM_FUNDS_REQUIRED = "A balance of £#{JOURNEY_COST} is required".freeze

ALREADY_IN_JOURNEY = 'Card is already in journey'.freeze
NOT_IN_JOURNEY = 'Card not in journey'.freeze

TOUCHED_IN = 'touched in!'.freeze
TOUCHED_OUT = 'touched out!'.freeze

# in lib/oystercard.rb
class Oystercard
  attr_reader :balance, :journeys, :current_journey

  def initialize(opening_balance = MIN_BALANCE)
    @balance = opening_balance
    @current_journey = nil
    @journeys = []
    puts "Created Oystercard #{self}"
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
    @current_journey = Journey.new(station)
    puts TOUCHED_IN
  end

  def touch_out(station)
    @current_journey = Journey.no_touch_in unless in_journey?
    log_journey(station)
    deduct(@current_journey.fare)
    @current_journey = nil
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
    !@current_journey.nil?
  end

  private

  def log_journey(exit_station)
    @journeys << { entry: @current_journey.entry_station, exit: exit_station }
    puts TOUCHED_OUT
    puts "journey completed #{@current_journey.entry_station} > #{exit_station}"
  end

  def deduct(amount)
    raise NO_FUNDS if empty?(@balance - amount)
    @balance -= amount
    puts "deducted #{amount} from balance."
    puts "new balance: #{@balance}."
  end
end
