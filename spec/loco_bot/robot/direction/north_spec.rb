RSpec.describe LocoBot::Robot::Direction::North do
  describe '.left' do
    subject { described_class.left }

    it { is_expected.to eql LocoBot::Robot::Direction::West }
  end

  describe '.right' do
    subject { described_class.right }

    it { is_expected.to eql LocoBot::Robot::Direction::East }
  end

  describe '.label' do
    subject { described_class.label }

    it { is_expected.to eql 'NORTH' }
  end

  describe '.vector' do
    subject { described_class.vector(21, 17) }

    it { is_expected.to eql({ x: 21, y: 18 }) }
  end
end
