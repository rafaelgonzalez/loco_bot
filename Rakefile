require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  warn 'Rubocop not found'
end

task default: :test

desc 'Run the test suite'
task test: [:spec, :rubocop]
