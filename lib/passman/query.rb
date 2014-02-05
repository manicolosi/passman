require_relative 'condition'

module Passman
  class Query
    attr_reader :query, :records

    def initialize(query, records)
      @query = query
      @records = records
    end

    def condition
      @condition ||=
        if @query.include?('/')
          category, identifier = @query.split('/')
          Condition.and_condition(identifier: identifier, category: category)
        else
          Condition.or_condition(identifier: @query, category: @query)
        end
    end

    def run
      records.select { |record| condition.evaluate record }
    end
  end
end
