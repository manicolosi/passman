require_relative 'command'

module Passman
  module Commands
    class Copy < Command
      desc 'Copy a password to the clipboard'
      arg_name 'query'

      def invoke
        password = database.find_one(args.first).password
        raise "Record does not have a password" unless password

        clipboard = `#{read_clipboard}`
        system "echo -n '#{password}' | #{write_clipboard}"
        system "sleep 5 && echo -n | echo -n '#{clipboard}' | #{write_clipboard} &"
      end

      def read_clipboard
        config['commands', 'read_clipboard']
      end

      def write_clipboard
        config['commands', 'write_clipboard']
      end
    end
  end
end
