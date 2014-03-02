require 'tempfile'
require_relative 'command'

module Passman
  module Commands
    class Edit < Command
      desc 'Edit records in a text editor'
      switch ['a', 'all'], desc: 'All records', default_value: false, negatable: false
      arg_name 'query'

      def invoke
        records = edit_records.each do |original, new|
          database.replace(original, new)
        end

        database.write
      end

      def query
        args.first if args.count > 0
      end

      def all?
        options['all']
      end

      def records
        raise "Cannot edit all records with a query." if all? && query

        if all?
          database.all
        elsif query
          database.find(query)
        else
          raise "Need a query or `--all` switch specified"
        end
      end

      def edit_records
        tmpfile = Tempfile.new(database.name)
        begin
          tmpfile.write dump_records
          tmpfile.close
          system "#{editor} #{tmpfile.path}"

          data = YAML.load_file(tmpfile)
        ensure
          tmpfile.unlink
        end

        if data
          new_records = data.map { |attrs| Record.new attrs }
          raise "Record count doesn't match. Aborting" if new_records.count != records.count
          records.zip new_records
        else
          raise "No records found! Aborting."
        end
      end

      def dump_records
        YAML.dump records.map(&:to_hash)
      end

      def editor
        config['commands', 'editor']
      end
    end
  end
end
