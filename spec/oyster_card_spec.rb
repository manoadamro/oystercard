require 'oyster_card'

# rubocop:disable Metrics/BlockLength

# in spec/oyster_card_spec.rb
describe OysterCard do
  let(:station) { double(:station) }

  describe '#balance' do
    it 'responds to balance' do
      expect(subject).to respond_to(:balance)
    end

    it "has opening balance of #{OPENING_BALANCE}" do
      expect(subject.balance).to eq(OPENING_BALANCE)
    end

    it 'can not directly modify balance' do
      expect { subject.balance = 10 }.to raise_error(NoMethodError)
    end

    it 'starts with opening balance' do
      expect(subject.balance).to eq(OPENING_BALANCE)
    end
  end

  describe '#in_journey?' do
    it 'responds to in_journey?' do
      expect(subject).to respond_to(:in_journey?)
    end

    it 'should start false' do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#journeys' do
    it 'should respond to journeys' do
      expect(subject).to respond_to(:journeys)
    end

    it 'should start empty' do
      expect(subject.journeys.length).to eq(0)
    end
  end

  describe '#top_up' do
    it 'responds to top_up' do
      expect(subject).to respond_to(:top_up)
    end

    it 'modifies balance' do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it 'balance can not exceed 90' do
      expect { subject.top_up(91) }.to raise_error(EXCEEDED_MAX)
    end
  end

  describe '#deduct' do
    it 'modifies balance' do
      subject.top_up(5)
      expect { subject.send(:deduct, 3) }.to change { subject.balance }.by(-3)
    end

    it 'should not go below 0' do
      subject.top_up(5)
      expect { subject.send(:deduct, 9) }.to raise_error(EXCEEDED_MIN)
    end
  end

  describe '#touch_in' do
    it 'responds to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'sets journey' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'requires minimum balance' do
      expect { subject.touch_in(station) }.to raise_error(LOW_BALANCE)
    end

    it 'responds to journey' do
      expect(subject).to respond_to(:journey)
    end

    it 'has nil journey by default' do
      expect(subject.journey).to eq(nil)
    end

    it 'sets journey' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.journey).to be_a(Journey)
    end

    it 'penalty fare for no touch out on last journey' do
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_in(station) }.to change { subject.balance }.by(-6)
    end
  end

  describe '#touch_out' do
    it 'responds to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'sets journey false' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq(false)
    end

    it 'charges for journey' do
      subject.top_up(5)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to(
        change { subject.balance }.by(-MIN_BALANCE)
      )
    end

    it 'should log journey' do
      subject.top_up(5)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to(
        change { subject.journeys.length }.by(1)
      )
    end
  end
end
