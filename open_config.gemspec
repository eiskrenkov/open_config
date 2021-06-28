# frozen_string_literal: true

require_relative 'lib/open_config/version'

Gem::Specification.new do |spec|
  spec.name          = 'open_config'
  spec.version       = OpenConfig::VERSION

  spec.authors       = ['Egor Iskrenkov']
  spec.email         = ['e.iskrenkov@gmail.com']

  spec.summary       = 'Building OpenStruct trees from configuration files'
  spec.homepage      = 'https://github.com/eiskrenkov/open_config'

  spec.files         = `git ls-files`.split($RS).reject { |f| f.match(%r{^spec/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = Gem::Requirement.new('~> 3.0.0')

  # OpenConfig dependencies
  spec.add_development_dependency 'pry', '~> 0.13.1'
end
