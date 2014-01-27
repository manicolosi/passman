module Passman
  module Commands
    class List < Command
      desc "List all identifiers"

      def invoke
        database.secrets.each do |secret|
          puts secret.identifier
        end
      end
    end
  end
end
