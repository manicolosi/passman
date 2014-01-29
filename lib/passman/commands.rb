module Passman
  module Commands
    require_relative 'commands/command'
    require_relative 'commands/copy'
    require_relative 'commands/databases'
    require_relative 'commands/dump_all'
    require_relative 'commands/edit_all'
    require_relative 'commands/list'
    require_relative 'commands/new'

    def self.each
      constants.map { |c| const_get(c) }.each do |cmd|
        yield cmd
      end
    end
  end
end
