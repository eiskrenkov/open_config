# frozen_string_literal: true

require 'delegate'

module OpenConfig
  class Base < DelegateClass(Node)
    def initialize(path)
      @path = path
      super(build_config)
    end

    def ==(other)
      return false unless other.kind_of?(OpenConfig::Base)
      table! == other.table!
    end

    private

    def build_config
      parse_file(read_file)
    end

    def parse_file(_file_content)
      raise NotImplementedError, 'Subclasses must implement #parse_file'
    end

    def read_file
      raise OpenConfig::Errors::FileNotFound, @path unless File.exist?(@path)

      File.read(@path)
    end
  end
end
