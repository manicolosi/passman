require 'tmpdir'
require 'fileutils'
require 'open3'

module Hooks
  def self.global_setup
    print 'Setting up environment... '

    ENV.delete 'GPG_AGENT_INFO'

    @home = Dir.mktmpdir
    ENV['HOME'] = @home

    gpg_cmd = if system('which gpg2')
                'gpg2'
              else
                'gpg'
              end
    param_file = File.join(File.dirname(__FILE__), 'gpg-params.txt')
    cmd = "#{gpg_cmd} --debug-quick-random --batch --gen-key #{param_file}"
    Open3.popen3 cmd do |stdin, stdout, stderr, wait_thr|
      raise "Failed to generate GPG keys:" unless wait_thr.value.success?
    end

    puts 'done.'
  end

  def self.global_teardown
    recursive_delete(@home)
  end

  def self.teardown
    ['.config', '.local'].each do |dir|
      recursive_delete(@home, dir)
    end
  end

  def self.recursive_delete(*components)
    dir = File.join(*components)

    FileUtils.rm_r dir if File.directory? dir
  end

  def gpg_cmd
    if which 'gpg2'
      'gpg2'
    elsif which 'gpg'
      'gpg'
    else
      raise 'You must install GnuPG 2.'
    end
  end

  def which(program)
    system "which #{program}"
  end
end
