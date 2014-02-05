module Passman
  class Condition
    def self.and_condition(conditions)
      AndCondition.new(conditions)
    end

    def self.or_condition(conditions)
      OrCondition.new(conditions)
    end

    def initialize(conditions)
      @conditions = conditions
    end

    def evaluate(record)
      @conditions.reduce(initial_value) do |acc, kv|
        k, v = kv
        evaluate_condition(acc, record.send(k) == v)
      end
    end

    class AndCondition < Condition
      def evaluate_condition(acc, cur)
        acc && cur
      end

      def initial_value
        true
      end
    end

    class OrCondition < Condition
      def evaluate_condition(acc, cur)
        acc || cur
      end

      def initial_value
        false
      end
    end
  end
end
