require_relative 'command'

module Passman
  module Commands
    class Dump < Command
      desc 'Dump records to stdout'

      def print_record(record)
        puts

        fields = record.fields
        max_len = fields.max { |a, b| a.length <=> b.length }.length

        fields.each { |field| print_field field, record[field], max_len }
      end

      def print_field(field, value, max_len)
        puts "%-#{max_len + 1}s #{value}" % "#{field}:"
      end

      def invoke
        puts "Found #{records.count} record(s) in database '#{database.path}'"

        records.each do |record|
          print_record record
        end
      end

      def records
        @records ||= if args.count > 0
          database.find(args)
        else
          database.all
        end
      end
    end
  end
end
