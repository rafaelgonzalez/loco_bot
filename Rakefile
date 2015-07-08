require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new('spec')
rescue LoadError
  warn 'RSpec not found'
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.options = ['-D']
  end
rescue LoadError
  warn 'Rubocop not found'
end

task default: :test

desc 'Run the test suite'
task test: [:spec, :rubocop]
