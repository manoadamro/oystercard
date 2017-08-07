
OPENING_BALANCE = 0
MAX_BALANCE = 90

# rubocop:disable Style/MutableConstant
LIMIT_EXCEEDED = "Balance must not exceed £#{MAX_BALANCE}."
NO_FUNDS = 'Balance is too low!'

# in lib/oystercard.rb
class Oystercard
  attr_accessor :balance

  def initialize(opening_balance)
    @balance = opening_balance
  end

  def top_up(amount)
    return exceeded_limit if @balance + amount > MAX_BALANCE
    @balance += amount
    true
  end

  def deduct
    return no_funds if @balance - amount < 0
    @balance -= amount
    true
  end

  private

  def exceeded_limit
    raise LIMIT_EXCEEDED
  end

  def no_funds
    raise NO_FUNDS
  end
end
