require 'tempfile'
require_relative 'command'

module Passman
  module Commands
    class Edit < Command
      desc 'Edit records in a text editor'

      def invoke
        new_record = edit_record
        database.replace(record, new_record)
        database.write
      end

      def record
        database.find_one(args.first)
      end

      def edit_record
        tmpfile = Tempfile.new(record.identifier)
        begin
          tmpfile.write dump_record
          tmpfile.close

          system "#{editor} #{tmpfile.path}"

          data = YAML.load_file(tmpfile)
          record = Record.new(data)
        ensure
          tmpfile.unlink
        end
      end

      def dump_record
        YAML.dump record.to_hash
      end

      def editor
        config['commands', 'editor']
      end
    end
  end
end
