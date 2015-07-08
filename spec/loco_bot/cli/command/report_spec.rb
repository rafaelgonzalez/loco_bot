RSpec.describe LocoBot::CLI::Command::Report do
  let(:robot) { LocoBot::Robot.new }
  let(:table) { LocoBot::Table.new }

  subject { described_class.new(robot, table) }

  describe '#execute' do
    context 'before placing robot' do
      it 'does not output a string' do
        expect { subject.execute }.not_to output.to_stdout
      end
    end

    context 'after placing robot' do
      before { subject.robot.place(table, 4, 2, LocoBot::Robot::Direction::East) }

      it 'outputs a string' do
        expect { subject.execute }.to output("4,2,EAST\n").to_stdout
      end
    end
  end
end
