require_relative 'command'
require_relative '../password_generator'
require_relative '../record'

module Passman
  module Commands
    class New < Command
      desc "Create a new password record"
      switch ['g', 'generate-password'], desc: 'generate a password'

      def questions
        {
          identifier: 'Identifier',
          category: 'Category',
          secret: 'Password',
        }
      end

      def get_answers(questions_to_ask)
        Hash[questions_to_ask.map do |question_key|
          question = questions[question_key]
          print "#{question}? "
          answer = $stdin.gets.chomp
          [question_key, answer]
        end]
      end

      def invoke
        attrs = get_attributes

        special_attrs = if options['generate-password']
                          if attrs[:secret]
                            raise "Can't have your cake and eat it too."
                          end
                          pw_gen = PasswordGenerator.new config['commands', 'password_gen']
                          { secret: pw_gen.generate }
                        else
                          {}
                        end

        questions_to_ask = questions.keys - attrs.keys - special_attrs.keys
        answers = get_answers(questions_to_ask)

        attrs = special_attrs.merge(attrs.merge(answers))

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
