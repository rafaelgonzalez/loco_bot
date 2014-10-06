RSpec.describe LocoBot::CLI::Command::Hodor do
  let(:robot) { LocoBot::Robot.new }
  let(:table) { LocoBot::Table.new }

  subject { described_class.new(robot, table) }

  describe '#execute' do
    it { expect { subject.execute }.to output("HODOR HODOR !\n").to_stdout }
  end
end
