module Passman
  class Record
    def initialize(attrs)
      @attrs = stringify_keys(attrs)
    end

    def stringify_keys(hash)
      hash.reduce(Hash.new) do |acc, kv|
        key, value = kv
        acc[key.to_s] = value
        acc
      end
    end

    def to_hash
      @attrs
    end

    def query_format
      "#{category}/#{identifier}"
    end

    def primary_keys
      %w[identifier category login password].select { |f| @attrs.include? f }
    end

    def secondary_keys
      @attrs.keys.sort - primary_keys
    end

    def fields
      primary_keys + secondary_keys
    end

    def [](field)
      @attrs[field.to_s]
    end

    def respond_to?(method)
      @attrs.has_key?(method.to_s) || super(method)
    end

    def method_missing(method, *args)
      if @attrs.has_key? method.to_s
        @attrs[method.to_s]
      else
        super method, *args
      end
    end
  end
end
