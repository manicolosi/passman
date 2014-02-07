require 'stringio'
require_relative '../../lib/passman'

module CommandHelper
  attr_reader :stdout, :stderr

  def invoke(*argv)
    $stdin.rewind if $stdin.is_a? StringIO

    @stdout, @stderr = capture_output do
      Passman::App.run argv.flatten
    end
  end

  def capture_output
    previous_stdout, $stdout = $stdout, StringIO.new
    previous_stderr, $stderr = $stderr, StringIO.new

    yield

    [$stdout.string, $stderr.string]
  ensure
    $stdout = previous_stdout
    $stderr = previous_stderr
  end

  def enter(text)
    $stdin.puts text
  end

  def inject_input
    previous_stdin = $stdin
    $stdin = StringIO.new

    yield

    $stdin = previous_stdin
  end

  def dump_output
    puts "STDOUT:\n#{stdout}"
    puts "STDERR:\n#{stderr}"
  end
end
