begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new('spec')
rescue LoadError
  warn 'RSpec not found'
end