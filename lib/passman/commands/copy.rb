require_relative 'command'

module Passman
  module Commands
    class Copy < Command
      desc 'Copy a password to the clipboard'
      arg_name 'query'

      def invoke
        password = database.find_one(args.first).password
        raise "Record does not have a password" unless password

        read_cmd = config['commands', 'read_clipboard']
        write_cmd = config['commands', 'write_clipboard']

        clipboard = `#{read_cmd}`
        system "echo -n '#{password}' | #{write_cmd}"
        system "sleep 5 && echo -n | echo -n '#{clipboard}' | #{write_cmd} &"
      end
    end
  end
end
