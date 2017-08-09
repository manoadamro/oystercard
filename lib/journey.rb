
JOURNEY_COST = 1
FINE_COST = 6

UNKNOWN_ENTRY = 'unknown'.freeze

# in lib/journey.rb
class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    if @entry_station == UNKNOWN_ENTRY
      puts "You have been fined £#{FINE_COST} for not touching in!"
      FINE_COST
    else
      JOURNEY_COST
    end
  end

  def complete?
    !@exit_station.nil?
  end

  def self.no_touch_in
    Journey.new(UNKNOWN_ENTRY)
  end
end
