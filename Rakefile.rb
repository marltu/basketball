require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :cov => [:spec] do
    sh "x-www-browser coverage/index.html"
end
