require_relative 'command'
require_relative '../password_generator'
require_relative '../record'

module Passman
  module Commands
    class New < Command
      desc "Create a new password record"
      switch ['g', 'generate-password'], desc: 'generate a password'
      switch 'password', desc: "ask for a password", default_value: true

      def questions
        {
          identifier: 'Identifier',
          category: 'Category',
          secret: 'Password',
        }
      end

      def question_attributes
        questions_to_ask = questions.keys - arg_attributes.keys - switch_attributes.keys

        @question_attributes ||=
          Hash[questions_to_ask.map do |question_key|
            question = questions[question_key]
            print "#{question}? "
            answer = $stdin.gets.chomp
            [question_key, answer]
          end]
      end

      def arg_attributes
        @arg_attributes ||=
          Hash[args.map do |a|
            k, v = a.split(/=/)
            [k.to_sym, v]
          end]
      end

      def switch_attributes
        puts options['password'].inspect
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
