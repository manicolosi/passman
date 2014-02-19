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

        @config = Config.new(global)
        @database = Database.new(config['database'])
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
        getter_appender :switch, args
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

      def self.getter_appender(var, args)
        current_value = instance_variable_get("@#{var}") || []
        if args.empty?
          current_value
        else
          current_value << get_value(args)
          instance_variable_set "@#{var}", current_value
        end
      end

      def self.get_value(args)
        args.count == 1 ? args.first : args
      end
    end
  end
end
