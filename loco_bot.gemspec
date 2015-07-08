# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'loco_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'loco_bot'
  spec.version       = LocoBot::VERSION
  spec.authors       = ['Rafaël Gonzalez']
  spec.email         = ['github@rafaelgonzalez.me']
  spec.summary       = 'Ruby gem of crazy robots and benevolent tables that ' \
                       'keep watching over them.'
  spec.description   = 'Issue commands to control the robots and the tables ' \
                       'will keep you from making them fall, you monster!'
  spec.homepage      = 'https://github.com/rafaelgonzalez/loco_bot'
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
  spec.add_development_dependency 'rubocop', '~> 0.32.1'
end
