RSpec.describe LocoBot::CLI::Command::Left do
  let(:robot) { LocoBot::Robot.new }
  let(:table) { LocoBot::Table.new }

  subject { described_class.new(robot, table) }

  describe '#execute' do
    it 'calls #turn_left on robot' do
      expect(subject.robot).to receive(:turn_left).with(no_args).once

      subject.execute
    end
  end
end
