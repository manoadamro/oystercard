require 'oystercard'

EXAMPLE_AMOUNT = 10

# rubocop:disable Metrics/BlockLength

# in spec/oystercard_spec.rb
describe Oystercard do
  subject { Oystercard.new }
  let(:station) { Station.new('aldgate', 1) }

  describe '#balance' do
    it 'should respond to balance' do
      expect(subject).to respond_to(:balance)
    end
  end

  describe '#journeys' do
    it 'should respond to journeys' do
      expect(subject).to respond_to(:journeys)
    end

    it 'should have no journeys by default' do
      expect(subject.journeys.empty?).to eq(true)
    end
  end

  describe '#top_up' do
    it 'should respond to top_up' do
      expect(subject).to respond_to(:top_up)
    end

    it "should have starting balance of #{MIN_BALANCE}" do
      expect(subject.balance).to eq(MIN_BALANCE)
    end

    it 'should be able to set a opening balance' do
      expect(Oystercard.new(EXAMPLE_AMOUNT).balance).to(
        eq(EXAMPLE_AMOUNT)
      )
    end

    it 'should be able to add to balance' do
      expect { subject.top_up(EXAMPLE_AMOUNT) }.to(
        change { subject.balance }.by(EXAMPLE_AMOUNT)
      )
    end

    it 'should not exceed maximum balance' do
      expect { subject.top_up(MAX_BALANCE + 1) }.to(
        raise_error(LIMIT_EXCEEDED)
      )
    end
  end

  describe '#in_journey?' do
    it 'should respond to in_journey?' do
      expect(subject).to respond_to(:in_journey?)
    end

    it 'should not start in journey' do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#empty?' do
    it 'should respond to empty?' do
      expect(subject).to respond_to(:empty?)
    end
  end

  describe '#minimum?' do
    it 'should respond to empty?' do
      expect(subject).to respond_to(:minimum?)
    end
  end

  describe '#limit?' do
    it 'should respond to empty?' do
      expect(subject).to respond_to(:limit?)
    end
  end

  describe '#touch_in' do
    it 'should respond to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'should raise error if in journey' do
      allow(subject).to receive(:in_journey?).and_return(EXAMPLE_STATION)
      expect { subject.touch_in(station) }.to(
        raise_error(ALREADY_IN_JOURNEY)
      )
    end

    it 'should create journey' do
      subject.top_up(EXAMPLE_AMOUNT)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'should raise error if funds below minimum' do
      expect { subject.touch_in(station) }.to(
        raise_error(MINIMUM_FUNDS_REQUIRED)
      )
    end

    it 'should record currrent journey' do
      subject.top_up(EXAMPLE_AMOUNT)
      subject.touch_in(station)
      expect(subject.current_journey.nil?).to eq(false)
    end
  end

  describe '#touch_out' do
    it 'should respond to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'should clear cuurent journey' do
      subject.top_up(EXAMPLE_AMOUNT)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.current_journey).to eq(nil)
    end

    it 'should clear journey' do
      subject.top_up(EXAMPLE_AMOUNT)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq(false)
    end

    it 'should log journey' do
      subject.top_up(EXAMPLE_AMOUNT)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to(
        change { subject.journeys.length }.by(1)
      )
    end

    it 'should deduct minimum amount from balance' do
      subject.top_up(EXAMPLE_AMOUNT)
      subject.touch_in(station)
      cost = -JOURNEY_COST
      expect { subject.touch_out(station) }.to(
        change { subject.balance }.by(cost)
      )
    end

    it 'should issue fine' do
      subject.top_up(EXAMPLE_AMOUNT)
      expect { subject.touch_out(EXAMPLE_STATION) }.to(
        change { subject.balance }.by(-FINE_COST)
      )
    end
  end
end
