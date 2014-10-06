RSpec.describe LocoBot::CLI::Command::Hodor do
  let(:robot) { LocoBot::Robot.new }
  let(:table) { LocoBot::Table.new }

  subject { described_class.new(robot, table) }

  describe '#execute' do
    it 'calls #hodor! on robot' do
      expect(subject.robot).to receive(:hodor!).with(no_args).once

      subject.execute
    end
  end
end
