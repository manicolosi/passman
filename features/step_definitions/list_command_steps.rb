Given(/^I don't have an existing database$/) do
end

When(/^I run '(.+)'$/) do |cmd|
  @output = `bundle exec passman #{cmd}`
end

Then(/^I see no output$/) do
  expect(@output).to eq('')
end
