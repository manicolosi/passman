def dump_output
  puts "STDOUT: #{stdout.inspect}"
  puts "STDERR: #{stderr.inspect}"
end

Given(/^I've configured the password generator$/) do
  init_config
  replace_option 'password_gen', 'echo generated_password'
end

When(/^I create a new record without a password$/) do
  invoke 'new', '--generate-password', 'identifier=myidentifier', 'category=mycategory'
end

Then(/^a password gets generated$/) do
  invoke 'print', 'mycategory/myidentifier'
  stdout.should == "generated_password\n"
end
