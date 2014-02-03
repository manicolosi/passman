require_relative 'command'
require_relative '../record'

module Passman
  module Commands
    class New < Command
      desc "Create a new password record"

      def invoke
        attrs = Hash[ args.map do |a|
          k, v = a.split(/=/)
          [k.to_sym, v]
        end]
        secret = Record.new(attrs)

        database.add secret
        database.write
      end
    end
  end
end
