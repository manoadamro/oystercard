require 'station'

describe Station do
  subject { Station.new('aldgate', 1) }

  describe '#name' do
    it 'should respond to name' do
      expect(subject).to respond_to(:name)
    end

    it 'should set name' do
      expect(subject.name).to eq('aldgate')
    end
  end

  describe '#zone' do
    it 'should respond to name' do
      expect(subject).to respond_to(:zone)
    end

    it 'should set zone' do
      expect(subject.zone).to eq(1)
    end
  end
end
