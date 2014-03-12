require_relative 'helpers/string'

module Passman
  class Condition
    def self.and(conditions)
      And.new(conditions)
    end

    def self.or(conditions)
      Or.new(conditions)
    end

    def initialize(conditions)
      @conditions = conditions
    end

    def evaluate(record)
      @conditions.reduce(initial_value) do |acc, kv|
        field, value = kv
        evaluate_condition acc, field_matches?(record, field, value)
      end
    end

    def field_matches?(record, field, value)
      if record.respond_to? field
        if value.nil?
          true
        else
          record.send(field) =~ regex(value)
        end
      end
    end

    def regex(v)
      Regexp.new(v, Helpers::String.all_lower?(v))
    end

    class And < Condition
      def evaluate_condition(acc, cur)
        acc && cur
      end

      def initial_value
        true
      end
    end

    class Or < Condition
      def evaluate_condition(acc, cur)
        acc || cur
      end

      def initial_value
        false
      end
    end
  end
end
