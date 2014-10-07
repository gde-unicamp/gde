# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :spec do
  $LOAD_PATH.unshift('lib', 'spec')
  Dir.glob('./spec/**/*_spec.rb') { |f| require f }
end

task default: :spec
