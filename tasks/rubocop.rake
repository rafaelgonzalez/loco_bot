begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.options = ['-D']
  end
rescue LoadError
  warn 'Rubocop not found'
end
