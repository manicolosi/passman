Given(/^I don't have an existing database$/) do
  # We start with no database
end

Given(/^I don't have a configuration file$/) do
end

Given(/^I have created (?:this|these) record(?:s?):$/) do |table|
  table.raw.each do |identifier, category, secret|
    argv = ['new', "identifier=#{identifier}", "category=#{category}"]
    if secret
      argv << "secret=#{secret}"
    else
      argv << '--no-password'
    end
    invoke argv
  end
end

Given(/^I run "(.+)" and answer (?:this|these) questions:$/) do |cmd, table|
  inject_input do
    table.raw.each do |question, answer|
      enter answer
    end

    invoke cmd.split(' ')
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

Then(/^I see text like:$/) do |text|
  stdout.should =~ Regexp.new(text)
end

Then(/^I see text like "(.*?)" on stderr$/) do |text|
  stderr.should =~ Regexp.new(text)
end
