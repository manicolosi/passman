require_relative 'secret'

module Passman
  require 'yaml'
  require 'gpgme'

  class Database
    def initialize(config)
      @config = config
      @crypto = GPGME::Crypto.new
      @secrets = []
    end

    def path
      File.join directory, file
    end

    def exists?
      File.exists? path
    end

    def directory
      File.expand_path @config['directory']
    end

    def file
      "#{@config['default']}.pdb.gpg"
    end

    def secrets
      read if exists? and !read?

      @secrets
    end

    def find(query)
      secrets.select { |secret| secret.identifier == query }
    end

    def find_one(query)
      find(query).first
    end

    def add(secret)
      secrets << secret
    end

    def count
      secrets.count
    end

    def read?
      @has_read || false
    end

    def read
      @has_read = true

      File.open(path) do |file|
        data = @crypto.decrypt file
        @secrets.concat read_secrets(data.to_s)
      end
    end

    def write
      ensure_path_exists

      File.open(path, 'w') do |file|
        data = dump_secrets
        @crypto.encrypt data, output: file
      end
    end

    def ensure_path_exists
      dir = File.dirname path

      FileUtils.mkdir_p dir unless File.exists? dir
    end

    private

    def read_secrets(data)
      YAML.load(data).map { |attrs| Secret.new attrs }
    end

    def dump_secrets
      YAML.dump @secrets.map(&:to_hash)
    end
  end
end
