# frozen_string_literal: true

require 'json'

module OpenConfig
  class JSON < Base
    private

    def parse_file(file_content)
      ::JSON.parse(file_content, object_class: OpenConfig::Node)
    end
  end
end
