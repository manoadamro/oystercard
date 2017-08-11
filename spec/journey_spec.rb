require 'journey'

# rubocop:disable Metrics/BlockLength

describe Journey do
  let(:station) { double(:station) }
  subject { Journey.new(station) }

  describe '#initialize' do
    it 'should respond to entry_station' do
      expect(subject).to respond_to(:entry_station)
    end

    it 'should respond to exit_station' do
      expect(subject).to respond_to(:exit_station)
    end

    it 'should have nil exit_station by default' do
      expect(subject.exit_station).to eq(nil)
    end

    it 'should set entry_station' do
      expect(subject.entry_station).to eq(station)
    end
  end

  describe '#start' do
    it 'should set entry_station' do
      subject.start('station')
      expect(subject.entry_station).to eq('station')
    end
  end

  describe '#fare' do
    it 'should respond to fare' do
      expect(subject).to respond_to(:fare)
    end

    it 'should return standard fare' do
      subject.finish(station)
      expect(subject.fare).to eq(STANDARD_FARE)
    end

    it 'should return penalty fare' do
      expect(Journey.new(nil).fare).to eq(PENALTY_FARE)
    end
  end
end
