RSpec.describe LocoBot::CLI do
  describe '#initialize' do
    subject { described_class.new }

    it { expect(subject.robot).to be_an_instance_of(LocoBot::Robot) }
    it { expect(subject.table).to be_an_instance_of(LocoBot::Table) }
  end

  describe '#input!' do
    let(:input) { "#{command} #{arguments}" }

    context 'using a valid command' do
      let(:command) { :place }

      context 'with a valid number of arguments' do
        let(:arguments) { '1, 3, SOUTH' }
      end

      context 'with an invalid number of arguments' do
        let(:arguments) { '1, 2' }

        it 'outputs a custom ArgumentError message' do
          expect { subject.input!(input) }.to output("PLACE: wrong number of arguments (2 for 3)\n").to_stdout
        end
      end
    end

    context 'using an invalid command' do
      let(:command) { :yadayada }
      let(:arguments) { '' }

      it 'does not raise an error' do
        expect { subject.input!(input) }.to output("YADAYADA: not a known command. Valid commands are HODOR, LEFT, MOVE, PLACE, REPORT, RIGHT.\n").to_stdout
      end
    end
  end
end
