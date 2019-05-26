# frozen_string_literal: true

require 'coveralls/rake/task'
require 'rake/testtask'
require 'yard'

# Run minitest (unit tests)

Rake::TestTask.new do |task|
  task.libs << 'test'
  task.warning = false
end

desc 'Run minitest (unit tests)'
task default: :test

# Run coveralls

Coveralls::RakeTask.new

desc 'Run coveralls'
task :coveralls => [:test, 'coveralls:push']

# Run yard

YARD::Rake::YardocTask.new

desc 'Run yard'
task :yard
