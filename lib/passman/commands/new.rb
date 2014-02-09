require_relative 'command'
require_relative '../password_generator'
require_relative '../record'

module Passman
  module Commands
    class New < Command
      desc "Create a new password record"
      switch ['g', 'generate-password'], desc: 'generate a password'
      switch 'password', desc: "ask for a password", default_value: true

      def prompt(message)
        print "#{message}? "
        $stdin.gets.chomp
      end

      def questions
        {
          identifier: 'Identifier',
          category: 'Category',
          secret: 'Password',
        }
      end

      def questions_to_ask
        questions.keys - arg_attributes.keys - switch_attributes.keys
      end

      def question_attributes
        @question_attributes ||=
          {}.tap do |hash|
            questions_to_ask.map do |question_key|
              answer = prompt questions[question_key]
              if question_key == :secret
                answer2 = prompt "Password (again)"
                raise "Passwords don't match" if answer != answer2
              end
              hash[question_key] = answer
            end
          end
      end

      def arg_attributes
        @arg_attributes ||=
          {}.tap do |hash|
            remaining = if args.first =~ /.+\/.+/
                          cat, id = args.first.split('/')
                          hash[:category] = cat
                          hash[:identifier] = id
                          args[1..-1]
                        else
                          args
                        end

            remaining.each do |arg|
              k, v = arg.split(/=/)
              hash[k.to_sym] = v
            end
          end
      end

      def switch_attributes
        @switch_attributes ||=
          {}.tap do |hash|
            if options['generate-password']
              pw_gen = PasswordGenerator.new config['commands', 'password_gen']
              hash[:secret] = pw_gen.generate
            end

            if !options['password']
              hash[:secret] = ''
            end
          end
      end

      def get_attributes
        [switch_attributes, arg_attributes, question_attributes].reduce do |all_attrs, attrs|
          all_attrs.merge(attrs)
        end
      end

      def invoke
        if switch_attributes.has_key?(:secret) && arg_attributes.has_key?(:secret)
          raise "Can't have your cake and eat it too."
        end

        secret = Record.new(get_attributes)

        database.add secret
        database.write
      end
    end
  end
end
