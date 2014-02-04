Given(/^I don't have an existing database$/) do
  # We start with no database
end

Given(/^I don't have a configuration file$/) do
end

Given(/^I have created (?:this|these) record(?:s?):$/) do |table|
  table.raw.each do |identifier, category, secret|
    argv = ['new', "identifier=#{identifier}", "category=#{category}"]
    argv << "secret=#{secret}" if secret
    invoke argv
  end
end

When(/^I run "(.+)"$/) do |cmd|
  invoke cmd.split(' ')
end

Then(/^I see no output$/) do
  stdout.should == ''
end

Then(/^I see:$/) do |expected|
  stdout.chomp.should == expected
end

Then(/^I see text like "(.*?)" on stderr$/) do |text|
  stderr.should =~ /#{text}/
end
