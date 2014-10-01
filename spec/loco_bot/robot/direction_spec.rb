RSpec.describe LocoBot::Robot::Direction do
  describe '.from_turn_direction' do
    subject { described_class.from_turn_direction(direction, turn_direction) }

    context 'passing :right' do
      let(:turn_direction) { :right }

      context 'facing north' do
        let(:direction) { LocoBot::Robot::Direction::NORTH }

        it { is_expected.to eql LocoBot::Robot::Direction::EAST }
      end

      context 'facing south' do
        let(:direction) { LocoBot::Robot::Direction::SOUTH }

        it { is_expected.to eql LocoBot::Robot::Direction::WEST }
      end

      context 'facing east' do
        let(:direction) { LocoBot::Robot::Direction::EAST }

        it { is_expected.to eql LocoBot::Robot::Direction::SOUTH }
      end

      context 'facing west' do
        let(:direction) { LocoBot::Robot::Direction::WEST }

        it { is_expected.to eql LocoBot::Robot::Direction::NORTH }
      end
    end

    context 'passing :left' do
      let(:turn_direction) { :left }

      context 'facing north' do
        let(:direction) { LocoBot::Robot::Direction::NORTH }

        it { is_expected.to eql LocoBot::Robot::Direction::WEST }
      end

      context 'facing south' do
        let(:direction) { LocoBot::Robot::Direction::SOUTH }

        it { is_expected.to eql LocoBot::Robot::Direction::EAST }
      end

      context 'facing east' do
        let(:direction) { LocoBot::Robot::Direction::EAST }

        it { is_expected.to eql LocoBot::Robot::Direction::NORTH }
      end

      context 'facing west' do
        let(:direction) { LocoBot::Robot::Direction::WEST }

        it { is_expected.to eql LocoBot::Robot::Direction::SOUTH }
      end
    end

    context 'passing an invalid turn direction' do
      let(:turn_direction) { :move }

      context 'facing north' do
        let(:direction) { LocoBot::Robot::Direction::NORTH }

        it { is_expected.to eql LocoBot::Robot::Direction::NORTH }
      end

      context 'facing south' do
        let(:direction) { LocoBot::Robot::Direction::SOUTH }

        it { is_expected.to eql LocoBot::Robot::Direction::SOUTH }
      end

      context 'facing east' do
        let(:direction) { LocoBot::Robot::Direction::EAST }

        it { is_expected.to eql LocoBot::Robot::Direction::EAST }
      end

      context 'facing west' do
        let(:direction) { LocoBot::Robot::Direction::WEST }

        it { is_expected.to eql LocoBot::Robot::Direction::WEST }
      end
    end
  end

  describe '.numeric' do
    subject { described_class.numeric(direction) }

    context 'passing Direction::NORTH' do
      let(:direction) { LocoBot::Robot::Direction::NORTH }

      it { is_expected.to eql 1 }
    end

    context 'passing Direction::SOUTH' do
      let(:direction) { LocoBot::Robot::Direction::SOUTH }

      it { is_expected.to eql -1 }
    end

    context 'passing Direction::EAST' do
      let(:direction) { LocoBot::Robot::Direction::EAST }

      it { is_expected.to eql 1 }
    end

    context 'passing Direction::WEST' do
      let(:direction) { LocoBot::Robot::Direction::WEST }

      it { is_expected.to eql -1 }
    end
  end
end
