module Passman
  module Commands
    Dir[ File.join(File.dirname(__FILE__), 'commands/*.rb') ].each do |file|
      require file
    end

    def self.extended(base)
      commands.each do |cmd|
        base.desc cmd.desc
        base.arg_name cmd.arg_name
        base.command cmd.name do |c|
          c.switch *cmd.switch if cmd.switch
          c.action &cmd.method(:invoke)
        end
      end
    end

    def self.commands
      constants.map { |c| const_get(c) }
    end
  end
end
