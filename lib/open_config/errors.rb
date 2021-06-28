# frozen_string_literal: true

module OpenConfig
  module Errors
    class FileNotFound < StandardError
      def initialize(path)
        super("#{path} doesn't exist!")
      end
    end
  end
end
