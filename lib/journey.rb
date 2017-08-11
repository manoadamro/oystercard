
STANDARD_FARE = 1
PENALTY_FARE = 6

#
class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def fare
    @entry_station.nil? || @exit_station.nil? ? PENALTY_FARE : STANDARD_FARE
  end

  def start(entry_station)
    @entry_station = entry_station
    self
  end

  def finish(station)
    @exit_station = station
    self
  end
end
