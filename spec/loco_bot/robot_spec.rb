RSpec.describe LocoBot::Robot do
  let(:robot) { described_class.new }
  let(:table) { LocoBot::Table.new(20, 20) }

  describe '#place' do
    subject { robot }

    it 'calls Table#place_robot' do
      expect(table).to receive(:place_robot).with(subject, 9, 3, LocoBot::Robot::Direction::East).once

      subject.place(table, 9, 3, LocoBot::Robot::Direction::East)
    end
  end

  describe '#remove' do
    subject { robot.remove }

    context 'when placed on a table' do
      before { robot.place(table, 6, 17, LocoBot::Robot::Direction::East)  }

      it 'calls Table#remove_robot' do
        expect(table).to receive(:remove_robot).with(robot).once

        subject
      end
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
