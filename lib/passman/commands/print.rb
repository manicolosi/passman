require_relative 'command'
require_relative '../command_concerns/password'

module Passman
  module Commands
    class Print < Command
      include CommandConcerns::Password

      desc 'Prints a password to stdout'
      arg_name 'query'

      def invoke
        puts password
      end
    end
  end
end
