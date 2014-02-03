require 'cucumber/rake/task'
require 'rspec/core/rake_task'

Cucumber::Rake::Task.new(:features)

RSpec::Core::RakeTask.new(:specs)

task default: [:specs, :features]
