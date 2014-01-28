module Passman
  module Commands
    class DumpAll < Command
      desc 'Dump all password records to stdout'

      def invoke
        puts "Found #{database.count} record(s) in database '#{database.path}'"

        database.secrets.each do |secret|
          puts

          [:identifier, :category, :secret, :metadata].each do |field|
            value = secret.send field
            puts "#{field}: #{value}"
          end
        end
      end
    end
  end
end
