# frozen_string_literal: true

require 'spec_helper'
require_relative 'shared'

RSpec.describe OpenConfig::YAML do
  subject { described_class.new(path) }

  let(:path) { 'spec/fixtures/files/configuration.yml' }

  describe 'configuration fields' do
    it 'evaluates ruby' do
      expect(subject.ruby).to eq(6)
    end

    context 'when env variable was not exported' do
      it { expect(subject.env).to be_nil }
    end

    context 'when env variable was exported' do
      let(:test_env_var) { SecureRandom.hex }

      before do
        ENV['TEST_ENV_VAR'] = test_env_var
      end

      after do
        ENV.delete('TEST_ENV_VAR')
      end

      it { expect(subject.env).to eq(test_env_var) }
    end
  end
end
