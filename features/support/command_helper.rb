require 'stringio'
require 'timeout'
require 'forwardable'
require_relative '../../lib/passman'
require_relative 'mock_standard_in'

module CommandHelper
  extend Forwardable

  def_delegator :@stdout, :string, :stdout
  def_delegator :@stderr, :string, :stderr
  def_delegator :@stdin, :enter

  def invoke(*argv)
    if @app
      @app.join
    end

    @stdin = MockStandardIn.new
    @stdout = StringIO.new
    @stderr = StringIO.new

    @app = Thread.new do
      $stdin = @stdin
      $stdout = @stdout
      $stderr = @stderr

      Passman::App.run argv.flatten
    end
  end

  def dump_output
    puts "STDOUT:\n#{stdout}"
    puts "STDERR:\n#{stderr}"
  end

  def delay_until
    exception = nil
    Timeout.timeout(1) do
      while true
        sleep 0.01
        begin
          return yield
        rescue RSpec::Expectations::ExpectationNotMetError => e
          exception = e
        end
      end
    end
  rescue Timeout::Error => e
    raise exception || e
  end
end
