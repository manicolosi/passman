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

      def self.desc(*args)
        getter_setter :desc, args
      end

      def self.arg_name(*args)
        getter_setter :arg_name, args
      end

      def self.switch(*args)
        getter_setter :switch, args
      end

      def self.invoke(global, options, args)
        new(global, options, args).invoke
      end

      def self.getter_setter(var, args)
        if args.empty?
          instance_variable_get "@#{var}"
        else
          instance_variable_set "@#{var}", get_value(args)
        end
      end

      def self.get_value(args)
        args.count == 1 ? args.first : args
      end
    end
  end
end
