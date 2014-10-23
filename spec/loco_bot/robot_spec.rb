RSpec.describe LocoBot::Robot do
  let(:robot) { described_class.new }
  let(:table) { LocoBot::Table.new(20, 20) }

  describe '#place' do
    let(:other_table) { LocoBot::Table.new(10, 10) }
    let(:robot) { described_class.new }

    before { robot.place(other_table, 5, 7, LocoBot::Robot::Direction::West) }

    context 'with a valid position' do
      it "modifies the table's robot list" do
        expect(other_table.robots).to include(robot)
        expect(table.robots).not_to include(robot)

        robot.place(table, 12, 14, LocoBot::Robot::Direction::South)

        expect(other_table.robots).not_to include(robot)
        expect(table.robots).to include(robot)
      end

      it 'changes the robot table, x, y and position' do
        expect(robot.table).to eql other_table
        expect(robot.x).to eql 5
        expect(robot.y).to eql 7
        expect(robot.direction).to eql LocoBot::Robot::Direction::West

        robot.place(table, 12, 14, LocoBot::Robot::Direction::South)

        expect(robot.table).to eql table
        expect(robot.x).to eql 12
        expect(robot.y).to eql 14
        expect(robot.direction).to eql LocoBot::Robot::Direction::South
      end

      it { expect(robot.place(table, 12, 14, LocoBot::Robot::Direction::South)).to be true }
    end

    context 'with an invalid position' do
      it "does not modify the table's robot list" do
        expect(other_table.robots).to include(robot)
        expect(table.robots).not_to include(robot)

        robot.place(table, 617, 9001, LocoBot::Robot::Direction::South)

        expect(other_table.robots).to include(robot)
        expect(table.robots).not_to include(robot)
      end

      it 'does not change the robot table, x, y and position' do
        expect(robot.table).to eql other_table
        expect(robot.x).to eql 5
        expect(robot.y).to eql 7
        expect(robot.direction).to eql LocoBot::Robot::Direction::West

        robot.place(table, 617, 9001, LocoBot::Robot::Direction::South)

        expect(robot.table).to eql other_table
        expect(robot.x).to eql 5
        expect(robot.y).to eql 7
        expect(robot.direction).to eql LocoBot::Robot::Direction::West
      end

      it { expect(robot.place(table, 617, 9001, LocoBot::Robot::Direction::South)).to be false }
    end
  end

  describe '#remove' do
    subject { robot.remove }

    before do
      table.place_robot(LocoBot::Robot.new, 3, 4, LocoBot::Robot::Direction::North)
      table.place_robot(LocoBot::Robot.new, 1, 8, LocoBot::Robot::Direction::West)
    end

    context 'when placed on a table' do
      before { robot.place(table, 6, 17, LocoBot::Robot::Direction::East)  }

      it "removes the robot from the table's list" do
        expect(table.robots.count).to eql 3
        expect(table.robots).to include(robot)

        robot.remove

        expect(table.robots.count).to eql 2
        expect(table.robots).not_to include(robot)
      end

      it 'sets to nil robot table, x, y and direction' do
        expect(robot.table).to eql table
        expect(robot.x).to eql 6
        expect(robot.y).to eql 17
        expect(robot.direction).to eql LocoBot::Robot::Direction::East

        robot.remove

        expect(robot.table).to be_nil
        expect(robot.x).to be_nil
        expect(robot.y).to be_nil
        expect(robot.direction).to be_nil
      end

      it { expect(subject).to be true }
    end

    context 'when not placed on a table' do
      it { expect(subject).to be false }
    end
  end

  describe '#move' do
    subject { robot }

    before { robot.place(table, x, y, direction) }

    context 'facing north' do
      let(:direction) { LocoBot::Robot::Direction::North }
      let(:x) { 10 }

      context 'when movement is possible' do
        let(:y) { 0 }

        it 'moves north' do
          expect { subject.move }.to change { subject.y }.to(1)
          expect { subject.move }.not_to change { subject.x }
        end
      end

      context 'when movement is not possible' do
        let(:y) { 19 }

        it 'does not move' do
          expect { subject.move }.not_to change { subject.x }
          expect { subject.move }.not_to change { subject.y }
        end
      end
    end

    context 'facing south' do
      let(:direction) { LocoBot::Robot::Direction::South }
      let(:x) { 10 }

      context 'when movement is possible' do
        let(:y) { 19 }

        it 'moves south' do
          expect { subject.move }.to change { subject.y }.to(18)
          expect { subject.move }.not_to change { subject.x }
        end
      end

      context 'when movement is not possible' do
        let(:y) { 0 }

        it 'does not move' do
          expect { subject.move }.not_to change { subject.x }
          expect { subject.move }.not_to change { subject.y }
        end
      end
    end

    context 'facing east' do
      let(:direction) { LocoBot::Robot::Direction::East }
      let(:y) { 10 }

      context 'when movement is possible' do
        let(:x) { 0 }

        it 'moves east' do
          expect { subject.move }.to change { subject.x }.to(1)
          expect { subject.move }.not_to change { subject.y }
        end
      end

      context 'when movement is not possible' do
        let(:x) { 19 }

        it 'does not move' do
          expect { subject.move }.not_to change { subject.x }
          expect { subject.move }.not_to change { subject.y }
        end
      end
    end

    context 'facing west' do
      let(:direction) { LocoBot::Robot::Direction::West }
      let(:y) { 10 }

      context 'when movement is possible' do
        let(:x) { 19 }

        it 'moves west' do
          expect { subject.move }.to change { subject.x }.to(18)
          expect { subject.move }.not_to change { subject.y }
        end
      end

      context 'when movement is not possible' do
        let(:x) { 0 }

        it 'does not move' do
          expect { subject.move }.not_to change { subject.x }
          expect { subject.move }.not_to change { subject.y }
        end
      end
    end
  end

  describe '#turn_left' do
    subject { robot }

    before { subject.place(table, 10, 10, direction) }

    context 'facing north' do
      let(:direction) { LocoBot::Robot::Direction::North }

      it { expect { subject.turn_left }.to change { subject.direction }.to LocoBot::Robot::Direction::West }
    end

    context 'facing south' do
      let(:direction) { LocoBot::Robot::Direction::South }

      it { expect { subject.turn_left }.to change { subject.direction }.to LocoBot::Robot::Direction::East }
    end

    context 'facing east' do
      let(:direction) { LocoBot::Robot::Direction::East }

      it { expect { subject.turn_left }.to change { subject.direction }.to LocoBot::Robot::Direction::North }
    end

    context 'facing west' do
      let(:direction) { LocoBot::Robot::Direction::West }

      it { expect { subject.turn_left }.to change { subject.direction }.to LocoBot::Robot::Direction::South }
    end
  end

  describe '#turn_right' do
    subject { robot }

    before { subject.place(table, 10, 10, direction) }

    context 'facing north' do
      let(:direction) { LocoBot::Robot::Direction::North }

      it { expect { subject.turn_right }.to change { subject.direction }.to LocoBot::Robot::Direction::East }
    end

    context 'facing south' do
      let(:direction) { LocoBot::Robot::Direction::South }

      it { expect { subject.turn_right }.to change { subject.direction }.to LocoBot::Robot::Direction::West }
    end

    context 'facing east' do
      let(:direction) { LocoBot::Robot::Direction::East }

      it { expect { subject.turn_right }.to change { subject.direction }.to LocoBot::Robot::Direction::South }
    end

    context 'facing west' do
      let(:direction) { LocoBot::Robot::Direction::West }

      it { expect { subject.turn_right }.to change { subject.direction }.to LocoBot::Robot::Direction::North }
    end
  end

  describe '#report' do
    subject { robot.report }

    context 'when placed on a table' do
      before { robot.place(table, 6, 17, LocoBot::Robot::Direction::East)  }

      it { is_expected.to eql({x: 6, y: 17, direction: LocoBot::Robot::Direction::East}) }
    end

    context 'when not placed on a table' do
      it 'returns an empty Hash' do
        expect(subject).to be_a Hash
        expect(subject).to be_empty
      end
    end
  end

  describe '#hodor!' do
    it { expect { robot.hodor! }.to output("HODOR HODOR !\n").to_stdout }
  end

  describe '#next_position' do
    subject { robot.next_position }

    context 'when not placed on a table' do
      it { is_expected.to eql({}) }
    end

    context 'when placed on a table' do
      before { robot.place(table, 10, 10, direction) }

      context 'facing north' do
        let(:direction) { LocoBot::Robot::Direction::North }

        it { is_expected.to eql({x: 10, y: 11}) }
      end

      context 'facing south' do
        let(:direction) { LocoBot::Robot::Direction::South }

        it { is_expected.to eql({x: 10, y: 9}) }
      end

      context 'facing east' do
        let(:direction) { LocoBot::Robot::Direction::East }

        it { is_expected.to eql({x: 11, y: 10}) }
      end

      context 'facing west' do
        let(:direction) { LocoBot::Robot::Direction::West }

        it { is_expected.to eql({x: 9, y: 10}) }
      end
    end
  end
end
