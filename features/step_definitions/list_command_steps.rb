require 'open3'

def execute(command, *args)
  exec = ['bundle exec passman', command, *args].flatten.join(' ')

  Open3.popen3 exec do |stdin, stdout, stderr, wait_thr|
    @stdout = stdout.gets
    @stderr = stderr.gets
    @exit_status = wait_thr.value.exitstatus
  end
end

def assert_stdout(expected)
  expect(@stdout.to_s.chomp).to eq(expected.chomp)
end


Given(/^I don't have an existing database$/) do
  # We start with no database
end

Given(/^I have created a record$/) do
  execute 'new', 'identifier=myidentifier', 'category=mycategory'
end

When(/^I run '(.+)'$/) do |cmd|
  execute cmd
end

Then(/^I see no output$/) do
  assert_stdout ''
end

Then(/^I see '(.+)'$/) do |expected_output|
  assert_stdout expected_output
end
