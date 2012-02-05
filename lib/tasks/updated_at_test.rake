require "#{::Rails.root}/app/helpers/pages_helper.rb"
include PagesHelper

namespace :db do
  desc "Regularly scheduled call to FS for data."
  task :updated_at_test => :environment do
    venues = Venue.limit(20).offset(1)
    time_now = DateTime.now
    venues.each do |v|
      update_time = v.updated_at
      difference = time_now.to_i - update_time.to_i
      puts "Time now: #{time_now}"
      
      puts "Updated Time: #{update_time}"
      
      puts "Diff: #{difference/(3600*24)}"
    end
  end
end