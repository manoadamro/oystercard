require 'oystercard'

# rubocop:disable Metrics/BlockLength

# in spec/oystercard_spec.rb
describe Oystercard do
  subject { Oystercard.new }

  describe '#balance' do
    it 'should respond to balance' do
      expect(subject).to respond_to(:balance)
    end
  end

  describe '#top_up' do
    it 'should respond to top_up' do
      expect(subject).to respond_to(:top_up)
    end
    it 'should set opening_balance' do
      expect(subject.balance).to eq(OPENING_BALANCE)
    end
    it 'should be able to add to balance' do
      opening_balance = subject.balance
      subject.top_up(1)
      expect(subject.balance).to eq(opening_balance + 1)
    end
    it 'should not exceed maximum balance' do
      expect { subject.top_up(91) }.to raise_error(LIMIT_EXCEEDED)
    end
  end

  describe '#deduct' do
    it 'should respond to deduct' do
      expect(subject).to respond_to(:deduct)
    end
    it 'should deduct from balance' do
      subject.top_up(5)
      opening_balance = subject.balance
      subject.deduct(1)
      expect(subject.balance).to eq(opening_balance - 1)
    end
    it 'should not go below zero' do
      expect { subject.deduct(1) }.to raise_error(NO_FUNDS)
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

  describe '#touch_in' do
    it 'should respond to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'should raise error if in journey' do
      allow(subject).to receive(:in_journey?).and_return(true)
      expect { subject.touch_in }.to raise_error(ALREADY_IN_JOURNEY)
    end

    it 'should create journey' do
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end
  end

  describe '#touch_out' do
    it 'should respond to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'should raise error unless in journey' do
      allow(subject).to receive(:in_journey?).and_return(false)
      expect { subject.touch_out }.to raise_error(NOT_IN_JOURNEY)
    end

    it 'should clear journey' do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end

    it 'should log journey' do
      journeys = subject.journeys.length
      subject.touch_in
      subject.touch_out
      expect(subject.journeys.length).to eq(journeys + 1)
    end
  end
end
