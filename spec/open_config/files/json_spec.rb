# frozen_string_literal: true

require 'spec_helper'
require_relative 'shared'

RSpec.describe OpenConfig::JSON do
  subject { described_class.new(path) }

  let(:path) { 'spec/fixtures/files/configuration.json' }

  it_behaves_like 'base configuration'
end
