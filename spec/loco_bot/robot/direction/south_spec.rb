RSpec.describe LocoBot::Robot::Direction::South do
  describe '.left' do
    subject { described_class.left }

    it { is_expected.to eql LocoBot::Robot::Direction::East }
  end

  describe '.right' do
    subject { described_class.right }

    it { is_expected.to eql LocoBot::Robot::Direction::West }
  end

  describe '.label' do
    subject { described_class.label }

    it { is_expected.to eql 'SOUTH' }
  end

  describe '.coordinates' do
    subject { described_class.coordinates(21, 17) }

    it { is_expected.to eql({ x: 21, y: 16 }) }
  end
end
