require 'open3'

class Command
  attr_reader :command_line, :stdout, :stderr, :status

  def initialize(command, *args)
    @command_line = ['bundle exec passman', command, *args].flatten.join(' ')
  end

  def execute
    Open3.popen3 @command_line do |stdin, stdout, stderr, wait_thr|
      @stdout = stdout.gets
      @stderr = stderr.gets
      @status = wait_thr.value.exitstatus
    end

    self
  end
end

def assert_stdout(expected)
  expect(@command.stdout.to_s.chomp).to eq(expected.chomp)
end

Given(/^I don't have an existing database$/) do
  # We start with no database
end

Given(/^I have created a record$/) do
  @command = Command.new('new', 'identifier=myidentifier', 'category=mycategory').execute
end

When(/^I run '(.+)'$/) do |cmd|
  @command = Command.new(cmd).execute
end

Then(/^I see no output$/) do
  assert_stdout ''
end

Then(/^I see '(.+)'$/) do |expected_output|
  assert_stdout expected_output
end
