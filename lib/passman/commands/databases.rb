module Passman
  module Commands
    class Databases < Command
      EXTENSION = /\.pdb\.gpg$/
      desc "Lists available databases"

      def invoke
        current_db = config['database', 'default']

        db_dir = File.expand_path config['database', 'directory']
        entries = Dir.entries(db_dir).select { |f| f =~ EXTENSION }

        entries.each do |file|
          db_name = file.sub(EXTENSION, '')
          print db_name

          puts db_name == current_db ? '*' : ''
        end
      end
    end
  end
end
