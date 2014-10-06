RSpec.describe LocoBot::Robot::Direction do
  describe '.list' do
    subject { described_class.list }

    it { is_expected.to eql ['East', 'North', 'South', 'West'] }
  end

  describe '.from_name' do
    subject { described_class.from_name(direction) }

    context 'passing :north' do
      let(:direction) { :north }

      it { is_expected.to eql LocoBot::Robot::Direction::North }
    end

    context 'passing :east' do
      let(:direction) { :east }

      it { is_expected.to eql LocoBot::Robot::Direction::East }
    end

    context 'passing :south' do
      let(:direction) { :south }

      it { is_expected.to eql LocoBot::Robot::Direction::South }
    end

    context 'passing :west' do
      let(:direction) { :west }

      it { is_expected.to eql LocoBot::Robot::Direction::West }
    end
  end
end
