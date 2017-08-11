require 'journey_log'
require 'journey'

# rubocop:disable Metrics/BlockLength

describe JourneyLog do
  subject { JourneyLog.new(Journey) }
  # describe '#initialize' {}

  describe '#journey_log' do
    it 'works' do
      expect(subject).to be_a(JourneyLog)
    end
  end

  describe '#start' do
    it 'should respond to start' do
      expect(subject).to respond_to(:start)
    end
  end

  describe '#finish' do
    it 'should respond to finish' do
      expect(subject).to respond_to(:finish)
    end

    it 'adds end station to Journey' do
      subject.finish('Kings Cross')
      journey = subject.send(:current_journey)
      expect(journey.exit_station).to eq 'Kings Cross'
    end
  end

  describe '#journeys' do
    it 'should respond to journeys' do
      expect(subject).to respond_to(:journeys)
    end
  end

  describe '#current_journey' do
    it 'should create new journey' do
      journey = subject.send(:current_journey)
      expect(journey.entry_station.nil? && journey.exit_station.nil?).to eq true
    end

    it 'should return current journey' do
      subject.start('Victoria')
      journey = subject.send(:current_journey)
      expect(journey.entry_station).to eq 'Victoria'
    end
  end
end
