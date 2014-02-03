module Passman
  module Helpers
    module Hyphenizer
      def self.hyphenize(name)
        name.split('::').last.chars.reduce([]) do |words, char|
          if char =~ /[A-Z]/
            words << char
          else
            words[-1] << char
          end
          words
        end.join('-').downcase
      end
    end
  end
end
