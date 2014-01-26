require File.join([File.dirname(__FILE__),'lib','passman','version.rb'])

spec = Gem::Specification.new do |s|
  s.name = 'passman'
  s.version = Passman::VERSION
  s.author = 'Mark A. Nicolosi'
  s.email = 'mark.a.nicolosi@gmail.com'
  s.homepage = 'https://github.com/manicolosi/passman'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A command-line password manager'
  s.files = `git ls-files`.split("\n")
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'passman'

  s.add_runtime_dependency('gli','2.9.0')
  s.add_runtime_dependency('gpgme', '2.0.2')
  s.add_runtime_dependency('toml', '0.1.0')

  s.add_development_dependency('debugger')
end
