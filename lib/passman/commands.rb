module Passman
  module Commands
    require_relative 'commands/command'
    require_relative 'commands/copy'
    require_relative 'commands/databases'
    require_relative 'commands/dump_all'
    require_relative 'commands/edit_all'
    require_relative 'commands/list'
    require_relative 'commands/new'
    require_relative 'commands/print'

    def self.included(base)
      commands.each do |cmd|
        base.desc cmd.desc
        base.arg_name cmd.arg_name
        base.command cmd.name do |c|
          c.action &cmd.method(:invoke)
        end
      end
    end

    def self.commands
      constants.map { |c| const_get(c) }
    end
  end
end
