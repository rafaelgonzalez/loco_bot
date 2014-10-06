RSpec.describe LocoBot::CLI::Command::Right do
  let(:robot) { LocoBot::Robot.new }
  let(:table) { LocoBot::Table.new }

  subject { described_class.new(robot, table) }

  describe '#execute' do
    it 'calls #turn_right on robot' do
      expect(subject.robot).to receive(:turn_right).with(no_args).once

      subject.execute
    end
  end
end
