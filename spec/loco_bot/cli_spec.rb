RSpec.describe LocoBot::CLI do
  describe '#initialize' do
    subject { described_class.new }

    it { expect(subject.robot).to be_an_instance_of(LocoBot::Robot) }
    it { expect(subject.table).to be_an_instance_of(LocoBot::Table) }
  end

  describe '#input!' do
    let(:input) { "#{command} #{arguments}" }

    context 'using PLACE command' do
      let(:command) { :place }

      context 'with an invalid number of arguments' do
        let(:arguments) { '' }

        it 'does not call Robot#place' do
          expect(subject.robot).not_to receive(:place)

          subject.input!(input)
        end
      end

      context 'with a valid number of arguments' do
        let(:arguments) { '2, 3, EAST' }

        it 'calls Robot#place' do
          expect(subject.robot).to receive(:place).with(subject.table, 2, 3, LocoBot::Robot::Direction::East).once

          subject.input!(input)
        end
      end
    end

    context 'using RIGHT command' do
      let(:command) { :right }

      context 'with an invalid number of arguments' do
        let(:arguments) { '2, SOUTH' }

        it 'does not call Robot#turn_right' do
          expect(subject.robot).not_to receive(:turn_right)

          subject.input!(input)
        end
      end

      context 'with a valid number of arguments' do
        let(:arguments) { '' }

        it 'calls Robot#turn_right' do
          expect(subject.robot).to receive(:turn_right).with(no_args).once

          subject.input!(input)
        end
      end
    end

    context 'using LEFT command' do
      let(:command) { :left }

      context 'with an invalid number of arguments' do
        let(:arguments) { 'NORTH, WEST, 4' }

        it 'does not call Robot#turn_left' do
          expect(subject.robot).not_to receive(:turn_left)

          subject.input!(input)
        end
      end

      context 'with a valid number of arguments' do
        let(:arguments) { '' }

        it 'calls Robot#turn_left' do
          expect(subject.robot).to receive(:turn_left).with(no_args).once

          subject.input!(input)
        end
      end
    end

    context 'using MOVE command' do
      let(:command) { :move }

      context 'with an invalid number of arguments' do
        let(:arguments) { '2, 0, 4' }

        it 'does not call Robot#move' do
          expect(subject.robot).not_to receive(:move)

          subject.input!(input)
        end
      end

      context 'with a valid number of arguments' do
        let(:arguments) { '' }

        it 'calls Robot#move' do
          expect(subject.robot).to receive(:move).with(no_args).once

          subject.input!(input)
        end
      end
    end

    context 'using REPORT command' do
      let(:command) { :report }

      context 'with an invalid number of arguments' do
        let(:arguments) { '1, 3' }
      end

      context 'with a valid number of arguments' do
        let(:arguments) { '' }

        context 'before placing robot' do
          it 'does not output a string' do
            expect { subject.input!(input) }.not_to output.to_stdout
          end
        end

        context 'after placing robot' do
          before { subject.input!('PLACE 4,2,SOUTH') }

          it 'outputs a string' do
            expect { subject.input!(input) }.to output("4,2,SOUTH\n").to_stdout
          end
        end
      end
    end

    context 'using HODOR command' do
      let(:command) { :hodor }

      context 'with an invalid number of arguments' do
        let(:arguments) { '1, 3' }

        it 'does not output a string' do
          expect { subject.input!(input) }.not_to output.to_stdout
        end
      end

      context 'with a valid number of arguments' do
        let(:arguments) { '' }

        it 'outputs a string' do
          expect { subject.input!(input) }.to output("HODOR HODOR !\n").to_stdout
        end
      end
    end

    context 'using an invalid command' do
      let(:command) { :yadayada }
      let(:arguments) { '' }

      it 'does not raise an error' do
        expect { subject.input!(input) }.not_to raise_error
      end
    end
  end
end
