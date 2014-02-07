Given(/^I create a new record$/) do
end

When(/^I answer the questions$/) do
  inject_input do
    enter 'myidentifier'
    enter 'mycategory'
    enter 'mysecret'

    invoke 'new'
  end
end

Then(/^I have a record$/) do
  invoke 'list'
  stdout.should == "mycategory/myidentifier\n"

  invoke 'print', 'mycategory/myidentifier'
  stdout.should == "mysecret\n"
end
