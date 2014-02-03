module Passman
  class Query
    def initialize(query, secrets)
      @secrets = secrets
      @fields = {}

      if query.include?('/')
        @fields[:category], @fields[:identifier] = query.split('/')
      else
        @fields[:identifier] = query
      end
    end

    def run
      @secrets.select do |secret|
        @fields.reduce(true) do |acc, field_kv|
          field, value = field_kv

          acc && secret.send(field) == value
        end
      end
    end
  end
end
