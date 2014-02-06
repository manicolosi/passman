module Passman
  class PasswordGenerator
    def initialize(generator)
      @generator = generator
    end

    def generate
      `#@generator`.chomp
    end
  end
end
