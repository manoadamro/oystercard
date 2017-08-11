require 'journey_log'

describe JourneyLog do
  subject { JourneyLog.new(String) }
  # describe '#initialize' {}

  describe '#start' do
    it 'should respond to start' do
      expect(subject).to respond_to(:start)
    end
  end

  describe '#finish' do
    it 'should respond to finish' do
      expect(subject).to respond_to(:finish)
    end
  end

  describe '#journeys' do
    it 'should respond to journeys' do
      expect(subject).to respond_to(:journeys)
    end
  end
end
