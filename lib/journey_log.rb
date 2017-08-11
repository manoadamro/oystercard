
# in lib/journey_log.rb
class JourneyLog
  def initialize(journey_class_type)
    @klass = journey_class_type
    @current = nil
  end

  def start(station)
    current_journey.start(station)
  end

  def journeys; end

  def finish(station)
    current_journey.finish(station)
  end

  private

  def current_journey
    @current = @klass.new if @current.nil?
    @current
  end
end
