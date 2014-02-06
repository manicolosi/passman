require_relative 'command'
require_relative '../password_generator'
require_relative '../record'

module Passman
  module Commands
    class New < Command
      desc "Create a new password record"
      switch ['g', 'generate-password'], desc: 'generate a password'

      def invoke
        attrs = get_attributes

        if options['generate-password']
          pw_gen = PasswordGenerator.new config['commands', 'password_gen']
          attrs[:secret] = pw_gen.generate
        end

        secret = Record.new(attrs)

        database.add secret
        database.write
      end

      def get_attributes
        Hash[args.map do |a|
          k, v = a.split(/=/)
          [k.to_sym, v]
        end]
      end
    end
  end
end
