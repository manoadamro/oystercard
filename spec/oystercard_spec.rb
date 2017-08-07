require 'oystercard'

# in spec/oystercard_spec.rb
describe Oystercard do
  describe '#balance' do
    it 'should respond to balance' do
      expect(subject).to respond_to(:balance)
    end
  end

  describe '#top_up' do
    it 'should respond to balance' do
      expect(subject).to respond_to(:top_up)
    end
  end
end
