module Passman
  module Extensions
    module String
      def all_lower?
        chars.all? { |c| c == c.downcase }
      end
    end
  end
end
