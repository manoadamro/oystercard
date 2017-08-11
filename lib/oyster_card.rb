require './lib/journey'

OPENING_BALANCE = 0
MAX_BALANCE = 90
MIN_BALANCE = 1

LOW_BALANCE = "a minimum balance of £#{MIN_BALANCE} is required.".freeze
EXCEEDED_MAX = "Balance must not exceed £#{MAX_BALANCE}".freeze
EXCEEDED_MIN = 'Balance can not be negative'.freeze

# in lib/oyster_card.rb
class OysterCard
  attr_reader :balance, :journey, :journey_log

  def initialize
    @balance = OPENING_BALANCE
    @journey_log = []
    @journey = nil
  end

  def top_up(amount)
    @balance += amount
    raise EXCEEDED_MAX if @balance > MAX_BALANCE
    puts "topped up £#{amount}. new balance: £#{@balance}"
  end

  def touch_in(station)
    raise LOW_BALANCE if @balance < MIN_BALANCE
    deduct(@journey.fare) unless @journey.nil?
    @journey = Journey.new(station)
    puts 'touched in'
  end

  def touch_out(station)
    @journey = Journey.new(nil) if @journey.nil?
    @journey.finish(station)
    deduct(@journey.fare)
    log_journey
    puts 'touched out'
  end

  def in_journey?
    !@journey.nil?
  end

  private

  def log_journey
    @journey_log << @journey
    @journey = nil
  end

  def deduct(amount)
    @balance -= amount
    puts "Deducting £#{amount} penalty from balance"
    raise EXCEEDED_MIN if @balance < 0
  end
end
