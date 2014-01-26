require_relative 'secret'

module Passman
  require 'yaml'
  require 'gpgme'

  class Database
    attr_reader :path, :secrets

    def initialize(path)
      @path = path
      @crypto = GPGME::Crypto.new
      @secrets = []
    end

    def find(query)
      secrets.select { |secret| secret.identifier == query }
    end

    def add(secret)
      secrets << secret
    end

    def count
      secrets.count
    end

    def read
      File.open(path) do |file|
        data = @crypto.decrypt file
        secrets.concat read_secrets(data.to_s)
      end
    end

    def write
      File.open(path, 'w') do |file|
        data = dump_secrets
        @crypto.encrypt data, output: file
      end
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
