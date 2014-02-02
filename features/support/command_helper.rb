require 'open3'

module CommandHelper
  attr_reader :stdout, :stderr

  def execute(command, *args)
    command_line = ['bundle exec passman', command, *args].flatten.join(' ')
    stdout, stderr, _ = Open3.capture3 command_line

    @stdout = stdout.to_s
    @stderr = stderr.to_s
  end
end
