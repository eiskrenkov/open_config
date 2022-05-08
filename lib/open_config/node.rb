# frozen_string_literal: true

require 'ostruct'

module OpenConfig
  class Node < OpenStruct
    def fetch(name, *args, &block)
      begin
        name = name.to_sym
      rescue NoMethodError
        raise! TypeError, "#{name} is not a symbol nor a string"
      end

      table.fetch(name, *args, &block)
    end

    def to_h
      super.transform_values do |value|
        value.instance_of?(self.class) ? value.to_h : value
      end
    end

    def pretty_print(q)
      q.object_group self do
        q.nest(1) do
          q.breakable
          q.seplist(table, nil, :each) do |key, value|
            q.group do
              q.text key.to_s
              q.text ': '
              q.pp value
            end
          end
        end
      end
    end
  end
end
