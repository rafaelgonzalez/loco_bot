RSpec.describe LocoBot::Table do
  describe '#initialize' do
    subject { described_class.new(width, height) }
    let(:width) { 8 }
    let(:height) { 3 }

    it { expect(subject.width).to eql 8 }
    it { expect(subject.height).to eql 3 }
    it { expect(subject.robots).to be_empty }

    context 'with an invalid width' do
      let(:width) { 0 }

      it { expect{ subject }.to(raise_error(ArgumentError)) }
    end

    context 'with an invalid height' do
      let(:height) { -5 }

      it { expect{ subject }.to(raise_error(ArgumentError)) }
    end

    context 'with an invalid width and height' do
      let(:width) { -16 }
      let(:height) { 0 }

      it { expect{ subject }.to(raise_error(ArgumentError)) }
    end
  end

  describe '#place_robot' do
    let(:table) { described_class.new(15, 15) }
    let(:other_table) { described_class.new(10, 10) }
    let(:robot) { LocoBot::Robot.new }

    before { other_table.place_robot(robot, 5, 7, LocoBot::Robot::Direction::West) }

    context 'with a valid position' do
      it 'modifies the robot list' do
        expect(other_table.robots).to include(robot)
        expect(table.robots).not_to include(robot)

        table.place_robot(robot, 12, 14, LocoBot::Robot::Direction::South)

        expect(other_table.robots).not_to include(robot)
        expect(table.robots).to include(robot)
      end

      it 'changes the robot table, x, y and position' do
        expect(robot.table).to eql other_table
        expect(robot.x).to eql 5
        expect(robot.y).to eql 7
        expect(robot.direction).to eql LocoBot::Robot::Direction::West

        table.place_robot(robot, 12, 14, LocoBot::Robot::Direction::South)

        expect(robot.table).to eql table
        expect(robot.x).to eql 12
        expect(robot.y).to eql 14
        expect(robot.direction).to eql LocoBot::Robot::Direction::South
      end

      it { expect(table.place_robot(robot, 12, 14, LocoBot::Robot::Direction::South)).to be true }
    end

    context 'with an invalid position' do
      it 'does not modify the robot list' do
        expect(other_table.robots).to include(robot)
        expect(table.robots).not_to include(robot)

        table.place_robot(robot, 617, 9001, LocoBot::Robot::Direction::South)

        expect(other_table.robots).to include(robot)
        expect(table.robots).not_to include(robot)
      end

      it 'does not change the robot table, x, y and position' do
        expect(robot.table).to eql other_table
        expect(robot.x).to eql 5
        expect(robot.y).to eql 7
        expect(robot.direction).to eql LocoBot::Robot::Direction::West

        table.place_robot(robot, 617, 9001, LocoBot::Robot::Direction::South)

        expect(robot.table).to eql other_table
        expect(robot.x).to eql 5
        expect(robot.y).to eql 7
        expect(robot.direction).to eql LocoBot::Robot::Direction::West
      end

      it { expect(table.place_robot(robot, 617, 9001, LocoBot::Robot::Direction::South)).to be false }
    end
  end

  describe '#remove_robot' do
    let(:table) { described_class.new(10, 10) }
    let(:robot) { LocoBot::Robot.new }

    before do
      table.place_robot(LocoBot::Robot.new, 3, 4, LocoBot::Robot::Direction::North)
      table.place_robot(LocoBot::Robot.new, 1, 8, LocoBot::Robot::Direction::West)
      LocoBot::Table.new.place_robot(robot, 1, 3, LocoBot::Robot::Direction::South)
    end

    context 'with a robot on another table' do
      let(:other_table) { described_class.new(20, 20) }

      before do
        other_table.place_robot(robot, 1, 3, LocoBot::Robot::Direction::South)
      end

      it 'does not modify the robot list' do
        expect(table.robots.count).to eql 2
        expect(table.robots).not_to include(robot)

        table.remove_robot(robot)

        expect(table.robots.count).to eql 2
        expect(table.robots).not_to include(robot)
      end

      it 'does not set to nil robot table, x, y and direction' do
        expect(robot.table).to eql other_table
        expect(robot.x).to eql 1
        expect(robot.y).to eql 3
        expect(robot.direction).to eql LocoBot::Robot::Direction::South

        table.remove_robot(robot)

        expect(robot.table).to eql other_table
        expect(robot.x).to eql 1
        expect(robot.y).to eql 3
        expect(robot.direction).to eql LocoBot::Robot::Direction::South
      end

      it { expect(table.remove_robot(robot)).to be false }
    end

    context 'with the robot on the table' do
      before { table.place_robot(robot, 5, 3, LocoBot::Robot::Direction::East) }

      it 'removes the robot from the list' do
        expect(table.robots.count).to eql 3
        expect(table.robots).to include(robot)

        table.remove_robot(robot)

        expect(table.robots.count).to eql 2
        expect(table.robots).not_to include(robot)
      end

      it 'sets to nil robot table, x, y and direction' do
        expect(robot.table).to eql table
        expect(robot.x).to eql 5
        expect(robot.y).to eql 3
        expect(robot.direction).to eql LocoBot::Robot::Direction::East

        table.remove_robot(robot)

        expect(robot.table).to be_nil
        expect(robot.x).to be_nil
        expect(robot.y).to be_nil
        expect(robot.direction).to be_nil
      end

      it { expect(table.remove_robot(robot)).to be true }
    end
  end

  describe '#position_valid?' do
    subject { table.position_valid?(x, y) }
    let(:table) { described_class.new(10, 5) }

    context 'with an out of bounds position' do
      let(:x) { 5 }
      let(:y) { 6 }

      it { is_expected.to be false }
    end

    context 'with an occupied position' do
      let(:x) { 2 }
      let(:y) { 3 }

      before { table.place_robot(LocoBot::Robot.new, 2, 3, LocoBot::Robot::Direction::North) }

      it { is_expected.to be false }
    end

    context 'with a free position within bounds' do
      let(:x) { 3 }
      let(:y) { 1 }

      it { is_expected.to be true }
    end
  end
end
