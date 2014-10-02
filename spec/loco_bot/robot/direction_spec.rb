RSpec.describe LocoBot::Robot::Direction do
  describe '.available' do
    subject { described_class.list }

    it { is_expected.to eql ['East', 'North', 'South', 'West'] }
  end
end
