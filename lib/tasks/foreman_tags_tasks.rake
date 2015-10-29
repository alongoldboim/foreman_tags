# Tasks
namespace :foreman_tags do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc 'Test ForemanTags'
  Rake::TestTask.new(:foreman_tags) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
  end
end

namespace :foreman_tags do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_tags) do |task|
        task.patterns = ["#{ForemanTags::Engine.root}/app/**/*.rb",
                         "#{ForemanTags::Engine.root}/lib/**/*.rb",
                         "#{ForemanTags::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_tags'].invoke
  end
end

Rake::Task[:test].enhance do
  Rake::Task['test:foreman_tags'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance do
    Rake::Task['test:foreman_tags'].invoke
    Rake::Task['foreman_tags:rubocop'].invoke
  end
end
