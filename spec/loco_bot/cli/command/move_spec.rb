RSpec.describe LocoBot::CLI::Command::Move do
  let(:robot) { LocoBot::Robot.new }
  let(:table) { LocoBot::Table.new }

  subject { described_class.new(robot, table) }

  describe '#execute' do
    it 'calls #move on robot' do
      expect(subject.robot).to receive(:move).with(no_args).once

      subject.execute
    end
  end
end
