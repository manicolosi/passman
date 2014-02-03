module Passman
  module Helpers
    class Hyphenizer
      def self.hyphenize(name)
        new(name).hyphenize
      end

      def initialize(name)
        @name = name
      end

      def hyphenize
        last_word.chars.reduce([], &method(:build_words)).join('-').downcase
      end

      def last_word
        @name.split('::').last
      end

      def build_words(words, char)
        words.tap do |words|
          if char =~ /[A-Z]/
            words << char
          else
            words[-1] << char
          end
        end
      end
    end
  end
end
