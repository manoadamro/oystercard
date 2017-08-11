
# in lib/journey_log.rb
class JourneyLog
  def initialize(journey_class )
    @klass = journey_class
    @log = []
    @current = nil
  end

  def start(station)
    @current.start(station)
  end

  def journeys; end

  def finish(station)
    @current.finish(station)
    yield
    @log << @current
    @current = nil
  end

  private

  def current_journey
    @current.nil? ? @klass.new : @current
  end
end
