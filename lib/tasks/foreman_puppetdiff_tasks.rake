require 'rake/testtask'

# Tasks
namespace :foreman_puppetdiff do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc 'Test ForemanPuppetdiff'
  Rake::TestTask.new(:foreman_puppetdiff) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :foreman_puppetdiff do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_puppetdiff) do |task|
        task.patterns = ["#{ForemanPuppetdiff::Engine.root}/app/**/*.rb",
                         "#{ForemanPuppetdiff::Engine.root}/lib/**/*.rb",
                         "#{ForemanPuppetdiff::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_puppetdiff'].invoke
  end
end

Rake::Task[:test].enhance ['test:foreman_puppetdiff']

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance ['test:foreman_puppetdiff', 'foreman_puppetdiff:rubocop']
end
