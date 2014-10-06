RSpec.describe LocoBot::CLI::Command do
  describe '.list' do
    subject { described_class.list }

    it { is_expected.to eql ['HODOR', 'LEFT', 'MOVE', 'PLACE', 'REPORT', 'RIGHT'] }
  end

  describe '.class_from_name' do
    subject { described_class.class_from_name(direction) }

    context 'passing :base' do
      let(:direction) { :base }

      it { is_expected.to eql nil }
    end

    context 'passing :hodor' do
      let(:direction) { :hodor }

      it { is_expected.to eql LocoBot::CLI::Command::Hodor }
    end

    context 'passing :left' do
      let(:direction) { :left }

      it { is_expected.to eql LocoBot::CLI::Command::Left }
    end

    context 'passing :move' do
      let(:direction) { :move }

      it { is_expected.to eql LocoBot::CLI::Command::Move }
    end

    context 'passing :place' do
      let(:direction) { :place }

      it { is_expected.to eql LocoBot::CLI::Command::Place }
    end

    context 'passing :report' do
      let(:direction) { :report }

      it { is_expected.to eql LocoBot::CLI::Command::Report }
    end

    context 'passing :right' do
      let(:direction) { :right }

      it { is_expected.to eql LocoBot::CLI::Command::Right }
    end
  end
end
