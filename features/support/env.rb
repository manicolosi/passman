require 'tmpdir'
require 'fileutils'

Before do
  @home = Dir.mktmpdir
  ENV['HOME'] = @home
end

After do
  FileUtils.rm_r @home, force: true
end
