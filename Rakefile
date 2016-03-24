require 'data_mapper'
require './app/app.rb'

namespace :db do
  desc "Non destructive upgrade"
  task :auto_upgrade do
    DataMapper.auto_upgrade!
    puts 'Auto-upgrade complete (no data loss)'
  end

  desc "Destructive upgrade"
  task :auto_migrate do
    puts 'Are you sure you want to auto_migrate? This will overwrite all data.'
    puts 'Answer y or n'
    answer = STDIN.gets.chomp
    if answer == 'y'
      DataMapper.auto_migrate!
      puts 'Auto-migrate complete (data was lost)'
    elsif answer == 'n'
      puts 'Rake aborted'
    else
      puts 'Unknown response. Rake aborted'
    end
  end
end
