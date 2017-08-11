require 'journey'

# rubocop:disable Metrics/BlockLength

describe Journey do
  let(:station) { double(:station, :zone =>1) }
  let(:station2) { double(:station2, :zone => 2) }
  let(:station3) { double(:station3, :zone => 3) }
  let(:station4) { double(:station4, :zone => 4) }
  let(:station5) { double(:station5, :zone => 5) }
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
      subject.start(station)
      expect(subject.entry_station).to eq(station)
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

    it 'should calculate fare based on zones' do
      subject.start(station)
      subject.finish(station5)
      value = subject.send(:zone_calc)
      expect(value).to eq 5
    end
  end
end
