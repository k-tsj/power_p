require "bundler/gem_tasks"

require "rake/testtask"
task :default => :test
Rake::TestTask.new do |t|
  t.ruby_opts = ["-w"]
  t.test_files = FileList["test/test_*.rb"]
end
