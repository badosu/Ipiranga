require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new

desc "Launches interactive console with borel"
task console: :install do
  system "pry -ripiranga"
end

task default: :spec
task test: :spec
