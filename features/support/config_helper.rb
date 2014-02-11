module ConfigHelper
  def init_config
    invoke 'list'
    @app.join
  end

  def replace_option(name, value)
    config_file = File.expand_path '~/.config/passman.conf'
    config = File.read(config_file)

    File.open(config_file, 'w') do |f|
      option_regex = /^#{name} ?=.+$/
      replacement = "#{name} = \"#{value}\""
      f.write config.gsub(option_regex, replacement)
    end
  end
end
