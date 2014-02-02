require 'open3'

class Command
  attr_reader :command_line, :stdout, :stderr

  def initialize(command, *args)
    @command_line = ['bundle exec passman', command, *args].flatten.join(' ')
  end

  def execute
    stdout, stderr, _ = Open3.capture3 @command_line
    @stdout = stdout.to_s
    @stderr = stderr.to_s

    self
  end
end

Given(/^I don't have an existing database$/) do
  # We start with no database
end

Given(/^I have created a record:$/) do |table|
  table.raw.each do |identifier, category|
    identifier = "identifier=#{identifier}"
    category   = "category=#{category}"
    @command = Command.new('new', identifier, category).execute
  end
end

When(/^I run "(.+)"$/) do |cmd|
  @command = Command.new(cmd).execute
end

Then(/^I see no output$/) do
  @command.stdout.should == ''
end

Then(/^I see:$/) do |expected|
  @command.stdout.chomp.should == expected
end
