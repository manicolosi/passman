module Passman
  require 'fileutils'
  require 'toml'

  class Config
    attr_reader :path

    INITIAL_CONFIG = "config/passman.conf"
    DEFAULT_CONFIG = "~/.config/passman.conf"

    def initialize(cli_options, path = DEFAULT_CONFIG)
      @path = File.expand_path path

      write_config unless File.exists? @path
      @config = TOML.load_file(@path)

      cli_config = cli_options_to_hash(cli_options)
      @config.merge!(cli_config) { |k, x, y| x.merge(y) }
    end

    def cli_options_to_hash(options)
      options
        .reject { |k, v| k.is_a? Symbol }
        .reduce(Hash.new) do |hash, kv|
          hash.tap do |h|
            k, v = kv
            k1, k2 = k.split /-/

            if k1 && k2 && v
              h[k1] ||= {}
              h[k1][k2] = v
            end
          end
      end
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
