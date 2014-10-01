# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'locobot/version'

Gem::Specification.new do |spec|
  spec.name          = 'locobot'
  spec.version       = Locobot::VERSION
  spec.authors       = ['Rafaël Gonzalez']
  spec.email         = ['rafaelgonzalez@users.noreply.github.com']
  spec.summary       = %q{Ruby gem of a crazy robot and a benevolent table that keeps watching over it.}
  spec.description   = %q{Issue commands to control the robot. The table will keep you from making it fall, you monster!}
  spec.homepage      = 'https://github.com/rafaelgonzalez/locobot'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.4.0'
end
