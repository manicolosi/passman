module Passman
  module Commands
    class List < Command
      desc "List all identifiers"

      def invoke
        database.secrets.each do |secret|
          puts secret.query_format
        end
      end
    end
  end
end
