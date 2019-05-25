# frozen_string_literal: true

require 'rake/testtask'
require 'yard'

# Run tests

Rake::TestTask.new do |task|
  task.libs << 'test'
  task.warning = false
end

desc 'Run unit tests'
task default: :test

# Run yard

YARD::Rake::YardocTask.new

desc 'Run yard'
task :yard
