require_relative 'command'
require_relative '../clipboard'

module Passman
  module Commands
    class Copy < Command
      desc 'Copy a password to the clipboard'
      arg_name 'query'

      def invoke
        raise "Record does not have a password" unless record.password

        clipboard.copy_and_restore(record.password)
      end

      def clipboard
        Clipboard.new(config)
      end

      def record
        @record ||= database.find_one(query)
      end

      def query
        args.first
      end
    end
  end
end
