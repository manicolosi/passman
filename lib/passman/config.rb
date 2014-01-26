module Passman
  require 'fileutils'
  require 'toml'

  class Config
    attr_reader :path

    INITIAL_CONFIG = "config/passman.conf"
    DEFAULT_CONFIG = "~/.config/passman.conf"

    def initialize(global_options, path = DEFAULT_CONFIG)
      @path = File.expand_path path

      write_config unless File.exists? @path
      @config = TOML.load_file(@path)
    end

    def [](*args)
      args.reduce(@config) { |c,a| c[a] }
    end

    def write_config
      puts "Installing initial configuration to #{path}"

      FileUtils.cp(INITIAL_CONFIG, path)
    end
  end
end
