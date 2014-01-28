module Passman
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

    singleton_class.send(:alias_method, :new_name, :name)

    def self.name
      new_name.split('::').last.chars.reduce([]) do |words, char|
        if char =~ /[A-Z]/
          words << char
        else
          words[-1] << char
        end
        words
      end.join('-').downcase
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
