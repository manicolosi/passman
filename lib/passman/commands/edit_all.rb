module Passman
  module Commands
    require 'tempfile'

    class EditAll < Command
      desc 'Edit the password database in an editor (DANGEROUS)'

      def invoke
        database.read

        path = Tempfile.new(database.name).path

        database.write path, false

        system "#{editor} #{path}"

        database.clear!
        database.read path, false

        database.write
      end

      def editor
        config['commands', 'editor']
      end
    end
  end
end
