require_relative 'command'
require_relative '../password_generator'
require_relative '../record'

module Passman
  module Commands
    class New < Command
      desc "Create a new password record"
      switch ['g', 'generate-password'], desc: 'generate a password'
      switch 'password', desc: "ask for a password", default_value: true

      def with_echo(disabled)
        system 'stty -echo' if disabled
        yield
      ensure
        if disabled
          system 'stty echo'
          print "\n"
        end
      end

      def prompt(message, options = {})
        with_echo options[:no_echo] do
          print "#{message}? "
          $stdin.gets.chomp
        end
      end

      def questions
        {
          identifier: 'Identifier',
          category: 'Category',
          password: 'Password',
        }
      end

      def confirmable_questions
        {
          password: "Passwords don't match"
        }
      end

      def secret_questions
        [:password]
      end

      def questions_to_ask
        questions.keys - arg_attributes.keys - switch_attributes.keys
      end

      def ask(key)
        question = questions[key]
        answer = prompt question, no_echo: secret_questions.include?(key)

        if answer.empty?
          raise "Fields cannot be blank"
        end

        if confirmable_questions.keys.include? key
          confirmation = prompt "#{question} (again)", no_echo: secret_questions.include?(key)
          raise "Passwords don't match" if answer != confirmation
        end

        answer
      end

      def question_attributes
        @question_attributes ||=
          {}.tap do |hash|
            questions_to_ask.each do |question_key|
              hash[question_key] = ask question_key
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
              hash[:password] = pw_gen.generate
            end

            if !options['password']
              hash[:password] = ''
            end
          end
      end

      def get_attributes
        [switch_attributes, arg_attributes, question_attributes].reduce do |all_attrs, attrs|
          all_attrs.merge(attrs)
        end
      end

      def invoke
        if switch_attributes.has_key?(:password) && arg_attributes.has_key?(:password)
          raise "Can't have your cake and eat it too."
        end

        record = Record.new(get_attributes)

        database.add record
        database.write
      end
    end
  end
end
