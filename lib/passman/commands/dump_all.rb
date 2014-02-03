require_relative 'command'

module Passman
  module Commands
    class DumpAll < Command
      desc 'Dump all password records to stdout'

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
        puts "Found #{database.count} record(s) in database '#{database.path}'"

        database.secrets.each { |record| print_record record }
      end
    end
  end
end
