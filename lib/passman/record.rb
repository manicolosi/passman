module Passman
  class Record
    attr_accessor :identifier, :secret, :category, :metadata

    def initialize(attrs)
      @metadata = {}

      attrs.each { |field, value| set_field field, value }
    end

    def to_hash
      @metadata.merge({
        identifier: identifier,
        secret: secret,
        category: category
      })
    end

    def query_format
      "#{category}/#{identifier}"
    end

    private

    def set_field(field, value)
      if respond_to? :"#{field}="
        send :"#{field}=", value
      else
        metadata[field.to_sym] = value
      end
    end
  end
end
