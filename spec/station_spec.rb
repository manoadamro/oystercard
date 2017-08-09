
require 'station'

EXAMPLE_STATION = 'aldgate'.freeze
EXAMPLE_ZONE = 1

describe Station do
  subject { Station.new(EXAMPLE_STATION, EXAMPLE_ZONE) }

  describe '#name' do
    it 'should expose name' do
      expect(subject).to respond_to(:name)
    end
  end

  describe '#zone' do
    it 'should expose zone' do
      expect(subject).to respond_to(:zone)
    end
  end
end
