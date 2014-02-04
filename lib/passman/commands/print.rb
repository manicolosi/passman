require_relative 'command'

module Passman
  module Commands
    class Print < Command
      desc 'Prints a password to stdout'
      arg_name 'query'

      def invoke
        secret = database.find_one(args.first).secret

        raise "Record does not have a secret" unless secret

        puts secret
      end
    end
  end
end
