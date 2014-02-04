require 'debugger'

require_relative 'command_helper'
require_relative 'hooks'

World(CommandHelper)

at_exit do
  Hooks.global_teardown
end

After do
  Hooks.teardown
end

Hooks.global_setup
