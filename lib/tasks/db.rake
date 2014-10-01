namespace :db do
  desc "Task responsible to hard reset the database: drop, delete schema.rb, create, migrate and seeds."
  task :hard_reset do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    FileUtils.rm "#{Rails.root.to_s}/db/schema.rb"
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end
