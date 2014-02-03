require_relative 'command'

module Passman
  module Commands
    class Print < Command
      desc 'Prints a password to stdout'
      arg_name 'query'

      def invoke
        record = database.find_one(args.first)

        puts record.secret
      end
    end
  end
end
