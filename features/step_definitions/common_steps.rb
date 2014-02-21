Given(/^I don't have an existing database$/) do
  # We start with no database
end

Given(/^I don't have a configuration file$/) do
end

Given(/^I have created (?:this|these) record(?:s?):$/) do |table|
  table.raw.each do |identifier, category, password|
    argv = ['new', "identifier=#{identifier}", "category=#{category}"]
    if password
      argv << "password=#{password}"
    else
      argv << '--no-password'
    end
    invoke argv
  end
end

When(/^I answer (?:this|these) question(?:s?):$/) do |table|
  table.raw.each do |question, answer|
    delay_until do
      stdout.should include(question)
    end
    enter answer
  end
end

When(/^I run "(.+)"$/) do |cmd|
  invoke cmd.split(' ')
end

Then(/^I see no output$/) do
  delay_until do
    stdout.should == ''
  end
end

Then(/^I see:$/) do |expected|
  delay_until do
    stdout.chomp.should == expected
  end
end

Then(/^I see text like:$/) do |jext|
  stdout.should =~ Regexp.new(text)
end

Then(/^I see text like "(.*?)" on stderr$/) do |text|
  delay_until do
    stderr.should =~ Regexp.new(text)
  end
end

Then(/^I have this record:$/) do |table|
  invoke 'dump-all'

  table.raw.each do |field, value|
    delay_until do
      stdout.should =~ /^#{field}: +#{value}$/
    end
  end
end
