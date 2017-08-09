require 'journey'

describe Journey do
  subject { Journey.new('aldgate') }

  describe '#fare' do
    it 'should respond to fare' do
      expect(subject).to respond_to(:fare)
    end
  end

  describe '#complete?' do
    it 'should respond to complete?' do
      expect(subject).to respond_to(:complete?)
    end

    it 'should know if journey is complete' do
      expect(Journey.new('aldgate', 'cannon street').complete?).to eq(true)
    end
    it 'should know if journey is not complete' do
      expect(subject.complete?).to eq(false)
    end
  end
end
