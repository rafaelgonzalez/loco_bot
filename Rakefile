require 'bundler/gem_tasks'

Dir['tasks/**/*.rake'].each { |ext| load ext } if defined?(Rake)

task default: :test

desc 'Run the test suite'
task test: [:spec, :rubocop]
