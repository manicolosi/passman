require_relative 'command'

module Passman
  module Commands
    class Print < Command
      desc 'Prints a password to stdout'
      arg_name 'query'

      def invoke
        password = database.find_one(args.first).password
        raise "Record does not have a password" unless password

        puts password
      end
    end
  end
end
