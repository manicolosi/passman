require 'cucumber/rake/task'
require 'rspec/core/rake_task'

Cucumber::Rake::Task.new(:features)
RSpec::Core::RakeTask.new(:specs)

task default: [:specs, :features]

# From: http://erniemiller.org/2014/02/05/7-lines-every-gems-rakefile-should-have
task :console do
  require 'irb'
  require 'irb/completion'
  require 'passman'
  ARGV.clear
  IRB.start
end
