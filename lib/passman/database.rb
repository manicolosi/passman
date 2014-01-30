require 'yaml'
require 'gpgme'

require_relative 'record'

module Passman
  class Database
    def initialize(config)
      @config = config
      @crypto = GPGME::Crypto.new
      clear!
    end

    def clear!
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
      "#{name}.pdb.gpg"
    end

    def name
      @config['default']
    end

    def secrets
      read if exists? and !read?

      @secrets
    end

    def find(query_str)
      Query.new(query_str, secrets).run
    end

    def find_one(query_str)
      no_query_error! unless query_str

      results = find query_str

      ambiguous_error! results if results.count > 1
      not_found_error! if results.empty?

      results.first
    end

    def ambiguous_error!(results)
      error = "Ambiguous query. Found #{results.count} records:\n"

      results.each do |secret|
        error << secret.query_format + "\n"
      end

      raise error
    end

    def not_found_error!
      raise "No records found matching that query"
    end

    def no_query_error!
      raise "You must provide a query"
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

    def read(file_path = path, decrypt = true)
      @has_read = true

      File.open(file_path) do |file|
        data = if decrypt
          @crypto.decrypt file
        else
          file.read
        end
        @secrets.concat read_secrets(data.to_s)

      end
    end

    def write(file_path = path, encrypt = true)
      ensure_path_exists

      File.open(file_path, 'w') do |file|
        if encrypt
          @crypto.encrypt dump_secrets, output: file
        else
          file.write dump_secrets
        end
      end
    end

    def ensure_path_exists
      dir = File.dirname path

      FileUtils.mkdir_p dir unless File.exists? dir
    end

    private

    def read_secrets(data)
      if data = YAML.load(data)
        data.map { |attrs| Record.new attrs }
      else
        []
      end
    end

    def dump_secrets
      YAML.dump @secrets.map(&:to_hash)
    end
  end
end
