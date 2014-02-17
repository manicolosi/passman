module Passman
  module Helpers
    class VariableExpander
      def initialize(lookup_table)
        @lookup_table = lookup_table
      end

      def expand(string)
        string.gsub(/([^\\])\$([a-zA-Z_][a-zA-Z0-9_]*)/) { $1 + @lookup_table[$2] }
              .gsub(/\\\$/, '$')
      end
    end
  end
end
