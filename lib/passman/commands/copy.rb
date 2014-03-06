require_relative 'command'
require_relative '../clipboard'
require_relative '../command_concerns/password'

module Passman
  module Commands
    class Copy < Command
      include CommandConcerns::Password

      desc 'Copy a password to the clipboard'
      arg_name 'query'

      def invoke
        clipboard.copy_and_restore(password)
      end

      def clipboard
        Clipboard.new(config)
      end
    end
  end
end
