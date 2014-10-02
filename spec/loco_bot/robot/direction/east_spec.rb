RSpec.describe LocoBot::Robot::Direction::East do
  describe '.left' do
    subject { described_class.left }

    it { is_expected.to eql LocoBot::Robot::Direction::North }
  end

  describe '.right' do
    subject { described_class.right }

    it { is_expected.to eql LocoBot::Robot::Direction::South }
  end

  describe '.label' do
    subject { described_class.label }

    it { is_expected.to eql 'EAST' }
  end

  describe '.coordinates' do
    subject { described_class.coordinates(21, 17) }

    it { is_expected.to eql({ x: 22, y: 17 }) }
  end
end
