require "#{::Rails.root}/app/helpers/pages_helper.rb"
include PagesHelper

namespace :cron do
  desc "Regularly scheduled call to FS for data by the Heroku cron add-on"
  task :heroku_cron => :environment do
    if Time.now.hour % 1 == 0 # run ever hour
      Rake::Task["db:collect_trending_data"].invoke
    end
  end  
end