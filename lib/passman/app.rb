require 'gli'
require 'term/ansicolor'

require_relative 'commands'
require_relative 'version'
require_relative 'config'
require_relative 'database'

module Passman
  module App
    extend GLI::App
    extend Term::ANSIColor

    program_desc 'Password Manager'
    version Passman::VERSION

    flag 'database-directory'
    flag 'database-default'

    def self.print_error(messages)
      puts red { messages.first.chomp }

      messages[1..-1].each do |message|
        puts message.chomp
      end
    end

    Passman::Commands.each do |cmd|
      desc cmd.desc
      arg_name cmd.arg_name
      command cmd.name do |c|
        c.action &cmd.method(:invoke)
      end
    end

    pre do |global,command,options,args|
      config = Config.new(global)
      database = Database.new(config['database'])

      global[:config] = config
      global[:database] = database

      true
    end

    on_error do |exception|
      if ENV['PASSMAN_DEBUG']
        puts exception
        puts exception.backtrace
      end

      print_error(exception.to_s.lines)

      false
    end
  end
end
