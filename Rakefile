require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/clean'

desc 'Run Tests'
task :default do
  Rake::Task["test"].invoke rescue got_error = true
  raise "Test failures" if got_error
end

Rake::TestTask.new do |t|
  t.libs << "test" 
  t.verbose = true
  t.pattern = "test/**/*_test.rb" 
end

