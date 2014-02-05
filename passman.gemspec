$:.push File.expand_path("../lib", __FILE__)
require "passman/version"

Gem::Specification.new do |s|
  # Metadata
  s.name        = 'passman'
  s.license     = 'MIT'
  s.version     = Passman::VERSION
  s.author      = 'Mark A. Nicolosi'
  s.email       = 'mark.a.nicolosi@gmail.com'
  s.homepage    = 'https://github.com/manicolosi/passman'
  s.summary     = 'A command-line password manager'
  s.description = 'Write description'

  # Manifest
  s.platform    = Gem::Platform::RUBY
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename f }
  s.require_paths = ['lib']

  s.add_runtime_dependency('gli','2.9.0')
  s.add_runtime_dependency('gpgme', '2.0.2')
  s.add_runtime_dependency('toml', '0.1.0')
  s.add_runtime_dependency('term-ansicolor', '1.2.2')

  s.add_development_dependency('rake')
  s.add_development_dependency('debugger')
  s.add_development_dependency('cucumber')
  s.add_development_dependency('rspec')
end
