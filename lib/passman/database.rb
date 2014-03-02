require 'yaml'
require 'gpgme'

require_relative 'record'
require_relative 'query'

module Passman
  class Database
    def initialize(config)
      @config = config
      @crypto = GPGME::Crypto.new
      clear!
    end

    def clear!
      @records = []
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

    def records
      read if exists? and !read?

      @records
    end

    def find(query_str)
      Query.new(query_str, records).run
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

      results.each do |record|
       error << record.query_format + "\n"
      end

      raise error
    end

    def not_found_error!
      raise "No records found matching that query"
    end

    def no_query_error!
      raise "You must provide a query"
    end

    def add(record)
      records << record
    end

    def replace(original, new)
      records.delete(original)
      records << new
    end

    def count
      records.count
    end

    def all
      records
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
        @records.concat read_records(data.to_s)
      end
    end

    def write(file_path = path, encrypt = true)
      ensure_path_exists

      File.open(file_path, 'w') do |file|
        if encrypt
          @crypto.encrypt dump_records, output: file
        else
          file.write dump_records
        end
      end
    end

    def ensure_path_exists
      dir = File.dirname path

      FileUtils.mkdir_p dir unless File.exists? dir
    end

    private

    def read_records(data)
      if data = YAML.load(data)
        data.map { |attrs| Record.new attrs }
      else
        []
      end
    end

    def dump_records
      YAML.dump @records.map(&:to_hash)
    end
  end
end
