module Passman
  module Commands
    class New < Command
      desc "Create a new password record"

      def invoke
        attrs = Hash[ args.map { |a| a.split(/=/) } ]
        secret = Secret.new(attrs)

        database.add secret
        database.write
      end
    end
  end
end
