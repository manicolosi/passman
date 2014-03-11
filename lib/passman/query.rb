require_relative 'condition'

module Passman
  class Query
    attr_reader :queries, :records

    def initialize(queries, records)
      @queries = queries
      @records = records
    end

    def condition(query)
      if query.include?('/')
        category, identifier = query.split('/')
        Condition.and(identifier: identifier, category: category)
      elsif query.include?(':')
        key, value = query.split(':')
        Condition.or(key => value, identifier: query, category: query)
      else
        Condition.or(identifier: query, category: query)
      end
    end

    def regex(v)
      Regexp.new(v, Helpers::String.all_lower?(v))
    end

    def run
      records.select do |record|
        queries.all? do |query|
          condition(query).evaluate(record)
        end
      end
    end
  end
end
