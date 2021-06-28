# frozen_string_literal: true

module OpenConfig
  class Base
    attr_reader :file_path

    def initialize(root:, file:)
      @file_path = File.join(root, file)
    end

    def method_missing(method_name, *arguments, &block)
      return super unless configuration_method?(method_name)

      tree.public_send(method_name, *arguments, &block)
    end

    def respond_to_missing?(method_name, include_private = false)
      configuration_method?(method_name) || super
    end

    private

    def configuration_method?(method_name)
      tree.respond_to?(method_name)
    end

    def tree
      @tree ||= parse_file(read_file)
    end

    def parse_file(_file_content)
      raise NotImplementedError, 'Subclassed must implement #parse_file'
    end

    def read_file
      raise OpenConfig::Errors::FileNotFound, file_path unless File.exists?(file_path)

      File.new(file_path).read
    end
  end
end
