RSpec.describe LocoBot::Robot::Direction::West do
  describe '.left' do
    subject { described_class.left }

    it { is_expected.to eql LocoBot::Robot::Direction::South }
  end

  describe '.right' do
    subject { described_class.right }

    it { is_expected.to eql LocoBot::Robot::Direction::North }
  end

  describe '.label' do
    subject { described_class.label }

    it { is_expected.to eql 'WEST' }
  end

  describe '.vector' do
    subject { described_class.vector(21, 17) }

    it { is_expected.to eql(x: 20, y: 17) }
  end
end
