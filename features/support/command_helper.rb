require 'stringio'
require_relative '../../lib/passman'

module CommandHelper
  attr_reader :stdout, :stderr

  def invoke(*argv)
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

  def dump_output
    puts "STDOUT:\n#{stdout}"
    puts "STDERR:\n#{stderr}"
  end
end
