module Passman
  module Commands
    class List < Command
      desc "List all identifiers"

      def invoke
        database.records.each do |record|
          puts record.query_format
        end
      end
    end
  end
end
