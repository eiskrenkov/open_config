# frozen_string_literal: true

require_relative 'lib/open_config/version'

Gem::Specification.new do |spec|
  spec.name          = 'open_config'
  spec.version       = OpenConfig::VERSION
  spec.license       = 'MIT'

  spec.authors       = ['Egor Iskrenkov']
  spec.email         = ['egor@iskrenkov.me']

  spec.summary       = 'Building OpenStruct trees from configuration files'
  spec.homepage      = 'https://github.com/eiskrenkov/open_config'

  spec.files         = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.4'

  # Dependencies
  spec.add_development_dependency 'rspec', '>= 3.8'
end
