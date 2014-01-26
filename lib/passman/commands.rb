module Passman
  module Commands
    require_relative 'commands/command'
    require_relative 'commands/databases'

    def self.each
      constants.map { |c| const_get(c) }.each do |cmd|
        yield cmd
      end
    end
  end
end
