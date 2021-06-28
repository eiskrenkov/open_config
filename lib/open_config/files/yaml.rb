# frozen_string_literal: true

require 'yaml'
require 'json'
require 'erb'

module OpenConfig
  class YAML < OpenConfig::Base
    private

    def parse_file(file_content)
      ::JSON.parse(build_json(file_content), object_class: OpenStruct)
    end

    def build_json(file_content)
      ::YAML.safe_load(load_erb(file_content)).to_json
    end

    def load_erb(file_content)
      ::ERB.new(file_content).result
    end
  end
end
