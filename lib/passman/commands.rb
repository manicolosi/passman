module Passman
  module Commands
    def self.extended(base)
      all.each do |cmd|
        base.desc cmd.desc
        base.arg_name cmd.arg_name
        base.command cmd.name do |c|
          cmd.switch.each do |switch|
            c.switch *switch
          end
          c.action &cmd.method(:invoke)
        end
      end
    end

    def self.all
      constants.map { |c| const_get(c) }.reject { |c| c == Command }
    end

    def self.files
      Dir[ File.join(File.dirname(__FILE__), 'commands/*.rb') ]
    end

    files.each do |file|
      require file
    end
  end
end
