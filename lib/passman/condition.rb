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
        k, v = kv
        evaluate_condition(acc, record.send(k) =~ Regexp.new(v))
      end
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
