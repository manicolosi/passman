module Passman
  class Record
    def initialize(attrs)
      @attrs = attrs
    end

    def to_hash
      @attrs
    end

    def query_format
      "#{category}/#{identifier}"
    end

    def fields
      primary = [:identifier, :category, :login, :password].select { |f| @attrs.include? f }
      secondary = @attrs.keys.sort - primary

      primary + secondary
    end

    def [](field)
      @attrs[field]
    end

    def method_missing(method, *args)
      if @attrs.has_key? method
        @attrs[method]
      else
        super method, *args
      end
    end
  end
end
