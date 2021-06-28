# frozen_string_literal: true

require 'json'

module OpenConfig
  class JSON < OpenConfig::Base
    private

    def parse_file(file_content)
      ::JSON.parse(file_content, object_class: OpenStruct)
    end
  end
end
