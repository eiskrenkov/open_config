# frozen_string_literal: true

require 'yaml'
require 'json'
require 'erb'

module OpenConfig
  class YAML < Base
    private

    def parse_file(file_content)
      ::JSON.parse(load_yaml(file_content).to_json, object_class: OpenConfig::Node)
    end

    def load_yaml(file_content)
      ::YAML.load(compile(file_content))
    end

    def compile(file_content)
      defined?(::ERB) ? ::ERB.new(file_content).result : file_content
    end
  end
end
