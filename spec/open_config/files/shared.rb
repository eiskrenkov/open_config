# frozen_string_literal: true

RSpec.shared_examples 'base configuration' do
  it { expect(subject.__getobj__).to be_instance_of(OpenConfig::Node) }

  describe '#initialize' do
    context 'when path is correct' do
      it { expect { subject }.not_to raise_error }
    end

    context 'when path is incorrect' do
      let(:path) { 'spec/fixtures/files/configuration.js' }

      it { expect { subject }.to raise_error(OpenConfig::Errors::FileNotFound) }
    end
  end

  describe '#==' do
    let(:another_subject) { described_class.new(path) }

    context 'when configs are the same' do
      it { expect(subject).to eq(another_subject) }
    end

    context 'when configs are not the same' do
      before do
        another_subject.node.string = SecureRandom.hex
      end

      it { expect(subject).not_to eq(another_subject) }
    end
  end
end
