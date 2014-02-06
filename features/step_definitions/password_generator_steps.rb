def dump_output
  puts "STDOUT: #{stdout.inspect}"
  puts "STDERR: #{stderr.inspect}"
end

def replace_option(name, value)
  config_file = File.expand_path '~/.config/passman.conf'
  config = File.read(config_file)

  modified_config = config.gsub(/^#{name} ?=.+$/, "#{name} = \"#{value}\"")
  File.open(config_file, 'w') do |f|
    f.write modified_config
  end
end

def init_config
  invoke 'list'
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
  stdout.chomp.should == 'generated_password'
end
