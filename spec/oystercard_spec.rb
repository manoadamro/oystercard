require 'oystercard'

# rubocop:disable Metrics/BlockLength

# in spec/oystercard_spec.rb
describe Oystercard do
  subject { Oystercard.new(OPENING_BALANCE) }

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

    end
    it 'should not go below zero' do
      
    end
  end
end
