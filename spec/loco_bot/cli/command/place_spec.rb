RSpec.describe LocoBot::CLI::Command::Place do
  let(:robot) { LocoBot::Robot.new }
  let(:table) { LocoBot::Table.new }

  subject { described_class.new(robot, table) }

  describe '#execute' do
    it 'calls #place on robot' do
      expect(subject.robot).to receive(:place).with(table, 3, 2, LocoBot::Robot::Direction::West).once

      subject.execute('3', '2', 'west')
    end
  end
end
