module Passman
  module Helpers
    module String
      def self.all_lower?(s)
        s.chars.all? { |c| c == c.downcase }
      end
    end
  end
end
