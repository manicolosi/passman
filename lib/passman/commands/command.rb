require_relative '../helpers/hyphenizer'

module Passman
  module Commands
    class Command
      attr_reader :global, :options, :args
      attr_reader :config, :database

      def initialize(global, options, args)
        @global = global
        @options = options
        @args = args

        @config = global[:config]
        @database = global[:database]
      end

      singleton_class.send(:alias_method, :original_name, :name)

      def self.name
        Helpers::Hyphenizer.hyphenize(original_name)
      end

      def self.desc(*arg)
        getter_setter :desc, arg
      end

      def self.arg_name(*arg)
        getter_setter :arg_name, arg
      end

      def self.invoke(global, options, args)
        new(global, options, args).invoke
      end

      def self.getter_setter(var, arg)
        if arg.empty?
          instance_variable_get "@#{var}"
        else
          instance_variable_set "@#{var}", arg.first
        end
      end
    end
  end
end
