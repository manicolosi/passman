Given(/^I create a new record$/) do
end

When(/^I answer the questions$/) do
  previous_stdin = $stdin

  $stdin = StringIO.new
  $stdin.puts 'myidentifier'
  $stdin.puts 'mycategory'
  $stdin.puts 'mysecret'
  $stdin.rewind

  invoke 'new'

  $stdin = previous_stdin
end

Then(/^I have a record$/) do
  invoke 'list'
  stdout.should == "mycategory/myidentifier\n"

  invoke 'print', 'mycategory/myidentifier'
  stdout.should == "mysecret\n"
end
