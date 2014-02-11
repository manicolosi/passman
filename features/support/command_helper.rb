require 'stringio'
require 'timeout'
require_relative '../../lib/passman'
require_relative 'mock_standard_in'

module CommandHelper
  attr_reader :stdout, :stderr

  def invoke(*argv)
    if @app
      @app.join
      @app = nil
    end

    @stdin = MockStandardIn.new
    @app = Thread.new do
      previous_stdin, $stdin = $stdin, @stdin

      @stdout, @stderr = capture_output do
        Passman::App.run argv.flatten
      end

      $stdin = previous_stdin
    end
  end

  def simple_invoke(*argv)
    @stdout, @stderr = capture_output do
      Passman::App.run argv.flatten
    end
  end

  def enter(text)
    @stdin.enter text
  end

  def capture_output
    $previous_stdout, $stdout = $stdout, StringIO.new
    $previous_stderr, $stderr = $stderr, StringIO.new

    yield

    [$stdout.string, $stderr.string]
  ensure
    $stdout = $previous_stdout
    $stderr = $previous_stderr
  end

  def dump_output
    puts "STDOUT:\n#{stdout}"
    puts "STDERR:\n#{stderr}"
  end

  def delay_until
    Timeout.timeout(2.5) do
      while true
        sleep 0.01
        begin
          return yield
        rescue RSpec::Expectations::ExpectationNotMetError
        end
      end
    end
  end
end
