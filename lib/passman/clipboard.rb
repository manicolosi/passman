module Passman
  class Clipboard
    def initialize(config)
      @config = config
    end

    def copy_and_restore(text)
      saved = read
      write text
      write saved, 5
    end

    def read
      `#{read_clipboard}`
    end

    def write(text, delay = 0)
      system "sleep #{delay} && echo -n '#{text}' | #{write_clipboard} &"
    end

    private

    def read_clipboard
      @config['commands', 'read_clipboard']
    end

    def write_clipboard
      @config['commands', 'write_clipboard']
    end
  end
end
