require_relative 'command'

module Passman
  module Commands
    class List < Command
      desc "List all identifiers"

      def invoke
        records.each do |record|
          puts record.query_format
        end
      end

      def records
        @records ||= if args.count > 0
          database.find(args.first)
        else
          database.all
        end
      end
    end
  end
end
